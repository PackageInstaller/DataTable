local ItemExpiredPanel, Super = System.NewClass("ItemExpiredPanel", UIBasePanel)
ItemExpiredPanel.uiResCls = UI_Awaker_Popup_Expired_TipResource

function ItemExpiredPanel:ctor(itemList)
  Super.ctor(self)
  self.itemList = itemList
  if not itemList or 0 == #itemList then
    self.itemList = ItemDataUtils.GetExpiredItems()
  end
  self.convertItemList = self:GetConvertItemList(itemList)
end

function ItemExpiredPanel:GetConvertItemList(itemList)
  local convertItemList = {}
  for _, item in ipairs(itemList) do
    local itemCfg = ItemDataUtils.GetItemConfig(item.tid)
    if itemCfg and itemCfg.TransItem then
      for itemTid, itemCount in table.iteraDouble(itemCfg.TransItem) do
        table.insert(convertItemList, {
          tid = itemTid,
          num = itemCount * item.num
        })
      end
    end
  end
  return convertItemList
end

function ItemExpiredPanel:OnBind(binder)
  self.binder = binder
  self.itemModel = binder:createModel(CommonIconItemModel)
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self.binder:SetText(self.ui.Text_Expired1, LT.Text("ExpiredText"))
  self.binder:SetText(self.ui.Text_Expired2, LT.Text("ExpiredText"))
  self.binder:SetText(self.ui.Text_Convert, LT.Text("ExpiredConvertText"))
  self:InitVisible()
end

function ItemExpiredPanel:InitVisible()
  local isShowConvert = #self.convertItemList > 0
  if isShowConvert then
    self.binder:SetActive(self.ui.Group_OnlyExpire, false)
    self.binder:SetActive(self.ui.Group_ExpireAndConvert, true)
    self:InitExpiredList2()
    self:InitConvertList()
  else
    self.binder:SetActive(self.ui.Group_OnlyExpire, true)
    self.binder:SetActive(self.ui.Group_ExpireAndConvert, false)
    self:InitExpiredList()
  end
end

function ItemExpiredPanel:InitExpiredList()
  self.binder:BindToCircularListView(self.ui.ScrollView_OnlyExpire, function()
    return self.itemList
  end, function(childBinder, obj, index)
    self:BindItemIcon(childBinder, obj, self.itemList[index], true)
  end)
  local content = self.ui.ScrollView_OnlyExpire:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect)).content
  local groupCom = content:GetComponent(typeof(CS.UnityEngine.UI.HorizontalLayoutGroup))
  groupCom.enabled = true
  groupCom.childAlignment = CS.UnityEngine.TextAnchor.MiddleCenter
end

function ItemExpiredPanel:InitExpiredList2()
  self.binder:BindToCircularListView(self.ui.ScrollView_Expired2, function()
    return self.itemList
  end, function(childBinder, obj, index)
    self:BindItemIcon(childBinder, obj, self.itemList[index], true)
  end)
end

function ItemExpiredPanel:InitConvertList()
  self.binder:BindToCircularListView(self.ui.ScrollView_Convert, function()
    return self.convertItemList
  end, function(childBinder, obj, index)
    self:BindItemIcon(childBinder, obj, self.convertItemList[index])
  end)
end

function ItemExpiredPanel:BindItemIcon(childBinder, gameObj, itemData, isShowExpired)
  local compData = {
    tid = itemData.tid,
    uid = itemData.uid,
    model = self.itemModel,
    num = itemData.num,
    callback = function(tid, uid)
      ItemDataUtils.ShowItemDetailTips(self.binder, gameObj, uid, tid)
    end,
    showExpiredFunc = function()
      return isShowExpired
    end,
    ShowLockImg = false,
    ShowRedDot = false
  }
  childBinder:BindComponent(CommonIconItem(gameObj, compData))
end

return ItemExpiredPanel
