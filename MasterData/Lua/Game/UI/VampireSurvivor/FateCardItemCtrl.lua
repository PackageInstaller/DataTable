local FateCardItemCtrl = class("FateCardItemCtrl", BaseCtrl)
FateCardItemCtrl._mapNodeConfig = {
  imgRareBg = {sComponentName = "Image"},
  imgFateCard = {sComponentName = "Image"},
  txtFateCard = {sComponentName = "TMP_Text"},
  txtFateCardDesc = {sComponentName = "TMP_Text"},
  TMP_Link = {
    sNodeName = "txtFateCardDesc",
    sComponentName = "TMPHyperLink",
    callback = "OnBtnClick_Word"
  },
  animCtrl = {sNodeName = "AnimRoot", sComponentName = "Animator"},
  db_SSR = {},
  imgRareBgSSR = {},
  imgRareBgSR = {},
  imgRareBgR = {},
  imgNew = {},
  imgReommend = {},
  txtNew = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_New_Text"
  },
  N = {},
  SR = {},
  SSR = {},
  ScrollView = {sComponentName = "ScrollRect"},
  gamePadScroll = {
    sNodeName = "ScrollView",
    sComponentName = "GamepadScroll"
  }
}
FateCardItemCtrl._mapEventConfig = {}
FateCardItemCtrl._mapRedDotConfig = {}

function FateCardItemCtrl:SetFateCardItem(nId, bNew)
  self._mapNode.imgNew.gameObject:SetActive(bNew)
  local itemCfg = ConfigTable.GetData_Item(nId)
  if nil == itemCfg then
    printError(string.format("获取Item表格配置失败！！！id = [%s]", nId))
    return
  end
  self.itemCfg = itemCfg
  local fateCardCfg = ConfigTable.GetData("FateCard", nId)
  if nil == fateCardCfg then
    printError(string.format("获取FateCard表格配置失败！！！id = [%s]", nId))
    return
  end
  local sFrame = AllEnum.FrameType_New.FateCard .. AllEnum.FrameColor_New[itemCfg.Rarity]
  self:SetAtlasSprite(self._mapNode.imgRareBg, "12_rare", sFrame)
  self:SetPngSprite(self._mapNode.imgFateCard, itemCfg.Icon)
  NovaAPI.SetTMPText(self._mapNode.txtFateCard, fateCardCfg.Name)
  local sDesc = UTILS.ParseParamDesc(fateCardCfg.Desc2, fateCardCfg)
  NovaAPI.SetTMPText(self._mapNode.txtFateCardDesc, sDesc)
  self._mapNode.db_SSR.gameObject:SetActive(itemCfg.Rarity == GameEnum.itemRarity.SSR)
  self._mapNode.imgRareBgSSR.gameObject:SetActive(itemCfg.Rarity == GameEnum.itemRarity.SSR)
  self._mapNode.imgRareBgSR.gameObject:SetActive(itemCfg.Rarity == GameEnum.itemRarity.SR)
  self._mapNode.imgRareBgR.gameObject:SetActive(itemCfg.Rarity == GameEnum.itemRarity.R)
  NovaAPI.SetVerticalNormalizedPosition(self._mapNode.ScrollView, 1)
end

function FateCardItemCtrl:ActiveRollEffect()
  if not self.itemCfg then
    return
  end
  self._mapNode.SSR:SetActive(self.itemCfg.Rarity == GameEnum.itemRarity.SSR)
  self._mapNode.SR:SetActive(self.itemCfg.Rarity == GameEnum.itemRarity.SR)
  self._mapNode.N:SetActive(self.itemCfg.Rarity == GameEnum.itemRarity.R or self.itemCfg.Rarity == GameEnum.itemRarity.N)
end

function FateCardItemCtrl:PlayAnim(sAnimName)
  self._mapNode.animCtrl:Play(sAnimName)
end

function FateCardItemCtrl:Awake()
end

function FateCardItemCtrl:OnEnable()
end

function FateCardItemCtrl:OnDisable()
end

function FateCardItemCtrl:OnDestroy()
end

function FateCardItemCtrl:OnBtnClick_Word(link, sWordId)
  UTILS.ClickWordLink(link, sWordId)
end

function FateCardItemCtrl:ChangeWordRaycast(bEnable)
  self._mapNode.txtFateCardDesc:SetAllDirty()
  NovaAPI.SetTMPRaycastTarget(self._mapNode.txtFateCardDesc, bEnable)
end

function FateCardItemCtrl:SetRecommend(bEnable)
  self._mapNode.imgReommend:SetActive(bEnable)
end

function FateCardItemCtrl:SetGamePadScrollEnable(bEnable)
  NovaAPI.SetComponentEnable(self._mapNode.gamePadScroll, bEnable)
end

return FateCardItemCtrl
