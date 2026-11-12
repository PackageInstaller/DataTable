local ConsumableSelectOutfitCtrl = class("ConsumableSelectOutfitCtrl", BaseCtrl)
ConsumableSelectOutfitCtrl._mapNodeConfig = {
  imgOutfit = {sComponentName = "Image"},
  imgStar = {nCount = 5},
  imgSelect = {}
}
ConsumableSelectOutfitCtrl._mapEventConfig = {}
ConsumableSelectOutfitCtrl._mapRedDotConfig = {}

function ConsumableSelectOutfitCtrl:Awake()
end

function ConsumableSelectOutfitCtrl:FadeIn()
end

function ConsumableSelectOutfitCtrl:FadeOut()
end

function ConsumableSelectOutfitCtrl:OnEnable()
end

function ConsumableSelectOutfitCtrl:OnDisable()
end

function ConsumableSelectOutfitCtrl:OnDestroy()
end

function ConsumableSelectOutfitCtrl:OnRelease()
end

function ConsumableSelectOutfitCtrl:Refresh(nTid, bSelect)
  local mapOutfit = ConfigTable.GetData("Outfit", nTid)
  if mapOutfit == nil then
    self.gameObject:SetActive(false)
    printError("Outfit Data Missing:" .. nTid)
    return
  end
  local mapItemCfgData = ConfigTable.GetData_Item(nTid)
  if mapItemCfgData == nil then
    self.gameObject:SetActive(false)
    printError("Outfit Item Data Missing:" .. nTid)
    return
  end
  local sSpriteName = mapItemCfgData.Icon .. AllEnum.OutfitIconSurfix.OutInfo
  self:SetPngSprite(self._mapNode.imgOutfit, sSpriteName)
  local nRare = mapItemCfgData.Rarity
  for nIdx, objStar in ipairs(self._mapNode.imgStar) do
    objStar:SetActive(nIdx > 5 - nRare)
  end
  self._mapNode.imgSelect:SetActive(bSelect)
end

function ConsumableSelectOutfitCtrl:SetSelect(bSelect)
  self._mapNode.imgSelect:SetActive(bSelect)
end

return ConsumableSelectOutfitCtrl
