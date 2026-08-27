local UINHeroInfoStrotyNodeUnlockedItem = class("UINHeroInfoStrotyNodeUnlockedItem", UIBaseNode)
local base = UIBaseNode

function UINHeroInfoStrotyNodeUnlockedItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.isOpen = false
  UIUtil.AddButtonListener(self.ui.btn_head, self, self.OnClickExpandUnlockedItem)
  UIUtil.AddButtonListener(self.ui.btn_voiceItem, self, self.OnClickPlayVoice)
  self.__setPlayRate = BindCallback(self, self.__SetPlayRate)
  self.__onPlayOver = BindCallback(self, self.__OnPlayOver)
  self.originSizeDelta = {
    x = self.ui.img_Bar.sizeDelta.x,
    y = self.ui.img_Bar.sizeDelta.y
  }
  self:__SetPlayRate(0)
end

function UINHeroInfoStrotyNodeUnlockedItem:InitHISNUnlockedItem(storyData, HeroInfoTextUtil, playVoiceCallback, isHaveVoiceRes)
  self.storyData = storyData
  self.isVoice = storyData.cfg.is_audio
  self.heroId = storyData.cfg.heroID
  self.playVoiceCallback = playVoiceCallback
  self.ui.tex_Type.text = LanguageUtil.GetLocaleText(storyData.cfg.describe)
  self.ui.voiceItem:SetActive(self.isVoice)
  if self.isVoice then
    self.ui.img_head:SetIndex(1)
    self.ui.btn_voiceItem.interactable = isHaveVoiceRes
    self.ui.obj_tex_Play:SetActive(isHaveVoiceRes)
    self.ui.obgj_tex_ComingSoon:SetActive(not isHaveVoiceRes)
    if isHaveVoiceRes then
      self.ui.img_buttom:SetIndex(0)
    else
      self.ui.img_buttom:SetIndex(2)
    end
    local cvController = ControllerManager:GetController(ControllerTypeId.Cv, true)
    self.voiceId = cvController:GetVoiceIdFromName(storyData.cfg.open)
    self.ui.tex_Content.text = ControllerManager:GetController(ControllerTypeId.Cv, true):GetCvText(self.heroId, self.voiceId) or ConfigData:GetTipContent(TipContent.HeroInformation_notHaveVoice)
  else
    self.ui.img_head:SetIndex(0)
    self.ui.tex_Content.text = HeroInfoTextUtil.GetArchiveText(self.heroId, storyData.cfg.open) or ""
  end
  self.isOpen = false
  self.ui.content:SetActive(false)
  self.ui.img_Triangle.transform.rotation = Vector3.New(0, 0, 180)
end

function UINHeroInfoStrotyNodeUnlockedItem:OnClickExpandUnlockedItem()
  self.isOpen = not self.isOpen
  self.ui.content:SetActive(self.isOpen)
  if self.isOpen then
    self.ui.img_Triangle.transform.rotation = Vector3.New(0, 0, 0)
  else
    self.ui.img_Triangle.transform.rotation = Vector3.New(0, 0, 180)
  end
end

function UINHeroInfoStrotyNodeUnlockedItem:__SetPlayRate(rate)
  self.ui.img_Bar.sizeDelta = Vector2.New(rate * self.originSizeDelta.x, self.originSizeDelta.y)
end

function UINHeroInfoStrotyNodeUnlockedItem:__OnPlayOver()
  self.ui.img_buttom:SetIndex(0)
end

function UINHeroInfoStrotyNodeUnlockedItem:OnClickPlayVoice()
  if not self.isVoice then
    return
  end
  self.ui.img_buttom:SetIndex(1)
  if self.playVoiceCallback ~= nil then
    self.playVoiceCallback(self.heroId, self.voiceId, self.__setPlayRate, self.__onPlayOver)
  end
end

function UINHeroInfoStrotyNodeUnlockedItem:OnDelete()
  base.OnDelete(self)
end

return UINHeroInfoStrotyNodeUnlockedItem
