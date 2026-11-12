local PotentialCardItemCtrl = class("PotentialCardItemCtrl", BaseCtrl)
PotentialCardItemCtrl._mapNodeConfig = {
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
  goNew = {},
  txtNew = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_New_Text"
  },
  imgPreselection = {},
  imgPreselectionAnmator = {
    sComponentName = "Animator",
    sNodeName = "imgPreselection"
  },
  txtPreselection = {sComponentName = "TMP_Text"},
  txtPreRecLv = {sComponentName = "TMP_Text"},
  imgLevelDB = {},
  imgFlag = {},
  N = {},
  SR = {},
  SSR = {},
  BgEffect = {},
  ArrowEffect = {},
  exId = {sComponentName = "TMP_Text"}
}
PotentialCardItemCtrl._mapEventConfig = {}
PotentialCardItemCtrl._mapRedDotConfig = {}
local level_txt_color = {
  [1] = "#44587f",
  [2] = "#4e76d4"
}

function PotentialCardItemCtrl:SetPotentialItem(nTid, nLevel, nNextLevel, bSimpleDesc, bShowChar, nPotentialAddLevel, nShowType, bNew, bLucky)
  self.nTid = nTid
  self.nLevel = nLevel
  self.nNextLevel = nNextLevel
  self.nShowType = nShowType or AllEnum.PotentialCardType.CharInfo
  self.nPotentialAddLevel = nPotentialAddLevel or 0
  self.bLucky = bLucky
  self._mapNode.goNew.gameObject:SetActive(bNew)
  self._mapNode.ArrowEffect:SetActive(self.bLucky)
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
  self._mapNode.exId.gameObject:SetActive(false)
  EventManager.Hit("TipsId", self._mapNode.exId, nTid)
  self._mapNode.db_SSR:SetActive(itemCfg.Rarity == GameEnum.itemRarity.SSR)
  local bSpecial = itemCfg.Stype == GameEnum.itemStype.SpecificPotential
  self._mapNode.goPotentialNormal.gameObject:SetActive(not bSpecial)
  self._mapNode.goPotentialSpecial.gameObject:SetActive(bSpecial)
  if not bSpecial then
    self:SetNormalCard(itemCfg, potentialCfg, bShowChar)
  else
    self:SetSpecialCard(itemCfg, potentialCfg, bShowChar)
  end
  self.bSpecial = bSpecial
  self:ChangeDesc(bSimpleDesc)
  self:ChangeWordRaycast(false)
  return bSpecial
end

function PotentialCardItemCtrl:SetNormalCard(itemCfg, potentialCfg, bShowChar)
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
  if self.nPotentialAddLevel > 0 then
    NovaAPI.SetTMPText(self._mapNode.txtLevelValue, self.nLevel .. "<color=#4e76d4>+" .. self.nPotentialAddLevel .. "</color>")
  else
    NovaAPI.SetTMPText(self._mapNode.txtLevelValue, self.nLevel)
  end
  if bUpgrade then
    if self.nPotentialAddLevel > 0 then
      NovaAPI.SetTMPText(self._mapNode.txtUpLevelValue, self.nNextLevel .. "<color=#4e76d4>+" .. self.nPotentialAddLevel .. "</color>")
    else
      NovaAPI.SetTMPText(self._mapNode.txtUpLevelValue, self.nNextLevel)
    end
  end
end

function PotentialCardItemCtrl:SetSpecialCard(itemCfg, potentialCfg, bShowChar)
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

function PotentialCardItemCtrl:ChangeDesc(bSimpleDesc)
  local potentialCfg = ConfigTable.GetData("Potential", self.nTid)
  if nil == potentialCfg then
    printError(string.format("获取潜能表配置失败！！！id = [%s])", self.nTid))
    return
  end
  local nLevel = self.nLevel + self.nPotentialAddLevel
  local nNextLevel
  if self.nNextLevel ~= nil and self.nNextLevel ~= self.nLevel then
    nNextLevel = self.nNextLevel + self.nPotentialAddLevel
  end
  local nDescLevel
  if self.nShowType == AllEnum.PotentialCardType.Book or self.nShowType == AllEnum.PotentialCardType.CharInfo then
    nDescLevel = self.nLevel
  else
    nDescLevel = nLevel
  end
  NovaAPI.SetTMPText(self._mapNode.txtDesc, UTILS.ParseDesc(potentialCfg, GameEnum.levelTypeData.Exclusive, nNextLevel, bSimpleDesc, nDescLevel))
  NovaAPI.SetTMPText(self._mapNode.txtSpDesc, UTILS.ParseDesc(potentialCfg, GameEnum.levelTypeData.Exclusive, nNextLevel, bSimpleDesc, nDescLevel))
  self._mapNode.Content.anchoredPosition = Vector2(0, 0)
  self._mapNode.SpContent.anchoredPosition = Vector2(0, 0)
end

