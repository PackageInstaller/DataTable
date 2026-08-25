local UI_Dbgcopy_Panel_Moves_VoiceResource = require("UI.UIPackages.UI_Dbgcopy_Panel_Moves_VoiceResource")
local System = require("System.System")
local UIBasePanel = require("Managers.UI.UIBasePanel")
local LT = require("System.LangTable")
local DT = require("System.DataTable")
local Logger = require("Utility.Logger")
local CommonDefine = require("World.Enums.CommonDefine")
local AwakerAudioManager = require("Managers.AwakerAudioManager")
local BattleExSkillPanelModel = require("Model.BattleExSkillPanelModel")
local BattleExSkillPanel, Super = System.NewClass("BattleExSkillPanel", UIBasePanel)
BattleExSkillPanel.uiResCls = UI_Dbgcopy_Panel_Moves_VoiceResource

function BattleExSkillPanel:ctor(awakerId, isSuperUtliSkill)
  Super.ctor(self)
  self.awakerId = awakerId
  self.isSuperUtliSkill = isSuperUtliSkill
  self.timer = nil
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
end

function BattleExSkillPanel:OnBind(binder)
  self.binder = binder
  local model = binder:createModel(BattleExSkillPanelModel, self.awakerId)
  self.model = model
  binder:BindToText(self.ui.Text_Voice, function()
    return self.model.curShowContent
  end)
  binder:BindToVisible(self.ui.uiNode, function()
    return self.model.curShowContent ~= ""
  end)
  self:ShowAwakerAudio()
end

function BattleExSkillPanel:OnUnbind()
  Super.OnUnbind(self)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
end

function BattleExSkillPanel:ShowAwakerAudio()
  self.model:SetCurShowContent("")
  local battleAwakerModel = bg.battleDataCenter:GetAwakerDataModelByCfgId(self.awakerId)
  local voiceId = AwakerAudioManager.Instance:GetAwakerVoiceIdFromBattle(self.isSuperUtliSkill and CommonDefine.AwakerVoiceTrigger.Slot_Super_Ultl or CommonDefine.AwakerVoiceTrigger.Slot_Super, self.model.awakerId, battleAwakerModel and battleAwakerModel:GetSkinId())
  if 0 == voiceId then
    return
  end
  local voiceConfig = DT.Voice[voiceId]
  if not voiceConfig.LongSentenceSplit_1 and not voiceConfig.LongSentenceSplit_2 and not voiceConfig.LongSentenceSplit_3 then
    self:SetTimer(0.1, voiceConfig.AwakerVoiceContent)
    return
  end
  if voiceConfig.LongSentenceSplit_1 then
    self:GetAudioInfo(voiceConfig.LongSentenceSplit_1)
  end
  if voiceConfig.LongSentenceSplit_2 then
    self:GetAudioInfo(voiceConfig.LongSentenceSplit_2)
  end
  if voiceConfig.LongSentenceSplit_3 then
    self:GetAudioInfo(voiceConfig.LongSentenceSplit_3)
  end
end

function BattleExSkillPanel:StopTimer()
  if self.timer ~= nil then
    self.binder:StopTimer(self.timer)
    self.timer = nil
  end
end

function BattleExSkillPanel:GetAudioInfo(inputStr)
  local duration = tonumber(string.sub(inputStr, 1, string.find(inputStr, ",") - 1))
  local content = string.sub(inputStr, string.find(inputStr, ",") + 1, #inputStr)
  self:SetTimer(duration, content)
end

function BattleExSkillPanel:SetTimer(duration, content)
  self.binder:BindTimer(duration, 1, nil, function()
    self.model:SetCurShowContent(content)
  end)
end

return BattleExSkillPanel
