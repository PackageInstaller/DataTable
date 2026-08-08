local SortFocusBase = inherit("Window/SortBase/SortFocusBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local EU = require("Common/EquipUtil")
local SU = require("Common/SortUtil")
local GU = require("Common/GroupUtil")
local DBH = require("Manager/DataBindingHandler")
local S = require("Common/Singleton")
local activityManager = S:Get("ActivityManager")
local Quality2BaseScore = {
  5,
  10,
  15
}
local m_actors, m_displayedActors
local m_selectedUids = {}
local m_resourcesPreview = {}
local m_chipsPreview = {}
local m_decomposeResultMap = {}
local m_coroutine
local m_talentDisplayDuration = 2
local m_filterFunc
local m_repeatedContext = {}
local m_allQualityActors, m_context

function SetupWindow()
  WU.BindButtonEvent(REF.BtnBatchSelected, function()
    WU.AcquireWindowAsync("BatchSelectActor")
  end)
  WU.BindButtonEvent(REF.BtnDecompose, OnDecomposeClick)
  LU.Bind(REF.WrapContentActor, {
    dataSource = function(dataIndex)
      return m_displayedActors ~= nil and m_displayedActors[dataIndex]
    end,
    updateSlot = UpdateActorSlot,
    delta = 0.01
  })
  LU.Bind(REF.WrapContentResources, {
    updateRow = OnResourceSlotUpdate
  })
  LU.Bind(REF.WrapContentChips, {
    updateRow = OnChipSlotUpdate
  })
end

function InitWindow()
  activityManager.ProcessWhenActivityStartedOrFinished(PB.enum.ActivityType.Couple, function()
    local couple = this:GetData("fci/couple/")
    if couple == nil then
      DB:SyncRemote(DB:GameRequest("fci/couple/"))
    end
  end)
  SortFocusBase.InitWindowActor()
  this:SetData("SelectedQuality/Actor", nil)
  this:Bind("ActorDecompose/Context", OnContext)
  this:Bind("SortFinished", OnSortFinished)
  this:Bind("SelectedQuality/Actor", OnSelectedQualityChange)
  this:Bind("fci/actor/", OnActorQualityData)
  WU.PreloadWindow("ActorDecomposeResult")
  this:DelayInvokeEndOfFrame(function()
    this:BroadcastGameEvent("ApplySortAlternative", 0, false)
  end)
end

function UninitWindow()
  m_filterFunc = nil
end

function SaveContext()
  table.insert(m_repeatedContext, m_context)
end

function LoadContext()
  if 0 < #m_repeatedContext then
    local context = m_repeatedContext[#m_repeatedContext]
    this:SetData("ActorDecompose/Context", context)
    table.remove(m_repeatedContext, #m_repeatedContext)
  end
end

function OnContext(context)
  ClearSelection()
  if context == nil then
    return
  end
  m_context = context
  m_filterFunc = nil
  if context.actor then
    local actorConfig = PB.get("ActorConfig", context.actor.id)
    local whiteIds = AU.GetActorIdsByRoleId(actorConfig.role)
    
    function m_filterFunc(v)
      return v.uid ~= context.actor.uid and _ENV["!"](whiteIds):has(v.id)
    end
  elseif context.chipId then
    local whiteIds = AU.GetActorIdsByChipId(context.chipId)
    
    function m_filterFunc(v)
      return _ENV["!"](whiteIds):has(v.id)
    end
  end
  ResetWrapContent()
end

function ClearSelection()
  WU.ToggleRendering(REF.DragActorList, false)
  REF.ActorTalentInfo.gameObject:SetActive(false)
  m_selectedUids = {}
  m_decomposeResultMap = {}
  m_resourcesPreview = {}
  m_chipsPreview = {}
  LU.Set(REF.WrapContentResources, 0)
  LU.Set(REF.WrapContentChips, 0)
end

function ResetWrapContent()
  if m_actors == nil then
    return
  end
  WU.ToggleRendering(REF.DragActorList, true)
  m_displayedActors = FilterActors(m_actors, m_filterFunc)
  REF.NodeEmpty.gameObject:SetActive(#m_displayedActors == 0)
  local row = math.ceil(#m_displayedActors / #REF.WrapContentActor[0]["$"])
  LU.Set(REF.WrapContentActor, row)
end

function UpdateActorSlot(slotRef, actor)
  if actor then
    slotRef["@actor"] = actor
    slotRef["$$BindActor"](actor)
    local tip = fif(GU.ActorNotInGroup(actor.uid), nil, "actorInGroup")
    local valid = AU.ActorDeleteValidate(actor.uid)
    if not valid then
      tip = "actorDisplay"
    end
    slotRef["$$SetTips"](tip)
    slotRef["$$SetSelected"](m_selectedUids[actor.uid])
    if valid and not actor.isLock then
      slotRef["$$SetClickCallback"](OnActorSlotClick)
    else
      slotRef["$$SetClickCallback"](nil)
    end
  else
    slotRef["@actor"] = nil
    slotRef["$$ClearSlot"]()
  end
end

function OnActorSlotClick(actorSlot)
  local slotRef = _ENV["$"](actorSlot)
  local actor = slotRef["@actor"]
  if actor then
    local selected = not m_selectedUids[actor.uid]
    slotRef["$$SetSelected"](selected)
    ToggleDecomposePreview(actor, selected)
    ShowTalentInfo(actor.talentInfo)
  end
end

function OnResourceSlotUpdate(rowRef, wrapIndex, realIndex)
  if m_resourcesPreview and realIndex ~= nil and realIndex < #m_resourcesPreview then
    local res = m_resourcesPreview[realIndex + 1]
    rowRef["$$SetData"](res.type, res.id, res.count)
  end
end

function OnChipSlotUpdate(rowRef, wrapIndex, realIndex)
  if m_chipsPreview and realIndex ~= nil and realIndex < #m_chipsPreview then
    local res = m_chipsPreview[realIndex + 1]
    rowRef["$$SetData"](res.type, res.id, res.count)
  end
end

function OnDecomposeClick()
  local all = {
    uids = {}
  }
  local hasAdvancedActor = false
  for uid, detail in pairs(m_selectedUids) do
    table.insert(all.uids, uid)
    if not hasAdvancedActor and (detail.level > 5 or detail.star > 3 or detail.quality >= 4) then
      hasAdvancedActor = true
    end
  end
  if #all.uids ~= 0 then
    local tip = WU.GetString("WindowGacha_ConfirmDecomposeTip")
    if hasAdvancedActor then
      tip = tip .. "<br/>" .. WU.GetString("WindowGacha_HasAdvancedActorTip")
    end
    local actorCultivationInfo = this:GetData("ActorCultivation")
    local actorAll = this:GetData("fci/actor")
    local canDec = true
    if actorCultivationInfo and 0 < #actorCultivationInfo then
      for _, v in pairs(actorCultivationInfo) do
        local actorList = AU.GetActorListById(v.actorId)
        if actorList then
          local canDecThisActor = false
          for _, a in pairs(actorList) do
            local inList = false
            for i = 1, #all.uids do
              if all.uids[i] == a.uid then
                inList = true
                break
              end
            end
            if not inList then
              canDecThisActor = true
              break
            end
          end
          canDec = canDec and canDecThisActor
        end
      end
      if not canDec then
        WU.ShowHintText(WU.GetString("ActorCultivation_CannotDecompose"))
        return
      end
    end
    local customActorCultivationInfo = DB:GetData("fci/custom-actor-cultivation/")
    local culPlans = customActorCultivationInfo.culPlans
    if culPlans and 0 < #culPlans then
      for _, v in ipairs(culPlans) do
        if v.actorId and v.actorId ~= 0 then
          local actorList = AU.GetActorListById(v.actorId)
          if actorList then
            local canDecThisActor = false
            for _, a in pairs(actorList) do
              local inList = false
              for i = 1, #all.uids do
                if all.uids[i] == a.uid then
                  inList = true
                  break
                end
              end
              if not inList then
                canDecThisActor = true
                break
              end
            end
            canDec = canDec and canDecThisActor
          end
        end
      end
      if not canDec then
        WU.ShowHintText(WU.GetString("ActorCultivation_CannotDecompose"))
        return
      end
    end
    local couple = DB:GetData("fci/couple/")
    if couple and couple.coupleActorId and couple.coupleActorId ~= 0 then
      local actorList = AU.GetActorListById(couple.coupleActorId)
      if actorList then
        local canDecThisActor = false
        for _, a in pairs(actorList) do
          local inList = false
          for i = 1, #all.uids do
            if all.uids[i] == a.uid then
              inList = true
              break
            end
          end
          if not inList then
            canDecThisActor = true
            break
          end
        end
        canDec = canDec and canDecThisActor
      end
    end
    if not canDec then
      WU.ShowHintText(WU.GetString("ActorCultivation_CannotDecompose"))
      return
    end
    WU.ShowMessageYesNo(tip, function(action)
      if action == "YES" then
        this:GameRequest("fci/actor/decompose/"):Post(all, function(result)
          DBH.ResChange(result.resChange)
          WU.AcquireWindowAsync("ActorDecomposeResult", function(ui)
            _ENV["$"](ui)["$$SetView"](result.resChange)
          end)
          GU.GroupTagCheck(all.uids)
          RemoveActorFromRollerBind("Actor/RollerTraverse", all.uids)
          m_selectedUids = {}
          m_resourcesPreview = {}
          m_chipsPreview = {}
          LU.Set(REF.WrapContentResources, 0)
          LU.Set(REF.WrapContentChips, 0)
          this:BroadcastGameEvent("ApplySortAlternative", REF["$SortMate"].tabIndex, REF["$SortMate"].reverse)
        end)
      end
    end)
  end
end

function ToggleDecomposePreview(actor, selected)
  if selected then
    m_selectedUids[actor.uid] = actor
  else
    m_selectedUids[actor.uid] = nil
  end
  local result = AU.GetDecomposeResult(actor, m_decomposeResultMap, true)
  UpdatePreview(m_resourcesPreview, result.resources, selected)
  UpdatePreview(m_chipsPreview, result.chips, selected)
  table.sort(m_resourcesPreview, function(a1, a2)
    return a1.id > a2.id
  end)
  LU.Set(REF.WrapContentResources, #m_resourcesPreview)
  LU.Set(REF.WrapContentChips, #m_chipsPreview)
end

function UpdatePreview(preview, result, selected)
  for _, res in pairs(result) do
    local i, p = _ENV["!"](preview):find(function(k, v)
      return v.type == res.type and v.id == res.id
    end)
    if p ~= nil then
      table.remove(preview, i)
      if selected then
        p.count = p.count + res.count
      else
        p.count = p.count - res.count
      end
    else
      p = {
        type = res.type,
        id = res.id,
        count = res.count
      }
    end
    if p and p.count > 0 then
      table.insert(preview, 1, p)
    end
  end
end

function ShowTalentInfo(talent)
  REF.ActorTalentInfo.gameObject:SetActive(true)
  for i = 0, #REF.Grid - 1 do
    local talentRef = REF.Grid[i]
    talentRef.root.gameObject:SetActive(i < #talent)
    if i < #talent then
      local talentId = talent[i + 1].talentId
      local data = AU.GetTalentDisplayInfo(talentId, talent[i + 1].talentValue)
      AU.SetTalentBG(_ENV["$"](talentRef.SpriteTalentBGNode), data.bgIdx, data.isRatio)
      talentRef.LabelTitle.UIHtmlLabel.text = data.talentName
      if data.talentIcon ~= nil then
        talentRef.TextureTalent.UITexture.mainTexturePath = "Texture/ActorTalent/ActorTalent_" .. data.talentIcon
      else
        error("Actor", " missing TalentIcon in Localization_Talent postfix")
      end
    end
  end
  REF.Grid.UIGrid:Reposition()
  if m_coroutine ~= nil then
    this:StopCoroutine(m_coroutine)
    m_coroutine = nil
  end
  m_coroutine = this:DelayInvokeInScaledSeconds(m_talentDisplayDuration, function()
    REF.ActorTalentInfo.gameObject:SetActive(false)
  end)
end

function RemoveActorFromRollerBind(bindString, uids)
  local actorTraverse = this:GetData(bindString)
  if actorTraverse ~= nil then
    for i = 1, #uids do
      local idx = table.find(actorTraverse, function(k, v)
        return v.uid == uids[i]
      end)
      if idx ~= nil then
        table.remove(actorTraverse, idx)
      end
    end
    this:SetData(bindString, actorTraverse)
  end
end

function OnSelectedQualityChange(selectedQuality)
  if selectedQuality == nil then
    return
  end
  CancelDecompose(true)
  for _, quality in pairs(selectedQuality) do
    if m_allQualityActors[quality] ~= nil then
      local filteredActors = FilterActors(m_allQualityActors[quality], m_filterFunc)
      for _, actor in pairs(filteredActors) do
        ToggleDecomposePreview(actor, true)
      end
    end
  end
  ResetWrapContent()
end

function CancelDecompose(onlyCancelSelected)
  m_resourcesPreview = {}
  m_chipsPreview = {}
  m_selectedUids = _ENV["!"]({})
  LU.Set(REF.WrapContentResources, #m_resourcesPreview)
  LU.Set(REF.WrapContentChips, #m_chipsPreview)
  local wrapContent = REF.WrapContentActor
  for i = 0, #wrapContent - 1 do
    for j = 0, #wrapContent[i]["$"] - 1 do
      local iconDetail = wrapContent[i]["$"][j]
      iconDetail["$$SetSelected"](false)
    end
  end
end

function OnActorQualityData(actors)
  if actors == nil then
    return
  end
  local xlsx = PB.get("Sort", 30)
  SU.SortOnce(actors, xlsx, true)
  m_allQualityActors = {}
  local decomposeId = {}
  local stayId = {}
  local stayIdMaxQuality = {}
  for i = 1, #actors do
    local actor = actors[i]
    if actor.star == 1 and actor.level == 1 and AU.ActorDeleteValidate(actor.uid) and AU.ActorTalentScore(actor) == Quality2BaseScore[actor.quality] and not actor.isLock then
      decomposeId[actor.id] = true
      m_allQualityActors[actor.quality] = m_allQualityActors[actor.quality] or {}
      table.insert(m_allQualityActors[actor.quality], actor)
    else
      stayId[actor.id] = true
      if stayIdMaxQuality[actor.id] then
        stayIdMaxQuality[actor.id] = math.max(actor.quality, stayIdMaxQuality[actor.id])
      else
        stayIdMaxQuality[actor.id] = actor.quality
      end
    end
  end
  for id, _ in pairs(decomposeId) do
    if stayId[id] == nil then
      for i = 3, 1, -1 do
        if m_allQualityActors[i] ~= nil then
          local index = table.find(m_allQualityActors[i], function(_, actor)
            return actor.id == id
          end)
          if index ~= nil then
            table.remove(m_allQualityActors[i], index)
            break
          end
        end
      end
    elseif stayIdMaxQuality[id] < PB.enum.ActorQuality.Purple and m_allQualityActors[PB.enum.ActorQuality.Purple] then
      do
        local index = table.find(m_allQualityActors[PB.enum.ActorQuality.Purple], function(_, actor)
          return actor.id == id
        end)
        if index ~= nil then
          table.remove(m_allQualityActors[PB.enum.ActorQuality.Purple], index)
        end
      end
    end
  end
end

function FilterActors(actors, filterFunc)
  if actors and 0 < #actors and filterFunc then
    local filteredActors = {}
    for i = 1, #actors do
      if filterFunc(actors[i]) then
        table.insert(filteredActors, actors[i])
      end
    end
    return filteredActors
  end
  return actors
end

function OnSortFinished(data)
  if data ~= nil and REF["$SortMate"] == data.sortMate then
    m_actors = data.list
    ResetWrapContent()
  end
end

function Focus(on)
  SortFocusBase.FocusActor(on, function()
    ClearSelection()
  end)
  WU.RecordWindowFocus(100152, on)
end
