local TemplateCharCtrl = class("TemplateCharCtrl", BaseCtrl)
TemplateCharCtrl._mapNodeConfig = {
  imgRareFrame = {sComponentName = "Image"},
  imgHead = {sComponentName = "Image"},
  imgRareName = {sComponentName = "Image"},
  imgElement = {sComponentName = "Image"},
  txtCharName = {sComponentName = "TMP_Text"},
  txtRank = {sComponentName = "TMP_Text"},
  txtLv = {sComponentName = "TMP_Text", sLanguageId = "Lv"},
  imgSelected = {},
  redDotChar = {},
  imgBg = {},
  imgElementMask = {},
  txtCharClass = {sComponentName = "TMP_Text"},
  imgAttackType = {sComponentName = "Image"},
  imgClassBg = {sComponentName = "Image"},
  imgRankBg = {},
  imgAttackTypeBg = {},
  goSkills = {},
  imgSkill = {nCount = 4, sComponentName = "Image"},
  txtSkill = {nCount = 4, sComponentName = "TMP_Text"},
  imgAffinity = {sComponentName = "Image"},
  txtAffinity = {sComponentName = "TMP_Text"},
  imgFavorite = {}
}
TemplateCharCtrl._mapEventConfig = {}

function TemplateCharCtrl:SetChar(nCharId, bShowRedDot, bLocked, nTrialId, nSortType)
  self.nCharId = nCharId
  self._mapNode.imgSelected:SetActive(false)
  local mapTrial
  if nTrialId then
    mapTrial = ConfigTable.GetData("TrialCharacter", nTrialId)
  end
  local mapChar = ConfigTable.GetData_Character(nCharId)
  if mapChar == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtCharName, mapTrial and mapTrial.Name or mapChar.Name)
  local nLv = bLocked and 1 or PlayerData.Char:GetCharLv(nCharId)
  if mapTrial then
    nLv = mapTrial.Level
  end
  NovaAPI.SetTMPText(self._mapNode.txtRank, nLv)
  local nSkinId = bLocked and ConfigTable.GetData_Character(nCharId).DefaultSkinId or PlayerData.Char:GetCharSkinId(nCharId)
  if mapTrial then
    nSkinId = mapTrial.CharacterSkin
  end
  local mapCharSkin = ConfigTable.GetData_CharacterSkin(nSkinId)
  if mapCharSkin == nil then
    return
  end
  self:RefreshCharaIsFavorite()
  self:SetPngSprite(self._mapNode.imgHead, mapCharSkin.Icon .. AllEnum.CharHeadIconSurfix.XL)
  local nRarity = mapChar.Grade
  self:SetSprite_FrameColor(self._mapNode.imgRareFrame, nRarity == GameEnum.characterGrade.R and GameEnum.characterGrade.SR or nRarity, AllEnum.FrameType_New.CharFrame, true)
  self:SetSprite_FrameColor(self._mapNode.imgRareName, nRarity, AllEnum.FrameType_New.Text)
  NovaAPI.SetImageNativeSize(self._mapNode.imgRareName)
  local sName = AllEnum.ElementIconType.Icon .. mapChar.EET
  self:SetAtlasSprite(self._mapNode.imgElement, "12_rare", sName)
  self._mapNode.imgElementMask:SetActive(bLocked)
  self._mapNode.imgBg:SetActive(bLocked)
  NovaAPI.SetTMPText(self._mapNode.txtCharClass, ConfigTable.GetUIText("Char_JobClass_" .. mapChar.Class))
  if mapChar.CharacterAttackType == GameEnum.characterAttackType.MELEE then
    self:SetAtlasSprite(self._mapNode.imgAttackType, "10_ico", "zs_list_near")
  elseif mapChar.CharacterAttackType == GameEnum.characterAttackType.RANGED then
    self:SetAtlasSprite(self._mapNode.imgAttackType, "10_ico", "zs_list_far")
  end
  if mapChar.Class == GameEnum.characterJobClass.Vanguard then
    self:SetAtlasSprite(self._mapNode.imgClassBg, "08_db", "db_list_herald")
  elseif mapChar.Class == GameEnum.characterJobClass.Balance then
    self:SetAtlasSprite(self._mapNode.imgClassBg, "08_db", "db_list_equal")
  elseif mapChar.Class == GameEnum.characterJobClass.Support then
    self:SetAtlasSprite(self._mapNode.imgClassBg, "08_db", "db_list_assist")
  end
  if bShowRedDot then
    self:RegisterRedDot()
  else
    self._mapNode.redDotChar.gameObject:SetActive(false)
  end
  self._mapNode.imgAffinity.gameObject:SetActive(nSortType == AllEnum.SortType.Affinity)
  self._mapNode.goSkills:SetActive(nSortType == AllEnum.SortType.Skill)
  if nSortType then
    if nSortType == AllEnum.SortType.Affinity then
      local mapCharAffinity = ConfigTable.GetData("CharAffinityTemplate", nCharId)
      if mapCharAffinity == nil then
        return
      end
      local templateId = mapCharAffinity.TemplateId
      local tbCharData = PlayerData.Char:GetCharDataById(nCharId)
      local curData = CacheTable.GetData("_AffinityLevel", templateId)[tbCharData.Favorability]
      if curData ~= nil then
        self:SetPngSprite(self._mapNode.imgAffinity, curData.AffinityLevelIcon)
      else
        self._mapNode.imgAffinity.gameObject:SetActive(false)
      end
      NovaAPI.SetTMPText(self._mapNode.txtAffinity, tbCharData.Favorability)
    elseif nSortType == AllEnum.SortType.Skill then
      local mapCharSkill = PlayerData.Char:GetCharSkillUpgradeData(nCharId)
      if mapCharSkill ~= nil and not bLocked then
        for i = 1, 4 do
          local skillShowCfg = AllEnum.SkillTypeShow[i]
          local skillTypeIconIdx = skillShowCfg.iconIndex
          self:SetAtlasSprite(self._mapNode.imgSkill[i], "05_language", "zs_character_skill_text_" .. skillTypeIconIdx)
          NovaAPI.SetTMPText(self._mapNode.txtSkill[i], mapCharSkill[i].nLv)
        end
      else
        self._mapNode.goSkills:SetActive(false)
      end
    end
  end
