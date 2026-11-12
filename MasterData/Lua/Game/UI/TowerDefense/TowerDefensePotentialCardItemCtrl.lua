local TowerDefensePotentialCardItemCtrl = class("TowerDefensePotentialCardItemCtrl", BaseCtrl)
TowerDefensePotentialCardItemCtrl._mapNodeConfig = {
  db_SSR = {},
  goPotentialNormal = {},
  imgRare_Gold = {},
  imgRare_RainBow = {},
  goIcon = {
    sCtrlName = "Game.UI.TowerDefense.TowerDefensePotentialIconCtrl"
  },
  txtName = {sComponentName = "TMP_Text"},
  txtDesc = {sComponentName = "TMP_Text"},
  TMP_Link1 = {
    sNodeName = "txtDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnBtnClick_Word"
  },
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
  txtNew = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_New_Text"
  },
  N = {},
  SR = {},
  SSR = {},
  BgEffect = {},
  ArrowEffect = {},
  imgPreselection = {},
  goNew = {}
}
TowerDefensePotentialCardItemCtrl._mapEventConfig = {}
TowerDefensePotentialCardItemCtrl._mapRedDotConfig = {}
local level_txt_color = {
  [1] = "#44587f",
  [2] = "#4e76d4"
}

function TowerDefensePotentialCardItemCtrl:SetPotentialItem(nTid, nShowType)
  self.nTid = nTid
  self.nShowType = nShowType or AllEnum.PotentialCardType.CharInfo
  self._mapNode.ArrowEffect:SetActive(self.bLucky)
  local potentialCfg = ConfigTable.GetData("TowerDefensePotential", nTid)
  if nil == potentialCfg then
    return
  end
  self._mapNode.db_SSR:SetActive(potentialCfg.Rarity == GameEnum.itemRarity.SSR)
  local bSpecial = potentialCfg.Rarity == GameEnum.itemRarity.SSR
  self._mapNode.goPotentialNormal.gameObject:SetActive(not bSpecial)
  self._mapNode.goPotentialSpecial.gameObject:SetActive(bSpecial)
  if not bSpecial then
    self:SetNormalCard(potentialCfg)
  else
    self:SetSpecialCard(potentialCfg)
  end
  self:ChangeWordRaycast(false)
  return bSpecial
end

function TowerDefensePotentialCardItemCtrl:SetNormalCard(potentialCfg)
  NovaAPI.SetTMPText(self._mapNode.txtName, potentialCfg.Name)
  local nColor = AllEnum.FrameColor_New[potentialCfg.Rarity]
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
  NovaAPI.SetTMPText(self._mapNode.txtDesc, potentialCfg.PotentialDes)
end

function TowerDefensePotentialCardItemCtrl:SetSpecialCard(potentialCfg)
  NovaAPI.SetTMPText(self._mapNode.txtSpName, potentialCfg.Name)
  self:SetPngSprite(self._mapNode.imgSpIcon, potentialCfg.Icon .. AllEnum.PotentialIconSurfix.A)
  NovaAPI.SetTMPText(self._mapNode.txtSpDesc, potentialCfg.PotentialDes)
end

function TowerDefensePotentialCardItemCtrl:ActiveRollEffect()
  if not self.itemCfg then
    return
  end
  self._mapNode.SSR:SetActive(self.itemCfg.Rarity == GameEnum.itemRarity.SSR)
  self._mapNode.SR:SetActive(self.itemCfg.Rarity == GameEnum.itemRarity.SR)
  self._mapNode.N:SetActive(self.itemCfg.Rarity == GameEnum.itemRarity.N)
end

function TowerDefensePotentialCardItemCtrl:CloseBgEffect()
  self._mapNode.BgEffect:SetActive(false)
end

function TowerDefensePotentialCardItemCtrl:PlayAnim(sAnimName)
  self._mapNode.animCtrl:Play(sAnimName)
  self._mapNode.BgEffect:SetActive(self.bLucky and sAnimName == "tc_newperk_card_in")
end

function TowerDefensePotentialCardItemCtrl:Awake()
  self._mapNode.goNew.gameObject:SetActive(false)
  self._mapNode.imgPreselection:SetActive(false)
end

function TowerDefensePotentialCardItemCtrl:OnEnable()
end

function TowerDefensePotentialCardItemCtrl:OnDisable()
end

function TowerDefensePotentialCardItemCtrl:OnDestroy()
end

function TowerDefensePotentialCardItemCtrl:OnBtnClick_Word(link, sWordId)
  local potentialCfg = ConfigTable.GetData("Potential", self.nTid)
  local nLevel = self.nLevel
  local nNextLevel = self.nNextLevel
  local nType = potentialCfg.BranchType
  local nCharId = potentialCfg.CharId
  local tbSkillLevel
  if self.nShowType == AllEnum.PotentialCardType.StarTower then
    tbSkillLevel = self._panel:GetSkillLevel(nCharId)
  elseif self.nShowType == AllEnum.PotentialCardType.CharInfo or self.nShowType == AllEnum.PotentialCardType.Book then
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

function TowerDefensePotentialCardItemCtrl:ChangeWordRaycast(bEnable)
  NovaAPI.SetTMPRaycastTarget(self._mapNode.txtDesc, bEnable)
  NovaAPI.SetTMPRaycastTarget(self._mapNode.txtSpDesc, bEnable)
end

function TowerDefensePotentialCardItemCtrl:SetRecommend(bEnable)
  self._mapNode.imgReommend:SetActive(bEnable)
end

return TowerDefensePotentialCardItemCtrl
