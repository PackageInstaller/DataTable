local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local EU = require("Common/EquipUtil")
local m_configDataManager = S:Get("ConfigDataManager")
local ACU = require("Common/ActivityUtil")
local m_activity, m_difficultyTable, m_materialChoose, m_actorGroupId, m_difficultyId
local m_displayTable = {}
local m_indicatorPosIndex
local m_unlockList = {}
local m_mathf, m_initPos, m_curTabPos, m_indicator, m_indicatorPos, m_indecating
local m_bFirstJump = true
local m_delayInterval = 0

function SetupWindow()
  local type = this:GetData("Activity/CurrentType")
  m_indicator = REF.SpriteIndicator.transform
  m_mathf = CS.UnityEngine.Mathf
  LU.Bind(REF.MaterialWrapContent, {
    updateRow = OnMaterialSlotShow
  })
  LU.Bind(REF.DifficultyWrapContent, {
    updateRow = OnDifficultySlotShow
  })
  WU.TraverseChildren(REF.MaterialWrapContent, function(go)
    local ref = _ENV["$"](go).root
    CS.EventDelegate.Add(ref.UIToggle.onChange, function()
      if CS.UIToggle.current.value then
        m_curTabPos = ref.transform.position
        m_indecating = true
        ref["$OnButtonChooseClick"]()
        local materialId = this:GetData("Activity/CurrentMaterialId")
        local category = PB.get("ActivityDungeon", materialId).category
        if category == 1 then
          WU.SetActive(REF.EffectBg, true)
          WU.SetActive(REF.BG, false)
        elseif category == 2 then
          WU.SetActive(REF.EffectBg, false)
          WU.SetActive(REF.BG, true)
        end
      end
    end)
  end)
  this:RegisterGameEvent("ActivityStatusChanged", OnActivityStatusChanged)
end

function OnActivityStatusChanged(category, activityId, status, type, activity)
  if type == PB.enum.ActivityType.CollectionDungeon then
    local opened = ACU.IsOpenForDoing(activity)
    local i, a = m_activity:find(function(k, v)
      return v.activityId == activityId
    end)
    if opened then
      if a == nil then
        table.insert(m_activity, activity)
      end
    elseif i ~= nil then
      table.remove(m_activity, i)
    end
    this:SetData("Activity/CurrentMaterialId", nil)
    OnCurrentActivityChange(m_activity)
  end
end

function InitWindow()
  REF.DifficultyList.gameObject:SetActive(false)
  REF.MaterialList.gameObject:SetActive(false)
  this:Bind("Activity/CurrentActivity", OnCurrentActivityChange)
  this:Bind("Activity/CurrentMaterialId", OnCurrentMaterialIdChange)
  this:BindRemote(DB:GameRequest("fci/activity-dungeon/summary/"), OnActivityGroupIdChange)
  m_initPos = REF.MaterialWrapContent[m_indicatorPosIndex].root.transform.position
  local pos = m_indicator.localPosition
  m_indicator.localPosition = pos
  m_curTabPos = m_initPos
  m_indecating = true
  this:GameRequest("fci/activity-dungeon/record/"):Get(function(result)
    REF.MaterialList.gameObject:SetActive(true)
    this:SetData("fci/activity-dungeon/record/", result)
    REF.DifficultyList.gameObject:SetActive(true)
    UpdateDifficultyList()
    if this:GetData("CurrentTutorial") == 14 then
      this:BroadcastGameEvent("Tutorial/StepReady")
    end
  end)
end

function UpdateWindow(delta)
  if not m_indecating then
    return
  end
  m_indicatorPos = m_indicator.position
  if m_mathf.Abs(m_indicatorPos.y - m_curTabPos.y) > 0.005 then
    m_indicatorPos.y = m_mathf.Lerp(m_indicatorPos.y, m_curTabPos.y, delta * 6)
    m_indicator.position = m_indicatorPos
  else
    m_indicatorPos.y = m_curTabPos.y
    m_indicator.position = m_indicatorPos
    m_indecating = false
  end
end

function Goto(index, difficulty)
  if index then
    local matreialSlot = REF.MaterialWrapContent[index - 1]
    matreialSlot["$UIToggle"].value = true
  end
  if difficulty then
    REF.DifficultyWrapContent[difficulty - 1]["$$OnDifficultyChoose"]()
  end
end

function OnActivityGroupIdChange(summary)
  if summary == nil then
    return
  end
  m_actorGroupId = summary.selectActorGroupId
end

