_class("UIWidgetPetMultiSkillItem", UICustomWidget)
UIWidgetPetMultiSkillItem = UIWidgetPetMultiSkillItem

function UIWidgetPetMultiSkillItem:OnShow()
  self.enableFakeInput = true
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._selectImage = self:GetUIComponent("Image", "select")
  self._frame = self:GetUIComponent("Image", "frame")
  self._btnGo = self:GetGameObject("ButtonBg")
  self._powerInfoGo = self:GetGameObject("PowerInfoArea")
  self._powerInfoGo:SetActive(false)
  self._alreadyCastGo = self:GetGameObject("AlreadyCastActiveImage")
  self._alreadyCastGo:SetActive(false)
  self._cdGo = self:GetGameObject("Energy")
  self._cdGo:SetActive(false)
  self._energyText = self:GetUIComponent("UILocalizationText", "CurEnergyText")
  self._flagIcon = self:GetUIComponent("RawImageLoader", "FlagIcon")
  self._flagIconBaseGo = self:GetGameObject("FlagIconBase")
  self._flagIconBaseGo:SetActive(false)
end

function UIWidgetPetMultiSkillItem:OnHide()
end

function UIWidgetPetMultiSkillItem:Init(index, uiData, callBack, isVariantSkillList)
  self._index = index
  self._callBack = callBack
  self._uiData = uiData
  local skillID = uiData._skillId
  local activeSkillData = BattleSkillCfg(skillID)
  self._icon:LoadImage(activeSkillData.Icon)
  local skillData = ConfigServiceHelper.GetSkillConfigData(skillID)
  self._powerInfoGo:SetActive(false)
  if skillData:GetSkillTriggerType() == SkillTriggerType.Energy and not isVariantSkillList then
    self._powerInfoGo:SetActive(true)
    self:RefreshPowerInfoArea()
  end
  if self._flagIconBaseGo then
    local variantSkillFlagCfg = Cfg.cfg_variant_skill_flag_icon[skillID]
    if variantSkillFlagCfg then
      local flagIconID = variantSkillFlagCfg.FlagIcon
      self._flagIconBaseGo:SetActive(true)
      self._flagIcon:LoadImage(flagIconID)
    else
      self._flagIconBaseGo:SetActive(false)
    end
  end
end

function UIWidgetPetMultiSkillItem:OnSelect(visible, canCast)
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIWidgetPetMultiSkillItem",
    input = "OnSelect",
    args = {visible, canCast}
  })
  self._selectImage.gameObject:SetActive(visible)
  self._frame.gameObject:SetActive(not canCast)
end

function UIWidgetPetMultiSkillItem:ButtonBgOnClick(go)
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIWidgetPetMultiSkillItem",
    input = "buttonBgOnClick",
    args = {}
  })
  if self._callBack then
    self._callBack(self._index)
  end
end

function UIWidgetPetMultiSkillItem:GetSelectBtn()
  return self._btnGo
end

function UIWidgetPetMultiSkillItem:RefreshPowerInfoArea()
  local canCast = self._uiData._canCast
  local leftPower = self._uiData._leftPower
  local maxPower = self._uiData._maxPower
  local showAlreadyCast = self._uiData._showAlreadyCast
  local showPowerInfo = self._uiData._showPowerInfo
  self._powerInfoGo:SetActive(showPowerInfo)
  if self._uiData._canCast then
    self._cdGo:SetActive(false)
    self._alreadyCastGo:SetActive(false)
  elseif showAlreadyCast then
    self._alreadyCastGo:SetActive(true)
    self._cdGo:SetActive(false)
  else
    self._alreadyCastGo:SetActive(false)
    if leftPower == 0 then
      self._cdGo:SetActive(false)
    else
      self._cdGo:SetActive(true)
      self._energyText:SetText(tostring(leftPower))
    end
  end
end
