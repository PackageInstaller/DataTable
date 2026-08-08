local Base = inherit("Window/ActorGroup/ActorGroupBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local GU = require("Common/GroupUtil")
local DBH = require("Manager/DataBindingHandler")
local DU = require("Common/DungeonUtil")
local EU = require("Common/EquipUtil")
local LU = require("Common/ListUtil")
local S = require("Common/Singleton")
local m_repeatedContext = {}
local m_dungeonId, m_replayTween, m_chapterId, m_chapter, m_groups, m_selectedGroupId, m_reloadAura, m_forTutorial
local m_autoSelect = true

function SetupWindow()
  Base.SetupWindow()
  REF.WidgetGroupMembers["$SetShowHint"](true)
  REF.WidgetGroupMembers["$SetClickCallback"](OnActorGroupButtonClick)
  REF.WidgetGroupMembers["$AllowDragDrop"](function(patchData)
    m_groups[tostring(m_selectedGroupId)] = patchData
    OnActorGroupChanged(m_groups)
  end)
  WU.BindButtonEvent(REF.ButtonAddTimes, OnButtonAddTimesClick)
  Base.SetData("OnButtonAddTimesClick", OnButtonAddTimesClick)
  Base.SetData("Fight", Fight)
end

function InitWindow()
  Base.InitAutoFight(PB.enum.DungeonType.Normal)
  m_reloadAura = true
  this:Bind("ActorGroup/DungeonId", OnActorGroupDungeonId)
  this:Bind("ActorGroup/ChapterId", OnActorGroupChapterId)
  this:RegisterGameEvent("ResourceExchangeSucceed", OnResourceExchangeSucceed)
  this:RegisterGameEvent("TutorialActorGroup", OnAutoSelect)
end

function UninitWindow()
  this:SetData("equipMinRequireLevelPosMap", nil)
end

function SaveContext()
  table.insert(m_repeatedContext, {dungeonId = m_dungeonId, chapterId = m_chapterId})
  m_reloadAura = true
end

function LoadContext()
  if 0 < #m_repeatedContext then
    local context = m_repeatedContext[#m_repeatedContext]
    this:SetData("ActorGroup/DungeonId", context.dungeonId)
    this:SetData("ActorGroup/ChapterId", context.chapterId)
    table.remove(m_repeatedContext, #m_repeatedContext)
  end
end

function OnActorGroupDungeonId(dungeonId)
  if dungeonId == nil then
    return
  end
  m_dungeonId = dungeonId
  Base.SetData("displayAttrs", false)
  Base.RefreshAttrDisplay()
  m_replayTween = true
  Base.SetData("powerMultiple", 1)
  REF.WidgetStarGridMTargets["$SetStar"](0)
  WU.ToggleRendering(REF.WidgetGroupMembers, false)
  if not WU.IsStandaloneGame() and m_reloadAura then
    m_reloadAura = false
    Base.ResetAuraSelection()
  end
  Base.OnDungeonInfo(dungeonId)
  this:BindRemote(DB:GameRequest("fci/SelectedGroupId/StoryMode/"), OnSelectedActorGroupId)
  if this:GetData("equipMinRequireLevelPosMap") == nil then
    EU.InitEquipMinRequireLevelByPos()
  end
  local triggered = S:Get("UnforcedTutorialManager").HasTriggered(1113)
  WU.ToggleRendering(REF.WidgetAuraSelection, triggered or 4 <= m_dungeonId)
  if m_dungeonId == 4 then
    WU.TriggerUnforcedTutorial(1113)
  end
end

function OnActorGroupChapterId(chapterId)
  if chapterId == nil then
    return
  end
  if m_chapterId ~= nil then
    this:Unbind("fci/dungeon/chapter/" .. m_chapterId, OnChapterInfoChanged)
  end
  m_chapterId = chapterId
  this:Bind("fci/dungeon/chapter/" .. m_chapterId, OnChapterInfoChanged)
end

function OnChapterInfoChanged(chapter)
  if chapter == nil then
    return
  end
  m_chapter = chapter
  local record = chapter.recordDungeons[m_dungeonId]
  Base.SetLeftTimes(record)
  local isMultiPowerLocked = WU.WindowIsLocked(PB.enum.UnlockWindow.MultiPower)
  local multiPowerShow = DU.IsShowStar(m_dungeonId)
  REF.ButtonMultiPower.BoxCollider2D.enabled = multiPowerShow
  REF.SpriteMultiPower.gameObject:SetActive(multiPowerShow)
  REF.SpriteMultiPower.UISprite.alpha = fif(isMultiPowerLocked, 0.3, 1)
  local starCount = 0
  if multiPowerShow then
    starCount = fif(record.finished, #record.targetsDone, 0)
  end
  Base.ShowStars(starCount)
  WU.ToggleRendering(REF.PowerDropList, false)
  if not isMultiPowerLocked and multiPowerShow then
    Base.SetMultiPowerStatus(record)
  end
end

function OnSelectedActorGroupId(result)
  if result then
    m_selectedGroupId = fif(tonumber(result.selectActorGroupId) == 0, 1, tonumber(result.selectActorGroupId))
    this:Unbind("fci/ActorGroup/", OnActorGroupChanged)
    this:BindRemote(DB:GameRequest("fci/ActorGroup/"), OnActorGroupChanged)
  end
end

function OnActorGroupButtonClick(go)
  this:SetData("AutoSlotSelection", _ENV["$"](go)["@index"])
  WU.AcquireWindowAsync("ActorSelect", function()
    this:SetData("ActorSelect/Mode", PB.enum.ActorGroupType.Dungeon)
  end)
end

function OnActorGroupChanged(actorGroup)
  if actorGroup ~= nil then
    m_groups = actorGroup
    local members = actorGroup[tostring(m_selectedGroupId)].members
    local curTutorial = this:GetData("CurrentTutorial")
    if curTutorial and curTutorial == 33 then
      this:BroadcastGameEvent("Tutorial/StepReady")
    elseif m_dungeonId and m_dungeonId == 2013 then
      this:BroadcastGameEvent("Tutorial/TriggerTutorial", "ActorGroup")
    end
    Base.Member2FightActorInfo(members)
    Base.RefreshGroupMembersAndTween(members, m_replayTween)
    m_replayTween = false
    if m_forTutorial or this:GetData("TutorialLevel13") then
      this:BroadcastGameEvent("TutorialActorGroup")
    end
    if this:GetData("CurrentTutorial") == 40 then
      this:BroadcastGameEvent("Tutorial/StepReady")
    end
  end
end

function Fight()
  if m_groups == nil then
    return
  end
  if m_forTutorial then
    WU.EnterStoryDungeon(m_dungeonId, nil, nil, PB.enum.DungeonType.Story)
    return
  end
  local members = m_groups[tostring(m_selectedGroupId)].members
  if GU.GroupIsOK(members, true) then
    local isReach, testResult = Base.FightAfterCultivationTest(members, m_dungeonId)
    if isReach then
      RequestPostDungeon()
    else
      Base.FightCultivationHint(testResult, RequestPostDungeon)
    end
  end
end

function RequestPostDungeon()
  local triggered = S:Get("UnforcedTutorialManager").HasTriggered(1113)
  if not triggered and m_dungeonId < 4 then
    this:SetData("Assistant/Aura", nil)
  end
  local members = m_groups[tostring(m_selectedGroupId)].members
  Base.Member2FightActorInfo(members)
  this:GameRequest("fci/ActorGroup/"):Put({actorGroups = m_groups}, function(resp)
    this:BroadcastGameEvent("MedalAttrAppend")
    local powerMultiple = Base.GetData("powerMultiple")
    local param = {
      dungeonId = m_dungeonId,
      selectActorGroupId = m_selectedGroupId,
      multiPower = powerMultiple,
      price = DU.GetDungeonPrice(m_dungeonId)
    }
    Base.AppendAuraAttrs(param)
    this:SetData("PowerMultiple", powerMultiple)
    this:SetData("WindowDungeon/EnterParam", param)
    this:SetData("BalanceInfo/Groups", {groups = m_groups, selectedGroupId = m_selectedGroupId})
    this:GameRequest("fci/dungeon/"):Post(param, function(result)
      this:SetData("EnteredChapterId", m_chapterId)
      this:SetData("WindowDungeon/ChapterId", m_chapterId)
      DBH.ResChange(result.resChange)
      WU.EnterGameLevel(result.dungeonUid, result.baseInfo, m_dungeonId, PB.enum.DungeonType.Normal, 1, true)
    end)
  end)
end

function GetDungeonStar()
  return #m_chapter.recordDungeons[m_dungeonId].targetsDone
end

function OnButtonAddTimesClick()
  WU.Exchange(PB.enum.ResourceType.ResDungeonPlayTimesLimit, m_dungeonId, true)
end

function OnResourceExchangeSucceed(buy)
  if buy.type == PB.enum.ResourceType.ResDungeonPlayTimesLimit then
    m_chapter.recordDungeons[m_dungeonId].doneTimes = m_chapter.recordDungeons[m_dungeonId].doneTimes - buy.count
    this:SetData("fci/dungeon/chapter/" .. m_chapterId, m_chapter)
    this:BroadcastGameEvent("RefreshChipExchangeDungeon")
  end
end

function Focus(on)
  if on and m_groups then
    local members = m_groups[tostring(m_selectedGroupId)].members
    Base.RefreshGroupMembersAndTween(members, true)
  end
end

function TutorialOnly()
  m_forTutorial = true
  WU.ToggleRendering(REF.WidgetAuraSelection, false)
  WU.ToggleRendering(REF.ButtonMultiPower, false)
  CS.SoundManager.Instance:PlayMusic("91Act_M2")
end

function OnAutoSelect()
  if m_autoSelect then
    OnActorGroupButtonClick(REF.DragDropNodeSub.gameObject)
    m_autoSelect = false
  end
end

function GetTutorialIndicator(id, step)
  local target, Highlight
  if id == 40 and step == 41 then
    local members = m_groups[tostring(m_selectedGroupId)].members
    local index = table.find(members, function(k, v)
      return v.actorUid == 0
    end)
    if index then
      target = REF.Grid[index - 1].DragDropNodeMain.gameObject
      Highlight = REF.Grid[index - 1].PlaceMain.gameObject
    end
  end
  if target ~= nil then
    local ref = _ENV["$"](target)
    local indicator = target:AddComponent(typeof(CS.TutorialIndicator))
    indicator.Highlight = Highlight
    indicator.Target = ref.root.gameObject
    return indicator
  end
end
