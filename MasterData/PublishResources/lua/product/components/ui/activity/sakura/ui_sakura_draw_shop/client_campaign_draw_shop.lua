_class("ClientCampaignDrawShop", Object)
ClientCampaignDrawShop = ClientCampaignDrawShop

function ClientCampaignDrawShop:Constructor()
end

function ClientCampaignDrawShop.CheckBuy(saleType, price, withToast)
  local showToast = withToast or false
  local result = true
  local roleModule = GameGlobal.GameLogic():GetModule(RoleModule)
  if saleType == RoleAssetID.RoleAssetGlow then
    local diamond = roleModule:GetGlow()
    if price > diamond then
      ToastManager.ShowToast(StringTable.Get("str_common_stop_pay"))
      result = false
    end
  elseif saleType == RoleAssetID.RoleAssetGold then
    local gold = roleModule:GetGold()
    if price > gold then
      if showToast then
        ToastManager.ShowToast(StringTable.Get("str_shop_buy_no_gold"))
      end
      result = false
    end
  elseif saleType == RoleAssetID.RoleAssetMazeCoin then
    local mazeCoin = roleModule:GetMazeCoin()
    if price > mazeCoin then
      if showToast then
        ToastManager.ShowToast(StringTable.Get("str_shop_buy_no_maze"))
      end
      result = false
    end
  else
    local itemMd = GameGlobal.GameLogic():GetModule(ItemModule)
    local money = itemMd:GetItemCount(saleType)
    if price > money then
      if showToast then
        ToastManager.ShowToast(StringTable.Get("str_shop_buy_no_maze"))
      end
      result = false
    end
  end
  return result
end

function ClientCampaignDrawShop.GetCurrencyImageName(saleType)
  if not ClientCampaignDrawShop.SaleType2ImageName then
    ClientCampaignDrawShop.SaleType2ImageName = {
      [RoleAssetID.RoleAssetGlow] = Cfg.cfg_top_tips[RoleAssetID.RoleAssetGlow].Icon,
      [RoleAssetID.RoleAssetGold] = Cfg.cfg_top_tips[RoleAssetID.RoleAssetGold].Icon,
      [RoleAssetID.RoleAssetMazeCoin] = Cfg.cfg_top_tips[RoleAssetID.RoleAssetMazeCoin].Icon
    }
  end
  local icon = ClientCampaignDrawShop.SaleType2ImageName[saleType]
  if icon then
    return icon
  end
  local cfgItem = Cfg.cfg_item[saleType]
  if cfgItem then
    return cfgItem.Icon
  end
  return nil
end

function ClientCampaignDrawShop.GetMoney(saleType)
  local roleModule = GameGlobal.GameLogic():GetModule(RoleModule)
  local money = 0
  if saleType == RoleAssetID.RoleAssetPhyPoint then
    money = roleModule:GetHealthPoint()
  elseif saleType == RoleAssetID.RoleAssetGlow then
    money = roleModule:GetGlow()
  elseif saleType == RoleAssetID.RoleAssetGold then
    money = roleModule:GetGold()
  elseif saleType == RoleAssetID.RoleAssetMazeCoin then
    money = roleModule:GetMazeCoin()
  else
    local itemMd = GameGlobal.GameLogic():GetModule(ItemModule)
    money = itemMd:GetItemCount(saleType)
  end
  return money
end
