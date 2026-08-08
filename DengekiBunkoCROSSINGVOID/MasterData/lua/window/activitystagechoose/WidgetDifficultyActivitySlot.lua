local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GotoUtil")
local DU = require("Common/DungeonUtil")
local m_id, m_preDungeonId, m_unlockLevel, m_levelOk, m_materialId, m_preDungeonOk, m_index

function Start()
  WU.BindButtonEvent(REF.ButtonDifficulty, OnDifficultyChoose)
end

function ModifyContent(id, index)
  m_index = index
  local record = this:GetData("fci/activity-dungeon/record/")
  if record then
    m_preDungeonId = PB.get("DungeonReward", id).preDungeonId
    m_unlockLevel = PB.get("DungeonReward", id).unlockLevel
    m_levelOk = this:GetData("fci/baseinfo/").level >= m_unlockLevel
    m_preDungeonOk = m_preDungeonId == 0
    if not m_preDungeonOk then
      local _, preDungeonFinished = _ENV["!"](record):find(function(k, v)
        return v.dungeonId == m_preDungeonId and v.finished
      end)
      m_preDungeonOk = preDungeonFinished ~= nil
    end
    local unlockAble = m_levelOk and m_preDungeonOk
    SetContent(unlockAble)
    m_id = id
    REF.LabelName.UILabel.text = WU.GetString("DungeonName_" .. m_id)
    local m_materialId = this:GetData("Activity/CurrentMaterialId")
    local bg = PB.get("DungeonSlotBackground", m_id, m_materialId).slotBackground
    REF.SlotBg.UITexture.mainTexturePath = "Texture/ActivityStage/" .. bg
    if DU.IsSpecialTreasureDengeon(m_materialId, id) and unlockAble then
      local remainTimes = GetSpecialDungeonRemainTimes(id)
      REF.ResidualTimes.gameObject:SetActive(true)
      if remainTimes <= 0 then
        REF.spriteMask.gameObject:SetActive(true)
      end
      REF.LabelTimes.UILabel.text = WU.GetString("Window_TodayRemainTimes", remainTimes)
    else
      REF.ResidualTimes.gameObject:SetActive(false)
    end
    SetDropDisplay()
    SetStar()
  end
end

function OnDifficultyChoose()
  WU.RecordButtonClick(100169001)
  local materialId = this:GetData("Activity/CurrentMaterialId")
  if not m_levelOk then
    WU.RecordButtonClick(166001)
    WU.ShowHintText(WU.GetString("Window_Level", m_unlockLevel) .. WU.GetString("Window_EquipUnlock"))
  elseif not m_preDungeonOk then
    WU.RecordButtonClick(166001)
    WU.ShowHintText(WU.GetString("Window_FinishPreDungeonFirst", WU.GetString("DungeonName_" .. m_preDungeonId)))
  elseif DU.IsSpecialTreasureDengeon(materialId, m_id) and GetSpecialDungeonRemainTimes(m_id) <= 0 then
    WU.ShowHintText(WU.GetString("Window_TodayRemainTimesRunOut"))
  else
    local material = this:GetData("Activity/CurrentMaterialId")
    WU.RecordButtonClick("166" .. material .. m_index)
    GU.CheckDungeonEnterCondition(m_id, function()
      this:SetData("Activity/CurrentDifficultyId", m_id)
      WU.AcquireWindowAsync("WeekActivityPrepare")
    end)
  end
end

function GetSpecialDungeonRemainTimes(id)
  local enterTimes = PB.get("DungeonReward", id).enterTimes
  local record = this:GetData("fci/activity-dungeon/record/")
  if record == nil then
    return enterTimes
  end
  local _, thisDungeonRecord = _ENV["!"](record):find(function(k, v)
    return v.dungeonId == id
  end)
  local doneTimes = 0
  if thisDungeonRecord then
    doneTimes = thisDungeonRecord.doneTimes
  end
  return enterTimes - doneTimes
end

function SetTweenDelay(delayTime)
  local tweens = REF.Visual.transform:GetComponents(typeof(CS.UITweener))
  for i = 0, tweens.Length - 1 do
    tweens[i].delay = delayTime
  end
  tweens = REF.SpriteBG_LIGHT.transform:GetComponents(typeof(CS.UITweener))
  for i = 0, tweens.Length - 1 do
    tweens[i].delay = delayTime
  end
end

function SetContent(unlock)
  if unlock then
    REF.spriteMask.gameObject:SetActive(false)
  else
    REF.spriteMask.gameObject:SetActive(true)
  end
  REF.ResidualTimes.gameObject:SetActive(unlock)
  REF.Lock.gameObject:SetActive(not unlock)
  REF.LabelLock.UILabel.text = WU.GetString("Window_Locked")
end

function SetDropDisplay()
  local type = this:GetData("Activity/CurrentType")
  local dropDisplay = REF.DropDisplay
  if type == PB.enum.ActivityType.StarResDungeon then
    local materialId = this:GetData("Activity/CurrentMaterialId")
    dropDisplay.gameObject:SetActive(true)
    local displayTable = PB.get("DungeonSlotBackground", m_id, materialId)
    local type = displayTable.dropDisplayType
    local id = displayTable.dropDisplayId
    REF.WidgetIconSlot["$SetData"](type, id)
    REF.WidgetIconSlot["$SetClickCallback"](function()
      WU.ShowResourceDetail(type, id)
    end)
  else
    REF.DropDisplay.gameObject:SetActive(false)
  end
end

function SetStar()
  local record = this:GetData("fci/activity-dungeon/record/")
  if record then
    local _, dungeonRecord = _ENV["!"](record):find(function(k, v)
      return v.dungeonId == m_id
    end)
    for i = 0, 2 do
      local star = REF["Star" .. i]
      if star then
        if dungeonRecord ~= nil and dungeonRecord.finished == true then
          star.UISprite.enabled = true
          local starName = "star_dark"
          if i < #dungeonRecord.targetsDone then
            starName = "star_light"
          end
          star.UISprite.spriteName = starName
        else
          star.UISprite.enabled = false
        end
      end
    end
  end
end
