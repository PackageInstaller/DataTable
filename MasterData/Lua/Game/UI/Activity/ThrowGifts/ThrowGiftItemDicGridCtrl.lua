local ThrowGiftItemDicGridCtrl = class("ThrowGiftItemDicGridCtrl", BaseCtrl)
ThrowGiftItemDicGridCtrl._mapNodeConfig = {
  imgBgItemNormal = {sComponentName = "Image"},
  imgItemIcon = {sComponentName = "Image"},
  TMPItemName = {sComponentName = "TMP_Text"},
  rtUnlock = {},
  rtLock = {}
}
ThrowGiftItemDicGridCtrl._mapEventConfig = {}
ThrowGiftItemDicGridCtrl._mapRedDotConfig = {}

function ThrowGiftItemDicGridCtrl:Awake()
end

function ThrowGiftItemDicGridCtrl:FadeIn()
end

function ThrowGiftItemDicGridCtrl:FadeOut()
end

function ThrowGiftItemDicGridCtrl:OnEnable()
end

function ThrowGiftItemDicGridCtrl:OnDisable()
end

function ThrowGiftItemDicGridCtrl:OnDestroy()
end

function ThrowGiftItemDicGridCtrl:OnRelease()
end

function ThrowGiftItemDicGridCtrl:SetItem(nItemId, bUnlock)
  local mapItemCfgData = ConfigTable.GetData("ThrowGiftItem", nItemId)
  if mapItemCfgData == nil then
    self.gameObject:SetActive(false)
    return
  end
  self.gameObject:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.TMPItemName, mapItemCfgData.Name)
  self:SetPngSprite(self._mapNode.imgItemIcon, mapItemCfgData.Icon)
  self._mapNode.rtUnlock:SetActive(bUnlock)
  self._mapNode.rtLock:SetActive(not bUnlock)
end

return ThrowGiftItemDicGridCtrl
