local SelectShowingAwakerPanel, Super = System.NewClass("SelectShowingAwakerPanel", UIBasePanel)
SelectShowingAwakerPanel.uiResCls = UI_Main_Helicopter_TipsResource

function SelectShowingAwakerPanel:ctor(mainPanelModel)
  Super.ctor(self)
  self.mainPanelModel = mainPanelModel
end

function SelectShowingAwakerPanel:OnBind(binder)
  local model = binder:createModel(SelectShowingAwakerPanelModel, self.mainPanelModel)
  self.model = model
  self:_OnBindAwakerSelectGroup(binder)
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.OnClose))
  binder:BindZ1Button(self.ui.Btn_Confirm, System.fn(self, self._OnClickConfirm))
  binder:BindZ1Button(self.ui.Btn_Cancel, System.fn(self, self.OnClose))
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.OnClose))
  binder:BindButtonClick(self.ui.Group_ResetBg, System.fn(self, self._OnClickResetBg))
  binder:BindButtonClick(self.ui.Btn_Hide_HUD, System.fn(self, function()
    self.mainPanelModel:SetHideHud(true)
    self:OnClose()
  end))
  binder:BindToRaw(function(childBinder, awakerTid)
    if awakerTid then
      local portraitAlign = CommonDefine.PortraitAlign.HorizontalCenter
      local resNum = AwakerDataUtils.GetAwakerResNum(awakerTid)
      childBinder:BindComponent(AwakerPortraitComp(self.ui.Container_Awaker, nil, resNum, nil, portraitAlign))
    end
  end, function()
    return self.model.curSelectAwakerTid
  end)
  binder:BindToText(self.ui.Text_Date, function()
    local awakerData = AwakerDataUtils.GetAwakerData(self.model.curSelectAwakerTid)
    if awakerData.createTime then
      local y, m, d = TimeUtils.GetTimestampYmdHMS(awakerData.createTime)
      do return LT.Text, string.format("%s/%s/%s", y, m, d) end
      return LT.Text, string.format("%s/%s/%s", y, m, d)
    end
    return ""
  end)
  binder:BindToText(self.ui.Text_Lv, function()
    do return AwakerDataUtils.GetAwakerLikeLevel end
    return AwakerDataUtils.GetAwakerLikeLevel, self.model.curSelectAwakerTid
  end)
  binder:BindToText(self.ui.Text_CurRate, function()
    do return self.model.GetAwakerLike end
    return self.model.GetAwakerLike, self.model
  end)
  binder:BindToText(self.ui.Text_NextRate, function()
    return "/" .. self.model:GetNextAwakerLike()
  end)
end

function SelectShowingAwakerPanel:_OnBindAwakerSelectGroup(binder)
  binder:BindToCircularListView(self.ui.ScrollView_Awaker_List, function()
    return self.model.selectAwakerGroup
  end, function(itemBinder, item, index)
    local awakerData = self.model.selectAwakerGroup[index]
    
    local function clickFunc()
      self.model:SetCurSelectAwakerTid(awakerData.tid)
    end
    
    local function selectFunc()
      return awakerData.tid == self.model.curSelectAwakerTid
    end
    
    local function showTextFunc()
      local awakerCfg = DT.AwakerConfig[awakerData.tid]
      return awakerCfg and awakerCfg.Name
    end
    
    local itemData = {
      clickFunc = clickFunc,
      awakerData = awakerData,
      selectFunc = selectFunc,
      showTextFunc = showTextFunc
    }
    itemBinder:BindComponent(CommonAwakerListItem(item, itemData))
  end)
end

function SelectShowingAwakerPanel:_OnClickConfirm()
  self.mainPanelModel:SetShowAwaker(self.model.curSelectAwakerTid)
  AwakerDataUtils.SetBoardAwaker(self.model.curSelectAwakerTid)
  self:OnClose()
end

function SelectShowingAwakerPanel:_OnClickResetBg()
  local function confirmResetBg()
    CollectionHallCfgUtils.ResetMainBgMusic()
    
    CollectionHallCfgUtils.ResetMainBgCG()
  end
  
  Alert.Show("MainResetBG", nil, confirmResetBg)
end

function SelectShowingAwakerPanel:OnClose()
  self:Close()
end

return SelectShowingAwakerPanel
