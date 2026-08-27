local UINFormationChioceCareerTog = class("UINFormationChioceCareerTog", UIBaseNode)
local base = UIBaseNode
UINFormationChioceCareerTog.eNodeType = {
  all = 1,
  byData = 2,
  other = 3
}

function UINFormationChioceCareerTog:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__refreshCallback = self.OnValueChangeCareer
  UIUtil.AddValueChangedListener(self.ui.tog_Filtrate, self, self.__RefeshFormationChioceTog)
  self._allFilterSprite = self.ui.img_Icon.sprite
  self._allFilterDes = self.ui.tex_Naem.text
  self._otherFilterSprite = self.ui.img_Icon.sprite
  self._otherFilterDes = ConfigData:GetTipContent(TipContent.CampTip_Other)
end

function UINFormationChioceCareerTog:__RefeshFormationChioceTog(flag)
  if self.__refreshCallback ~= nil then
    self:__refreshCallback(flag)
  end
end

function UINFormationChioceCareerTog:InitCareerTog(careerId, onValueChange, nodeType)
  self._OnValueChange = onValueChange
  self.__refreshCallback = self.OnValueChangeCareer
  self.careerId = careerId
  self.nodeType = nodeType
  self.ui.obj_HasEvaluation:SetActive(false)
  local careerCfg = ConfigData.career[self.careerId]
  self.ui.img_Icon.gameObject:SetActive(true)
  if careerCfg ~= nil then
    self.ui.img_Icon.sprite = CRH:GetSprite(careerCfg.icon, CommonAtlasType.CareerCamp)
    self.ui.tex_Naem.text = LanguageUtil.GetLocaleText(careerCfg.name)
  else
    self.ui.img_Icon.sprite = self._allFilterSprite
    self.ui.tex_Naem.text = self._allFilterDes
  end
end

function UINFormationChioceCareerTog:InitCompany(companyId, onValueChange, nodeType)
  self._OnValueChange = onValueChange
  self.__refreshCallback = self.OnValueChangeCompany
  self.ui.obj_HasEvaluation:SetActive(false)
  self.companyId = companyId
  self.nodeType = nodeType
  if nodeType == self.eNodeType.all then
    self.ui.img_Icon.gameObject:SetActive(false)
    self.ui.img_Icon.sprite = self._allFilterSprite
    self.ui.tex_Naem.text = self._allFilterDes
  elseif nodeType == self.eNodeType.byData then
    local companyCfg = ConfigData.camp[companyId]
    self.ui.img_Icon.gameObject:SetActive(false)
    self.ui.img_Icon.sprite = CRH:GetSprite(companyCfg.icon, CommonAtlasType.CareerCamp)
    self.ui.tex_Naem.text = LanguageUtil.GetLocaleText(companyCfg.editor_filter_name)
  else
    self.ui.img_Icon.gameObject:SetActive(false)
    self.ui.img_Icon.sprite = self._otherFilterSprite
    self.ui.tex_Naem.text = self._otherFilterDes
  end
end

function UINFormationChioceCareerTog:SetEvaluation(isAdvantage)
  self.ui.obj_HasEvaluation:SetActive(isAdvantage)
end

function UINFormationChioceCareerTog:OnValueChangeCareer(flag)
  if flag and self._OnValueChange ~= nil then
    if not self._notClickTog then
      if self.careerId == 0 then
        AudioManager:PlayAudioById(4100)
      else
        local careerCfg = ConfigData.career[self.careerId]
        AudioManager:PlayAudioById(careerCfg.click_audio)
      end
    end
    self._OnValueChange(self.careerId, self, self.nodeType)
  end
end

function UINFormationChioceCareerTog:OnValueChangeCompany(flag)
  if flag and self._OnValueChange ~= nil then
    if not self._notClickTog then
      AudioManager:PlayAudioById(4100)
    end
    self._OnValueChange(self.companyId, self, self.nodeType)
  end
end

function UINFormationChioceCareerTog:SetTogState(flag)
  if self.ui.tog_Filtrate.isOn == flag then
    self._notClickTog = true
    self.__refreshCallback(self, flag)
    self._notClickTog = false
  else
    self.ui.tog_Filtrate.isOn = flag
  end
end

return UINFormationChioceCareerTog
