local UINHeroInfoVoiceNodeItem = class("UINHeroInfoVoiceNodeItem", UIBaseNode)
local base = UIBaseNode
local eHeroInfoenum = require("Game.Hero.NewUI.HeroInfo.eHeroInfoenum")
local CS_MessageCommon = CS.MessageCommon

function UINHeroInfoVoiceNodeItem:OnInit()
  self.__setPlayRate = BindCallback(self, self.__SetPlayRate)
  self.__onPlayOver = BindCallback(self, self.__OnPlayOver)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_friendShipItem, self, self.OnClickPlayVoice)
  self.ui.img_Rate.fillAmount = 0
end

function UINHeroInfoVoiceNodeItem:InitHeroInfoNodeItem(voiceData, playVoiceCallback)
  self.voiceData = voiceData
  self.playVoiceCallback = playVoiceCallback
  local isUnlock = self:IsUnlock()
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(voiceData.cfg.describe)
  self.ui.obj_lock:SetActive(not isUnlock)
  self.ui.obj_img_isNew:SetActive(isUnlock and voiceData.isNewVoice)
  local no_voiceCfg = ConfigData.audio_no_voice.heroNotHaveVoiceDataList[self.voiceData.heroId]
  local voiceId = voiceData.cfg.id
  if voiceData.hasVoice and (no_voiceCfg == nil or no_voiceCfg[voiceId] == nil) then
    self.ui.img_buttom:SetIndex(0)
  else
    self.ui.img_buttom:SetIndex(1)
  end
end

function UINHeroInfoVoiceNodeItem:IsUnlock()
  if self.voiceData == nil then
    return false
  end
  return self.voiceData.isUnlock
end

function UINHeroInfoVoiceNodeItem:GetUnLockTipStr()
  if self.voiceData == nil then
    return nil
  end
  return self.voiceData.unlockInfo
end

function UINHeroInfoVoiceNodeItem:OnClickPlayVoice()
  local isUnlock = self:IsUnlock()
  if not isUnlock then
    local unlockStr = self:GetUnLockTipStr()
    if unlockStr ~= nil then
      CS_MessageCommon.ShowMessageTips(unlockStr)
    end
    return
  end
  if self.playVoiceCallback ~= nil then
    self.playVoiceCallback(self.voiceData.heroId, self.voiceData.skinId, self.voiceData.cfg.id, self.__setPlayRate, self.__onPlayOver)
  end
  if self.voiceData.isNewVoice then
    NetworkManager:GetNetwork(NetworkTypeID.Hero):CS_HERO_Record(self.voiceData.heroId, eHeroInfoenum.recordType.audio, self.voiceData.cfg.is_show, function()
      self.voiceData.heroData:SetAudioListed(self.voiceData.cfg.is_show)
      self.voiceData.isNewVoice = false
      self.ui.obj_img_isNew:SetActive(false)
    end)
  end
end

function UINHeroInfoVoiceNodeItem:__SetPlayRate(rate)
  if self.ui ~= nil and not IsNull(self.ui.img_Rate) then
    self.ui.img_Rate.fillAmount = rate
  end
end

function UINHeroInfoVoiceNodeItem:__OnPlayOver()
end

function UINHeroInfoVoiceNodeItem:OnDelete()
  base.OnDelete(self)
end

return UINHeroInfoVoiceNodeItem
