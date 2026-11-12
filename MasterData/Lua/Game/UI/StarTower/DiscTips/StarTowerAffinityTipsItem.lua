local StarTowerAffinityTipsItem = class("StarTowerAffinityTipsItem", BaseCtrl)
StarTowerAffinityTipsItem._mapNodeConfig = {
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
  itemIconTr = {
    sNodeName = "img_ItemIcon",
    sComponentName = "RectTransform"
  },
  txtItemName = {
    sNodeName = "txt_ItemName",
    sComponentName = "TMP_Text"
  }
}
StarTowerAffinityTipsItem._mapEventConfig = {}

function StarTowerAffinityTipsItem:Show(nNpcId, nAffinity)
  local mapNpcCfg = ConfigTable.GetData("StarTowerNPC", nNpcId)
  self:SetPngSprite(self._mapNode.imgBg, "UI/big_sprites/rare_vestige_obtain_6")
  NovaAPI.SetImageNativeSize(self._mapNode.imgBg)
  if nAffinity == 0 then
    self:SetAtlasSprite(self._mapNode.imgItemIcon, "10_ico", "icon_favorability_01")
    self._mapNode.itemIconTr.localScale = Vector3.one
    NovaAPI.SetTMPText(self._mapNode.txtItemName, ConfigTable.GetUIText("StarTowerNPCAffinity_MaxCount"))
  else
    if mapNpcCfg ~= nil then
      self:SetPngSprite(self._mapNode.imgItemIcon, mapNpcCfg.Head)
      self._mapNode.itemIconTr.localScale = Vector3.one * 0.25
      self._mapNode.itemIconTr.anchoredPosition = Vector2(16.9, 3.89)
    else
      self:SetAtlasSprite(self._mapNode.imgItemIcon, "10_ico", "icon_favorability_01")
      self._mapNode.itemIconTr.localScale = Vector3.one
      self._mapNode.itemIconTr.anchoredPosition = Vector2(16.9, 0)
    end
    NovaAPI.SetTMPText(self._mapNode.txtItemName, orderedFormat(ConfigTable.GetUIText("StarTowerNPCAffinity_Increase"), nAffinity))
  end
  NovaAPI.SetImageNativeSize(self._mapNode.imgItemIcon)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.canvasGroup, 0)
  self._mapNode.itemTr.anchoredPosition = Vector2(0, 0)
  local nInAnimLen = NovaAPI.GetAnimClipLength(self.animRoot, {
    "TemplateItemTip_in"
  })
  self:AddTimer(1, nInAnimLen + 1, function()
    self:OnTipItemHide()
  end, true, true, true, nil)
end

function StarTowerAffinityTipsItem:OnTipItemHide()
  local nInAnimLen = NovaAPI.GetAnimClipLength(self.animRoot, {
    "TemplateItemTip_out"
  })
  self.animRoot:Play("TemplateItemTip_out")
  self:AddTimer(1, nInAnimLen, function()
    EventManager.Hit("StarTowerTipsShowEnd", self, AllEnum.StarTowerTipsType.NPCAffinity)
  end, true, true, true, nil)
end

function StarTowerAffinityTipsItem:Awake()
  self.animRoot = self.gameObject:GetComponent("Animator")
end

return StarTowerAffinityTipsItem
