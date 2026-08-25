local AwakerClipSelectPanel, Super = System.NewClass("AwakerClipSelectPanel", UIBasePanel)
AwakerClipSelectPanel.uiResCls = UI_Bag_Obtain_Awaken_TipsResource

function AwakerClipSelectPanel:ctor(itemTid, confirmCallback)
  Super.ctor(self)
  self.itemTid = itemTid
  self.confirmCallback = confirmCallback
end

function AwakerClipSelectPanel:OnBind(binder)
  local model = binder:createModel(AwakerClipOptionalPanelModel, self.itemTid)
  self.model = model
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.PopupTipsType.L,
    clickFunc = System.fn(self, self.ClosePanel)
  }
  self.binder:BindComponent(CommonPopupTips(self.ui.UI_Common_Popup_Tips_L, commonPopupConfirmTipsData))
  binder:BindZ1Button(self.ui.Btn_Cancel, System.fn(self, self.JumpToDetail))
  binder:BindZ1Button(self.ui.Btn_Confirm, System.fn(self, self.ConfirmSelect))
  binder:BindToCircularListView(self.ui.ScrollView, function()
    return model.showAwakerGroup
  end, function(itemBinder, item, index)
    local itemTid = model.showAwakerGroup[index].tid
    
    local function showTextFunc()
      return DT.Item[itemTid].Name
    end
    
    local function selectBgFunc()
      return itemTid == model.curSelectAwakerClipTid
    end
    
    if DT.Item[itemTid].SubType == CommonDefine.ItemSubType.AwakerChip then
      local awakerId = DT.Item[itemTid].SpParam[1]
      local awakerData = AwakerDataUtils.GetAwakerData(awakerId)
      
      local function fullAwakenFunc()
        do return ItemDataUtils.IsAwakerChipOverFlow end
        return ItemDataUtils.IsAwakerChipOverFlow, itemTid
      end
      
      local function clickFunc()
        model:SetCurSelectAwakerClipTid(itemTid)
      end
      
      local itemData = {
        clickFunc = clickFunc,
        awakerData = awakerData,
        selectBgFunc = selectBgFunc,
        fullAwakenFunc = fullAwakenFunc,
        showTextFunc = showTextFunc,
        showPotencyInfoFunc = function()
          do return AwakerDataUtils.HasOwnedAwaker end
          return AwakerDataUtils.HasOwnedAwaker, awakerId
        end
      }
      itemBinder:BindComponent(CommonAwakerListItem(item, itemData))
    else
      local function clickFunc()
        model:SetCurSelectAwakerClipTid(itemTid)
      end
      
      local function showNumFunc()
        return model.showAwakerGroup[index].num
      end
      
      local itemData = {
        clickFunc = clickFunc,
        selectBgFunc = selectBgFunc,
        showTextFunc = showTextFunc,
        itemTid = itemTid,
        showNumFunc = showNumFunc
      }
      itemBinder:BindComponent(CommonAwakerListItem(item, itemData))
    end
  end)
end

function AwakerClipSelectPanel:ConfirmSelect()
  if not self.confirmCallback then
    self:_UseChooseItem()
    return
  end
  local itemCfg = DT.Item[self.model.curSelectAwakerClipTid]
  local tipCfg = DT.TipsType[20107]
  local title = LT.Text(tipCfg.Title)
  local desc = LT.Textf(tipCfg.Desc, LT.Text(itemCfg.Name))
  local extraParams = {
    pickItems = {
      [self.itemTid] = {
        choose = self.model.curSelectAwakerClipTid
      }
    }
  }
  Alert.Show(20107, nil, function()
    self.confirmCallback(extraParams, System.fn(self, self.Close))
  end, title, desc)
end

function AwakerClipSelectPanel:_UseChooseItem()
  local itemCfg = DT.Item[self.model.curSelectAwakerClipTid]
  local tipCfg = DT.TipsType[20107]
  local title = LT.Text(tipCfg.Title)
  local desc = LT.Textf(tipCfg.Desc, LT.Text(itemCfg.Name))
  Alert.Show(20107, nil, function()
    EventMgr.Instance.OpenReqMask:Dispatch()
    ProtoManager.Instance:ReqServer("GameRequest", "OnUseChooseItem", function(svrData)
      Logger.Info(" OnUseChooseItem Successful")
      self:Close()
    end, function()
      Logger.Info(" OnUseChooseItem Fail")
    end, self.itemTid, self.model.curSelectAwakerClipTid, 1)
  end, title, desc)
end

function AwakerClipSelectPanel:JumpToDetail()
  if self:IsChooseAwakerClip() then
    local awakerTid = DT.Item[self.model.curSelectAwakerClipTid].SpParam[1]
    
    local function panelOpenFunc()
      local awakerBasePanelData = {}
      awakerBasePanelData.jumpPage = CommonDefine.AwakerPage.Detail
      awakerBasePanelData.specialAwakerList = {
        AwakerDataUtils.GetAwakerData(awakerTid)
      }
      UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
    end
    
    FuncJumpManager.JumpToFuncPanel(nil, panelOpenFunc)
  else
    ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.Btn_Cancel, nil, self.model.curSelectAwakerClipTid)
  end
end

function AwakerClipSelectPanel:IsChooseAwakerClip()
  return DT.Item[self.model.curSelectAwakerClipTid].SubType == CommonDefine.ItemSubType.AwakerChip
end

function AwakerClipSelectPanel:ClosePanel()
  self:Close()
end

return AwakerClipSelectPanel
