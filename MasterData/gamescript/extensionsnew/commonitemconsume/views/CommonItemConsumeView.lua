local CommonItemConsumeView, Super = NewClass("CommonItemConsumeView", BaseView)
CommonItemConsumeView.uiResCls = UI_Common_Popup_ConsumeResource
local ITEM_SCALE = 0.7
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local T_HorizontalLayoutGroup = typeof(CS.UnityEngine.UI.HorizontalLayoutGroup)
local T_RectTransform = typeof(CS.UnityEngine.RectTransform)
local GameObject = CS.UnityEngine.GameObject

function CommonItemConsumeView:ctor(data)
  Super.ctor(self)
  self.data = data
  self._confirmCallback = data.confirmCallback
  self._closeCallback = data.closeCallback
  self._backExpandFunc = nil
  self._prevBackExpandFunc = nil
  self._itemComps = {}
end

function CommonItemConsumeView:OnBuildView()
  Super.OnBuildView(self)
end

function CommonItemConsumeView:RegisterEvents()
  if self.ui.Btn_Cancel then
    self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self._OnClickCancel))
  end
  if self.ui.Btn_Confirm then
    self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._OnClickConfirm))
  end
  if self.ui.Btn_Mask then
    self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self._OnClickMask))
  end
end

function CommonItemConsumeView:OnEnterView()
  Super.OnEnterView(self)
  self._prevBackExpandFunc = UIManager.Instance.backExpandFunc
  
  function self._backExpandFunc()
    self:_Close()
  end
  
  UIManager.Instance:UpdateBackExpandFunc(self._backExpandFunc)
  if self.ui.Text_Tip and self.data.tipText then
    self:SetText(self.ui.Text_Tip, self.data.tipText)
  end
  self:_CreateItemTableView()
end

function CommonItemConsumeView:OnExitView()
  Super.OnExitView(self)
  if UIManager.Instance and UIManager.Instance.backExpandFunc == self._backExpandFunc then
    if self._prevBackExpandFunc then
      UIManager.Instance:UpdateBackExpandFunc(self._prevBackExpandFunc)
    else
      UIManager.Instance:ClearBackExpandFuc()
    end
  end
  self._prevBackExpandFunc = nil
  self._backExpandFunc = nil
  self._itemComps = nil
  if self._closeCallback then
    self._closeCallback()
    self._closeCallback = nil
  end
end

function CommonItemConsumeView:_CreateItemTableView()
  local itemList = self.data.itemList or {}
  local cellTemplate = self.ui.UI_Common_Item_WuPin_Type1
  if not cellTemplate then
    return
  end
  if #itemList < 7 then
    self:_CreateDirectItems(itemList, cellTemplate)
  else
    self:_CreateTableViewItems(itemList, cellTemplate)
  end
end

function CommonItemConsumeView:_CreateDirectItems(itemList, cellTemplate)
  local scrollRect = self.ui.ScrollView:GetComponent(T_ScrollRect)
  local contentNode = scrollRect and scrollRect.content
  if not contentNode then
    return
  end
  local contentTransform = contentNode.transform
  local tableView = self.ui.ScrollView:GetComponent(typeof(CS.UITableview))
  if tableView then
    tableView.enabled = false
  end
  for i, itemData in ipairs(itemList) do
    local go = GameObject.Instantiate(cellTemplate, contentTransform)
    go.name = "Item_" .. i
    go:SetActive(true)
    local itemUi = UI_Common_Item_WuPin_Type1Resource(go)
    self:SetImage(itemUi.Icon_Article, ItemDataUtils.GetItemIcon(itemData.itemId))
    local itemCfg = DT.Item[itemData.itemId]
    if itemCfg then
      local qualityFrame = ItemDataUtils.GetCommonItemBottomQualityFrame(itemCfg, itemUi.Image_Bg_Black)
      if qualityFrame then
        self:SetImage(itemUi.Image_Quality, qualityFrame)
      end
    end
    local haveNum = ItemDataUtils.GetItemNum(itemData.itemId)
    local needNum = itemData.itemNum or 1
    local numText
    if haveNum < needNum then
      numText = string.format("<color=#FA3A50>%s</color>/%s", haveNum, needNum)
    else
      numText = string.format("%s/%s", haveNum, needNum)
    end
    self:SetText(itemUi.Text_Article_Number, numText)
  end
  local contentLayout = contentNode:GetComponent(T_HorizontalLayoutGroup)
  if contentLayout then
    contentLayout.enabled = true
  end
  local contentRt = contentNode:GetComponent(T_RectTransform)
  if contentRt then
    local sd = contentRt.sizeDelta
    contentRt.sizeDelta = CS.UnityEngine.Vector2(1083, sd.y)
  end
end

function CommonItemConsumeView:_CreateTableViewItems(itemList, cellTemplate)
  local cellRt = cellTemplate:GetComponent(T_RectTransform)
  local cellW = cellRt and cellRt.sizeDelta.x / ITEM_SCALE or 100
  local cellH = cellRt and cellRt.sizeDelta.y / ITEM_SCALE or 100
  self._itemTableView = self:CreateTableview(self.ui.ScrollView, function()
    return #itemList
  end, function(view, idx)
    local itemData = itemList[idx]
    if not itemData then
      return nil
    end
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(cellTemplate)
    local gameObj = cell.gameObject
    local itemUi = UI_Common_Item_WuPin_Type1Resource(gameObj)
    self:SetImage(itemUi.Icon_Article, ItemDataUtils.GetItemIcon(itemData.itemId))
    local itemCfg = DT.Item[itemData.itemId]
    if itemCfg then
      local qualityFrame = ItemDataUtils.GetCommonItemBottomQualityFrame(itemCfg, itemUi.Image_Bg_Black)
      if qualityFrame then
        self:SetImage(itemUi.Image_Quality, qualityFrame)
      end
    end
    local haveNum = ItemDataUtils.GetItemNum(itemData.itemId)
    local needNum = itemData.itemNum or 1
    local numText
    if haveNum < needNum then
      numText = string.format("<color=#FA3A50>%s</color>/%s", haveNum, needNum)
    else
      numText = string.format("%s/%s", haveNum, needNum)
    end
    self:SetText(itemUi.Text_Article_Number, numText)
    return cell
  end, function()
    return cellW, cellH
  end, function()
    self._itemComps = {}
  end)
  if self._itemTableView then
    self._itemTableView:ReloadData()
  end
end

function CommonItemConsumeView:_OnClickCancel()
  self:_Close()
end

function CommonItemConsumeView:_OnClickConfirm()
  if self._confirmCallback then
    self._confirmCallback()
    self._confirmCallback = nil
  end
  self:_Close()
end

function CommonItemConsumeView:_OnClickMask()
  self:_Close()
end

function CommonItemConsumeView:_Close()
  Super.Close(self)
end

return CommonItemConsumeView
