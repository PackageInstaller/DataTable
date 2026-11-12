local TutorialPotentialCardItemCtrl = class("TutorialPotentialCardItemCtrl", BaseCtrl)
TutorialPotentialCardItemCtrl._mapNodeConfig = {
  db_SSR = {},
  goPotentialNormal = {},
  imgRare_Gold = {},
  imgRare_RainBow = {},
  goIcon = {
    sCtrlName = "Game.UI.StarTower.Potential.PotentialIconCtrl"
  },
  txtName = {sComponentName = "TMP_Text"},
  imgCharBg = {},
  imgCharIcon = {sComponentName = "Image"},
  imgCharSpBg = {},
  imgCharSpIcon = {sComponentName = "Image"},
  Content = {
    sComponentName = "RectTransform"
  },
  txtDesc = {sComponentName = "TMP_Text"},
  TMP_Link1 = {
    sNodeName = "txtDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnBtnClick_Word"
  },
  txtLevelValue = {sComponentName = "TMP_Text"},
  txtLevel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Potential_Level"
  },
  imgArrow = {},
  goUpgrade = {},
  txtUpLevelValue = {sComponentName = "TMP_Text"},
  goPotentialSpecial = {},
  imgSpIcon = {sComponentName = "Image"},
  txtSpName = {sComponentName = "TMP_Text"},
  SpContent = {
    sComponentName = "RectTransform"
  },
  txtSpDesc = {sComponentName = "TMP_Text"},
  TMP_Link2 = {
    sNodeName = "txtSpDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnBtnClick_Word"
  },
  animCtrl = {sComponentName = "Animator", sNodeName = "AnimRoot"},
  imgReommend = {},
  imgNew = {},
  goLayout = {},
  txtNew = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_New_Text"
  },
  N = {},
  SR = {},
  SSR = {},
  BgEffect = {},
  ArrowEffect = {}
}
TutorialPotentialCardItemCtrl._mapEventConfig = {}
TutorialPotentialCardItemCtrl._mapRedDotConfig = {}
local level_txt_color = {
  [1] = "#44587f",
  [2] = "#4e76d4"
}

function TutorialPotentialCardItemCtrl:SetPotentialItem(nTid, bSimpleDesc, bShowChar, nShowType, nLevel, nNextLevel, nPotentialAddLevel)
  self.nTid = nTid
  self.nLevel = nLevel
  self.nNextLevel = nNextLevel
  self.nPotentialAddLevel = nPotentialAddLevel or 0
  self.nShowType = nShowType or AllEnum.PotentialCardType.CharInfo
  self._mapNode.imgNew.gameObject:SetActive(false)
  self._mapNode.goLayout.gameObject:SetActive(false)
  self._mapNode.ArrowEffect:SetActive(false)
  local itemCfg = ConfigTable.GetData_Item(nTid)
  if nil == itemCfg then
    printError(string.format("获取道具表配置失败！！！id = [%s])", nTid))
    return
  end
  self.itemCfg = itemCfg
  local potentialCfg = ConfigTable.GetData("Potential", nTid)
  if nil == potentialCfg then
    return
  end
  self._mapNode.db_SSR:SetActive(itemCfg.Rarity == GameEnum.itemRarity.SSR)
  local bSpecial = itemCfg.Stype == GameEnum.itemStype.SpecificPotential
  self._mapNode.goPotentialNormal.gameObject:SetActive(not bSpecial)
  self._mapNode.goPotentialSpecial.gameObject:SetActive(bSpecial)
  if not bSpecial then
    self:SetNormalCard(itemCfg, potentialCfg, bShowChar)
  else
    self:SetSpecialCard(itemCfg, potentialCfg, bShowChar)
  end
  self:ChangeDesc(bSimpleDesc)
  self:ChangeWordRaycast(false)
  return bSpecial
end

function TutorialPotentialCardItemCtrl:SetNormalCard(itemCfg, potentialCfg, bShowChar)
  self._mapNode.imgCharBg.gameObject:SetActive(bShowChar)
  local nCharId = potentialCfg.CharId
  if bShowChar then
    local nCharSkinId = PlayerData.Char:GetCharSkinId(nCharId)
    local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
    self:SetPngSprite(self._mapNode.imgCharIcon, mapCharSkin.Icon, AllEnum.CharHeadIconSurfix.S)
  end
  NovaAPI.SetTMPText(self._mapNode.txtName, itemCfg.Title)
  local nColor = AllEnum.FrameColor_New[itemCfg.Rarity]
  if nColor == "4" then
    self._mapNode.imgRare_Gold.gameObject:SetActive(true)
    self._mapNode.imgRare_RainBow.gameObject:SetActive(false)
  elseif nColor == "5" then
    self._mapNode.imgRare_Gold.gameObject:SetActive(false)
    self._mapNode.imgRare_RainBow.gameObject:SetActive(true)
  else
    self._mapNode.imgRare_Gold.gameObject:SetActive(false)
    self._mapNode.imgRare_RainBow.gameObject:SetActive(false)
  end
  self._mapNode.goIcon:SetIcon(potentialCfg.Id)
  local bUpgrade = self.nNextLevel ~= nil and self.nLevel ~= self.nNextLevel
  self._mapNode.imgArrow.gameObject:SetActive(bUpgrade)
  self._mapNode.goUpgrade.gameObject:SetActive(bUpgrade)
  NovaAPI.SetTMPText(self._mapNode.txtLevelValue, self.nLevel + self.nPotentialAddLevel)
  local sColor = self.nPotentialAddLevel == 0 and level_txt_color[1] or level_txt_color[2]
  local _, color = ColorUtility.TryParseHtmlString(sColor)
  NovaAPI.SetTMPColor(self._mapNode.txtLevelValue, color)
  if bUpgrade then
    NovaAPI.SetTMPText(self._mapNode.txtUpLevelValue, self.nNextLevel + self.nPotentialAddLevel)
  end
