local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_missionInfo, m_remainTime, m_finished
local m_speedUpItems = {}

function SetupWindow()
  local allItems = PB.all("ItemInfo")
  for _, item in pairs(allItems) do
    if item.funcType == PB.enum.ItemFuncType.DeploySpeedUp then
      table.insert(m_speedUpItems, {
        type = PB.enum.ResourceType.ResItem,
        id = item.id,
        param = item.param[1],
        count = 1
      })
    end
  end
  table.sort(m_speedUpItems, function(a, b)
    return a.param < b.param
  end)
end

function InitWindow()
  OnCurrentMissionChange(this:GetData("Deploy/SelectedMission"))
end

function UpdateWindow()
  if m_missionInfo == nil then
    return
  end
  m_remainTime = m_missionInfo.endTimestamp - CS.GameTime.serverUtc
  m_finished = m_remainTime <= 0
  if 0 < m_remainTime then
    REF.LabelRemainTime.UIHtmlLabel.text = WU.RenderCountDownTime(m_remainTime, REF.LabelRemainTime.UIHtmlLabel.fontSize)
  else
    this:BroadcastGameEvent("DeployFinishEffect")
    WU.RecycleWindow("DeploySpeedUp")
    CS.SoundManager.Instance:PlaySound("Sound/system/s_System_DeployComplete")
  end
end

function OnCurrentMissionChange(mission)
  m_missionInfo = mission
  if m_missionInfo ~= nil then
    for i = 0, #REF.Grid - 1 do
      REF.Grid[i].root["$SetView"](m_missionInfo, m_speedUpItems[i + 1])
    end
    REF.LabelName.UILabel.text = WU.GetString("DeployMissionName_" .. m_missionInfo.config.id)
  end
end

function Focus(on)
  WU.RecordWindowFocus(1001323, on)
end
