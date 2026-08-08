local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local U = require("Common/Util")
local GU = require("Common/GroupUtil")
local AU = require("Common/ActorUtil")
local HU = require("Common/HtmlUtil")
local EU = require("Common/EquipUtil")
local S = require("Common/Singleton")
local AM = S:Get("ActivityManager")
local m_dungeonId, m_displayTable, m_cost, m_costWin, m_dungeonRecord, m_activityId, m_dungeonReward, m_dungeonMonster, m_selectActorGroupId, m_groupMembers, m_actorGroup

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonPrepare, OnButtonPrepareClick)
  LU.Bind(REF.DropContent, {
    updateRow = OnDropSlotShow
  })
end

function InitWindow()
  this:Bind("Activity/CurrentDifficultyId", OnDungeonIdChanged)
end

function OnDungeonIdChanged(dungeonId)
  if dungeonId == nil then
    return
  end
  m_activityId = this:GetData("Activity/CurrentMaterialId")
  m_dungeonId = dungeonId
  m_dungeonReward = PB.get("DungeonReward", m_dungeonId)
  m_displayTable = {}
  for k, v in pairs(m_dungeonReward.dropDisplay) do
    m_displayTable[k] = v
  end
  AM.GetTimeLimitExtraReward({type = 3, dungeonId = m_dungeonId}, function(extra)
    for i = 1, #extra do
      table.insert(m_displayTable, extra[i])
    end
    LU.Set(REF.DropContent, #m_displayTable)
  end)
  m_cost = m_dungeonReward.cost
  m_costWin = m_dungeonReward.costWin
  m_dungeonMonster = PB.get("DungeonMonster", m_dungeonId)
  this:SetData("WindowDungeon/DungeonId", dungeonId)
  SetOpponents()
  SetDungeonName()
  this:BindRemote(DB:GameRequest("fci/activity-dungeon/record/"), OnActivityRecord)
  ChangeBackground()
  REF.LabelDescription.UILabel.text = WU.GetString("Activity_Id_Description" .. m_activityId)
  REF.AffixWidget["$ShowAffixWidget"](dungeonId)
  LU.Set(REF.DropContent, #m_displayTable)
end

function OnButtonPrepareClick(obj)
  WU.RecordButtonClick(100169101)
  if not EU.CheckEquipOverflow() then
    WU.AcquireWindowAsync("ActivityActorGroup", function()
      this:SetData("ActivityActorGroup/DungeonInfo", {
        dungeonId = m_dungeonId,
        activityId = m_activityId,
        activityType = PB.enum.ActivityType.CollectionDungeon,
        mode = nil
      })
    end)
  end
end

function OnDropSlotShow(rowRef, wrapIndex, realIndex)
  if m_displayTable and realIndex ~= nil and realIndex < #m_displayTable then
    local item = m_displayTable[realIndex + 1]
    if item.type == 11 then
      rowRef["$$SetData"](item.type, item.id)
    else
      rowRef["$$SetData"](item.type, item.id, item.count)
    end
    rowRef["$$SetClickCallback"](function()
      WU.ShowResourceDetail(item.type, item.id)
    end)
  end
end

function SetDungeonName()
  if m_dungeonId and m_dungeonId ~= 0 then
    local dungeonName = WU.GetString("DungeonName_" .. m_dungeonId)
    REF.LabelDungeonTitle.UIHtmlLabel.text = dungeonName
  else
    info("Activity", "Has no material chosen!")
  end
end

function SetOpponents(floor)
  local dungeonMonster = PB.get("DungeonMonster", m_dungeonId)
  if dungeonMonster == nil then
    error("Activity", "no dungeonId " .. m_dungeonId .. " in DungeonMonster! ")
    return
  end
  local actors = GU.MonsterGroup(dungeonMonster.monsterId)
  REF.WidgetDungeonGroup["$SetViewByActors"](actors, true, true)
end

function OnActivityRecord(record)
  if record == nil then
    return
  end
  local doneTaskMap = {}
  local _, dungeonRecord = _ENV["!"](record):find(function(k, v)
    return v.dungeonId == m_dungeonId
  end)
  if dungeonRecord ~= nil then
    for i = 1, #dungeonRecord.targetsDone do
      doneTaskMap[dungeonRecord.targetsDone[i]] = true
    end
  end
  for i = 1, #m_dungeonReward.target do
    local target = m_dungeonReward.target[i]
    local targetText = WU.GetDungeonTargetText(target)
    if doneTaskMap[target.id] then
      targetText = HU.ApplyFontColor(targetText, "white")
    end
    REF["LabelTarget" .. target.id].UIHtmlLabel.text = targetText
    REF["SpriteStar" .. target.id].UISprite.graify = not doneTaskMap[target.id]
  end
end

function ChangeBackground()
  REF.TextureStage.UITexture.mainTexturePath = "Texture/StageThumb/" .. m_dungeonMonster.stageID
end

function Goto(activity, dungeon)
  if activity == nil or dungeon == nil then
    warning("Meet wrong goto data in WeekActiviryPrepare. Both params should be filled.")
    return
  end
  local activityId = math.floor(tonumber(activity))
  local dungeonId = math.floor(tonumber(dungeon))
  this:SetData("Activity/CurrentMaterialId", activityId)
  if activityId ~= 0 and dungeonId ~= 0 then
    OnDungeonIdChanged(dungeonId)
  end
end

function Focus(on)
  WU.RecordWindowFocus(1001691, on)
end
