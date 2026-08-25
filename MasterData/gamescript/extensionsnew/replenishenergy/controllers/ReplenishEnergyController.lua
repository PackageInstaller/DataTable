local ReplenishEnergyController = NewClass("ReplenishEnergyController", BaseController)

function ReplenishEnergyController:OnInit()
end

function ReplenishEnergyController:OnReset()
end

function ReplenishEnergyController:OpenReplenishEnergyView()
  UIManager.Instance:Reopen(Urls.ReplenishEnergyView)
end

function ReplenishEnergyController:ReqBuyEnergy(callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnBuyEnergy", callback)
end

function ReplenishEnergyController:OnClickConfirm(tid, exchangeType, useAfterCall)
  if not ItemDataUtils.CheckCanAddEnergy() then
    Alert.Show(10736)
    return
  end
  if CommonDefine.ExchangeType.EnergyItemExchange == exchangeType then
    ItemDataUtils.OpenItemUsePanel(tid, useAfterCall)
  elseif CommonDefine.ExchangeType.DiamondExchange == exchangeType then
    local num = ItemDataUtils.GetItemNum(tid)
    local costCnt, _, _ = ReplenishEnergyModel.Instance:GetParamByExchangeType(exchangeType)
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
        self:ReqBuyEnergy(useAfterCall)
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

return ReplenishEnergyController
