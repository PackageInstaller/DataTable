local BatchItemCtrl = class("BatchItemCtrl", BaseCtrl)
BatchItemCtrl._mapNodeConfig = {
  rtqQuantitySelector = {
    sCtrlName = "Game.UI.TemplateEx.TemplateQuantitySelectorCtrl"
  },
  BatchItemTipsView = {
    sCtrlName = "Game.UI.Consumable.ConsumableItemTipsCtrl"
  },
  txtStock = {sComponentName = "TMP_Text"},
  srItemList = {
    sComponentName = "LoopScrollView"
  },
  ItemContent = {sComponentName = "Transform"},
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnConfirm1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Confirm"
  },
  txtBatchItemTitle2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "ConsumeableSelectItemTitle"
  },
  goNeed = {},
  txtNeedCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Consumable_NeedCount"
  },
  txtNeed = {sComponentName = "TMP_Text"}
}
BatchItemCtrl._mapEventConfig = {
  ConsumableCancel = "OnBtnClick_Close"
}
BatchItemCtrl._mapRedDotConfig = {}

function BatchItemCtrl:Awake()
  self._mapItemCtrl = {}
  self.gameObject:SetActive(false)
  self.animator = self.gameObject:GetComponent("Animator")
end

function BatchItemCtrl:FadeIn()
end

function BatchItemCtrl:FadeOut()
end

function BatchItemCtrl:OnEnable()
end

function BatchItemCtrl:OnDisable()
  self:UnbindAllCtrl()
end

function BatchItemCtrl:OnDestroy()
end

function BatchItemCtrl:OnRelease()
end

function BatchItemCtrl:UnbindAllCtrl()
  for go, mapCtrl in pairs(self._mapItemCtrl) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self._mapItemCtrl = {}
end

