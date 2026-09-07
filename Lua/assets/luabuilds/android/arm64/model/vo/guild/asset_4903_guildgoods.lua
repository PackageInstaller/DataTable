local GuildGoods = class("GuildGoods", import("..BaseVO"))

function GuildGoods:Ctor(arg_1_1)
	self.configId = arg_1_1.id
	self.count = arg_1_1.count
	self.index = arg_1_1.index
	self.id = self.configId .. "_" .. self.index

	return
end

function GuildGoods:UpdateCnt(arg_2_1)
	self.count = self.count - arg_2_1

	return
end

function GuildGoods:bindConfigTable()
	return pg.guild_store
end

function GuildGoods:CanPurchase()
	return self.count > 0
end

function GuildGoods:GetPrice()
	return self:getConfig("price")
end

function GuildGoods:Selectable()
	return self:getConfig("goods_type") == 2
end

function GuildGoods:GetFirstDropId()
	return self:getConfig("goods")
end

function GuildGoods:GetMaxCnt()
	return self.count
end

function GuildGoods:CanPurchaseCnt(arg_9_1)
	return arg_9_1 <= self.count
end

function GuildGoods:GetLimit()
	return self:getConfig("goods_purchase_limit")
end

function GuildGoods:GetDropInfo()
	return Drop.New({
		type = self:getConfig("type"),
		id = self:getConfig("goods")[1],
		count = self:getConfig("num")
	})
end

return GuildGoods
