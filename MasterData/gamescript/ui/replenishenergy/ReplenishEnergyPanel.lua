local EnergyRestoreTime = DT.GetConstant("EnergyRestoreTime")
local EnergyExceedRestoreTime = DT.GetConstant("EnergyExceedRestoreTime")
local ReplenishEnergyPanel, Super = System.NewClass("ReplenishEnergyPanel", UIBasePanel)
ReplenishEnergyPanel.uiResCls = UI_Other_Physical_TipsResource

function ReplenishEnergyPanel:ctor()
  Super.ctor(self)
end

function ReplenishEnergyPanel:OnBind(binder)
  self.binder = binder
  local model = binder:createModel(ReplenishEnergyModel)
  self.model = model
  self:_BindEnergeRestoreInfo()
  binder:BindToText(self.ui.Text_Title, function()
    do return LT.Text end
    return LT.Text, "ReplenishEnergy_Title"
  end)
  binder:BindToText(self.ui.Text_Supplement, function()
    do return LT.Text end
    return LT.Text, "ReplenishEnergy_Supplement"
  end)
  binder:BindToText(self.ui.Text_Auto, function()
    local recoverLimit = PlayerDataUtils.GetEnergyNaturalRecoverLimit(DataCenter.playerData.DRole.level)
    local itemNum = PlayerDataUtils.GetEnergy()
    return recoverLimit > itemNum and LT.Text("EnergyCommonAutoRecoverTips") or LT.Text("EnergyOverAutoRecoverTips")
  end)
  binder:BindToText(self.ui.Text_Frequency, function()
    do return self.model.GetFrequencyDesc end
    return self.model.GetFrequencyDesc, self.model
  end)
  binder:BindToText(self.ui.Text_Prompt, function()
    do return self.model.GetPromptDesc end
    return self.model.GetPromptDesc, self.model
  end)
  binder:BindButtonClick(self.ui.Btn_Confirm, System.fn(self, self.OnClickConfirm))
  binder:BindButtonClick(self.ui.Btn_Cancel, System.fn(self, self.Close))
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  local itemModel = binder:createModel(CommonIconItemModel)
  local tReplenishEnergyItems = DT.GetOriginalConstant("ReplenishEnergyItem")
  for i, v in ipairs(tReplenishEnergyItems) do
    local itemcfgId = tonumber(v)
    local cnt = ItemDataUtils.GetItemNum(itemcfgId)
    self.model:SetExchangeDescIndex(itemcfgId, i)
    if cnt > 0 or 1 ~= i then
      local tItemUids = ItemDataUtils.GetItemUidMap(itemcfgId)
      local uid = table.next(tItemUids or {})
      if 0 == self.model:GetCurSelectCfgId() then
        self.model:SetCurSelectCfgId(itemcfgId)
      end
      local itemData = {
        tid = itemcfgId,
        uid = uid,
        model = itemModel,
        callback = System.fn(self, self.ItemOnClick),
        clickFrameShowFunc = System.fn(self, self.OnChosen),
        articleNumberShowFunc = System.fn(self, self.CountShowFunc),
        ShowRedDot = false
      }
      binder:BindComponent(CommonIconItem(self.ui["Medicine_" .. i], itemData))
    else
      self.ui["Medicine_" .. i]:SetActive(false)
    end
  end
  binder:BindToText(self.ui.Text_Name, function()
    local tid = self.model:GetCurSelectCfgId()
    local exchangeType = self.model:GetExchangeDescType(tid)
    do return self.GetComfirmDescByExchangeType, self end
    return self.GetComfirmDescByExchangeType, self, exchangeType
  end)
  binder:BindToVisible(self.ui.ImageZ, System.fn(self, self.CheckNeedShowRestoreInfo))
  binder:BindToVisible(self.ui.ImageE, System.fn(self, self.CheckNeedShowRestoreInfo))
end

function ReplenishEnergyPanel:GetParamByExchangeType(exchangeType)
  if CommonDefine.ExchangeType.EnergyItemExchange == exchangeType then
    local restoreNum = tonumber(DT.GetConstant("ReplenishEnergyItemRestoreNum"))
    return restoreNum
  elseif CommonDefine.ExchangeType.DiamondExchange == exchangeType then
    local costCnt = PlayerDataUtils.GetCurrentBuyEnergyCost()
    local getCnt = PlayerDataUtils.GetEnergyRestoreNum(DataCenter.playerData.DRole.level)
    local leftBuyTimes = PlayerDataUtils.GetEnergyLeftBuyTimes()
    if leftBuyTimes <= 0 then
      leftBuyTimes = 0
    end
    return costCnt, getCnt, leftBuyTimes
  end
end

function ReplenishEnergyPanel:GetComfirmDescByExchangeType(exchangeType)
  local btnDesc = LT.Text("ReplenishEnergy_Comfirm" .. exchangeType)
  return btnDesc
end

function ReplenishEnergyPanel:ItemOnClick(tid, _)
  self.model:SetCurSelectCfgId(tid)
  self:ShowExchangeDesc(tid)
end

