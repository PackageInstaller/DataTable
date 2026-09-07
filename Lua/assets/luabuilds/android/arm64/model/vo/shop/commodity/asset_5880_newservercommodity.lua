local NewServerCommodity = class("NewServerCommodity", import("...BaseVO"))

function NewServerCommodity:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.count = arg_1_1.count or self:getConfig("goods_purchase_limit")
	self.boughtRecord = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.bought_record or {}) do
		self.boughtRecord[iter_1_1] = true
	end

	return
end

function NewServerCommodity:bindConfigTable()
	return pg.newserver_shop_template
end

function NewServerCommodity:CanPurchase()
	return self.count > 0
end

function NewServerCommodity:ReduceCnt(arg_4_1)
	self.count = self.count - arg_4_1

	return
end

function NewServerCommodity:CanPurchaseMulTimes(arg_5_1)
	return arg_5_1 <= self.count
end

function NewServerCommodity:CanPurchaseSubGoods(arg_6_1)
	if self:LimitPurchaseSubGoods() then
		return self.boughtRecord[arg_6_1] ~= true
	else
		return true
	end

	return
end

function NewServerCommodity:UpdateBoughtRecord(arg_7_1)
	self.boughtRecord[arg_7_1] = true

	return
end

function NewServerCommodity:LimitPurchaseSubGoods()
	return self:getConfig("goods_type") == 4
end

function NewServerCommodity:Selectable()
	local var_9_0 = self:getConfig("goods_type")

	return var_9_0 == 2 or var_9_0 == 4
end

function NewServerCommodity:GetConsume()
	return Drop.New({
		type = self:getConfig("resource_category"),
		id = self:getConfig("resource_type"),
		count = self:getConfig("resource_num")
	})
end

function NewServerCommodity:GetDesc()
	return {
		name = self:getConfig("goods_name"),
		icon = self:getConfig("goods_icon"),
		rarity = self:getConfig("goods_rarity")
	}
end

function NewServerCommodity:IsOpening(arg_12_1)
	local var_12_0 = {}
	local var_12_1 = arg_12_1 + self:getConfig("unlock_time")
	local var_12_2 = pg.TimeMgr.GetInstance():GetServerTime()
	local var_12_3 = var_12_1 <= var_12_2

	if var_12_1 > var_12_2 then
		local var_12_4, var_12_5, var_12_6, var_12_7 = pg.TimeMgr.GetInstance():parseTimeFrom(var_12_1 - var_12_2)

		var_12_0.day = var_12_4
		var_12_0.hour = var_12_5
	end

	return var_12_3, var_12_0
end

function NewServerCommodity:GetDropCnt()
	return self:getConfig("num")
end

function NewServerCommodity:GetCanPurchaseCnt()
	return self.count
end

function NewServerCommodity:GetCanPurchaseMaxCnt()
	return self:getConfig("goods_purchase_limit")
end

function NewServerCommodity:GetDropType()
	return self:getConfig("type")
end

function NewServerCommodity:GetSelectableGoods()
	return self:getConfig("goods")
end

function NewServerCommodity:CheckTimeLimit()
	local var_18_0 = false
	local var_18_1 = false
	local var_18_2
	local var_18_3 = Item.getConfigData(self:getConfig("goods")[1])

	if self:getConfig("type") == DROP_TYPE_VITEM and var_18_3.virtual_type == 22 then
		var_18_0 = true
		var_18_2 = true

		local var_18_4 = getProxy(ActivityProxy):getActivityById(var_18_3.link_id)

		if var_18_4 and not var_18_4:isEnd() then
			var_18_1 = true
		end
	end

	return var_18_0, var_18_1, var_18_2
end

function NewServerCommodity:GetPurchasableCnt()
	return self.count
end

return NewServerCommodity
