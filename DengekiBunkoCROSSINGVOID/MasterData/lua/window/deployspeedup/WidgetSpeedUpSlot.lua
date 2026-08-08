local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local HU = require("Common/HtmlUtil")
local DBH = require("Manager/DataBindingHandler")
local m_missionInfo, m_item, m_effect

function Start()
  WU.BindButtonEvent(REF.ButtonSpeedUp, OnSpeedUpClick)
  REF.root.ResourceChangeListener:AddListener(OnItemCountChange, false)
end

function OnDestroy()
  REF.root.ResourceChangeListener:RemoveListener(OnItemCountChange)
end

function OnSpeedUpClick()
  WU.TryToPay(m_item.type, m_item.id, 1, function()
    WU.RecordButtonClick(m_item.id)
    this:GameRequest("fci/deploy/deploymissionspeedup/"):Post({
      cost = m_item,
      id = m_missionInfo.id
    }, function(result)
      DBH.ResChange(result.resChange)
      CS.SoundManager.Instance:PlaySound("Sound/system/s_System_SpeedUp")
      m_missionInfo.endTimestamp = m_missionInfo.endTimestamp - m_item.param
      m_effect.gameObject:SetActive(true)
      m_effect:Play()
      this:SetData("fci/deploy/mission/", this:GetData("fci/deploy/mission/"))
    end)
  end)
end

function SetView(mission, item)
  m_missionInfo = mission
  m_item = item
  m_effect = _ENV["$"](WU.FindWindow("DeploySpeedUp")).Effect.EffectGenerator
  m_effect.gameObject:SetActive(false)
  REF.LabelInfo.UIHtmlLabel.text = WU.GetString("WindowDeploy_SpeedUpInfo", HU.ApplyFontColor(item.param // 3600, "#199AE9"))
  REF.WidgetIconSlot["$BindItem"](item.id)
  REF.WidgetIconSlot["$SetClickCallback"](function()
    WU.ShowResourceDetail(m_item.type, m_item.id, false)
  end)
  REF.root.ResourceChangeListener:SetResource(item.type, item.id)
end

function OnItemCountChange(type, id, count)
  REF.ButtonSpeedUp.UIButton.isEnabled = 0 < count
  if 0 < count then
    REF.LabelButton.UILabel.text = WU.GetString("WindowDeploy_SpeedUp")
  else
    REF.LabelButton.UILabel.text = WU.GetString("Window_ItemNotEnough")
  end
end
