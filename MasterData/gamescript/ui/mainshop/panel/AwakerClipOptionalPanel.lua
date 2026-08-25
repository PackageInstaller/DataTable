local AwakerClipOptionalPanel, Super = System.NewClass("AwakerClipOptionalPanel", UIBasePanel)
AwakerClipOptionalPanel.uiResCls = UI_Events_Popup_OptionalResource

function AwakerClipOptionalPanel:ctor(itemTid, goodsTid)
  Super.ctor(self)
  self.itemTid = itemTid
  self.goodsTid = goodsTid
end

function AwakerClipOptionalPanel:OnBind(binder)
  self.chestModel = binder:createModel(FreeChoiceChestModel, self.itemTid)
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, function()
    self:Close()
  end)
  binder:SetText(self.ui.Text_Title, LT.Text("AwakerChipSelectTitle"))
  binder:BindToCircularListView(self.ui.ScrollView, function()
    return self.chestModel.itemInfos
  end, function(itemBinder, obj, idx)
    local itemInfo = self.chestModel.itemInfos[idx]
    itemBinder:BindComponent(FreeChoiceChestItem(obj, self.chestModel, itemInfo, idx))
  end)
  if self.ui.Group_Tips_Left then
    self.ui.Group_Tips_Left:SetActive(false)
  end
  if self.ui.Group_Tips_Middle then
    self.ui.Group_Tips_Middle:SetActive(false)
  end
  binder:BindZ1Button(self.ui.Btn_Details, function()
    local itemInfo = self.chestModel.itemInfos[self.chestModel.currSelectedIdx]
    if not itemInfo then
      Alert.Show(10650)
      return
    end
    if itemInfo.SubType == CommonDefine.ItemSubType.AwakerChip then
      FuncJumpManager.JumpToFuncPanel(nil, function()
        local awakerBasePanelData = {}
        awakerBasePanelData.jumpPage = CommonDefine.AwakerPage.Detail
        awakerBasePanelData.specialAwakerList = {
          AwakerDataUtils.GetAwakerData(itemInfo.awakerTid)
        }
        UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
      end)
    else
      ItemDataUtils.ShowItemDetailTips(binder, self.ui.Btn_Cancel, nil, itemInfo.tid)
    end
  end, nil, function()
    do return LT.Text end
    return LT.Text, "AwakerWeaponSelectDetail"
  end)
  binder:BindZ1Button(self.ui.Btn_Receive, function()
    local itemInfo = self.chestModel.itemInfos[self.chestModel.currSelectedIdx]
    if not itemInfo then
      Alert.Show(10650)
      return
    end
    local itemCfg = DT.Item[itemInfo.tid]
    local tipCfg = DT.TipsType[20107]
    local title = LT.Text(tipCfg.Title)
    local desc = LT.Textf(tipCfg.Desc, LT.Text(itemCfg.Name))
    Alert.Show(20107, nil, function()
      MainShopDataUtils.ReqOnChooseBuy(self.goodsTid, {
        itemInfo.tid
      }, System.fn(self, self.ClosePanel))
    end, title, desc)
  end, nil, function()
    do return LT.Text end
    return LT.Text, "Common_Button_Confirm"
  end)
end

function AwakerClipOptionalPanel:_ShowAwakerInfo(itemInfo, svrData)
  local transItems = {}
  for _, data in ipairs(svrData) do
    if data.transData then
      for _, td in ipairs(data.transData) do
        table.insert(transItems, {
          tid = td.tid,
          count = td.num
        })
      end
      break
    end
  end
  local summonResult = {
    highestQuality = DT.Item[itemInfo.tid].Quality,
    itemList = {
      {
        tid = itemInfo.tid,
        count = 1,
        transItems = transItems
      }
    }
  }
  UIManager.Instance:Reopen(Urls.SummonResultPanel, summonResult, nil, true, function()
    if #transItems > 0 then
      local items = {}
      for _, item in ipairs(transItems) do
        table.insert(items, {
          tid = item.tid,
          changedNum = item.count
        })
      end
      ItemDataUtils.ShowItemGain(items)
    end
  end, true)
end

function AwakerClipOptionalPanel:ClosePanel()
  self:Close()
end

return AwakerClipOptionalPanel
