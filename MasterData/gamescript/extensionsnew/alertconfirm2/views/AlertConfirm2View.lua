local AlertConfirm2View, Super = NewClass("AlertConfirm2View", BaseView)
AlertConfirm2View.uiResCls = UI_Common_Popup_Tip_3Resource

function AlertConfirm2View:ctor(data, callback, playAnim)
  Super.ctor(self)
  self.data = data
  self.callback = callback
  self._playAnim = false
  local funcs = self.data.funcs
  self._rightBtnFunc = funcs.rightBtnFunc
  self._leftBtnFunc = funcs.leftBtnFunc
  self._blankMaskBtnFunc = data.blankMaskBtnFunc
  self._maskClickClose = data.maskClickClose
  self._isOn = false
  self._execFuncType = nil
  self._leftBtnTypeFunc = data.leftBtnTypeFunc
  self._showCloseBtn = data.showCloseBtn
  self._closeCb = data.closeCb
  self._prevBackExpandFunc = nil
  self._backExpandFunc = nil
end

function AlertConfirm2View:OnBuildView()
  local confirmBtnTipsData = {}
  local cancelBtnTipsData = {}
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.ConfirmTipsType.S,
    confirmBtnTipsData = confirmBtnTipsData,
    cancelBtnTipsData = cancelBtnTipsData
  }
  self:AddViewComponent(self.ui.UI_Common_Popup_Tips_Confirm_S, UICompCommonPopupConfirmTips, commonPopupConfirmTipsData)
end

function AlertConfirm2View:RegisterEvents()
  if self.ui.UI_Common_Btn_Back1 then
    self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self._OnClickClose))
  end
  if self.ui.Btn_Mask then
    self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self._OnClickMask))
  end
  if self.ui.Toggle_Screening then
    self:AddToggleValueChangeListener(self.ui.Toggle_Screening, System.fn(self, self._OnToggle))
  end
  self:_SetupButtonListeners()
end

function AlertConfirm2View:OnEnterView()
  Super.OnEnterView(self)
  self._prevBackExpandFunc = UIManager.Instance.backExpandFunc
  
  function self._backExpandFunc()
    self:_Close()
  end
  
  UIManager.Instance:UpdateBackExpandFunc(self._backExpandFunc)
  self.animCtrl = self.ui.uiNode:GetComponent(typeof(CS.Z1Client.UIAnimationController))
  if self._playAnim then
    self.ui.UI_Vx_bg:SetActive(true)
    self.ui.UI_Common_Glass:SetActive(false)
    self.animCtrl:PlayState("UI_Common_Popup_Tip_3_Open")
  else
    self.ui.UI_Vx_bg:SetActive(false)
    self.ui.UI_Common_Glass:SetActive(true)
  end
  if Alert.showAllLangFont then
    self:LoadAllLangFont(self.ui.Text_Tips)
  end
  if self.ui.Group_Coin then
    self.ui.Group_Coin:SetActive(self.showCoin or false)
  end
  if self.ui.UI_Common_Btn_Back1 and self._showCloseBtn then
    self.ui.UI_Common_Btn_Back1:SetActive(true)
  end
  self:_RefreshAll()
end

function AlertConfirm2View:OnExitView()
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
  if self.callback then
    self.callback()
    self.callback = nil
  end
  Alert.SetShowAllLangFont(false)
end

function AlertConfirm2View:_RefreshAll()
  self:_RefreshTexts()
  self:_RefreshButtonVisibility()
  self:_RefreshToggle()
  self:_RefreshRevivalCoin()
end

function AlertConfirm2View:_RefreshTexts()
  local title = self.data.title
  if string.isempty(title) then
    title = LT.Text("UniversalAlertTitle")
  end
  self:SetText(self.ui.Text_Title, self.data.title or "")
  self:SetText(self.ui.Text_Tips, self.data.desc or "")
  self:SetText(self.ui.Text_Bottom, self.data.bottomDesc or "")
  if self.ui.Text_Need then
    self:SetText(self.ui.Text_Need, LT.Text("ItemNeed"))
  end
