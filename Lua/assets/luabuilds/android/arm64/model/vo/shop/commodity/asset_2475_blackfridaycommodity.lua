local BlackFridayCommodity = class("BlackFridayCommodity", import(".NewServerCommodity"))

function BlackFridayCommodity:bindConfigTable()
	return pg.blackfriday_shop_template
end

function BlackFridayCommodity:GetResType()
	return self:getConfig("resource_type")
end

function BlackFridayCommodity:GetDiscount()
	return self:getConfig("discount")
end

function BlackFridayCommodity:GetSalesPrice()
	return self:getConfig("resource_num") - self:getConfig("discount")
end

function BlackFridayCommodity:GetOffPercent()
	return math.modf(self:getConfig("discount") / self:getConfig("resource_num") * 100)
end

function BlackFridayCommodity:GetConsume()
	return Drop.New({
		type = self:getConfig("resource_category"),
		id = self:getConfig("resource_type"),
		count = self:GetSalesPrice()
	})
end

return BlackFridayCommodity
