local AlertConfirm2Panel, Super = System.NewClass("AlertConfirm2Panel", UIBasePanel)
AlertConfirm2Panel.uiResCls = UI_Common_Popup_Tip_3Resource

function AlertConfirm2Panel:ctor(data, callback, playAnim)
  Super.ctor(self)
  self.data = data
  self.callback = callback
  local funcs = self.data.funcs
  self.rightBtnFunc = funcs.rightBtnFunc
  self.leftBtnFunc = funcs.leftBtnFunc
  self.blankMaskBtnFunc = data.blankMaskBtnFunc
  self.maskClickClose = data.maskClickClose
  self.isOn = false
  self.execFuncType = nil
  self.leftBtnTypeFunc = data.leftBtnTypeFunc
  self.showCloseBtn = data.showCloseBtn
  self.closeCb = data.closeCb
end

function AlertConfirm2Panel:OnBind(binder)
  Super.OnBind(self, binder)
  if Alert.showAllLangFont then
    binder:LoadAllLangFont(self.ui.Text_Tips)
  end
  if self.ui.Group_Coin then
    self.ui.Group_Coin:SetActive(self.showCoin)
  end
  self._prevBackExpandFunc = UIManager.Instance.backExpandFunc
  
  function self._backExpandFunc()
    self:Close()
  end
  
  UIManager.Instance:UpdateBackExpandFunc(self._backExpandFunc)
  if self.ui.UI_Common_Btn_Back1 then
    if self.showCloseBtn then
      self.ui.UI_Common_Btn_Back1:SetActive(true)
    end
    binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  end
  self.animCtrl = self.ui.uiNode:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  if self.playAnim then
    self.ui.UI_Vx_bg:SetActive(true)
    self.ui.UI_Common_Glass:SetActive(false)
    self.animCtrl:PlayState("UI_Common_Popup_Tip_3_Open")
  else
    self.ui.UI_Vx_bg:SetActive(false)
    self.ui.UI_Common_Glass:SetActive(true)
  end
  local confirmBtnTipsData = {}
  local cancelBtnTipsData = {}
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.S,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData
  }
  binder:BindComponent(CommonPopupConfirmTips(self.ui.UI_Common_Popup_Tips_Confirm_S, commonPopupConfirmTipsData))
  local tipConfig = DT.TipsType[self.data.tipTid]
  local btnLeftDesc = LT.Text(tipConfig.LeftBtnDesc)
  local btnRightDesc = LT.Text(tipConfig.RightBtnDesc)
  
  local function _GetBtnType(btnCfgValue)
    if 1 == btnCfgValue then
      if self.leftBtnTypeFunc then
        do return end
        return self.leftBtnTypeFunc
      else
        return CommonDefine.BtnType.High
      end
    elseif 2 == btnCfgValue then
      return CommonDefine.BtnType.High
    end
    return CommonDefine.BtnType.Unclickable
  end
  
  local leftBtnType = _GetBtnType(tipConfig.LeftBtn)
  local rightBtnType = _GetBtnType(tipConfig.RightBtn)
  local showDouble = tipConfig.LeftBtn and tipConfig.RightBtn
  if showDouble then
    binder:BindZ1Button(self.ui.Btn_Cancel, function()
      if self.leftBtnFunc then
        self.leftBtnFunc()
      end
      self:ClosePanel()
    end, function()
      return leftBtnType
    end, function()
      return btnLeftDesc
    end, nil, nil, nil)
    binder:BindZ1Button(self.ui.Btn_Confirm, function()
      if self.rightBtnFunc then
        self.rightBtnFunc()
        self.rightBtnFunc = nil
      end
      self.execFuncType = tipConfig.RightBtn
      self:ClosePanel()
    end, function()
      return rightBtnType
    end, function()
      return btnRightDesc
    end, nil, nil, nil)
    binder:SetActive(self.ui.Btn_Confirm, true)
    binder:SetActive(self.ui.Btn_Cancel, true)
  else
    local midBtnDesc = ""
    local midBtnFunc
    local midBtnType = 0
    local funcType, middelBtn
    if tipConfig.LeftBtn then
      midBtnDesc = btnLeftDesc
      midBtnFunc = self.leftBtnFunc
      midBtnType = leftBtnType
      funcType = tipConfig.LeftBtn
      middelBtn = self.ui.Btn_Cancel
      binder:SetActive(self.ui.Btn_Confirm, false)
      binder:SetActive(self.ui.Btn_Cancel, true)
    elseif tipConfig.RightBtn then
      midBtnDesc = btnRightDesc
      midBtnFunc = self.rightBtnFunc
      midBtnType = rightBtnType
      funcType = tipConfig.RightBtn
      middelBtn = self.ui.Btn_Confirm
      binder:SetActive(self.ui.Btn_Confirm, true)
      binder:SetActive(self.ui.Btn_Cancel, false)
    else
      binder:SetActive(self.ui.Btn_Confirm, false)
      binder:SetActive(self.ui.Btn_Cancel, false)
    end
    if middelBtn then
      binder:BindZ1Button(middelBtn, function()
        if midBtnFunc then
          midBtnFunc()
          midBtnFunc = nil
          self.execFuncType = funcType
        end
        self:ClosePanel()
      end, function()
        return midBtnType
      end, function()
        return midBtnDesc
      end, nil, nil, nil)
    end
  end
  local title = self.data.title
  if string.isempty(title) then
    title = LT.Text("UniversalAlertTitle")
  end
  binder:SetText(self.ui.Text_Title, self.data.title or "")
  binder:SetText(self.ui.Text_Tips, self.data.desc or "")
  binder:SetText(self.ui.Text_Bottom, self.data.bottomDesc or "")
  if self.ui.Text_Need then
    binder:SetText(self.ui.Text_Need, LT.Text("ItemNeed"))
  end
  local toggleTipsText = ""
  if tipConfig.DonotRemind then
    if 1 == tipConfig.DonotRemind then
      toggleTipsText = LT.Text("ConfirmationNoLongerPromptsText_1")
    elseif tipConfig.DonotRemind > 1 then
      toggleTipsText = LT.Textf("ConfirmationNoLongerPromptsText_2", tipConfig.DonotRemind)
    end
  end
  binder:SetText(self.ui.Text_Screening, toggleTipsText)
  local showToggle = tipConfig.DonotRemind ~= nil
  binder:SetActive(self.ui.Toggle_Screening, showToggle)
  if showToggle then
    binder:BindToToggleValueChange(self.ui.Toggle_Screening, System.fn(self, self.OnToggle))
  end
  if self.ui.Btn_Mask then
    binder:BindButtonClick(self.ui.Btn_Mask, function()
      if self.blankMaskBtnFunc then
        self.blankMaskBtnFunc()
        self.blankMaskBtnFunc = nil
      end
      if self.maskClickClose then
        self:Close()
      end
    end)
  end
