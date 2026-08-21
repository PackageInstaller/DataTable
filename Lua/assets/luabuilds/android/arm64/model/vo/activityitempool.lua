local var_0_0 = class("ActivityItemPool", import(".BaseVO"))
local var_0_1 = pg.activity_random_award_item

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.awards = arg_1_1.awards or {}
	arg_1_0.prevId = arg_1_1.prevId
	arg_1_0.index = arg_1_1.index

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.activity_random_award_template
end

function var_0_0.getComsume(arg_3_0)
	return {
		type = arg_3_0:getConfig("resource_category"),
		id = arg_3_0:getConfig("resource_type"),
		count = arg_3_0:getConfig("resource_num")
	}
end

function var_0_0.enoughResForUsage(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getComsume()

	if var_4_0.type == DROP_TYPE_RESOURCE then
		if getProxy(PlayerProxy):getData():getResById(var_4_0.id) < var_4_0.count * arg_4_1 then
			return false
		end
	elseif var_4_0.type == DROP_TYPE_ITEM then
		if getProxy(BagProxy):getItemCountById(var_4_0.id) < var_4_0.count * arg_4_1 then
			return false
		end
	end

	return true
end

function var_0_0.getItemCount(arg_5_0)
	return _.reduce(arg_5_0:getConfig("item_list"), 0, function(arg_6_0, arg_6_1)
		return arg_6_0 + arg_6_1[2]
	end)
end

function var_0_0.getleftItemCount(arg_7_0)
	return arg_7_0:getItemCount() - arg_7_0:getFetchCount()
end

function var_0_0.getFetchCount(arg_8_0)
	return _.reduce(_.values(arg_8_0.awards), 0, function(arg_9_0, arg_9_1)
		return arg_9_0 + arg_9_1
	end)
end

function var_0_0.getMainItems(arg_10_0)
	return arg_10_0:filterItems(true)
end

function var_0_0.filterItems(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getConfig("main_item")

	return (_.map(_.select(arg_11_0:getConfig("item_list"), function(arg_12_0)
		if arg_11_1 then
			return table.contains(var_11_0, arg_12_0[1])
		else
			return not table.contains(var_11_0, arg_12_0[1])
		end

		return
	end), function(arg_13_0)
		local var_13_0 = arg_11_0.awards[arg_13_0[1]] or 0

		return {
			id = var_0_1[arg_13_0[1]].commodity_id,
			type = var_0_1[arg_13_0[1]].resource_category,
			count = var_0_1[arg_13_0[1]].num,
			surplus = arg_13_0[2] - var_13_0,
			total = arg_13_0[2]
		}
	end))
end

function var_0_0.getItems(arg_14_0)
	return arg_14_0:filterItems(true), (arg_14_0:filterItems(false))
end

function var_0_0.canOpenNext(arg_15_0)
	return _.all(arg_15_0:getMainItems(), function(arg_16_0)
		return arg_16_0.surplus == 0
	end)
end

function var_0_0.getTempleNewChar(arg_17_0, arg_17_1)
	if not arg_17_0.charAwardDisplayData then
		arg_17_0.charAwardDisplayData = {}

		for iter_17_0, iter_17_1 in ipairs(pg.guardian_template.all) do
			if pg.guardian_template[iter_17_1].guardian_gain_pool == arg_17_0.configId then
				table.insert(arg_17_0.charAwardDisplayData, {
					iter_17_1,
					(arg_17_0:getCharLotteryCount(iter_17_1))
				})
			end
		end
	end

	local var_17_0 = {}

	for iter_17_2 = arg_17_1 + 1, arg_17_0:getFetchCount() do
		for iter_17_3, iter_17_4 in ipairs(arg_17_0.charAwardDisplayData) do
			if iter_17_4[2] == iter_17_2 then
				table.insert(var_17_0, iter_17_4[1])
			end
		end
	end

	return var_17_0
end

var_0_0.guardian_type_lottery = 1
var_0_0.guardian_type_lock = 2

function var_0_0.getCharLotteryCount(arg_18_0, arg_18_1)
	if pg.guardian_template[arg_18_1].type == ActivityItemPool.guardian_type_lottery then
		return pg.guardian_template[arg_18_1].guardian_gain[2]
	elseif pg.guardian_template[arg_18_1].type == ActivityItemPool.guardian_type_lock then
		local var_18_0 = 0

		for iter_18_0, iter_18_1 in ipairs(pg.guardian_template[arg_18_1].guardian_gain) do
			var_18_0 = math.max(var_18_0, arg_18_0:getCharLotteryCount(iter_18_1))
		end

		return var_18_0
	end

	return -1
end

function var_0_0.getGuardianGot(arg_19_0, arg_19_1)
	local var_19_0 = pg.guardian_template[arg_19_1]

	if pg.guardian_template[arg_19_1].guardian_gain_pool ~= arg_19_0.id then
		warning("guardian id " .. arg_19_1 .. "不属于该池子 " .. arg_19_0.id .. " 所属对象")

		return false, 0
	end

	if var_19_0.type == ActivityItemPool.guardian_type_lottery then
		local var_19_1 = arg_19_0:getFetchCount() >= var_19_0.guardian_gain[2]
		local var_19_2 = math.max(var_19_0.guardian_gain[2] - arg_19_0:getFetchCount(), 0)

		return
	elseif var_19_0.type == ActivityItemPool.guardian_type_lock then
		local var_19_3 = 0

		for iter_19_0, iter_19_1 in ipairs(var_19_0.guardian_gain) do
			if not arg_19_0:getGuardianGot(iter_19_1) then
				var_19_3 = var_19_3 + 1
			end
		end

		return var_19_3 == 0, var_19_3
	end

	return false, 0
end

function var_0_0.GetAllGuardianIds(arg_20_0)
	if not pg.activity_template[arg_20_0] then
		return {}
	end

	if pg.activity_template[arg_20_0].type ~= ActivityConst.ACTIVITY_TYPE_LOTTERY then
		return {}
	end

	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(pg.guardian_template.all) do
		if table.contains(pg.activity_template[arg_20_0].config_data, pg.guardian_template[iter_20_1].guardian_gain_pool) then
			table.insert(var_20_0, pg.guardian_template[iter_20_1].id)
		end
	end

	return var_20_0
end

function var_0_0.GetAllGuardianIdsStatus(arg_21_0)
	local var_21_0 = getProxy(ActivityProxy):getActivityById(arg_21_0)

	if not pg.activity_template[arg_21_0] then
		return {}
	end

	if pg.activity_template[arg_21_0].type ~= ActivityConst.ACTIVITY_TYPE_LOTTERY then
		return {}
	end

	if not var_21_0 then
		return
	end

	local var_21_1 = {}

	for iter_21_0, iter_21_1 in ipairs(pg.activity_template[arg_21_0].config_data) do
		({})[iter_21_1] = ActivityItemPool.CreateItemPool(iter_21_1, var_21_0:getAwardInfos()[iter_21_1], nil, iter_21_0)
	end

	for iter_21_2, iter_21_3 in ipairs(pg.guardian_template.all) do
		if table.contains(pg.activity_template[arg_21_0].config_data, pg.guardian_template[iter_21_3].guardian_gain_pool) then
			if ({})[pg.guardian_template[iter_21_3].guardian_gain_pool] then
				local var_21_2, var_21_3 = ({})[pg.guardian_template[iter_21_3].guardian_gain_pool]:getGuardianGot(pg.guardian_template[iter_21_3].id)

				if var_21_2 then
					table.insert(var_21_1, pg.guardian_template[iter_21_3].id)
				else
					table.insert({}, {
						pg.guardian_template[iter_21_3].id,
						var_21_3
					})
				end
			end
		end
	end

	return var_21_1, {}
end

function var_0_0.GetGuardianLastCount(arg_22_0, arg_22_1)
	local var_22_0 = getProxy(ActivityProxy):getActivityById(arg_22_0)

	if not pg.activity_template[arg_22_0] then
		return {}
	end

	if pg.activity_template[arg_22_0].type ~= ActivityConst.ACTIVITY_TYPE_LOTTERY then
		return {}
	end

	if not var_22_0 then
		return
	end

	return ActivityItemPool.CreateItemPool(pg.guardian_template[arg_22_1].guardian_gain_pool, var_22_0:getAwardInfos()[pg.guardian_template[arg_22_1].guardian_gain_pool], nil, 1):getGuardianGot(arg_22_1)
end

function var_0_0.CreateItemPool(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	return (ActivityItemPool.New({
		id = arg_23_0,
		awards = arg_23_1,
		index = arg_23_3
	}))
end

function var_0_0.GetTempleRedTip(arg_24_0, arg_24_1)
	if not pg.activity_template[arg_24_0] then
		return false
	end

	local var_24_0 = getProxy(ActivityProxy):getActivityById(arg_24_0)

	if not var_24_0 then
		return false
	end

	arg_24_1 = arg_24_1 or 60

	local var_24_1 = getProxy(PlayerProxy):getData()
	local var_24_2 = 0
	local var_24_3 = 0

	for iter_24_0, iter_24_1 in ipairs(pg.activity_template[arg_24_0].config_data) do
		var_24_2 = math.max(var_24_2, math.floor(var_24_1:getResById(pg.activity_random_award_template[iter_24_1].resource_type) / pg.activity_random_award_template[iter_24_1].resource_num))

		local var_24_4 = ActivityItemPool.CreateItemPool(iter_24_1, var_24_0:getAwardInfos()[iter_24_1], nil, 1)

		var_24_3 = var_24_3 + var_24_4:getleftItemCount()
	end

	if var_24_3 <= 0 then
		return false
	end

	if arg_24_1 <= var_24_2 then
		return true
	end

	local var_24_5 = pg.activity_template[arg_24_0].config_client.red_tip_time

	if pg.activity_template[arg_24_0].config_client.red_tip_time then
		local var_24_6 = pg.TimeMgr.GetInstance():GetServerTime() - os.time({
			year = var_24_5[1],
			month = var_24_5[2],
			day = var_24_5[3],
			hour = var_24_5[4],
			min = var_24_5[5],
			sec = var_24_5[6]
		})

		return var_24_6 > 0 and var_24_2 > 1
	end

	return false
end

return var_0_0
