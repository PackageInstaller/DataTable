_class("UIS4TradeCrewItem", UICustomWidget)
UIS4TradeCrewItem = UIS4TradeCrewItem

function UIS4TradeCrewItem:Constructor()
  self._isShowPrice = false
  self._isUsing = false
  self._isOccupying = false
  self._canClick = true
end

function UIS4TradeCrewItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIS4TradeCrewItem:_GetComponents()
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
  self._anim = self:GetUIComponent("Animation", "anim")
  local comp1, comp2, comp3 = {}, {}, {}
  comp1.valueComp = self:GetUIComponent("UILocalizationText", "power1Value")
  comp1.sliderComp = self:GetUIComponent("Slider", "power1Slider")
  comp2.valueComp = self:GetUIComponent("UILocalizationText", "power2Value")
  comp2.sliderComp = self:GetUIComponent("Slider", "power2Slider")
  comp3.valueComp = self:GetUIComponent("UILocalizationText", "power3Value")
  comp3.sliderComp = self:GetUIComponent("Slider", "power3Slider")
  self._compTb = {
    comp1,
    comp2,
    comp3
  }
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._price = self:GetUIComponent("UILocalizationText", "price")
  self._occupyNum = self:GetUIComponent("UILocalizationText", "occupyNum")
  self._bgRect = self:GetUIComponent("RectTransform", "bg")
  self._bgGroup = self:GetUIComponent("CanvasGroup", "bg")
  self._usingObj = self:GetGameObject("Using")
  self._occupyObj = self:GetGameObject("occupy")
  self._priceBGObk = self:GetGameObject("priceBg")
end

function UIS4TradeCrewItem:SetData(tradeData, crewID, shipID, isShowPrice, buyCallback)
  self._tradeData = tradeData
  self._crewID = crewID
  self._shipID = shipID
  self._isShowPrice = isShowPrice
  self._buyCallback = buyCallback
  self._cfg = Cfg.cfg_component_business_seaman[self._crewID]
  self._usingShipID = self._tradeData:GetCrewsUsingShipID(crewID)
  self._isUsing = self._usingShipID == shipID
  self._isOccupying = self._usingShipID ~= 0 and not self._isUsing
  self:_InitComponents()
end

function UIS4TradeCrewItem:PlayInAnim(index)
  self._anim:Stop()
  self:SetAnimReady()
  self:StartTask(function(TT)
    YIELD(TT, index * 20)
    if not tolua.isnull(self._anim) then
      self._anim:Play("uieff_UIS4TradeCrewItem_in")
    end
  end)
end

function UIS4TradeCrewItem:SetAnimReady()
  self._bgRect.anchoredPosition = Vector2(0, -25)
  self._bgGroup.alpha = 0
end

function UIS4TradeCrewItem:_InitComponents()
  if self._isShowPrice then
    self._priceBGObk:SetActive(true)
    self._price:SetText(self._cfg.CostItem[1][2])
  else
    self._priceBGObk:SetActive(false)
  end
  if self._isOccupying then
    self._occupyObj:SetActive(true)
    self._occupyNum:SetText(self._usingShipID)
  else
    self._occupyObj:SetActive(false)
  end
  self._usingObj:SetActive(self._isUsing)
  self._name:SetText(StringTable.Get(self._cfg.Name))
  self._icon:LoadImage(self._cfg.Icon)
  for i, comp in pairs(self._compTb) do
    comp.valueComp:SetText(self._cfg.ProValue[i])
    comp.sliderComp.maxValue = self._cfg.ProValueMax[i]
    comp.sliderComp.value = self._cfg.ProValue[i]
  end
end

function UIS4TradeCrewItem:Refresh()
  self:_InitComponents()
end

function UIS4TradeCrewItem:SetClick(canClick)
  self._canClick = canClick
end

function UIS4TradeCrewItem:BtnOnClick()
  self:_ClickAction()
end

function UIS4TradeCrewItem:PriceBgOnClick()
  self:_ClickAction()
end

function UIS4TradeCrewItem:_ClickAction()
  if not self._canClick then
    return
  end
  self:StartTask(function(TT)
    if self._isShowPrice then
      local costCfg = self._cfg.CostItem[1]
      local costItemID = costCfg[1]
      local itemModule = self:GetModule(ItemModule)
      local itemNum = itemModule:GetItemCount(costItemID)
      if itemNum < costCfg[2] then
        ToastManager.ShowToast(StringTable.Get("str_season_s4_trade_crew_bug_nomoney"))
        return
      end
      local title = StringTable.Get("str_season_s4_trade_crew_buy_title", costCfg[2])
      PopupManager.Alert("UIS4MessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", title, function()
        self:BuyCrewCallback()
      end)
    else
      local res = AsyncRequestRes:New()
      if self._isUsing then
        res = self._tradeData:ChangeCrewWorkShip(TT, self._shipID, self._crewID, false)
      elseif self._isOccupying then
        if self._tradeData:CheckShipIsFull(self._shipID) then
          ToastManager.ShowToast(StringTable.Get("str_season_s4_trade_full_crew"))
          return
        end
        local shipName = StringTable.Get("str_season_s4_trade_ship_" .. self._shipID)
        local title = StringTable.Get("str_season_s4_trade_crew_used", shipName)
        PopupManager.Alert("UIS4MessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", title, function()
          self:StartTask(function(YY)
            local changeRes = self._tradeData:ChangeCrewWorkShip(YY, self._shipID, self._crewID, true)
            if changeRes:GetSucc() then
              self._isUsing = not self._isUsing
              self._isOccupying = false
              self:Refresh()
              GameGlobal.EventDispatcher():Dispatch(GameEventType.OnS4TradeCrewChange)
            else
              Log.fatal("船员更换工作船只失败：", changeRes:GetResult())
            end
          end)
        end)
        return
      else
        if self._tradeData:CheckShipIsFull(self._shipID) then
          ToastManager.ShowToast(StringTable.Get("str_season_s4_trade_full_crew"))
          return
        end
        res = self._tradeData:ChangeCrewWorkShip(TT, self._shipID, self._crewID, true)
      end
      if res:GetSucc() then
        self._isUsing = not self._isUsing
        self._isOccupying = false
        self:Refresh()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnS4TradeCrewChange)
      else
        Log.fatal("船员更换工作船只失败：", res:GetResult())
      end
    end
  end)
end

function UIS4TradeCrewItem:BuyCrewCallback()
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local comp = self._tradeData:GetBusinessComp()
    local harbourID = self._tradeData:GetLockHarbourIDByCrewID(self._crewID)
    comp:HandleBusinessHireSeamanReq(TT, res, harbourID, self._crewID)
    if res:GetSucc() then
      self:ShowDialog("UIS4TradeCrewGetController", self._tradeData, self._crewID, self._shipID, function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnS4TradeCrewBuy)
        if self._buyCallback then
          self._buyCallback()
        end
      end)
    else
      Log.fatal("船员购买失败", res:GetResult())
    end
  end)
end
