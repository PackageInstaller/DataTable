local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GroupUtil")
local AU = require("Common/ActorUtil")
local NU = require("Common/NotepadUtil")
local m_actors, m_selectedActorsForShow
local m_selectActorType = PB.enum.ActorType.None
local m_curMainActorCount = 0
local m_curSubActorCount = 0

function SetupWindow()
  WU.BindButtonEvent(REF.Confirm, OnConfirmFormation)
end

function InitWindow()
  m_selectActorType = PB.enum.ActorType.None
  m_curMainActorCount = 0
  m_curSubActorCount = 0
  m_selectedActorsForShow = nil
  WU.ToggleRendering(REF.NodeTitle, false)
  WU.ToggleRendering(REF.NodeActors, false)
  WU.ToggleRendering(REF.WidgetBurstLinkSelectedActor, false)
  for i = 0, #REF.GridActors - 1 do
    REF.GridActors[i].AlphaControl.UIWidget.alpha = 0
    WU.ToggleRendering(REF.GridActors[i]["$"], false)
  end
  REF.Confirm.BoxCollider2D.enabled = false
  _ENV["$"](REF.Confirm).Sprite.UISprite.graify = true
  this:RegisterGameEvent("ActivityStatusChanged", OnActivityStatusChanged)
  this:RegisterGameEvent("SelectActorChanged", OnSelectActorChanged)
  RequestSelectActorProgress()
end

function UninitWindow()
end

function OnActivityStatusChanged(category, activityId, status)
  if category == PB.enum.ActivityCategory.Tournament and this:GetData("fci/tournament/curId") == activityId and (status == PB.enum.ActivityStatus.Finished or status == PB.enum.ActivityStatus.Close) then
    WU.RecycleWindow(this)
  end
end

function OnSelectActorChanged(curMainActorCount, curSubActorCount, selectActor)
  m_curMainActorCount = curMainActorCount
  m_curSubActorCount = curSubActorCount
  local actorIndex = m_curMainActorCount + m_curSubActorCount
  if 6 < actorIndex then
    actorIndex = 6
  end
  SetSelectedActor(selectActor, actorIndex)
  if m_curMainActorCount + m_curSubActorCount < 6 then
    if m_curMainActorCount <= m_curSubActorCount then
      SetMainActorSelect(m_curMainActorCount + 1)
      RequestSelectActorInfo()
    else
      SetSubActorSelect(m_curSubActorCount + 1)
      RequestSelectActorInfo()
    end
  else
    for i = 0, #REF.GridActors - 1 do
      REF.GridActors[i].ButtonSlot.BoxCollider2D.enabled = false
    end
    REF.Confirm.BoxCollider2D.enabled = true
    _ENV["$"](REF.Confirm).Sprite.UISprite.graify = false
  end
end

function SetSelectedActor(selectActor, actorIndex)
  if selectActor and 0 < #selectActor then
    table.insert(m_selectedActorsForShow, 1, selectActor[1])
    REF.WidgetBurstLinkSelectedActor["$SetActorByIndex"](selectActor[1], actorIndex, ShowActorSkill)
    REF.WidgetBurstLinkSelectedActor["$SetNextHightlight"](actorIndex + 1)
  end
end