end

function TemplateCharCtrl:SetSpecificChar(nCharId, nLv, nSkinId)
  self._mapNode.imgSelected:SetActive(false)
  local mapChar = ConfigTable.GetData_Character(nCharId)
  if mapChar == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtCharName, mapChar.Name)
  self._mapNode.imgRankBg:SetActive(nLv)
  if nLv then
    NovaAPI.SetTMPText(self._mapNode.txtRank, nLv)
  end
  nSkinId = nSkinId or ConfigTable.GetData_Character(nCharId).DefaultSkinId
  local mapCharSkin = ConfigTable.GetData_CharacterSkin(nSkinId)
  if mapCharSkin == nil then
    return
  end
  self:SetPngSprite(self._mapNode.imgHead, mapCharSkin.Icon .. AllEnum.CharHeadIconSurfix.XL)
  local nRarity = mapChar.Grade
  self:SetSprite_FrameColor(self._mapNode.imgRareFrame, nRarity == GameEnum.characterGrade.R and GameEnum.characterGrade.SR or nRarity, AllEnum.FrameType_New.CharFrame, true)
  self:SetSprite_FrameColor(self._mapNode.imgRareName, nRarity, AllEnum.FrameType_New.Text)
  NovaAPI.SetImageNativeSize(self._mapNode.imgRareName)
  local sName = AllEnum.ElementIconType.Icon .. mapChar.EET
  self:SetAtlasSprite(self._mapNode.imgElement, "12_rare", sName)
  self._mapNode.imgElementMask:SetActive(false)
  self._mapNode.imgBg:SetActive(false)
  self._mapNode.imgAttackTypeBg:SetActive(false)
  self._mapNode.imgClassBg.gameObject:SetActive(false)
  self._mapNode.redDotChar.gameObject:SetActive(false)
end

function TemplateCharCtrl:SetSelect(bSelect)
  self._mapNode.imgSelected:SetActive(bSelect)
end

function TemplateCharCtrl:RefreshCharaIsFavorite()
  if PlayerData.Char:CheckCharUnlock(self.nCharId) then
    local bIsFavorite = PlayerData.Char:GetCharFavoriteState(self.nCharId)
    if bIsFavorite ~= nil then
      self._mapNode.imgFavorite:SetActive(bIsFavorite)
    end
  end
end

function TemplateCharCtrl:RegisterRedDot()
  RedDotManager.RegisterNode(RedDotDefine.Role_Item, self.nCharId, self._mapNode.redDotChar)
end

function TemplateCharCtrl:OnDisable()
end

return TemplateCharCtrl
