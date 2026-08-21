require("d_shop_secret_good_base")
_class("DShopBattlePassGood", DShopSecretGoodBase)
DShopBattlePassGood = DShopBattlePassGood

function DShopBattlePassGood:Refresh(goodinfo, goodconfig)
  DShopSecretGoodBase.Refresh(self, goodinfo, goodconfig)
  if not self.cfg then
    Log.error("服务器传来的商品配置缺失 商品id：" .. tostring(self.goodId) .. " 防御..使用本地配置")
    self.localCfg = Cfg.cfg_shop_battlepass_goods[self.goodId]
  end
end

function DShopBattlePassGood:GetRemainTotalCount()
  return self.cfg and self.cfg[ConfigKey.ConfigKey_SaleNum] or self.localCfg and self.localCfg.SaleNum or 1
end

function DShopBattlePassGood:ShowRemain()
  return true
end

function DShopBattlePassGood:ShowSaleTag()
  return true
end

function DShopBattlePassGood:GetSaleTag()
  local saleTag = self.cfg and self.cfg[ConfigKey.ConfigKey_SaleTag] or self.localCfg and self.localCfg.SaleTag or 0
  if saleTag == 1 then
    return 1
  elseif 0 < self.discount and self.discount < 100 then
    return self.discount
  elseif saleTag == 0 then
    return 0
  end
end

function DShopBattlePassGood:GetRefreshTimeStr()
  if self.localCfg == nil then
    self.localCfg = Cfg.cfg_shop_battlepass_goods[self.goodId]
  end
  local loginModule = GameGlobal.GetModule(LoginModule)
  local maxEndTime = loginModule:GetTimeStampByTimeStr("2100-12-31 24:00:00", Enum_DateTimeZoneType.E_ZoneType_GMT)
  local refreshTime = self.localCfg and loginModule:GetTimeStampByTimeStr(self.localCfg.EndTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  if refreshTime == nil then
    return
  end
  if maxEndTime <= refreshTime then
    return
  end
  local leftSeconds = UICommonHelper.CalcLeftSeconds(refreshTime)
  if leftSeconds <= 0 then
    return
  end
  local str = ""
  if leftSeconds <= 0 then
    str = StringTable.Get("str_pay_expired")
  elseif leftSeconds <= 60 then
    str = string.format(StringTable.Get("str_pay_left_minute", 1))
  elseif leftSeconds <= 3600 then
    local leftMinutes = math.ceil(leftSeconds / 60)
    str = string.format(StringTable.Get("str_pay_left_minute", leftMinutes))
  elseif leftSeconds <= 86400 then
    local leftHours = math.ceil(leftSeconds / 3600)
    str = string.format(StringTable.Get("str_pay_left_hour", leftHours))
  else
    local leftDays = math.ceil(leftSeconds / 86400)
    str = string.format(StringTable.Get("str_pay_left_day", leftDays))
  end
  return str
end
