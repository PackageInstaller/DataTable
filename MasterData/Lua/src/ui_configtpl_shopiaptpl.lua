local this = class("shopIapTpl")

function this:init(config)
  if C_AppConfigManager.Platform == C_EAppPlatform.Harmony then
    C_MJSDKManager.GetChannelCode(function(channel)
      self:_initWithChannel(config, channel)
    end)
  else
    local channel = C_MJSDKManager.GetChannelCode()
    self:_initWithChannel(config, channel)
  end
end

function this:_initWithChannel(config, channel)
  self.data = {}
  self.shopMap = {}
  for _, v in pairs(config) do
    local c = self:getChannelId(v)
    local payId = self:getPayId(v)
    local shopId = self:getShopItemId(v)
    self.data[payId] = v
    self.shopMap[shopId] = v
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTplByShopItemId(shopItemId)
  return self.shopMap[shopItemId]
end

function this:getChargeDouble(tpl)
  return tpl.chargeDouble
end

function this:getId(tpl)
  return tpl.id
end

function this:getPayId(tpl)
  return tpl.payId
end

function this:getChargeNum(tpl)
  return tpl.chargeNum
end

function this:getChargeDouble(tpl)
  return tpl.chargeDouble == 0
end

function this:getItem(tpl)
  return tpl.item
end

function this:getChargeExtra(tpl)
  return tpl.chargeExtra
end

function this:getShopItemId(tpl)
  return tpl.shopItemId
end

function this:getChannelId(tpl)
  return tpl.channelId
end

return this
