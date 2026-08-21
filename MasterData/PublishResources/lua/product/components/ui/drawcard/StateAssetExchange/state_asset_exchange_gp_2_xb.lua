_class("StateAssetExchangeGp2Xb", State)
StateAssetExchangeGp2Xb = StateAssetExchangeGp2Xb

function StateAssetExchangeGp2Xb:Init()
  self._fsm = self:GetFsm()
  self._ui = self._fsm:GetData()
  self._uiData = self._ui:GetUIData()
end

function StateAssetExchangeGp2Xb:OnEnter(TT, ...)
  self:Init()
  local costGP, diffXB, alert = table.unpack({
    ...
  })
  if alert then
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_pay_drawcard_gp_2_xb", costGP, diffXB, self._uiData:GetXBName(self._ui:GetIsSingle())), function(param)
      if self._fsm then
        self:RequestGP2XB(costGP, diffXB)
      end
    end, nil, function(param)
      if self._fsm then
        self._fsm:ChangeState(StateAssetExchange.Init)
      end
    end, nil)
  else
    self:RequestGP2XB(costGP, diffXB)
  end
end

function StateAssetExchangeGp2Xb:OnExit(TT)
end

function StateAssetExchangeGp2Xb:Destroy()
  self._fsm = nil
  self._ui = nil
  self._uiData = nil
end

function StateAssetExchangeGp2Xb:RequestGP2XB(costGP, countXB)
  GameGlobal.TaskManager():StartTask(function(TT)
    local isSingle = self._ui:GetIsSingle()
    local costMat
    if isSingle then
      costMat = self._uiData.singleMat
    else
      costMat = self._uiData.multipleMat
    end
    local cfgv, goodsId = ClientShop.GetXBCfg(costMat)
    if not cfgv then
      self._fsm:ChangeState(StateAssetExchange.Init)
      return
    end
    local sale_tpye = cfgv[ConfigKey.ConfigKey_SaleType]
    local price = cfgv[ConfigKey.ConfigKey_NowPrice]
    local mShop = GameGlobal.GetModule(ShopModule)
    GameGlobal.UIStateManager():Lock("StateAssetExchangeGp2Xb")
    local ret = mShop:BuyItem(TT, MarketType.Shop_GuangPo, goodsId, countXB, sale_tpye, price)
    GameGlobal.UIStateManager():UnLock("StateAssetExchangeGp2Xb")
    if ClientShop.CheckShopCode(ret) then
      self._fsm:ChangeState(StateAssetExchange.DrawCard)
    else
      Log.fatal("### RequestGP2XB failed.", costGP, countXB, ret)
      self._fsm:ChangeState(StateAssetExchange.Init)
    end
  end, self)
end