function RequestSelectActorProgress()
  this:GameRequest("fci/BurstLinkPVPRandActorInfo/"):Get(function(response)
    if response ~= nil then
      WU.ToggleRendering(REF.NodeTitle, true)
      if response.curMainActor then
        m_curMainActorCount = #response.curMainActor
      end
      if response.curAssistantActor then
        m_curSubActorCount = #response.curAssistantActor
      end
      info("selected actors", "size=" .. tostring(#response.selectActor) .. " " .. table.dump(response.selectActor))
      SetSelectedActors(response.selectActor)
      SetTitle()
      RequestSelectActorInfo()
    end
  end)
end

function RequestSelectActorInfo()
  this:GameRequest("fci/BurstLinkPVPRandActorInfo/" .. tostring(m_selectActorType) .. "/"):Post({}, function(response)
    if response ~= nil then
      if response.curMainActor then
        m_curMainActorCount = #response.curMainActor
      end
      if response.curAssistantActor then
        m_curSubActorCount = #response.curAssistantActor
      end
      m_actors = response.randActor
      this:SetData("BurstLink/ActorSelect/SelectActors/", m_actors)
      SetActors()
    end
  end)
end

function SetTitle()
  if m_curMainActorCount + m_curSubActorCount < 6 then
    if m_curMainActorCount <= m_curSubActorCount then
      SetMainActorSelect(m_curMainActorCount + 1)
    else
      SetSubActorSelect(m_curSubActorCount + 1)
    end
  else
    SetSubActorSelect(m_curSubActorCount)
    REF.Confirm.BoxCollider2D.enabled = true
    _ENV["$"](REF.Confirm).Sprite.UISprite.graify = false
  end
end

function SetMainActorSelect(curSelectIndex)
  REF.LabelTitle.UILabel.text = WU.GetString("Tournament_BurstLinkMainActorSelect", curSelectIndex, 3)
  m_selectActorType = PB.enum.ActorType.Main
  this:SetData("BurstLink/ActorSelect/SelectActorType/", m_selectActorType)
end

function SetSubActorSelect(curSelectIndex)
  REF.LabelTitle.UILabel.text = WU.GetString("Tournament_BurstLinkSubActorSelect", curSelectIndex, 3)
  m_selectActorType = PB.enum.ActorType.Sub
  this:SetData("BurstLink/ActorSelect/SelectActorType/", m_selectActorType)
end

function SetActors()
  local canClick = false
  if m_curMainActorCount + m_curSubActorCount < 6 then
    canClick = true
  end
  local relationActor
  if m_selectedActorsForShow then
    if canClick then
      if 0 < #m_selectedActorsForShow then
        relationActor = m_selectedActorsForShow[1]
      end
    elseif 1 < #m_selectedActorsForShow then
      relationActor = m_selectedActorsForShow[2]
    end
  end
  if m_actors then
    WU.ToggleRendering(REF.NodeActors, true)
    for i = 0, #REF.GridActors - 1 do
      local hasActor = i + 1 <= #m_actors
      if hasActor then
        local actor = m_actors[i + 1]
        REF.GridActors[i]["$$SetActorData"](actor, i + 1)
        if m_selectActorType == PB.enum.ActorType.Sub then
          if relationActor then
            REF.GridActors[i]["$$ShowRelationEffect"](AU.IsLinked(actor, relationActor))
          end
        else
          REF.GridActors[i]["$$ShowRelationEffect"](false)
        end
      end
      REF.GridActors[i].ButtonSlot.BoxCollider2D.enabled = canClick
      REF.GridActors[i].AlphaControl.UIWidget.alpha = 0
      this:DelayInvokeInSeconds(0.07 * i, function()
        WU.RecordButtonClick(100127101)
        WU.ToggleRendering(REF.GridActors[i]["$"], hasActor)
        REF.GridActors[i].Visual.UIPlayTween:Play(true)
      end)
    end
  end
end

function SetSelectedActors(selectedActors)
  m_selectedActorsForShow = {}
  for i = 1, m_curMainActorCount do
    if i <= #selectedActors then
      table.insert(m_selectedActorsForShow, selectedActors[i])
    end
    if i + m_curMainActorCount <= #selectedActors then
      table.insert(m_selectedActorsForShow, selectedActors[i + m_curMainActorCount])
    end
  end
  REF.WidgetBurstLinkSelectedActor["$SetActors"](m_selectedActorsForShow, ShowActorSkill)
  table.reverse(m_selectedActorsForShow)
  WU.ToggleRendering(REF.WidgetBurstLinkSelectedActor, true)
end

function ShowActorSkill(go)
  local actor = _ENV["$"](go)["@actor"]
  if actor then
    NU.OpenNotepadForActor(actor)
  end
end

function OnConfirmFormation()
  WU.RecordButtonClick(100127102)
  local groups = {}
  local members = {}
  local index = 0
  for i = 1, m_curMainActorCount do
    local uidIndex = #m_selectedActorsForShow - 2 * (i - 1)
    local actorUid = 0
    local actorId = 0
    if 0 < uidIndex then
      actorUid = m_selectedActorsForShow[uidIndex].uid
      actorId = m_selectedActorsForShow[uidIndex].id
    end
    table.insert(members, {
      index = index,
      actorUid = actorUid,
      actorId = actorId
    })
    index = index + 1
  end
  for i = 1, m_curSubActorCount do
    local uidIndex = #m_selectedActorsForShow - 1 - 2 * (i - 1)
    local actorUid = 0
    if 0 < uidIndex then
      actorUid = m_selectedActorsForShow[uidIndex].uid
    end
    table.insert(members, {index = index, actorUid = actorUid})
    index = index + 1
  end
  groups["1"] = {members = members}
  this:SetData("fci/BurstLinkPvpActor", nil)
  this:GameRequest("fci/BurstLinkPvpActorGroup/"):Put({actorGroups = groups}, function(response)
    this:SetData("fci/BurstLinkPvpActorGroup/", groups)
    DB:HandleRemoteChanged("fci/tournament/summary")
    WU.AcquireWindowAsync("BurstLinkActorGroup", nil, true)
  end)
end

function Focus(on)
  WU.RecordWindowFocus(1001271, on)
end
