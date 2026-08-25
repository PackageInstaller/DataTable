local T_DragGesture = typeof(CS.Z1Client.General.DragGesture)
local AppearanceItemComp, Super = NewViewComponent("AppearanceItemComp")
AppearanceItemComp.uiResCls = UI_Bag_Item_AppearanceResource
local TypeOfTMP_Text = typeof(CS.TMPro.TMP_Text)
local TextAlignmentOptions = CS.TMPro.TextAlignmentOptions

function AppearanceItemComp:ctor(uiNode, view, itemId, extraData, nowId, interactable, outerScrollRect)
  Super.ctor(self, uiNode, view)
  self.ui = self.uiResCls(uiNode)
  self._itemId = itemId
  self._extraData = extraData
  self._nowId = nowId
  self._interactable = interactable
  self._outerScrollRect = outerScrollRect
end

function AppearanceItemComp:OnEnterComponent()
  local realItemId = ItemDataUtils.GetGenderDifferenceRealItem(self._itemId)
  self:SetImage(self.ui.Image_Icon, ItemDataUtils.GetIcon(realItemId))
  self:SetText(self.ui.Text_Name, ItemDataUtils.GetItemName(realItemId))
  local textComp = self.ui.Text_Name:GetComponent(TypeOfTMP_Text)
  if textComp then
    textComp.enableWordWrapping = Utils.IsLangChinese()
  end
  local comp = AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_Name)
  if comp then
    comp:SetBtn(self.ui.Btn_Click)
  end
  if comp then
    local cfgAdaption = {
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
    local cfgInit = {
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
      initCfg = cfgInit,
      adaptionCfg = cfgAdaption
    })
  end
  local realId = ItemDataUtils.GetGenderDifferenceRealItem(self._itemId)
  self:SetActive(self.ui.Group_Got, ItemDataUtils.GetBagItemNum(realId) > 0)
  self:SetActive(self.ui.Image_Select, false)
  self:BindEvent(EventMgr.Instance.AppearanceChoose, System.fn(self, self._OnAppearanceChoose))
  if self._nowId == self._itemId then
    EventMgr.Instance.AppearanceChoose:Dispatch(self._itemId, self._extraData)
  end
  self._gesture = self.ui.Btn_Click:GetComponent(T_DragGesture)
  if not self._gesture then
    self._gesture = self.ui.Btn_Click:AddComponent(T_DragGesture)
  end
  self._cbPointerDown = System.fn(self, self._OnPointerDown)
  self._cbClick = System.fn(self, self._OnClickItem)
  self._cbBeginDrag = System.fn(self, self._OnBeginDrag)
  self._cbDrag = System.fn(self, self._OnDrag)
  self._cbEndDrag = System.fn(self, self._OnEndDrag)
  self._gesture:onPointerDown("+", self._cbPointerDown)
  self._gesture:onPointerClick("+", self._cbClick)
  if self._outerScrollRect then
    self._gesture:onBeginDrag("+", self._cbBeginDrag)
    self._gesture:onDrag("+", self._cbDrag)
    self._gesture:onEndDrag("+", self._cbEndDrag)
  end
end

function AppearanceItemComp:OnExitComponent()
  if self._gesture then
    self._gesture:onPointerDown("-", self._cbPointerDown)
    self._gesture:onPointerClick("-", self._cbClick)
    if self._outerScrollRect then
      self._gesture:onBeginDrag("-", self._cbBeginDrag)
      self._gesture:onDrag("-", self._cbDrag)
      self._gesture:onEndDrag("-", self._cbEndDrag)
    end
  end
  Super.OnExitComponent(self)
end

function AppearanceItemComp:_OnPointerDown()
  self._isDragging = false
end

function AppearanceItemComp:_OnBeginDrag(eventData)
  self._isDragging = true
  self._outerScrollRect:OnBeginDrag(eventData)
end

function AppearanceItemComp:_OnDrag(eventData)
  self._outerScrollRect:OnDrag(eventData)
end

function AppearanceItemComp:_OnEndDrag(eventData)
  self._outerScrollRect:OnEndDrag(eventData)
end

function AppearanceItemComp:_OnAppearanceChoose(id, extraData)
  if self._extraData and extraData then
    if self._extraData.tabIndex == extraData.tabIndex then
      self:_UpdateSelectState(id)
    end
  else
    self:_UpdateSelectState(id)
  end
end

function AppearanceItemComp:_UpdateSelectState(id)
  self:SetActive(self.ui.Image_Select, id == self._itemId)
end

function AppearanceItemComp:_OnClickItem()
  if self._isDragging then
    return
  end
  ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.uiNode, nil, self._itemId, nil, {posY = -287})
  if ItemDataUtils.GetBagItemNum(ItemDataUtils.GetGenderDifferenceRealItem(self._itemId)) <= 0 and self._interactable then
    EventMgr.Instance.AppearanceChoose:Dispatch(self._itemId, self._extraData)
  else
    EventMgr.Instance.AppearanceChoose:Dispatch(nil, self._extraData)
  end
end

return AppearanceItemComp
