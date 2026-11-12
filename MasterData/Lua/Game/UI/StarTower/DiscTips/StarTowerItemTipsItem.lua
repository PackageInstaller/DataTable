local StarTowerItemTipsItem = class("StarTowerItemTipsItem", BaseCtrl)
StarTowerItemTipsItem._mapNodeConfig = {
  imgBg = {sComponentName = "Image"},
  itemTr = {
    sNodeName = "imgBg",
    sComponentName = "RectTransform"
  },
  canvasGroup = {
    sNodeName = "imgBg",
    sComponentName = "CanvasGroup"
  },
  imgItemIcon = {
    sNodeName = "img_ItemIcon",
    sComponentName = "Image"
  },
  txtItemName = {
    sNodeName = "txt_ItemName",
    sComponentName = "TMP_Text"
  }
}
StarTowerItemTipsItem._mapEventConfig = {}

function StarTowerItemTipsItem:Show(nTid, nCount)
  local mapItemCfg = ConfigTable.GetData_Item(nTid)
  self:SetSprite_FrameColor(self._mapNode.imgBg, mapItemCfg.Rarity, "rare_vestige_obtain_", true)
  NovaAPI.SetImageNativeSize(self._mapNode.imgBg)
  if mapItemCfg.Type == GameEnum.itemType.Disc then
    self:SetPngSprite(self._mapNode.imgItemIcon, mapItemCfg.Icon .. AllEnum.OutfitIconSurfix.Item)
  else
    self:SetPngSprite(self._mapNode.imgItemIcon, mapItemCfg.Icon)
  end
  NovaAPI.SetTMPText(self._mapNode.txtItemName, string.format("[%s]", mapItemCfg.Title) .. "×" .. nCount)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, 0)
  self._mapNode.itemTr.anchoredPosition = Vector2(0, 0)
  local nInAnimLen = NovaAPI.GetAnimClipLength(self.animRoot, {
    "TemplateItemTip_in"
  })
  self:AddTimer(1, nInAnimLen + 1, function()
    self:OnTipItemHide()
  end, true, true, true, nil)
end

function StarTowerItemTipsItem:OnTipItemHide()
  local nInAnimLen = NovaAPI.GetAnimClipLength(self.animRoot, {
    "TemplateItemTip_out"
  })
  self.animRoot:Play("TemplateItemTip_out")
  self:AddTimer(1, nInAnimLen, function()
    EventManager.Hit("StarTowerTipsShowEnd", self, AllEnum.StarTowerTipsType.ItemTip)
  end, true, true, true, nil)
end

function StarTowerItemTipsItem:Awake()
  self.animRoot = self.gameObject:GetComponent("Animator")
end

return StarTowerItemTipsItem