function ReplenishEnergyPanel:ShowExchangeDesc(tid)
  local exchangeType = self.model:GetExchangeDescType(tid)
  local langData = "ReplenishEnergy_ExchangeDesc" .. exchangeType
  local subLangData = "ReplenishEnergy_ExchangeSubDesc" .. exchangeType
  local desc = LT.Textf(langData, self:GetParamByExchangeType(exchangeType))
  local subDesc = LT.Text(subLangData)
  self.model:SetFrequencyDesc(desc)
  self.model:SetPromptDesc(subDesc)
end

function ReplenishEnergyPanel:OnChosen(_, tid)
  local chosen = tid == self.model:GetCurSelectCfgId()
  if chosen then
    self:ShowExchangeDesc(tid)
  end
  return chosen
end

function ReplenishEnergyPanel:CountShowFunc(tid, num)
  local exchangeType = self.model:GetExchangeDescType(tid)
  if CommonDefine.ExchangeType.DiamondExchange == exchangeType then
    local costCnt, _, _ = self:GetParamByExchangeType(exchangeType)
    local str = num >= costCnt and num or string.format("<color=#ff6969>%s</color>", num)
    return str
  else
    return num
  end
end

function ReplenishEnergyPanel:OnClickConfirm()
  if not ItemDataUtils.CheckCanAddEnergy() then
    Alert.Show(10736)
    return
  end
  local tid = self.model:GetCurSelectCfgId()
  local exchangeType = self.model:GetExchangeDescType(tid)
  
  local function useAfterCall()
    self:Close()
  end
  
  if CommonDefine.ExchangeType.EnergyItemExchange == exchangeType then
    ItemDataUtils.OpenItemUsePanel(tid, useAfterCall)
  elseif CommonDefine.ExchangeType.DiamondExchange == exchangeType then
    local num = ItemDataUtils.GetItemNum(tid)
    local costCnt, _, _ = self:GetParamByExchangeType(exchangeType)
    if num >= costCnt then
      local function CheckEnergyOver()
        local energyItemNum = PlayerDataUtils.GetEnergyRestoreNum(DataCenter.playerData.DRole.level)
        
        if energyItemNum > 0 then
          do return GetEnergyCheckUtils.EnergyIsOverMax end
          return GetEnergyCheckUtils.EnergyIsOverMax, energyItemNum
        else
          return false
        end
      end
      
      local function ReqBuyEnergy()
        ProtoManager.Instance:ReqServer("GameRequest", "OnBuyEnergy", useAfterCall)
      end
      
      if CheckEnergyOver() then
        GetEnergyCheckUtils.TipsShow(ReqBuyEnergy)
      else
        ReqBuyEnergy()
      end
    else
      DiamondShopDataUtils.OpenRechargePanel()
    end
  end
end

function ReplenishEnergyPanel:_BindEnergeRestoreInfo()
  self:_RefreshRestoreInfo()
  self.binder:BindTimer(0.3, -1, System.fn(self, self._RefreshRestoreInfo))
end

function ReplenishEnergyPanel:_RefreshRestoreInfo()
  local countDown = math.floor(DataCenter.playerData.DRole.nextEnergyRestoreTimeStamp - TimeUtils.GetServerTime())
  if countDown < 0 then
    countDown = 0
  end
  local curEnergy = PlayerDataUtils.GetEnergy()
  local maxEnergy = PlayerDataUtils.GetMaxEnergyLimit()
  local commonRecoverLimit = PlayerDataUtils.GetEnergyNaturalRecoverLimit(DataCenter.playerData.DRole.level)
  if curEnergy < maxEnergy then
    local commonRecoverEnergy = commonRecoverLimit - curEnergy
    commonRecoverEnergy = commonRecoverEnergy > 0 and commonRecoverEnergy or 0
    local overRecoverEnergy = math.min(maxEnergy - commonRecoverLimit, maxEnergy - curEnergy)
    local deltaTime
    if curEnergy < commonRecoverLimit then
      deltaTime = EnergyRestoreTime * (commonRecoverEnergy - 1)
    else
      deltaTime = EnergyExceedRestoreTime * (overRecoverEnergy - 1)
    end
    self.binder:SetText(self.ui.Text_NextTime, self:_GetRestoreShowStr(countDown))
    self.binder:SetText(self.ui.Text_AllTime, self:_GetRestoreShowStr(deltaTime + countDown))
  else
    self.binder:SetText(self.ui.Text_NextTime, "")
    self.binder:SetText(self.ui.Text_AllTime, "")
  end
end

function ReplenishEnergyPanel:CheckNeedShowRestoreInfo()
  local curEnergy = PlayerDataUtils.GetEnergy()
  local maxEnergy = PlayerDataUtils.GetMaxEnergyLimit()
  return curEnergy < maxEnergy
end

function ReplenishEnergyPanel:_GetRestoreShowStr(countDown)
  local d, h, m, s = TimeUtils.ConvertTime(countDown)
  if d > 0 then
    h = h + d * 24
  end
  local showStr = ""
  if h > 0 then
    showStr = showStr .. h .. LT.Text("Hour")
  end
  if m >= 0 then
    showStr = showStr .. m .. LT.Text("Minute")
  end
  if s >= 0 then
    showStr = showStr .. s .. LT.Text("Second")
  end
  return showStr
end

return ReplenishEnergyPanel
