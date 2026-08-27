local CheckerBuyExplorationFund = {}

function CheckerBuyExplorationFund.LengthCheck(param)
  if 2 <= #param then
    return true
  end
  return false
end

function CheckerBuyExplorationFund.IsBuyExplorationFund(fundId)
  local explorationFundCtrl = ControllerManager:GetController(ControllerTypeId.ActivityExplorationFund)
  if explorationFundCtrl == nil then
    return false
  end
  local singleFundData = explorationFundCtrl:GetExplorationSingleFundDataByFundId(fundId)
  if singleFundData ~= nil and singleFundData:GetIsSingleFundDataUnlockSenior() then
    return true
  end
  return false
end

function CheckerBuyExplorationFund.ParamsCheck(param)
  local ok = CheckerBuyExplorationFund.IsBuyExplorationFund(1, param[2])
  return ok
end

function CheckerBuyExplorationFund.GetUnlockInfo(param)
  local fundId = param[2]
  local explorationFundCtrl = ControllerManager:GetController(ControllerTypeId.ActivityExplorationFund)
  if explorationFundCtrl == nil then
    return ""
  end
  local singleFundData = explorationFundCtrl:GetExplorationSingleFundDataByFundId(fundId)
  if singleFundData ~= nil then
    return string.format(ConfigData:GetTipContent(7905), LanguageUtil.GetLocaleText(singleFundData:GetSingleFundDataFundCfg().name))
  end
  return ""
end

return CheckerBuyExplorationFund
