local TemplateSkillCtrl = class("TemplateSkillCtrl", BaseCtrl)
local TipsType = {
  CharSkill = 1,
  Talent = 2,
  TalentSkill = 3,
  MonsterSkill = 4
}
TemplateSkillCtrl._mapNodeConfig = {
  imgElementBg = {sComponentName = "Image"},
  imgIcon = {sComponentName = "Image"},
  txtName = {sComponentName = "TMP_Text"},
  btnSkill = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Skill"
  },
  rtSkill = {
    sNodeName = "btnSkill",
    sComponentName = "RectTransform"
  },
  TopGridCanvas = {sNodeName = "btnSkill"},
  txtLevel = {sComponentName = "TMP_Text"},
  txtLv = {
    sComponentName = "TMP_Text",
    sLanguageId = "Character_Skill_Lv"
  }
}
TemplateSkillCtrl._mapEventConfig = {}

function TemplateSkillCtrl:SetCharSkill(nSkillId, nSkillLevel, nElementType)
  self.nTipsType = TipsType.CharSkill
  self.nSkillId = nSkillId
  self.nSkillLevel = nSkillLevel
  self.nElementType = nElementType
  self:_RefreshSkillContent()
end

function TemplateSkillCtrl:SetTalent(nRoguelikeTalentSkill)
  self.nTipsType = TipsType.Talent
  self.nTalentSkillId = nRoguelikeTalentSkill
  self:_RefreshTalentContent()
end

function TemplateSkillCtrl:SetTalentSkill(nSkillLevel, nTalentSkillId, nTalentLevel)
  local nCharId = math.floor(nTalentSkillId / 1000)
  nSkillLevel = nSkillLevel or 0
  self.nTipsType = TipsType.TalentSkill
  self.nSkillId = CacheTable.GetData("_TalentSkillAI", nCharId)[nTalentSkillId].SpecialSkillId
  self.nSkillLevel = nSkillLevel
  self.nTalentSkillId = nTalentSkillId
  self.nTalentLevel = nTalentLevel
  self.nElementType = ConfigTable.GetData_Character(nCharId).EET
  self:_RefreshSkillContent()
end

function TemplateSkillCtrl:SetMonsterSkill(nSkillId, nDiffLv)
  self.nTipsType = TipsType.MonsterSkill
  self.nSkillId = nSkillId
  self:_RefreshMonsterContent(nDiffLv)
end

function TemplateSkillCtrl:SetTravelerDuelSkill(nSkillId)
  self.nTipsType = TipsType.MonsterSkill
  self.nSkillId = nSkillId
  self:_RefreshTravelerDuelContent()
end

function TemplateSkillCtrl:_RefreshSkillContent()
  self:SetAtlasSprite(self._mapNode.imgElementBg, "12_rare", AllEnum.ElementIconType.Skill .. self.nElementType)
  self:SetPngSprite(self._mapNode.imgIcon, ConfigTable.GetData_Skill(self.nSkillId).Icon)
  NovaAPI.SetTMPText(self._mapNode.txtName, ConfigTable.GetData_Skill(self.nSkillId).Title)
  if self.nSkillLevel then
    NovaAPI.SetTMPText(self._mapNode.txtLevel, self.nSkillLevel)
  end
end

function TemplateSkillCtrl:_RefreshTalentContent()
  local nRare = self.nTalentSkillId % 100 > 10 and GameEnum.itemRarity.SSR or GameEnum.itemRarity.SR
  self:SetSprite_FrameColor(self._mapNode.imgElementBg, nRare, AllEnum.FrameType_New.Talent)
  self:SetPngSprite(self._mapNode.imgIcon, self.nTalentSkillId)
  NovaAPI.SetTMPText(self._mapNode.txtName, ConfigTable.GetData("RoguelikeTalentSkill", self.nTalentSkillId).Title)
end

function TemplateSkillCtrl:_RefreshMonsterContent(nDiffLv)
  local isWeeklyCopies = PlayerData.RogueBoss:GetIsWeeklyCopies()
  if isWeeklyCopies then
    local mapSkill = ConfigTable.GetData("WeekBossAffix", self.nSkillId)
    self:SetAtlasSprite(self._mapNode.imgElementBg, "12_rare", AllEnum.ElementIconType.Skill .. mapSkill.Element)
    self:SetPngSprite(self._mapNode.imgIcon, mapSkill.Icon)
    NovaAPI.SetTMPText(self._mapNode.txtName, mapSkill.name)
    NovaAPI.SetTMPText(self._mapNode.txtLevel, mapSkill.Level)
  else
    local mapSkill = ConfigTable.GetData("RegionBossAffix", self.nSkillId)
    self:SetAtlasSprite(self._mapNode.imgElementBg, "12_rare", AllEnum.ElementIconType.Skill .. mapSkill.Element)
    self:SetPngSprite(self._mapNode.imgIcon, mapSkill.Icon)
    NovaAPI.SetTMPText(self._mapNode.txtName, mapSkill.name)
    NovaAPI.SetTMPText(self._mapNode.txtLevel, mapSkill.Level)
  end
  local goMask = self.gameObject.transform:Find("imgMask").gameObject
  goMask:SetActive(nDiffLv and 0 < nDiffLv)
end

function TemplateSkillCtrl:_RefreshTravelerDuelContent()
  local mapSkill = ConfigTable.GetData("TravelerDuelChallengeAffix", self.nSkillId)
  self:SetAtlasSprite(self._mapNode.imgElementBg, "12_rare", AllEnum.ElementIconType.Skill .. mapSkill.Element)
  self:SetPngSprite(self._mapNode.imgIcon, mapSkill.Icon)
  NovaAPI.SetTMPText(self._mapNode.txtName, mapSkill.name)
  NovaAPI.SetTMPText(self._mapNode.txtLevel, "")
  local goMask = self.gameObject.transform:Find("imgMask").gameObject
  goMask:SetActive(false)
end

function TemplateSkillCtrl:Awake()
  self.nTipsType = TipsType.CharSkill
  self.nSkillId = nil
  self.nSkillLevel = nil
  self.nTalentSkillId = nil
  self.nTalentLevel = nil
  self.nElementType = nil
  NovaAPI.SetComponentEnableByName(self._mapNode.TopGridCanvas.gameObject, "TopGridCanvas", false)
end

function TemplateSkillCtrl:OnDestroy()
  self.nSkillId = nil
  self.nSkillLevel = nil
  self.nTalentSkillId = nil
  self.nTalentLevel = nil
  self.nElementType = nil
end

function TemplateSkillCtrl:OnBtnClick_Skill(btn)
  if self.nTipsType == TipsType.CharSkill then
    EventManager.Hit(EventId.ShowCharacterSkillTips, self.nSkillId, self.nSkillLevel, self.nElementType, self._mapNode.rtSkill)
  elseif self.nTipsType == TipsType.Talent then
    EventManager.Hit(EventId.ShowCharacterTalentTips, self.nTalentSkillId, 0, GameEnum.itemRarity.SR, self._mapNode.rtSkill)
  elseif self.nTipsType == TipsType.TalentSkill then
    EventManager.Hit(EventId.ShowTalentSkillTips, self.nTalentSkillId, self.nSkillLevel, self.nElementType, self.nTalentLevel)
  elseif self.nTipsType == TipsType.MonsterSkill then
    EventManager.Hit(EventId.ShowMonsterSkillTips, self.nSkillId, self._mapNode.rtSkill)
  end
end

return TemplateSkillCtrl