function OnCurrentActivityChange(currentActivity)
  if currentActivity == nil then
    return
  end
  m_activity = currentActivity
  LU.Set(REF.MaterialWrapContent, #m_activity)
  local toIndex
  local materialId = this:GetData("Activity/CurrentMaterialId")
  if materialId ~= nil then
    local category = PB.get("ActivityDungeon", materialId).category
    local mulId = PB.get("ActivityDungeon", materialId).multipleActivityId
    if mulId == 0 and category == 1 then
      for k, v in pairs(m_activity) do
        local mul = PB.get("ActivityDungeon", v.activityId).multipleActivityId
        if mul == materialId then
          materialId = v.activityId
        end
      end
    end
    toIndex = _ENV["!"](m_activity):find(function(k, v)
      return v.activityId == materialId
    end)
  else
    local activeActivity
    toIndex, activeActivity = _ENV["!"](m_activity):find(function(k, v)
      return ACU.IsOpenForDoing(v)
    end)
    this:SetData("Activity/CurrentMaterialId", activeActivity.activityId)
    REF.MaterialWrapContent[toIndex - 1].root["$OnButtonChooseClick"](true)
  end
  m_indicatorPosIndex = toIndex - 1
  REF.MaterialWrapContent[toIndex - 1].root.UIToggle.value = true
end

function OnCurrentMaterialIdChange(idChoose)
  if idChoose == nil then
    return
  end
  m_materialChoose = idChoose
  m_difficultyTable = PB.get("ActivityDungeon", m_materialChoose).dungeonId
  UpdateDifficultyList()
end

function UpdateDifficultyList()
  REF.DifficultyListScrollView.UIPlayTween:Play(true)
  LU.Set(REF.DifficultyWrapContent, #m_difficultyTable)
  local record = this:GetData("fci/activity-dungeon/record/")
  if record then
    local index = 0
    for i, id in ipairs(m_difficultyTable) do
      local preDungeonId = PB.get("DungeonReward", id).preDungeonId
      local unlockLevel = PB.get("DungeonReward", id).unlockLevel
      local levelOk = unlockLevel <= this:GetData("fci/baseinfo/").level
      local preDungeonOk = preDungeonId == 0
      if not preDungeonOk then
        local _, preDungeonFinished = _ENV["!"](record):find(function(k, v)
          return v.dungeonId == preDungeonId and v.finished
        end)
        preDungeonOk = preDungeonFinished ~= nil
      end
      local unlockAble = levelOk and preDungeonOk
      if unlockAble then
        index = index + 1
      else
        break
      end
    end
    index = index + 1
    local jumpLength = 0
    if 5 < index then
      if index >= #m_difficultyTable then
        jumpLength = index - 6
      else
        jumpLength = index - 5
      end
      if m_bFirstJump then
        m_bFirstJump = false
        this:DelayInvokeInSeconds(0.1, function()
          JumpIndex(jumpLength)
        end)
      else
        JumpIndex(jumpLength)
      end
    end
  end
end

function JumpIndex(index)
  REF.DifficultyList.UIWidget:UpdateAnchors()
  REF.DifficultyListScrollView.UIPanel:UpdateAnchors()
  local scrollView = REF.DifficultyListScrollView.UIScrollView
  local v3 = CS.UnityEngine.Vector3(-REF.DifficultyWrapContent.UIWrapContent.itemSize * index, 0, 0)
  scrollView:ResetPosition()
  scrollView:MoveRelative(v3)
  scrollView:RestrictWithinBounds(true)
end

function OnMaterialSlotShow(rowRef, wrapIndex, realIndex)
  if realIndex ~= nil and m_activity and realIndex < #m_activity then
    local activity = m_activity[realIndex + 1]
    rowRef["$$ModifyContent"](activity, realIndex + 1)
  end
end

function OnDifficultySlotShow(rowRef, wrapIndex, realIndex)
  if realIndex ~= nil and m_difficultyTable and realIndex < #m_difficultyTable then
    local difficultyId = m_difficultyTable[realIndex + 1]
    rowRef["$$ModifyContent"](difficultyId, realIndex + 1)
    rowRef["$$SetTweenDelay"](realIndex * m_delayInterval)
  end
end

function Insert2UnlockList(id, unlockLevel)
  local unlockItem = {}
  unlockItem.id = id
  unlockItem.unlockLevel = unlockLevel
  table.insert(m_unlockList, unlockItem)
end

function Focus(on)
  WU.RecordWindowFocus(100166, on)
end
