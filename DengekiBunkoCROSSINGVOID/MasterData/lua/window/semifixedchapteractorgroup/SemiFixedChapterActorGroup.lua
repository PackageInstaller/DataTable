local Base = inherit("Window/ActorGroup/ActorGroupBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GroupUtil")
local DBH = require("Manager/DataBindingHandler")
local DU = require("Common/DungeonUtil")
local EU = require("Common/EquipUtil")
local AU = require("Common/ActorUtil")
local DU = require("Common/DungeonUtil")
local m_dungeonId, m_replayTween, m_chapter, m_chapterId, m_groups, m_callBind, m_reloadAura, m_selectedGroupId
local m_repeatedContext = {}

function SetupWindow()
  Base.SetupWindow()
  REF.WidgetGroupMembers["$SetClickCallback"](OnActorGroupButtonClick)
  REF.WidgetGroupMembers["$AllowDragDrop"](function(patchData)
    if not LegalCheckNpc(patchData.members) then
      return
    end
    m_groups.groupInfo = patchData
    this:SetData("fci/npc-dungeon/actorgroup/" .. m_dungeonId, m_groups)
  end)
  Base.SetData("Fight", Fight)
end

function InitWindow()
  m_callBind = true
  Base.InitAutoFight(PB.enum.DungeonType.SemiFixed)
  REF.DescribeNode.transform.localPosition = CS.UnityEngine.Vector3(-912, -473, 0)
  m_reloadAura = true
  WU.SetActive(REF.CarnivalAdditions, false)
  this:Bind("ActorGroup/DungeonId", OnActorGroupDungeonId)
  this:Bind("ActorGroup/ChapterId", OnActorGroupChapterId)
end

function UninitWindow()
  this:SetData("equipMinRequireLevelPosMap", nil)
end

function OnActorGroupDungeonId(dungeonId)
  if dungeonId == nil then
    return
  end
  if WU.TopWindow().name ~= "SemiFixedChapterActorGroup" then
    return
  end
  if not m_callBind then
    m_callBind = true
    return
  end
  if m_dungeonId ~= nil then
    this:Unbind("fci/npc-dungeon/actorgroup/" .. m_dungeonId, OnActorGroupChanged)
  end
  m_dungeonId = dungeonId
  Base.SetData("displayAttrs", false)
  Base.RefreshAttrDisplay()
  m_replayTween = true
  Base.SetData("powerMultiple", 1)
  REF.WidgetStarGridMTargets["$SetStar"](0)
  WU.ToggleRendering(REF.WidgetGroupMembers, false)
  if m_reloadAura then
    m_reloadAura = false
    Base.ResetAuraSelection()
  end
  Base.OnDungeonInfo(dungeonId)
  this:BindRemote(DB:GameRequest("fci/SelectedGroupId/StoryMode/"), OnSelectedActorGroupId)
  if this:GetData("equipMinRequireLevelPosMap") == nil then
    EU.InitEquipMinRequireLevelByPos()
  end
end

function OnActorGroupChapterId(chapterId)
  if chapterId == nil then
    return
  end
  if WU.TopWindow().name ~= "SemiFixedChapterActorGroup" then
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

function OnDungeonRecord(result)
  if result == nil then
    return
  end
  local records = result.records
  local _, record = table.find(records, function(_, v)
    return v.dungeonId == m_dungeonId
  end)
  if record then
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
  else
    warning("SemiFixedActorGroup", "no record for dungeonId -> " .. tostring(m_dungeonId))
  end
end

function OnActorGroupButtonClick(go)
  m_callBind = false
  this:SetData("AutoSlotSelection", _ENV["$"](go)["@index"])
  this:SetData("ActorGroup/DungeonId", m_dungeonId)
  WU.AcquireWindowAsync("SemiFixedChapterActorSelect")
end

function OnActorGroupChanged(actorGroup)
  if actorGroup then
    local members = actorGroup.groupInfo.members
    m_groups = actorGroup
    RefreshSemiFixedDungeonNPC(m_dungeonId, m_groups)
    RefreshGroupMembersAndTween(members, m_replayTween)
    m_replayTween = false
  end
end

function LegalCheckNpc(members)
  local legal = true
  local semiFixedDungeon = PB.get("NPCDungeonInfo", m_dungeonId)
  local npcPos = semiFixedDungeon.isNpc
  if members == nil or semiFixedDungeon == nil then
    return
  end
  for i = 1, #members do
    if members[i].isNpc and npcPos[i] ~= 1 or not members[i].isNpc and npcPos[i] == 1 and (members[i].actorUid ~= 0 or members[i].npcId ~= 0) then
      WU.ShowHintText(WU.GetString("Window_PosNpcForbidden"))
      return false
    end
  end
  return legal
end

