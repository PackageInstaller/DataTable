local NewServerShop = class("NewServerShop", import("..BaseVO"))

function NewServerShop:Ctor(arg_1_1)
	self.startTime = arg_1_1.start_time
	self.stopTime = arg_1_1.stop_time
	self.goods = {}
	self.phases = {}
	self.activityId = arg_1_1.id

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.goods) do
		var_1_0[iter_1_1.id] = NewServerCommodity.New(iter_1_1)
	end

	local var_1_1 = {}

	for iter_1_2, iter_1_3 in ipairs(getProxy(ActivityProxy):getActivityById(self.activityId):getConfig("config_data")) do
		var_1_1[iter_1_3] = true
	end

	for iter_1_4, iter_1_5 in pairs(pg.newserver_shop_template.get_id_list_by_unlock_time) do
		self.goods[iter_1_4] = self:WrapPhaseGoods(iter_1_5, var_1_0, var_1_1)

		table.insert(self.phases, iter_1_4)
	end

	return
end

function NewServerShop:GetPtId()
	return pg.newserver_shop_template[getProxy(ActivityProxy):getActivityById(self.activityId):getConfig("config_data")[1]].resource_type
end

function NewServerShop:WrapPhaseGoods(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if arg_3_3[iter_3_1] then
			local var_3_1 = arg_3_2[iter_3_1] or NewServerCommodity.New({
				id = iter_3_1
			})

			var_3_0[var_3_1.id] = var_3_1
		end
	end

	return var_3_0
end

function NewServerShop:GetStartTime()
	return self.startTime
end

function NewServerShop:GetEndTime()
	return self.stopTime
end

function NewServerShop:GetCommodityById(arg_6_1)
	for iter_6_0, iter_6_1 in pairs(self.goods) do
		for iter_6_2, iter_6_3 in pairs(iter_6_1) do
			if iter_6_2 == arg_6_1 then
				return iter_6_3
			end
		end
	end

	return
end

function NewServerShop:GetOpeningGoodsList(arg_7_1)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(self.goods[arg_7_1]) do
		table.insert(var_7_0, iter_7_1)
	end

	return var_7_0
end

function NewServerShop:IsOpenPhase(arg_8_1)
	return self:GetStartTime() + self.phases[arg_8_1] <= pg.TimeMgr.GetInstance():GetServerTime()
end

function NewServerShop:GetPhases()
	return self.phases
end

return NewServerShop