end

function AlertConfirm2Panel:ShowCoin(coins, showBg, costData)
  if not self.ui.Group_Coin or IsNil(self.ui.Group_Coin) then
    return
  end
  self.ui.Group_Coin:SetActive(true)
  self.binder:BindComponent(CommonCurrencyGroupItem(self.ui.Group_Coin, coins, showBg))
  self:BindCost(costData)
end

function AlertConfirm2Panel:BindCost(costData)
  if not costData then
    return
  end
  self.ui.Group_Need:SetActive(true)
  local itemId = costData.tid
  self.binder:BindToImage(self.ui.Image_icon_2, function()
    do return ItemDataUtils.GetItemIcon end
    return ItemDataUtils.GetItemIcon, itemId
  end)
  local costNum = costData.num
  local haveNum = ItemDataUtils.GetItemNum(costData.tid)
  local ChargeCfg = ShopDataUtils.GetChargeCfgById(costData.tid)
  local rst
  if ChargeCfg then
    rst = ShopDataUtils.GetChargePriceStr(costData.tid)
  elseif costNum > haveNum then
    rst = LT.Text(string.format("<color=#FA3A50>%s</color>/%s", haveNum, costNum))
  else
    rst = LT.Text(string.format("%s/%s", haveNum, costNum))
  end
  self.binder:SetText(self.ui.Text_coin, rst)
end

function AlertConfirm2Panel:OnToggle(isOn)
  self.isOn = isOn
end

function AlertConfirm2Panel:Close()
  if self.closeCb then
    self.closeCb()
    self.closeCb = nil
  end
  self:ClosePanel()
end

function AlertConfirm2Panel:ClosePanel()
  if self.isOn then
    UIPopTipsDataUtils.SetTipDontRemind(self.data.tipTid, self.execFuncType, TimeUtils.GetServerTime())
  end
  self:BaseClose()
end

function AlertConfirm2Panel:BaseClose()
  Super.Close(self)
end

function AlertConfirm2Panel:OnUnbind()
  Super.OnUnbind(self)
  if UIManager.Instance and UIManager.Instance.backExpandFunc == self._backExpandFunc then
    if self._prevBackExpandFunc then
      UIManager.Instance:UpdateBackExpandFunc(self._prevBackExpandFunc)
    else
      UIManager.Instance:ClearBackExpandFuc()
    end
  end
  self._prevBackExpandFunc = nil
  self._backExpandFunc = nil
  if self.callback then
    self.callback()
    self.callback = nil
  end
  Alert.SetShowAllLangFont(false)
end

return AlertConfirm2Panel
