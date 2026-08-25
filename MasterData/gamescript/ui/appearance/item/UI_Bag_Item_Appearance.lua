local UI_Bag_Item_Appearance, Super = System.NewComponent("UI_Bag_Item_Appearance")
UI_Bag_Item_Appearance.uiResCls = UI_Bag_Item_AppearanceResource
local TypeOfTMP_Text = typeof(CS.TMPro.TMP_Text)
local TextAlignmentOptions = CS.TMPro.TextAlignmentOptions

function UI_Bag_Item_Appearance:ctor(uiNode, itemId, extraData, nowId, interactable)
  Super.ctor(self)
  self.ui = self.uiResCls(uiNode)
  self.itemId = itemId
  self.extraData = extraData
  self.nowId = nowId
  self.interactable = interactable
end

function UI_Bag_Item_Appearance:OnBind(binder)
  self.binder = binder
  local realItemId = ItemDataUtils.GetGenderDifferenceRealItem(self.itemId)
  self.binder:SetImage(self.ui.Image_Icon, ItemDataUtils.GetIcon(realItemId))
  self.binder:SetText(self.ui.Text_Name, ItemDataUtils.GetItemName(realItemId))
  local textComp = self.ui.Text_Name:GetComponent(TypeOfTMP_Text)
  if textComp then
    textComp.enableWordWrapping = Utils.IsLangChinese()
  end
  local comp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Name)
  if comp then
    comp:SetBtn(self.ui.Btn_Click)
  end
  if comp then
    local cfg_adaption = {
      fontSize = 26,
      autoSizeCN = true,
      autoSizeOther = false,
      alignmentCN = TextAlignmentOptions.Center,
      alignmentOther = TextAlignmentOptions.Center,
      widthCN = 180,
      widthOther = 180,
      height = 38,
      x = 0,
      y = 0,
      pivotX = 0,
      pivotY = 0.5,
      anchorX = 0,
      anchorY = 0.5,
      contentSize = 180
    }
    local cfg_init = {
      fontSize = 26,
      autoSizeCN = true,
      autoSizeOther = false,
      alignmentCN = TextAlignmentOptions.Left,
      alignmentOther = TextAlignmentOptions.Left,
      widthCN = 180,
      widthOther = 180,
      height = 38,
      x = 0,
      y = 0,
      pivotX = 0,
      pivotY = 1,
      anchorX = 0,
      anchorY = 1
    }
    comp:ForceUpdate({
      limitPercent = 0.8,
      lineLimit = 4,
      miniFontSize = 20,
      maxFontSize = 26,
      initCfg = cfg_init,
      adaptionCfg = cfg_adaption
    })
  end
  self.binder:BindToVisible(self.ui.Group_Got, function()
    local realId = ItemDataUtils.GetGenderDifferenceRealItem(self.itemId)
    return ItemDataUtils.GetBagItemNum(realId) > 0
  end)
  self.binder:SetActive(self.ui.Image_Select, false)
  self.binder:BindEvent(EventMgr.Instance.AppearanceChoose, System.fn(self, self.OnAppearanceChoose))
  if self.nowId == self.itemId then
    EventMgr.Instance.AppearanceChoose:Dispatch(self.itemId, self.extraData)
  end
  self.binder:BindButtonClick(self.ui.Btn_Click, function()
    ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.uiNode, nil, self.itemId, nil, {posY = -287})
    if ItemDataUtils.GetBagItemNum(ItemDataUtils.GetGenderDifferenceRealItem(self.itemId)) <= 0 and self.interactable then
      EventMgr.Instance.AppearanceChoose:Dispatch(self.itemId, self.extraData)
    else
      EventMgr.Instance.AppearanceChoose:Dispatch(nil, self.extraData)
    end
  end)
end

function UI_Bag_Item_Appearance:OnAppearanceChoose(id, extraData)
  if self.extraData and extraData then
    if self.extraData.tabIndex == extraData.tabIndex then
      self:UpdateSelectState(id)
    end
  else
    self:UpdateSelectState(id)
  end
end

function UI_Bag_Item_Appearance:UpdateSelectState(id)
  self.binder:SetActive(self.ui.Image_Select, id == self.itemId)
end

return UI_Bag_Item_Appearance
