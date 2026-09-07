local WorldNShopCommodity = class("WorldNShopCommodity", import(".BaseCommodity"))

function WorldNShopCommodity:bindConfigTable()
	return pg.world_newshop_data
end

function WorldNShopCommodity:canPurchase()
	return self:GetPurchasableCnt() > 0
end

function WorldNShopCommodity:GetPurchasableCnt()
	return self:GetLimitGoodCount() - self.buyCount
end

function WorldNShopCommodity:GetLimitGoodCount()
	return self:getConfig("frequency")
end

function WorldNShopCommodity:GetDropInfo()
	return Drop.New({
		type = self:getConfig("item_type"),
		id = self:getConfig("item_id"),
		count = self:getConfig("item_num")
	})
end

function WorldNShopCommodity:GetPriceInfo()
	return Drop.New({
		type = self:getConfig("price_type"),
		id = self:getConfig("price_id"),
		count = self:getConfig("price_num")
	})
end

return WorldNShopCommodity
