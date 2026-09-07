local MiniGameGoods = class("MiniGameGoods", import("model.vo.BaseVO"))

function MiniGameGoods:Ctor(arg_1_1)
	self.configId = arg_1_1.id
	self.id = arg_1_1.id
	self.count = self:GetLimit()

	return
end

function MiniGameGoods:getId()
	return self.id
end

function MiniGameGoods:UpdateCnt(arg_3_1)
	self.count = self.count - arg_3_1

	if self.count < 0 then
		self.count = 0
	end

	return
end

function MiniGameGoods:bindConfigTable()
	return pg.gameroom_shop_template
end

function MiniGameGoods:CanPurchase()
	local var_5_0 = self:GetDropInfo()
	local var_5_1 = var_5_0:getOwnedLimit()

	if var_5_1 > 0 and var_5_1 <= var_5_0:getOwnedCount() then
		return false
	end

	return self.count > 0
end

function MiniGameGoods:GetPrice()
	return self:getConfig("price")
end

function MiniGameGoods:Selectable()
	return self:getConfig("goods_type") == 2
end

function MiniGameGoods:Single()
	return self:getConfig("goods_type") == 1
end

function MiniGameGoods:GetFirstDropId()
	return self:getConfig("goods")
end

function MiniGameGoods:GetMaxCnt()
	if self:CanPurchase() then
		return self.count
	else
		return 0
	end

	return
end

function MiniGameGoods:CanPurchaseCnt(arg_11_1)
	return arg_11_1 <= self.count
end

function MiniGameGoods:GetLimit()
	return self:getConfig("goods_purchase_limit")
end

function MiniGameGoods:GetDropInfo()
	return Drop.New({
		type = self:getConfig("drop_type"),
		id = self:getConfig("goods")[1],
		count = self:getConfig("num")
	})
end

return MiniGameGoods
