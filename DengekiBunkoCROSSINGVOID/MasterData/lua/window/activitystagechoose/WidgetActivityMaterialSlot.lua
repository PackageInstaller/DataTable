local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local m_configDataManager = S:Get("ConfigDataManager")
local m_activity, m_weekdays, m_dayToday, m_isMultiple, m_isOpen, m_multipleId, firstTime

function Start()
  m_dayToday = U.ToInt(CS.GameTime.serverNow.DayOfWeek)
  if m_dayToday == 0 then
    m_dayToday = 7
  end
end

function OnDisable()
  if REF.root.UIToggle.value then
    REF.root.UIToggle.optionCanBeNone = true
    REF.root.UIToggle.value = false
    REF.root.UIToggle.optionCanBeNone = false
  end
end

function ModifyContent(activity, index)
  if activity == nil then
    return
  end
  m_activity = activity
  SetMultiple()
  SetOpenOrNot()
  local type = this:GetData("Activity/CurrentType")
  local category = PB.get("ActivityDungeon", m_activity.activityId).category
  if type == PB.enum.ActivityType.CollectionDungeon then
    REF.root.UISprite.spriteName = "activity_stage_equip_" .. index
  else
    REF.root.UISprite.spriteName = "activity_stage_item_" .. index
  end
  local name = WU.GetString("Activity_Id_Name_" .. m_activity.activityId)
  REF.LabelMaterialTitle.UILabel.text = name
  REF.LabelMaterialTitle1.UILabel.text = name
  local needShowTime = true
  REF.LabelMaterialTitle.gameObject:SetActive(not needShowTime)
  REF.LabelMaterialTitle1.gameObject:SetActive(needShowTime)
  REF.LabelMaterialTime.gameObject:SetActive(needShowTime)
  REF.SpriteLock.gameObject:SetActive(not m_isOpen)
  REF.SpriteActivityRunning.gameObject:SetActive(category == 2)
  REF.root.BoxCollider2D.enabled = m_isOpen
  if needShowTime then
    if category == 1 then
      local days = ""
      for i = 1, #m_weekdays do
        if i < #m_weekdays then
          days = days .. WU.GetString("Window_Number_" .. m_weekdays[i]) .. "/"
        else
          days = days .. WU.GetString("Window_Number_" .. m_weekdays[i])
        end
      end
      REF.LabelMaterialTime.UILabel.text = WU.GetString("Window_EveryWeek") .. days .. WU.GetString("Window_Open")
    else
      REF.LabelMaterialTime.UILabel.text = WU.RenderTime2(m_activity.timestampStart) .. "~" .. WU.RenderTime2(m_activity.timestampEnd)
    end
  end
end

function OnButtonChooseClick(firstTime)
  local material = this:GetData("Activity/CurrentMaterialId")
  WU.RecordButtonClick("166" .. m_activity.activityId)
  if m_activity.activityId ~= nil then
    local mulId = PB.get("ActivityDungeon", m_activity.activityId).multipleActivityId
    if firstTime or material ~= m_activity.activityId and material ~= mulId then
      if m_isMultiple then
        this:SetData("Activity/CurrentMaterialId", mulId)
      else
        this:SetData("Activity/CurrentMaterialId", m_activity.activityId)
      end
    end
    this:SetData("Activity/MultipleMaterialChoose", m_isMultiple)
  end
end

function SetOpenOrNot()
  m_isOpen = false
  for i = 1, #m_weekdays do
    if m_weekdays[i] == m_dayToday and CS.GameTime.serverUtc > m_activity.timestampStart then
      m_isOpen = true
      break
    end
  end
end

function SetMultiple()
  m_isMultiple = false
  local multupleDays
  m_multipleId = 0
  local tab = PB.get("ActivityDungeon", m_activity.activityId)
  if tab ~= nil then
    m_multipleId = tab.multipleActivityId
  end
  local activityTable = PB.get("ActivityDungeon", m_multipleId)
  if activityTable ~= nil and activityTable.multiple > 1 then
    multupleDays = activityTable.multipleDay
    for i = 1, #multupleDays do
      if m_dayToday == multupleDays[i] then
        m_isMultiple = true
        break
      end
    end
  end
  REF.SpriteMultuple.gameObject:SetActive(m_isMultiple)
  m_weekdays = m_activity.weekdays
  if multupleDays ~= nil then
    for i = 1, #multupleDays do
      if 0 < multupleDays[i] and not _ENV["!"](m_weekdays):find(function(k, v)
        return v == multupleDays[i]
      end) then
        table.insert(m_weekdays, multupleDays[i])
      end
    end
  end
end

function IsOpen()
  return m_isOpen
end
