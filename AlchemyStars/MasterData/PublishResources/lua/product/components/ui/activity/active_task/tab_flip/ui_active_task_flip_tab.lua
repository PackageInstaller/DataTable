_class("UIActiveTaskFlipTab", UICustomWidget)
UIActiveTaskFlipTab = UIActiveTaskFlipTab

function UIActiveTaskFlipTab:OnShow()
  self._gridSize = Vector2(135, 135)
  self:_GetComponent()
  self:AddListener()
end

function UIActiveTaskFlipTab:OnHide()
  self:DetachListener()
end

function UIActiveTaskFlipTab:AddListener()
  self._itemChangeCallback = GameHelper:GetInstance():CreateCallback(self.OnItemCountChanged, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.ItemCountChanged, self._itemChangeCallback)
end

function UIActiveTaskFlipTab:DetachListener()
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.ItemCountChanged, self._itemChangeCallback)
end

function UIActiveTaskFlipTab:_GetComponent()
  self._moneyIcon = self:GetUIComponent("RawImageLoader", "moneyIcon")
  self._moneyNum = self:GetUIComponent("UILocalizationText", "moneyNum")
  self._itemContent = self:GetUIComponent("UISelectObjectPath", "itemContent")
  self._maskContent = self:GetUIComponent("UISelectObjectPath", "maskContent")
  self._selectInfoPool = self:GetUIComponent("UISelectObjectPath", "selectInfoPool")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._effRect = self:GetUIComponent("RectTransform", "effRect")
  self._effAnim = self:GetUIComponent("Animation", "effRect")
  self._gameObj = self:GetGameObject("anim")
  self._moneyIconObj = self:GetGameObject("moneyIcon")
  self._effRect.anchorMax = Vector2(0, 1)
  self._effRect.anchorMin = Vector2(0, 1)
end

function UIActiveTaskFlipTab:OnItemCountChanged()
  self:RefreshExchangeNum()
end

function UIActiveTaskFlipTab:Close(isAnim)
  if self._selectInfo then
    self._selectInfo:closeOnClick()
  end
  if isAnim then
    self:StartTask(function(TT)
      self:Lock("UIActiveTaskFlipTab_Close")
      self._anim:Play("uieff_UIActiveTaskFlipTab_out")
      YIELD(TT, 333)
      self._gameObj:SetActive(false)
      self:UnLock("UIActiveTaskFlipTab_Close")
    end, self)
  else
    self._gameObj:SetActive(false)
  end
end

function UIActiveTaskFlipTab:Open()
  self._gameObj:SetActive(true)
end

function UIActiveTaskFlipTab:SetData(data)
  self._data = data
  self._turnCardCfg = self._data:GetTurnCardCfg()
  self:InitComponent()
end

function UIActiveTaskFlipTab:RefreshExchangeNum()
  self._CostItem = self._turnCardCfg.CostItem[1]
  local moneyId = self._CostItem[1]
  local moneyCfg = Cfg.cfg_item[moneyId]
  local itemModule = GameGlobal.GetModule(ItemModule)
  local num = itemModule:GetItemCount(moneyId)
  self._moneyIcon:LoadImage(moneyCfg.Icon)
  self._moneyNum:SetText(num)
end

function UIActiveTaskFlipTab:InitComponent()
  self:RefreshExchangeNum()
  self._itemList, self._maskList = self._data:GetTurnCardInfo()
  self._items = self._itemContent:SpawnObjects("UIActiveTaskFlipAwardItem", #self._itemList)
  self._masks = self._maskContent:SpawnObjects("UIActiveTaskFlipMaskItem", table.count(self._maskList))
  local maskIndex = 1
  for _, data in pairs(self._maskList) do
    self._masks[maskIndex]:SetData(data, self._gridSize, function(item)
      self:FlipMask(item)
    end)
    maskIndex = maskIndex + 1
  end
  for i, v in pairs(self._items) do
    local data = self._itemList[i]
    v:SetData(data, self._gridSize)
  end
end

function UIActiveTaskFlipTab:FlipMask(widget)
  local isOver = self._data:CheckFlipIsOver()
  if isOver then
    return
  end
  local moneyId = self._CostItem[1]
  local costNum = self._CostItem[2]
  local itemModule = GameGlobal.GetModule(ItemModule)
  local num = itemModule:GetItemCount(moneyId)
  if costNum > num then
    ToastManager.ShowToast(StringTable.Get("str_n32_turn_card_item_less"))
    return
  end
  if widget:IsMaskFliped() then
    Log.debug("该牌已经被翻过")
    return
  end
  self:Lock("UIActiveTaskFlipTab_FlipMask")
  self:StartTask(function(TT)
    local comp = self._data:GetFlipComp()
    local index = self._data:GetMatrixIndex()
    local cellIndex = widget:GetCellIndex()
    local res = AsyncRequestRes:New()
    local rewards = comp:HandleTurnCardOperate(TT, res, index, cellIndex)
    if res:GetSucc() then
      widget:SetFlipState(widget, true)
      local pos = widget:GetMaskPos()
      self._effRect.anchoredPosition = pos
      self._effAnim:Play("uieff_UIActiveTaskFlipMaskItem")
      YIELD(TT, 400)
      if rewards and 0 < #rewards then
        self:ShowDialog("UIGetItemController", rewards, function()
          GameGlobal.EventDispatcher():Dispatch(GameEventType.OnFlipMask, cellIndex)
        end)
      else
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnFlipMask, cellIndex)
      end
      GameGlobal.EventDispatcher():Dispatch(GameEventType.RefreshActiveTaskRed)
    elseif res:GetResult() == CampaignErrorType.E_COMPONENT_TURNCARD_LACK_ITEM then
      ToastManager.ShowToast(StringTable.Get("str_n32_turn_card_item_less"))
    elseif res:GetResult() == CampaignErrorType.E_COMPONENT_TURNCARD_CELL_TURNED then
      Log.fatal("该牌已经被翻过")
    end
    self:UnLock("UIActiveTaskFlipTab_FlipMask")
  end, self)
end

function UIActiveTaskFlipTab:OnItemSelect(id, pos)
  if not self._selectInfo then
    self._selectInfo = self._selectInfoPool:SpawnObject("UISelectInfo")
  end
  self._selectInfo:SetData(id, pos)
end

function UIActiveTaskFlipTab:AwardBtnOnClick()
  local isOver = self._data:CheckFlipIsOver()
  if isOver then
    return
  end
  self._itemList, self._maskList = self._data:GetTurnCardInfo()
  self:ShowDialog("UIActiveTaskAwardShowController", self._itemList)
end

function UIActiveTaskFlipTab:MoneyIconBtnOnClick()
  local moneyId = self._CostItem[1]
  self:OnItemSelect(moneyId, self._moneyIconObj.transform.position)
end
