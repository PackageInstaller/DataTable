_class("UIWidgetFeatureBanPetSkill", UICustomWidget)
UIWidgetFeatureBanPetSkill = UIWidgetFeatureBanPetSkill

function UIWidgetFeatureBanPetSkill:OnShow(uiParams)
  self:InitWidget()
end

function UIWidgetFeatureBanPetSkill:InitWidget()
  self.enableFakeInput = true
  self._buttonNormal = self:GetGameObject("ButtonNormal")
  self._maskNormal = self:GetGameObject("MaskNormal")
  self._textNormal = self:GetUIComponent("UILocalizationText", "TextNormal")
  self._buttonChain = self:GetGameObject("ButtonChain")
  self._maskChain = self:GetGameObject("MaskChain")
  self._textChain = self:GetUIComponent("UILocalizationText", "TextChain")
  self._buttonActive = self:GetGameObject("ButtonActive")
  self._maskActive = self:GetGameObject("MaskActive")
  self._textActive = self:GetUIComponent("UILocalizationText", "TextActive")
  self:RegisterEvent()
end

function UIWidgetFeatureBanPetSkill:RegisterEvent()
  self:AttachEvent(GameEventType.FeatureAutoFightCastBanPetSkill, self._OnFeatureAutoFightCastBanPetSkill)
end

function UIWidgetFeatureBanPetSkill:SetData(featureEffectParam)
  self._featureEffectParam = featureEffectParam
  self._skillID = 0
  self:OnRefreshUI()
end

function UIWidgetFeatureBanPetSkill:GetFeatureType()
  return FeatureType.BanPetSkill
end

function UIWidgetFeatureBanPetSkill:OnRefreshUI()
  local skillCD = self._featureEffectParam:GetSkillCD()
  local curRoundCount = BattleStatHelper.GetLevelTotalRoundCount()
  local castRoundList = FeatureServiceHelper.GetBanPetSkillCastRoundList()
  local colorDisabled = Color(0.7333333333333333, 0.7333333333333333, 0.7333333333333333, 1)
  local normalSkillRoundList = castRoundList[self._featureEffectParam:GetBanNormalSkillID()] or {}
  local lastNormalRound = -1
  if 0 < #normalSkillRoundList then
    lastNormalRound = normalSkillRoundList[#normalSkillRoundList]
  end
  local normalSkillEnable = skillCD < curRoundCount - lastNormalRound
  self._buttonNormal:SetActive(normalSkillEnable == true)
  self._maskNormal:SetActive(normalSkillEnable == false)
  self._textNormal.color = normalSkillEnable and Color.white or colorDisabled
  local chainSkillRoundList = castRoundList[self._featureEffectParam:GetBanChainSkillID()] or {}
  local lastChainRound = -1
  if 0 < #chainSkillRoundList then
    lastChainRound = chainSkillRoundList[#chainSkillRoundList]
  end
  local chainSkillEnable = skillCD < curRoundCount - lastChainRound
  self._buttonChain:SetActive(chainSkillEnable == true)
  self._maskChain:SetActive(chainSkillEnable == false)
  self._textChain.color = chainSkillEnable and Color.white or colorDisabled
  local activeSkillRoundList = castRoundList[self._featureEffectParam:GetBanActiveSkillID()] or {}
  local lastActiveRound = -1
  if 0 < #activeSkillRoundList then
    lastActiveRound = activeSkillRoundList[#activeSkillRoundList]
  end
  local acticeSkillEnable = skillCD < curRoundCount - lastActiveRound
  self._buttonActive:SetActive(acticeSkillEnable == true)
  self._maskActive:SetActive(acticeSkillEnable == false)
  self._textActive.color = acticeSkillEnable and Color.white or colorDisabled
end

function UIWidgetFeatureBanPetSkill:ButtonNormalOnClick()
  self._skillID = self._featureEffectParam:GetBanNormalSkillID()
  self:OnCastSkill()
end

function UIWidgetFeatureBanPetSkill:ButtonChainOnClick()
  self._skillID = self._featureEffectParam:GetBanChainSkillID()
  self:OnCastSkill()
end

function UIWidgetFeatureBanPetSkill:ButtonActiveOnClick()
  self._skillID = self._featureEffectParam:GetBanActiveSkillID()
  self:OnCastSkill()
end

function UIWidgetFeatureBanPetSkill:_OnFeatureAutoFightCastBanPetSkill(skillID)
  self._skillID = skillID
  self:OnCastSkill()
end

function UIWidgetFeatureBanPetSkill:OnCastSkill()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.FeatureShowBanPetSkill, false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UISwitchActiveSkillUI)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PreClickPetHead, self._skillID)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ClickPersonaSkill, FeatureType.BanPetSkill, self._skillID)
end
