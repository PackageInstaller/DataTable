local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local SU = require("Common/SortUtil")
local GU = require("Common/GroupUtil")
local Type2Preview = {
  [PB.enum.ActivityType.CustomActorCultivation] = "CustomActorCultivation/PreviewSelectedId",
  [PB.enum.ActivityType.Couple] = "CoupleActorCultivation/PreviewSelectedId"
}
local m_previewSelectedId, m_type, m_actorList, m_tmpFilteredActorMap, m_advancedFilters, m_displayOption, m_displayNumbers, m_firstEnter

function SetupWindow()
  LU.Bind(REF.WrapContentActors, {
    updateRow = UpdateActorSlot
  })
  WU.BindButtonEvent(REF.ButtonSelect, function()
    if m_type == PB.enum.ActivityType.CustomActorCultivation then
      OnClickSelect()
    elseif m_type == PB.enum.ActivityType.Couple then
      OnCoupleSelect()
    end
  end)
end

function InitWindow()
  m_firstEnter = true
end

function UninitWindow()
  this:SetData("SortFinished", nil)
end

function OnSortFinished(data)
  if data ~= nil and REF["$SortMate"] == data.sortMate then
    local sortMate = data.sortMate
    m_advancedFilters = data.advancedFilters
    REF.SortFullScreenFilters["$FilterContext"](m_advancedFilters)
    local RobotActorIds = {
      3001,
      3002,
      3003,
      3004,
      4001,
      4002,
      4003,
      4004
    }
    if m_type == PB.enum.ActivityType.Couple then
      RobotActorIds = {}
    end
    local originalIdxTbl = {}
    m_actorList = _ENV["!"](SU.ApplyFilters(data.list, m_advancedFilters)):where(function(k, v)
      return not table.has(RobotActorIds, v.id) and PB.get("ActorConfig", v.id).isLimited ~= 1
    end):toarray()
    local l = #m_actorList
    for i, v in ipairs(m_actorList) do
      originalIdxTbl[v.uid] = i
    end
    m_actorList = m_actorList:filter("id", function(src, dst)
      if src.level ~= dst.level then
        return src.level > dst.level
      end
      if src.curExp ~= dst.curExp then
        return src.curExp ~ dst.curExp
      end
      if src.quality ~= dst.quality then
        return src.quality > dst.quality
      end
    end)
    local r = _ENV["!"]({})
    for _, v in pairs(m_actorList) do
      r[originalIdxTbl[v.uid]] = v
    end
    local t = _ENV["!"]({})
    m_actorList = {}
    for i = 1, l do
      if r[i] then
        table.insert(m_actorList, r[i])
      end
    end
    m_displayOption = SU.DisplayOption[data.advancedFilters.displayOption]
    local id = sortMate.ids[sortMate.tabIndex]
    for _, ids in pairs(SU.DisplayNumbers) do
      if table.find(ids, function(_, v)
        return v == id
      end) then
        m_displayNumbers = ids
      end
    end
    RefreshWrapContent()
  end
end

function RefreshWrapContent()
  LU.Set(REF.WrapContentActors, #m_actorList)
  if m_firstEnter then
    local index = table.find(m_actorList, function(k, v)
      return v.id == this:GetData(m_previewSelectedId)
    end)
    if index then
      local movement = math.clamp(REF.AnchorScrollViewActors.UIWidget.width / 2 - (index - 0.5) * REF.WrapContentActors.UIWrapContent.itemSize, REF.AnchorScrollViewActors.UIWidget.width - #m_actorList * REF.WrapContentActors.UIWrapContent.itemSize + 50, 0)
      this:DelayInvokeInFrames(1, function()
        REF.ScrollViewActors.UIScrollView:MoveRelative(CS.UnityEngine.Vector3(movement, 0, 0))
      end)
    end
    m_firstEnter = false
  end
end

function UpdateActorSlot(slotRef, wrapIndex, realIndex)
  if realIndex ~= nil and m_actorList and realIndex < #m_actorList then
    local actor = m_actorList[realIndex + 1]
    slotRef["$$BindActor"](actor)
    slotRef["$$SetHighlighted"](actor.id == this:GetData(m_previewSelectedId))
    local inWhichGroup
    if m_displayOption == SU.DisplayOption.group then
      inWhichGroup = GU.GetActorInWhichGroups(actor.uid)
    end
    slotRef["$$ShowCustom"]({
      showEquips = m_displayOption == SU.DisplayOption.equip,
      showName = m_displayOption == SU.DisplayOption.name,
      showArm = m_displayOption == SU.DisplayOption.arm,
      showCultivationTotal = m_displayNumbers == SU.DisplayNumbers.Cultivation,
      showSpeed = m_displayNumbers == SU.DisplayNumbers.Speed,
      showStar = m_displayNumbers == SU.DisplayNumbers.Star,
      showGroup = inWhichGroup
    })
    slotRef["$$SetClickCallback"](function()
      this:SetData(m_previewSelectedId, actor.id)
      ClearHighlighted()
      slotRef["$$SetHighlighted"](actor.id == this:GetData(m_previewSelectedId))
    end)
  end
end

function ClearHighlighted()
  for i = 0, #REF.WrapContentActors - 1 do
    REF.WrapContentActors[i]["$$SetHighlighted"](false)
  end
end

function OnClickSelect()
  local actorId = this:GetData(m_previewSelectedId)
  if actorId then
    local activity = this:GetData("CustomActorCultivation/CurActivity")
    this:GameRequest("fci/custom-actor-cultivation/"):Post({
      activityType = PB.enum.ActivityType.CustomActorCultivation,
      activityId = activity.activityId,
      actorId = actorId
    }, function(resp)
      local acIndex = this:GetData("CustomActorCultivation/ActivityIndex")
      DB:BroadcastGameEvent("SetViewInfo", "CustomActorCultivation" .. acIndex, {
        actorId = actorId,
        text = WU.GetString("ProgressTask_CustomConfirm"),
        canGet = false
      })
      this:SetData("fci/custom-actor-cultivation/", resp)
      WU.RecycleWindow(this)
    end)
  end
end

function OnCoupleSelect()
  local actorId = this:GetData(m_previewSelectedId)
  if actorId then
    this:GameRequest("fci/couple/reward-preview/"):Post({coupleActorId = actorId}, function(resp)
      WU.SetGameDataCache("couple/reward-preview", {
        actorId = actorId,
        rewards = resp.reward
      })
      this:SetData("fci/couple/", this:GetData("fci/couple/"))
      WU.RecycleWindow(this)
    end)
  end
end

function SetType(type)
  m_type = type
  m_previewSelectedId = Type2Preview[type]
  local isCustom = m_type == PB.enum.ActivityType.CustomActorCultivation
  REF.LabelHint1.UILabel.text = WU.GetString(fif(isCustom, "CustomActorCultivation_Select_Hint1", "CoupleActorCultivation_Select_Hint1"))
  REF.LabelHint2.UILabel.text = WU.GetString(fif(isCustom, "CustomActorCultivation_Select_Hint2", "CoupleActorCultivation_Select_Hint2"))
  this:Unbind("SortFinished", OnSortFinished)
  this:Bind("SortFinished", OnSortFinished)
end
