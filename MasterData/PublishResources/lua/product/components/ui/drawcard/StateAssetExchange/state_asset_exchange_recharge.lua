_class("StateAssetExchangeRecharge", State)
StateAssetExchangeRecharge = StateAssetExchangeRecharge

function StateAssetExchangeRecharge:Init()
  self._fsm = self:GetFsm()
end

function StateAssetExchangeRecharge:OnEnter(TT, ...)
  self:Init()
  if EngineGameHelper.EnableAppleVerifyBulletin() and self._fsm then
    ToastManager.ShowToast(StringTable.Get("str_pay_yj_not_enough_cant_exchange"))
    self._fsm:ChangeState(StateAssetExchange.Init)
    return
  end
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_pay_res_not_enough_goto_recharge"), function(param)
    if self._fsm then
      local mShop = GameGlobal.GetModule(ShopModule)
      mShop:GetClientShop():OpenRechargeShop()
      self._fsm:ChangeState(StateAssetExchange.Init)
    end
  end, nil, function(param)
    if self._fsm then
      self._fsm:ChangeState(StateAssetExchange.Init)
    end
  end, nil)
end

function StateAssetExchangeRecharge:OnExit(TT)
end

function StateAssetExchangeRecharge:Destroy()
  self._fsm = nil
end
