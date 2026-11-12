local DepotFateCardItemCtrl = class("DepotFateCardItemCtrl", BaseCtrl)
DepotFateCardItemCtrl._mapNodeConfig = {
  imgRare = {sComponentName = "Image"},
  imgIcon = {sComponentName = "Image"},
  txtCount = {sComponentName = "TMP_Text"},
  imgChoose = {},
  imgUnable = {},
  txtUnable = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_FateCard_Unable"
  },
  ImgMark = {}
}
DepotFateCardItemCtrl._mapEventConfig = {}
DepotFateCardItemCtrl._mapRedDotConfig = {}

function DepotFateCardItemCtrl:InitFateCard(nId, nTime, bEx)
  self.nId = nId
  local itemCfg = ConfigTable.GetData_Item(nId)
  if nil == itemCfg then
    printError(string.format("获取Item表格配置失败！！！id = [%s]", nId))
    return
  end
  local sFrame = AllEnum.FrameType_New.FateCardS .. AllEnum.FrameColor_New[itemCfg.Rarity]
  self:SetAtlasSprite(self._mapNode.imgRare, "12_rare", sFrame)
  self:SetPngSprite(self._mapNode.imgIcon, itemCfg.Icon2)
  self._mapNode.imgUnable.gameObject:SetActive(nTime == 0)
  self._mapNode.txtCount.gameObject:SetActive(false)
  self._mapNode.imgChoose.gameObject:SetActive(false)
  self._mapNode.ImgMark:SetActive(bEx)
end

function DepotFateCardItemCtrl:SetChoose(bChoose)
  self._mapNode.imgChoose.gameObject:SetActive(bChoose)
end

function DepotFateCardItemCtrl:Awake()
end

function DepotFateCardItemCtrl:FadeIn()
end

function DepotFateCardItemCtrl:FadeOut()
end

function DepotFateCardItemCtrl:OnEnable()
end

function DepotFateCardItemCtrl:OnDisable()
end

function DepotFateCardItemCtrl:OnDestroy()
end

function DepotFateCardItemCtrl:OnRelease()
end

function DepotFateCardItemCtrl:OnBtnClick_AAA()
end

function DepotFateCardItemCtrl:OnEvent_AAA()
end

return DepotFateCardItemCtrl