end

function AlertConfirm2View:_RefreshRevivalCoin()
  local coinGroupNode = self.ui.UI_Common_Item_Coin_Group_Revival or self.ui.UI_Common_Item_Coin_Group
  if not coinGroupNode then
    return
  end
  local isRevivalTips = self.data.tipTid == "20079" or self.data.tipTid == "20080" or self.data.tipTid == "AbyssChallengeRevivalTips"
  coinGroupNode:SetActive(isRevivalTips)
  if not isRevivalTips then
    return
  end
  local revivalItemId = DT.GetConstant("RevivalItemId")
  self:AddViewComponentOnce(coinGroupNode, UICompCommonCurrencyGroupItem, {revivalItemId}, false, true)
end

function AlertConfirm2View:_SetupButtonListeners()
  local tipConfig = DT.TipsType[self.data.tipTid]
  local showDouble = tipConfig.LeftBtn and tipConfig.RightBtn
  if showDouble then
    self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self._OnClickCancel))
    self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._OnClickConfirm))
  elseif tipConfig.LeftBtn then
    self._midBtnFunc = self._leftBtnFunc
    self._midBtnExecType = tipConfig.LeftBtn
    self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self._OnClickMidBtn))
  elseif tipConfig.RightBtn then
    self._midBtnFunc = self._rightBtnFunc
    self._midBtnExecType = tipConfig.RightBtn
    self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._OnClickMidBtn))
  end
end

function AlertConfirm2View:_RefreshButtonVisibility()
  local tipConfig = DT.TipsType[self.data.tipTid]
  local btnLeftDesc = LT.Text(tipConfig.LeftBtnDesc)
  local btnRightDesc = LT.Text(tipConfig.RightBtnDesc)
  local leftBtnType = self:_GetBtnType(tipConfig.LeftBtn)
  local rightBtnType = self:_GetBtnType(tipConfig.RightBtn)
  local showDouble = tipConfig.LeftBtn and tipConfig.RightBtn
  if showDouble then
    self.ui.Btn_Confirm:SetActive(true)
    self.ui.Btn_Cancel:SetActive(true)
    self:_SetupDoubleButtons(leftBtnType, rightBtnType, btnLeftDesc, btnRightDesc, tipConfig)
  else
    self:_SetupSingleButton(tipConfig, leftBtnType, rightBtnType, btnLeftDesc, btnRightDesc)
  end
end

function AlertConfirm2View:_SetupDoubleButtons(leftBtnType, rightBtnType, btnLeftDesc, btnRightDesc, tipConfig)
  self:SetButtonState(self.ui.Btn_Cancel, leftBtnType)
  self:SetButtonText(self.ui.Btn_Cancel, btnLeftDesc)
  self:SetButtonState(self.ui.Btn_Confirm, rightBtnType)
  self:SetButtonText(self.ui.Btn_Confirm, btnRightDesc)
  self._rightBtnExecType = tipConfig.RightBtn
end

function AlertConfirm2View:_SetupSingleButton(tipConfig, leftBtnType, rightBtnType, btnLeftDesc, btnRightDesc)
  local midBtnType, midBtnDesc, middelBtn
  if tipConfig.LeftBtn then
    midBtnDesc = btnLeftDesc
    midBtnType = leftBtnType
    middelBtn = self.ui.Btn_Cancel
    self.ui.Btn_Confirm:SetActive(false)
    self.ui.Btn_Cancel:SetActive(true)
  elseif tipConfig.RightBtn then
    midBtnDesc = btnRightDesc
    midBtnType = rightBtnType
    middelBtn = self.ui.Btn_Confirm
    self.ui.Btn_Confirm:SetActive(true)
    self.ui.Btn_Cancel:SetActive(false)
  else
    self.ui.Btn_Confirm:SetActive(false)
    self.ui.Btn_Cancel:SetActive(false)
  end
  if middelBtn then
    self:SetButtonState(middelBtn, midBtnType)
    self:SetButtonText(middelBtn, midBtnDesc)
  end
