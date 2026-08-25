local ReplenishEnergyModel = NewClass("ReplenishEnergyModel", BaseModel)

function ReplenishEnergyModel:OnInit()
  self:OnReset()
end

function ReplenishEnergyModel:OnReset()
  self._itemId2ExchangeType = {}
  self._frequencyDesc = ""
  self._promptDesc = ""
  self._curSelectCfgId = 0
end

function ReplenishEnergyModel:GetExchangeDescType(itemCfgID)
  return self._itemId2ExchangeType[itemCfgID] or 0
end

function ReplenishEnergyModel:GetFrequencyDesc()
  return self._frequencyDesc
end

function ReplenishEnergyModel:GetPromptDesc()
  return self._promptDesc
end

function ReplenishEnergyModel:GetCurSelectCfgId()
  return self._curSelectCfgId
end

function ReplenishEnergyModel:SetExchangeDescIndex(itemCfgID, exchangeType)
  self._itemId2ExchangeType[itemCfgID] = exchangeType
end

function ReplenishEnergyModel:SetFrequencyDesc(desc)
  self._frequencyDesc = desc
end

function ReplenishEnergyModel:SetPromptDesc(desc)
  self._promptDesc = desc
end

function ReplenishEnergyModel:SetCurSelectCfgId(tid)
  self._curSelectCfgId = tid
end

function ReplenishEnergyModel:GetParamByExchangeType(exchangeType)
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

function ReplenishEnergyModel:GetComfirmDescByExchangeType(exchangeType)
  local btnDesc = LT.Text("ReplenishEnergy_Comfirm" .. exchangeType)
  return btnDesc
end

function ReplenishEnergyModel:ShowExchangeDesc(tid)
  local exchangeType = self:GetExchangeDescType(tid)
  local langData = "ReplenishEnergy_ExchangeDesc" .. exchangeType
  local subLangData = "ReplenishEnergy_ExchangeSubDesc" .. exchangeType
  local desc = LT.Textf(langData, self:GetParamByExchangeType(exchangeType))
  local subDesc = LT.Text(subLangData)
  self:SetFrequencyDesc(desc)
  self:SetPromptDesc(subDesc)
end

function ReplenishEnergyModel:CheckNeedShowRestoreInfo()
  local curEnergy = PlayerDataUtils.GetEnergy()
  local maxEnergy = PlayerDataUtils.GetMaxEnergyLimit()
  return curEnergy < maxEnergy
end

function ReplenishEnergyModel:GetRestoreShowStr(countDown)
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

return ReplenishEnergyModel
