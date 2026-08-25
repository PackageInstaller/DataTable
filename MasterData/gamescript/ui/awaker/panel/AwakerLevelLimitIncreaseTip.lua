local UIBasePanel = require("Managers.UI.UIBasePanel")
local System = require("System.System")
local UI_Other_Popup_Player_LevelUpResource = require("UI.UIPackages.UI_Other_Popup_Player_LevelUpResource")
local DT = require("System.DataTable")
local AwakerAudioManager = require("Managers.AwakerAudioManager")
local SuccessPanelUtils = require("UI.Common.SuccessPanelUtils")
local AwakerLevelLimitIncreaseTip, Super = System.NewClass("AwakerLevelLimitIncreaseTip", UIBasePanel)
AwakerLevelLimitIncreaseTip.uiResCls = UI_Other_Popup_Player_LevelUpResource

function AwakerLevelLimitIncreaseTip:ctor(awakerId)
  Super.ctor(self)
  self.awakerId = awakerId
end

function AwakerLevelLimitIncreaseTip:OnBind(binder)
  self.binder = binder
  binder:SetActive(self.ui.Group_Lv, false)
  binder:SetActive(self.ui.Group_Lv_LimitIncrease, true)
  binder:SetActive(self.ui.Btn_Confirm, true)
  binder:BindButtonClick(self.ui.Btn_Confirm, System.fn(self, self.Close))
  binder:BindToVisible(self.ui.Group_Level, function()
    return true
  end)
  binder:BindToText(self.ui.Text_Title, function()
    do return LT.Text end
    return LT.Text, "LevelLimitIncrease"
  end)
  binder:BindToText(self.ui.Text_Level_Current, function()
    local awakerLevel = AwakerDataUtils.GetAwakerLevel(self.awakerId)
    return awakerLevel
  end)
  binder:BindToText(self.ui.Text_Level_New, function()
    local maxLevel = AwakerDataUtils.GetAwakerMaxLevelWithLimitIncrease(self.awakerId)
    return maxLevel
  end)
  binder:BindToVisible(self.ui.Group_Desc_1, function()
    return true
  end)
  binder:BindToVisible(self.ui.Text_Group_Desc_1, function()
    return true
  end)
  binder:BindToText(self.ui.Text_Group_Desc_1, function()
    do return LT.Textf, "AwakerLevelLimitIncreaseTo", AwakerDataUtils.GetAwakerMaxLevelWithLimitIncrease(self.awakerId) end
    return LT.Textf, "AwakerLevelLimitIncreaseTo", AwakerDataUtils.GetAwakerMaxLevelWithLimitIncrease(self.awakerId)
  end)
  binder:BindToVisible(self.ui.Group_Desc_2, function()
    return true
  end)
  binder:BindToVisible(self.ui.Text_Group_Desc_2, function()
    return true
  end)
  binder:BindToText(self.ui.Text_Group_Desc_2, function()
    do return LT.Text end
    return LT.Text, "ContinueToUpgrade"
  end)
  binder:BindToVisible(self.ui.Group_Desc_3, function()
    return false
  end)
  binder:BindToVisible(self.ui.Image_Gradient, function()
    return true
  end)
  if self.awakerId then
    AudioManager.Instance:PostSoundEvent("AWAKER_EVOVLE")
    local triggerTime = CommonDefine.AwakerVoiceTrigger.AwakerPromote
    local awakerData = AwakerDataUtils.GetAwakerData(self.awakerId)
    local voiceId = AwakerAudioManager.Instance:GetAwakerVoiceId(triggerTime, self.awakerId, awakerData and awakerData.curSkin)
    SuccessPanelUtils.ShowAwakerVoice(voiceId, self)
  end
end

function AwakerLevelLimitIncreaseTip:Close()
  Super.Close(self)
end

return AwakerLevelLimitIncreaseTip