end

function AlertConfirm2View:_GetBtnType(btnCfgValue)
  if 1 == btnCfgValue then
    if self._leftBtnTypeFunc then
      do return end
      return self._leftBtnTypeFunc
    else
      return CommonDefine.BtnType.High
    end
  elseif 2 == btnCfgValue then
    return CommonDefine.BtnType.High
  end
  return CommonDefine.BtnType.Unclickable
end

function AlertConfirm2View:_RefreshToggle()
  local tipConfig = DT.TipsType[self.data.tipTid]
  local toggleTipsText = ""
  if tipConfig.DonotRemind then
    if 1 == tipConfig.DonotRemind then
      toggleTipsText = LT.Text("ConfirmationNoLongerPromptsText_1")
    elseif tipConfig.DonotRemind > 1 then
      toggleTipsText = LT.Textf("ConfirmationNoLongerPromptsText_2", tipConfig.DonotRemind)
    end
  end
  self:SetText(self.ui.Text_Screening, toggleTipsText)
  local showToggle = tipConfig.DonotRemind ~= nil
  self.ui.Toggle_Screening:SetActive(showToggle)
end

function AlertConfirm2View:_OnClickClose()
  self:_Close()
end

function AlertConfirm2View:_OnClickCancel()
  if self._leftBtnFunc then
    self._leftBtnFunc()
  end
  self:_ClosePanel()
end

function AlertConfirm2View:_OnClickConfirm()
  if self._rightBtnFunc then
    self._rightBtnFunc()
    self._rightBtnFunc = nil
  end
  self._execFuncType = self._rightBtnExecType
  self:_ClosePanel()
end

function AlertConfirm2View:_OnClickMidBtn()
  if self._midBtnFunc then
    self._midBtnFunc()
    self._midBtnFunc = nil
    self._execFuncType = self._midBtnExecType
  end
  self:_ClosePanel()
end

function AlertConfirm2View:_OnClickMask()
  if self._blankMaskBtnFunc then
    self._blankMaskBtnFunc()
    self._blankMaskBtnFunc = nil
  end
  if self._maskClickClose then
    self:_Close()
  end
end

function AlertConfirm2View:_OnToggle(isOn)
  self._isOn = isOn
end

function AlertConfirm2View:_Close()
  if self._closeCb then
    self._closeCb()
    self._closeCb = nil
  end
  self:_ClosePanel()
end

function AlertConfirm2View:_ClosePanel()
  if self._isOn then
    UIPopTipsDataUtils.SetTipDontRemind(self.data.tipTid, self._execFuncType, TimeUtils.GetServerTime())
  end
  self:_BaseClose()
end

function AlertConfirm2View:_BaseClose()
  Super.Close(self)
end

function AlertConfirm2View:ShowCoin(coins, showBg, costData)
  if not self.ui.Group_Coin or IsNil(self.ui.Group_Coin) then
    return
  end
  self.ui.Group_Coin:SetActive(true)
  self:AddViewComponent(self.ui.Group_Coin, UICompCommonCurrencyGroupItem, coins, showBg)
  self:_BindCost(costData)
end

function AlertConfirm2View:_BindCost(costData)
  if not costData then
    return
  end
  self.ui.Group_Need:SetActive(true)
  local itemId = costData.tid
  self:SetImage(self.ui.Image_icon_2, ItemDataUtils.GetItemIcon(itemId))
  local costNum = costData.num
  local haveNum = ItemDataUtils.GetItemNum(costData.tid)
  local chargeCfg = ShopDataUtils.GetChargeCfgById(costData.tid)
  local rst
  if chargeCfg then
    rst = ShopDataUtils.GetChargePriceStr(costData.tid)
  elseif costNum > haveNum then
    rst = LT.Text(string.format("<color=#FA3A50>%s</color>/%s", haveNum, costNum))
  else
    rst = LT.Text(string.format("%s/%s", haveNum, costNum))
  end
  self:SetText(self.ui.Text_coin, rst)
end

return AlertConfirm2View