end

function TutorialPotentialCardItemCtrl:SetSpecialCard(itemCfg, potentialCfg, bShowChar)
  self._mapNode.imgCharSpBg.gameObject:SetActive(bShowChar)
  local nCharId = potentialCfg.CharId
  if bShowChar then
    local nCharSkinId = PlayerData.Char:GetCharSkinId(nCharId)
    local mapCharSkin = ConfigTable.GetData_CharacterSkin(nCharSkinId)
    self:SetPngSprite(self._mapNode.imgCharSpIcon, mapCharSkin.Icon, AllEnum.CharHeadIconSurfix.S)
  end
  NovaAPI.SetTMPText(self._mapNode.txtSpName, itemCfg.Title)
  self:SetPngSprite(self._mapNode.imgSpIcon, itemCfg.Icon .. AllEnum.PotentialIconSurfix.A)
end

function TutorialPotentialCardItemCtrl:ChangeDesc(bSimpleDesc)
  local potentialCfg = ConfigTable.GetData("Potential", self.nTid)
  if nil == potentialCfg then
    printError(string.format("获取潜能表配置失败！！！id = [%s])", self.nTid))
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtDesc, UTILS.ParseDesc(potentialCfg, GameEnum.levelTypeData.Exclusive, nil, bSimpleDesc, nil))
  NovaAPI.SetTMPText(self._mapNode.txtSpDesc, UTILS.ParseDesc(potentialCfg, GameEnum.levelTypeData.Exclusive, nil, bSimpleDesc, nil))
  self._mapNode.Content.anchoredPosition = Vector2(0, 0)
  self._mapNode.SpContent.anchoredPosition = Vector2(0, 0)
end

function TutorialPotentialCardItemCtrl:ActiveRollEffect()
  if not self.itemCfg then
    return
  end
  self._mapNode.SSR:SetActive(self.itemCfg.Rarity == GameEnum.itemRarity.SSR)
  self._mapNode.SR:SetActive(self.itemCfg.Rarity == GameEnum.itemRarity.SR)
  self._mapNode.N:SetActive(self.itemCfg.Rarity == GameEnum.itemRarity.N)
end

function TutorialPotentialCardItemCtrl:CloseBgEffect()
  self._mapNode.BgEffect:SetActive(false)
end

function TutorialPotentialCardItemCtrl:PlayAnim(sAnimName)
  self._mapNode.animCtrl:Play(sAnimName)
  self._mapNode.BgEffect:SetActive(false)
end

function TutorialPotentialCardItemCtrl:OnEnable()
end

function TutorialPotentialCardItemCtrl:OnDisable()
end

function TutorialPotentialCardItemCtrl:OnDestroy()
end

function TutorialPotentialCardItemCtrl:OnBtnClick_Word(link, sWordId)
  local potentialCfg = ConfigTable.GetData("Potential", self.nTid)
  local nLevel = self.nLevel
  local nNextLevel = self.nNextLevel
  local nType = potentialCfg.BranchType
  local nCharId = potentialCfg.CharId
  local tbSkillLevel
  if self.nShowType == AllEnum.PotentialCardType.StarTower then
    tbSkillLevel = self._panel:GetSkillLevel(nCharId)
  elseif self.nShowType == AllEnum.PotentialCardType.CharInfo then
    tbSkillLevel = PlayerData.Char:GetSkillLevel(nCharId)
  end
  if nType == GameEnum.BranchType.Master then
    nLevel = tbSkillLevel[GameEnum.skillSlotType.B]
    nNextLevel = nil
  elseif nType == GameEnum.BranchType.Assist then
    nLevel = tbSkillLevel[GameEnum.skillSlotType.C]
    nNextLevel = nil
  end
  local mapData = {
    nPerkId = 0,
    nCount = 0,
    bWordTip = true,
    sWordId = sWordId,
    nLevel = nLevel,
    nNextLevel = nNextLevel
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.PerkTips, link, mapData)
end

function TutorialPotentialCardItemCtrl:ChangeWordRaycast(bEnable)
  NovaAPI.SetTMPRaycastTarget(self._mapNode.txtDesc, bEnable)
  NovaAPI.SetTMPRaycastTarget(self._mapNode.txtSpDesc, bEnable)
end

function TutorialPotentialCardItemCtrl:SetRecommend(bEnable)
  self._mapNode.imgReommend:SetActive(bEnable)
end

return TutorialPotentialCardItemCtrl
