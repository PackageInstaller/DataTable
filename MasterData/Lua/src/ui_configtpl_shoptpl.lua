local this = class("shopTpl")

function this:init(config)
  self.data = config
  self._tab2id = {}
  for _, conf in pairs(config) do
    self._tab2id[conf.commonTabId] = conf.shopId
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getDuration(tpl)
  return tpl.duration
end

function this:getShoptype(tpl)
  return tpl.shoptype
end

function this:getShopName(tpl)
  return L_Config:provider(tpl.shopName)
end

function this:getShopId(tpl)
  return tpl.shopId
end

function this:getGoodsList(tpl)
  return tpl.goodsList
end

function this:getGoodsListPurchase(tpl)
  return tpl.goodsListPurchase
end

function this:getRefreshTypeParam(tpl)
  return tpl.refreshTypeParam
end

function this:getRefreshType(tpl)
  return tpl.refreshType
end

function this:getRefreshTime(tpl)
  return tpl.refreshTime
end

function this:getStartTime(tpl)
  return tpl.startTime
end

function this:getGoodsGroup(tpl)
  return tpl.goodsGroup
end

function this:getCurrency(tpl)
  return tpl.currency
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.icon)
  return icon
end

function this:getOrder(tpl)
  return tpl.order
end

function this:getEndTime(tpl)
  return tpl.endTime
end

function this:getTabId(tpl)
  return tpl.commonTabId
end

function this:getResourceBar(tpl)
  return tpl.resourceBar
end

function this:getShopIdByTab(tab)
  return self._tab2id[tab]
end

function this:getTimelimit(tpl)
  return tpl.timelimit
end

return this