function RefreshAdditions(members)
  local npcInfo = {}
  for i = 1, #members do
    local member = members[i]
    if member.isNpc then
      local actor = PB.get("DungeonNPC", member.npcId)
      if actor == nil then
        warning("DungeonNPC", "can't find npc id -> " .. tostring(member.npcId))
      else
        AU.RenameDungeonNPCFields(actor)
        table.insert(npcInfo, actor)
      end
    end
  end
  REF.AdditionsInfo.UILabel.text = fif(table.empty(npcInfo), WU.GetString("Window_SemiFixedAdditionsNoActor"), WU.GetString("Window_SemiFixedAdditionsActors"))
  local additionsActors = ""
  for i = 1, #npcInfo do
    additionsActors = additionsActors .. WU.GetString("ActorName_" .. npcInfo[i].id)
    if i ~= #npcInfo then
      additionsActors = additionsActors .. "\227\128\129"
    end
  end
  REF.AdditionsActors.UILabel.text = additionsActors
  WU.SetActive(REF.AdditionsOutput, not table.empty(npcInfo))
  WU.SetActive(REF.CarnivalAdditions, true)
end

function RefreshSemiFixedDungeonNPC(dungeonId, groups)
  local semiFixedDungeon = PB.get("NPCDungeonInfo", dungeonId)
  local members = groups.groupInfo.members
  if members == nil or semiFixedDungeon == nil then
    return
  end
  for i = 1, #members do
    local grouped = table.find(members, function(_, v)
      return v.index + 1 == i and v.isNpc
    end)
    if grouped and members[grouped].actorUid ~= 0 then
      members[grouped].npcId = members[grouped].actorUid
    end
  end
end

function Fight()
  local members = m_groups.groupInfo.members
  if GU.GroupIsOK(members, true) then
    local isReach, testResult = Base.FightAfterCultivationTest(members, m_dungeonId)
    if isReach then
      RequestPostDungeon()
    else
      Base.FightCultivationHint(testResult, RequestPostDungeon)
    end
  end
end

function OnSelectedActorGroupId(result)
  if result then
    m_selectedGroupId = fif(tonumber(result.selectActorGroupId) == 0, 1, tonumber(result.selectActorGroupId))
    this:Unbind("fci/npc-dungeon/actorgroup/" .. m_dungeonId, OnActorGroupChanged)
    this:BindRemote(DB:GameRequest("fci/npc-dungeon/actorgroup/" .. m_dungeonId), OnActorGroupChanged)
  end
end

function RequestPostDungeon()
  local members = m_groups.groupInfo.members
  Base.Member2FightActorInfo(members)
  local fightActorInfo = this:GetData("FightActorInfo")
  for k, v in pairs(m_groups.groupInfo.members) do
    if v.isNpc and v.actorUid == 0 then
      v.actorUid = v.npcId
    end
  end
  this:GameRequest("fci/npc-dungeon/actorgroup/" .. m_dungeonId):Put(m_groups, function(resp)
    local powerMultiple = Base.GetData("powerMultiple")
    local param = {dungeonId = m_dungeonId, multiPower = powerMultiple}
    Base.AppendAuraAttrs(param)
    this:SetData("PowerMultiple", powerMultiple)
    this:SetData("WindowDungeon/EnterParam", param)
    local balanceGroup = _ENV["!"]({})
    balanceGroup.selectedGroupId = m_selectedGroupId
    balanceGroup.groups = _ENV["!"]({})
    balanceGroup.groups[tostring(m_selectedGroupId)] = m_groups.groupInfo
    this:SetData("BalanceInfo/Groups", balanceGroup)
    this:GameRequest("fci/dungeon/"):Post(param, function(result)
      this:SetData("ActorGroup/DungeonId", m_dungeonId)
      this:SetData("ActorGroup/ChapterId", m_chapterId)
      this:SetData("SemiFixedChapterIn", true)
      this:SetData("EnteredChapterId", m_chapterId)
      this:SetData("WindowDungeon/ChapterId", m_chapterId)
      DBH.ResChange(result.resChange)
      WU.EnterGameLevel(result.dungeonUid, result.baseInfo, m_dungeonId, PB.enum.DungeonType.Normal, 1, true)
    end)
  end)
end

function Focus(on)
  if on and m_groups then
    local members = m_groups.groupInfo.members
    RefreshGroupMembersAndTween(members, true)
  end
  if on then
    WU.SetWindowTitle("SemiFixedChapterActorGroup", "ActorGroup")
  end
end

function RefreshGroupMembersAndTween(members, replay)
  if m_dungeonId == nil then
    return
  end
  local semiFixedDungeon = PB.get("NPCDungeonInfo", m_dungeonId)
  REF.WidgetGroupMembers["$Set91GroupMembers"](members)
  if REF.WidgetGroupCultivation then
    REF.WidgetGroupCultivation["$SetGroupMembers"](members)
  elseif REF.WidgetGroupCultivation4Group then
    REF.WidgetGroupCultivation4Group["$SetGroupMembers"](members)
  end
  REF.WidgetGroupMembers["$ShowCustom"]({showNew = false, showName = true})
  WU.ToggleRendering(REF.WidgetGroupMembers, true)
  if replay then
    REF.WidgetGroupMembers.UIPlayTween.enabled = false
    REF.WidgetGroupMembers.UIPlayTween.enabled = true
  end
end

function SaveContext()
  table.insert(m_repeatedContext, {dungeonId = m_dungeonId, chapterId = m_chapterId})
end

function LoadContext()
  local context = m_repeatedContext[#m_repeatedContext]
  this:SetData("ActorGroup/DungeonId", context.dungeonId)
  this:SetData("ActorGroup/ChapterId", context.chapterId)
  table.remove(m_repeatedContext, #m_repeatedContext)
end