function BatchItemCtrl:OpenPanel(nTid, nItemCount, nSelectItemId, nNeedCount)
  self.gameObject:SetActive(true)
  self.animator:Play("t_window_04_t_in")
  if nItemCount == 0 then
    return
  end
  self._tbItem = {}
  self.nUseItemTid = nTid
  self.nSelectItemId = nSelectItemId
  local mapItemCfgData = ConfigTable.GetData_Item(nTid)
  local mapItemUseCfg = decodeJson(mapItemCfgData.UseArgs)
  if mapItemCfgData ~= nil then
    for sTid, nCount in pairs(mapItemUseCfg) do
      local nItemTid = tonumber(sTid)
      if nItemTid ~= nil then
        table.insert(self._tbItem, {nItemTid, nCount})
      end
    end
  end
  
  local function sort(a, b)
    local mapItemCfgDataA = ConfigTable.GetData_Item(a[1])
    local mapItemCfgDataB = ConfigTable.GetData_Item(b[1])
    if mapItemCfgDataA.Rarity ~= mapItemCfgDataB.Rarity then
      return mapItemCfgDataA.Rarity < mapItemCfgDataB.Rarity
    end
    return a[1] < b[1]
  end
  
  table.sort(self._tbItem, sort)
  self.useCount = 1
  self.nCurSelectItem = 1
  for i, v in ipairs(self._tbItem) do
    if v[1] == nSelectItemId then
      self.nCurSelectItem = i
      break
    end
  end
  self.bShowNeed = nNeedCount and nSelectItemId
  self._mapNode.goNeed:SetActive(self.bShowNeed)
  local nHasCount = nSelectItemId and PlayerData.Item:GetItemCountByID(nSelectItemId) or 0
  if self.bShowNeed and nNeedCount > nHasCount then
    self.useCount = nNeedCount - nHasCount
    if nItemCount < self.useCount then
      self.useCount = nItemCount
    end
  end
  self:RefreshNeed(nHasCount, nNeedCount)
  self.nItemCount = nItemCount
  if 0 < #self._tbItem then
    self._mapNode.BatchItemTipsView:Refresh(self._tbItem[self.nCurSelectItem][1])
    self._mapNode.srItemList:SetAnim(0.1)
    self._mapNode.srItemList:Init(#self._tbItem, self, self.OnGridRefresh, self.OnGridBtnClick, true)
  end
  NovaAPI.SetTMPText(self._mapNode.txtStock, orderedFormat(ConfigTable.GetUIText("ConsumableQtySelectorTitle"), self.nItemCount))
  
  local function callback(nCount)
    self.useCount = nCount
    self:RefreshNeed(nHasCount, nNeedCount)
  end
  
  self._mapNode.rtqQuantitySelector:Init(callback, self.useCount, self.nItemCount)
end

function BatchItemCtrl:OnGridRefresh(goGrid, gridIndex)
  if self._mapItemCtrl[goGrid] == nil then
    local mapCtrl = self:BindCtrlByNode(goGrid, "Game.UI.TemplateEx.TemplateItemCtrl")
    self._mapItemCtrl[goGrid] = mapCtrl
  end
  local nIdx = gridIndex
  if nIdx ~= nil then
    nIdx = nIdx + 1
  else
    return
  end
  local nItemTid = self._tbItem[nIdx][1]
  local nItemCount = self._tbItem[nIdx][2]
  self._mapItemCtrl[goGrid]:SetItem(nItemTid, nil, nItemCount)
  self._mapItemCtrl[goGrid]:SetSelect(nIdx == self.nCurSelectItem)
end

function BatchItemCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIdx = gridIndex
  if nIdx ~= nil then
    nIdx = nIdx + 1
  else
    return
  end
  if nIdx == self.nCurSelectItem then
    return
  end
  local rtItemBefore = self._mapNode.ItemContent:Find(tostring(self.nCurSelectItem - 1))
  if rtItemBefore ~= nil and self._mapItemCtrl[rtItemBefore.gameObject] ~= nil then
    self._mapItemCtrl[rtItemBefore.gameObject]:SetSelect(false)
  end
  if self._mapItemCtrl[goGrid] ~= nil then
    self._mapItemCtrl[goGrid]:SetSelect(true)
  end
  self._mapNode.BatchItemTipsView:Refresh(self._tbItem[nIdx][1])
  self._mapNode.goNeed:SetActive(self._tbItem[nIdx][1] == self.nSelectItemId and self.bShowNeed)
  self.nCurSelectItem = nIdx
end

function BatchItemCtrl:RefreshNeed(nHasCount, nNeedCount)
  if not self.bShowNeed then
    return
  end
  local nAfterCount = nHasCount + self.useCount
  if nNeedCount <= nAfterCount then
    NovaAPI.SetTMPText(self._mapNode.txtNeed, "<color=#264278>" .. nAfterCount .. "</color>/" .. nNeedCount)
  else
    NovaAPI.SetTMPText(self._mapNode.txtNeed, "<color=#BD3059>" .. nAfterCount .. "</color>/" .. nNeedCount)
  end
end

function BatchItemCtrl:OnBtnClick_Close(btn)
  EventManager.Hit("CancelUseItem")
  self.animator:Play("t_window_04_t_out")
end

function BatchItemCtrl:OnBtnClick_Confirm(btn)
  local nSelectItem = self._tbItem[self.nCurSelectItem][1]
  local nSelectCount = self._tbItem[self.nCurSelectItem][2] * self.useCount
  local nUseName = ConfigTable.GetData_Item(self.nUseItemTid).Title
  local nItemName = ConfigTable.GetData_Item(nSelectItem).Title
  local msg = {
    nType = AllEnum.MessageBox.Item,
    sContent = orderedFormat(ConfigTable.GetUIText("Consumable_ConfirmTipBatchItem"), self.useCount, nUseName, nSelectCount, nItemName),
    tbItem = {
      [1] = {nTid = nSelectItem, nCount = nSelectCount}
    },
    callbackConfirm = function()
      EventManager.Hit("ConfirmUseItem", self.nUseItemTid, self.useCount, nSelectItem)
    end,
    bBlur = false
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

return BatchItemCtrl