function PotentialCardItemCtrl:ActiveRollEffect()
  if not self.itemCfg then
    return
  end
  self._mapNode.SSR:SetActive(self.itemCfg.Rarity == GameEnum.itemRarity.SSR)
  self._mapNode.SR:SetActive(self.itemCfg.Rarity == GameEnum.itemRarity.SR)
  self._mapNode.N:SetActive(self.itemCfg.Rarity == GameEnum.itemRarity.N)
end

function PotentialCardItemCtrl:CloseBgEffect()
  self._mapNode.BgEffect:SetActive(false)
end

function PotentialCardItemCtrl:PlayAnim(sAnimName)
  self._mapNode.animCtrl:Play(sAnimName)
  self._mapNode.BgEffect:SetActive(self.bLucky and sAnimName == "tc_newperk_card_in")
end

function PotentialCardItemCtrl:Awake()
  if self.shieldPreselectionAnimator == nil then
    self.shieldPreselectionAnimator = true
  end
  self._mapNode.imgPreselectionAnmator.enabled = self.shieldPreselectionAnimator
  self._mapNode.imgPreselection:SetActive(false)
  self._mapNode.imgLevelDB:SetActive(false)
end

function PotentialCardItemCtrl:OnEnable()
end

function PotentialCardItemCtrl:OnDisable()
end

function PotentialCardItemCtrl:OnDestroy()
end

function PotentialCardItemCtrl:OnBtnClick_Word(link, sWordId)
  local potentialCfg = ConfigTable.GetData("Potential", self.nTid)
  local nLevel = self.nLevel
  local nNextLevel = self.nNextLevel
  local nType = potentialCfg.BranchType
  local nCharId = potentialCfg.CharId
  local tbSkillLevel
  if self.nShowType == AllEnum.PotentialCardType.StarTower then
    tbSkillLevel = self._panel:GetSkillLevel(nCharId)
  elseif self.nShowType == AllEnum.PotentialCardType.CharInfo or self.nShowType == AllEnum.PotentialCardType.Book or self.nShowType == AllEnum.PotentialCardType.Detial then
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

function PotentialCardItemCtrl:ChangeWordRaycast(bEnable)
  NovaAPI.SetTMPRaycastTarget(self._mapNode.txtDesc, bEnable)
  NovaAPI.SetTMPRaycastTarget(self._mapNode.txtSpDesc, bEnable)
end

function PotentialCardItemCtrl:SetRecommend(bEnable, nLevel, nCurLevel)
  local bShow = bEnable and nLevel ~= nil
  self._mapNode.imgReommend:SetActive(bEnable and nLevel == nil)
  self:DoSetRecommend(bShow, nLevel, nCurLevel)
end

function PotentialCardItemCtrl:DoSetRecommend(bShow, nLevel, nCurLevel)
  self._mapNode.imgPreselection:SetActive(bShow)
  if not bShow then
    return
  end
  if nLevel ~= nil then
    if self.bSpecial then
      self._mapNode.imgLevelDB:SetActive(false)
      if self.shieldSpecialPontential then
        self._mapNode.imgFlag.gameObject:SetActive(false)
      else
        self._mapNode.imgFlag.gameObject:SetActive(true)
      end
      NovaAPI.SetTMPText(self._mapNode.txtPreselection, ConfigTable.GetUIText("Potential_Preselection_Recommend"))
    else
      self._mapNode.imgFlag.gameObject:SetActive(true)
      self._mapNode.imgLevelDB:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtPreselection, orderedFormat(ConfigTable.GetUIText("Potential_Preselection_Recommend_Level"), nLevel))
      if nCurLevel == nil then
        nCurLevel = 0
        if self.nNextLevel ~= nil and self.nNextLevel ~= self.nLevel then
          nCurLevel = self.nLevel
        end
      end
      local sCurLevel
      if nLevel > nCurLevel then
        sCurLevel = "<color=#e74470>" .. nCurLevel .. "</color>"
      else
        sCurLevel = "<color=#8cac59>" .. nCurLevel .. "</color>"
      end
      NovaAPI.SetTMPText(self._mapNode.txtPreRecLv, sCurLevel .. "/" .. nLevel)
    end
  end
end

function PotentialCardItemCtrl:ShieldPreselectionAnimator(state)
  self.shieldPreselectionAnimator = state
  if self._mapNode.imgPreselectionAnmator then
    self._mapNode.imgPreselectionAnmator.enabled = state
  end
end

function PotentialCardItemCtrl:ShieldSpecialPontential(state)
  self.shieldSpecialPontential = state
end

function PotentialCardItemCtrl:OnSwitchPotentialRecommendChange(isshow)
  self._mapNode.imgPreselection:SetActive(isshow)
  self._mapNode.imgReommend:SetActive(false)
end

function PotentialCardItemCtrl:OnSetPotentialRecommend(isshow, nLevel)
  self._mapNode.imgReommend:SetActive(false)
  self:DoSetRecommend(isshow, nLevel)
end

return PotentialCardItemCtrl
