local ActivityShop = class("ActivityShop", import(".BaseShop"))

function ActivityShop:Ctor(arg_1_1)
	self.activityId = arg_1_1.id

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.data1_list) do
		var_1_0[iter_1_1] = arg_1_1.data2_list[iter_1_0]
	end

	self.goods = {}

	local var_1_1 = self:bindConfigTable()

	for iter_1_2, iter_1_3 in ipairs(var_1_1.all) do
		if arg_1_1.id == var_1_1[iter_1_3].activity then
			local var_1_2 = var_1_0[iter_1_3] or 0

			self.goods[iter_1_3] = Goods.Create({
				shop_id = iter_1_3,
				buy_count = var_1_2
			}, Goods.TYPE_ACTIVITY)
		end
	end

	self.type = ShopArgs.ShopActivity
	self.config = pg.activity_template[self.activityId]

	return
end

function ActivityShop:IsSameKind(arg_2_1)
	local var_2_0 = isa(arg_2_1, ActivityShop)

	if var_2_0 then
		var_2_0 = arg_2_1.activityId and arg_2_1.activityId == self.activityId
	end

	return var_2_0
end

function ActivityShop:GetCommodityById(arg_3_1)
	return self:getGoodsById(arg_3_1)
end

function ActivityShop:GetCommodities()
	return self:getSortGoods()
end

function ActivityShop:getSortGoods()
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(self.goods) do
		table.insert(var_5_0, iter_5_1)
	end

	self:SortGoods(var_5_0)

	return var_5_0
end

function ActivityShop:SortGoods(arg_6_1)
	table.sort(arg_6_1, CompareFuncs({
		function(arg_7_0)
			return (arg_7_0:canPurchase() or arg_7_0:CheckArgLimit()) and arg_7_0:CheckCntLimit() and 0 or 1
		end,
		function(arg_8_0)
			local var_8_0, var_8_1, var_8_2 = arg_8_0:CheckTimeLimit()

			return var_8_0 and var_8_1 and 0 or 1
		end,
		function(arg_9_0)
			return arg_9_0:getConfig("order")
		end,
		function(arg_10_0)
			return arg_10_0.id
		end
	}))

	return
end

function ActivityShop:GetSplitNameCodes()
	local var_11_0 = {}

	if self.config and self.config.config_client and self.config.config_client.category then
		for iter_11_0, iter_11_1 in ipairs(self.config.config_client.category) do
			table.insert(var_11_0, iter_11_1[1])
		end
	end

	return var_11_0
end

function ActivityShop:GetSplitCommodities()
	local var_12_0 = {}

	if self.config and self.config.config_client and self.config.config_client.category then
		for iter_12_0, iter_12_1 in ipairs(self.config.config_client.category) do
			local var_12_1 = {}

			for iter_12_2, iter_12_3 in ipairs(iter_12_1[2]) do
				table.insert(var_12_1, self.goods[iter_12_3])
			end

			self:SortGoods(var_12_1)
			table.insert(var_12_0, var_12_1)
		end
	end

	return var_12_0
end

function ActivityShop:bindConfigTable()
	return pg.activity_shop_template
end

function ActivityShop:getGoodsById(arg_14_1)
	return self.goods[arg_14_1]
end

function ActivityShop:isEnd()
	local var_15_0 = getProxy(ActivityProxy):getActivityById(self.activityId)

	return not var_15_0 or var_15_0:isEnd()
end

function ActivityShop:getOpenTime()
	return string.format("%d.%d.%d~%d.%d.%d %d:%d:%d", pg.activity_template[self.activityId].time[2][1][1], pg.activity_template[self.activityId].time[2][1][2], pg.activity_template[self.activityId].time[2][1][3], pg.activity_template[self.activityId].time[3][1][1], pg.activity_template[self.activityId].time[3][1][2], pg.activity_template[self.activityId].time[3][1][3], pg.activity_template[self.activityId].time[3][2][1], pg.activity_template[self.activityId].time[3][2][2], pg.activity_template[self.activityId].time[3][2][3])
end

function ActivityShop:getStartTime()
	if self:isEnd() then
		return 0
	end

	return getProxy(ActivityProxy):getActivityById(self.activityId):getStartTime()
end

function ActivityShop:getBgPath()
	local var_18_0 = pg.activity_template[self.activityId].config_client[2] or {
		255,
		255,
		255,
		255
	}
	local var_18_1 = pg.activity_template[self.activityId].config_client.outline or {
		0,
		0,
		0,
		1
	}
	local var_18_3 = Color.New(var_18_0[1], var_18_0[2], var_18_0[3], var_18_0[4])
	local var_18_4 = Color.New(var_18_1[1], var_18_1[2], var_18_1[3], var_18_1[4])
end

function ActivityShop:getToggleImage()
	return pg.activity_template[self.activityId].config_client.toggle or "huodongdduihuan_butten"
end

function ActivityShop:getResId()
	local var_20_0

	for iter_20_0, iter_20_1 in pairs(self.goods) do
		var_20_0 = iter_20_1

		break
	end

	return (var_20_0:getConfig("resource_type"))
end

function ActivityShop:GetResList()
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in pairs(self.goods) do
		var_21_0[iter_21_1:getConfig("resource_type")] = true
	end

	local var_21_1 = {}

	for iter_21_2, iter_21_3 in pairs(var_21_0) do
		table.insert(var_21_1, iter_21_2)
	end

	return var_21_1
end

function ActivityShop:GetEnterVoice()
	if self.config.config_client.enter then
		return self.config.config_client.enter[1], self.config.config_client.enter[2], self.config.config_client.enter[3]
	end

	return
end

function ActivityShop:GetPurchaseVoice()
	if self.config.config_client.purchase then
		return self.config.config_client.purchase[1], self.config.config_client.purchase[2], self.config.config_client.purchase[3]
	end

	return
end

function ActivityShop:GetPurchaseAllVoice()
	if self.config.config_client.purchase_all then
		return self.config.config_client.purchase_all[1], self.config.config_client.purchase_all[2], self.config.config_client.purchase_all[3]
	end

	return
end

function ActivityShop:GetTouchVoice()
	if self.config.config_client.touch then
		return self.config.config_client.touch[1], self.config.config_client.touch[2], self.config.config_client.touch[3]
	end

	return
end

function ActivityShop:IsEventShop()
	return pg.activity_template[self.activityId].config_client.event_shop
end

function ActivityShop:GetBGM()
	return pg.activity_template[self.activityId].config_client.bgm or ""
end

return ActivityShop
