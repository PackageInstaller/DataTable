local CardKeyWordTipItem, Super = System.NewComponent("CardKeyWordTipItem")

function CardKeyWordTipItem:ctor(uiNode, tipsInfo, spacing)
  Super.ctor(self)
  if nil == uiNode then
    Logger.Debug("ShopCardDescItem nil: ")
  end
  self.ui = CardKeyWordTipItemResource(uiNode)
  self.name = tipsInfo.name
  self.desc = tipsInfo.desc
  self.source = tipsInfo.source
  self.isYellow = tipsInfo.isYellow
  self.spacing = spacing
  self.qualityToBg = {
    White = "UIResources/UIBigImages/UI_Large/UI_Card_Image_Enchant_Ordinary.png",
    Orange = "UIResources/UIBigImages/UI_Large/UI_Card_Image_Enchant_Advanced.png",
    Red = "UIResources/UIBigImages/UI_Large/UI_Card_Image_Enchant_Corrupt.png"
  }
end

function CardKeyWordTipItem:OnBind(binder)
  binder:SetText(self.ui.Text_Description, self.desc)
  local isEnchant = self.source and self.source.sourceType == "Enchant"
  local enchantTypeMap = {
    Orange = LT.Text("OrangeEnchantConfigTypeName"),
    White = LT.Text("WhiteEnchantConfigTypeName"),
    Red = LT.Text("RedEnchantConfigTypeName")
  }
  if isEnchant then
    local tid = self.source.tid
    local quality = DT.EnchantConfig[tid].Quality
    local icon = DT.EnchantConfig[tid].SmallIcon
  else
  end
  CS.Framework.UIUtilTool.RefreshLayout(self.ui.uiNode)
end

function CardKeyWordTipItem:GetObjSize()
  CS.Framework.UIUtilTool.RefreshLayout(self.ui.uiNode)
  if not self.rootRt then
    self.RootRt = self.ui.uiNode:GetComponent(typeof(CS.UnityEngine.RectTransform))
  end
  local sizeDelta = self.RootRt.sizeDelta
  return sizeDelta
end

return CardKeyWordTipItem
