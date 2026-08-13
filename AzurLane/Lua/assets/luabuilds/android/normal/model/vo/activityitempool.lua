class = var_0_10000

local var_0_0 = "ActivityItemPool"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseVO"))

pg = var_0_0

local var_0_2 = var_0_0.activity_random_award_item

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id

	local var_1_0

	if not arg_1_1.awards then
		var_1_0 = {}
	end

	arg_1_0.awards = var_1_0
	arg_1_0.prevId = arg_1_1.prevId
	arg_1_0.index = arg_1_1.index

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.activity_random_award_template
end

function var_0_1.getComsume(arg_3_0)
	local var_3_0 = arg_3_0:getConfig("resource_category")
	local var_3_1 = arg_3_0:getConfig("resource_type")
	local var_3_2 = arg_3_0:getConfig("resource_num")

	return {
		type = var_3_0,
		id = var_3_1,
		count = var_3_2
	}
end

function var_0_1.enoughResForUsage(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getComsume().type

	DROP_TYPE_RESOURCE = var_1_10004

	if var_4_0 == var_1_10004 then
		getProxy = var_4_0
		PlayerProxy = var_1_10004
		var_1_10004 = var_4_0(var_1_10004)

		local var_4_1 = var_3.getData(var_1_10004)

		if var_3.getResById(var_4_1, var_2.id) < var_2.count * arg_4_1 then
			return false
		end
	else
		local var_4_2 = var_2.type

		DROP_TYPE_ITEM = var_1_10004

		if var_4_2 == var_1_10004 then
			getProxy = var_4_2
			BagProxy = var_1_10004

			local var_4_3 = var_4_2(var_1_10004)

			if var_3.getItemCountById(var_4_3, var_2.id) < var_2.count * arg_4_1 then
				return false
			end
		end
	end

	return true
end

function var_0_1.getItemCount(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.getConfig(var_5_0, "item_list")

	_ = var_5_0

	return var_5_0.reduce(var_5_1, 0, function(arg_6_0, arg_6_1)
		return arg_6_0 + arg_6_1[2]
	end)
end

function var_0_1.getleftItemCount(arg_7_0)
	return arg_7_0:getItemCount() - arg_7_0:getFetchCount()
end

function var_0_1.getFetchCount(arg_8_0)
	_ = var_1_10001

	local var_8_0 = var_1_10001.reduce

	_ = var_1_10002

	return var_8_0(var_1_10002.values(arg_8_0.awards), 0, function(arg_9_0, arg_9_1)
		return arg_9_0 + arg_9_1
	end)
end

function var_0_1.getMainItems(arg_10_0)
	return arg_10_0:filterItems(true)
end

function var_0_1.filterItems(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.getConfig(var_11_0, "main_item")

	_ = var_11_0

	local var_11_2 = var_11_0.select(arg_11_0:getConfig("item_list"), function(arg_12_0)
		if arg_11_1 then
			table = var_1

			return var_1.contains(var_11_1, arg_12_0[1])
		else
			table = var_1

			return not var_1.contains(var_11_1, arg_12_0[1])
		end

		return
	end)

	_ = var_4

	return (var_4.map(var_11_2, function(arg_13_0)
		local var_13_0 = var_0_2[arg_13_0[1]]
		local var_13_1

		if not arg_11_0.awards[arg_13_0[1]] then
			var_13_1 = 0
		end

		return {
			id = var_13_0.commodity_id,
			type = var_13_0.resource_category,
			count = var_13_0.num,
			surplus = arg_13_0[2] - var_13_1,
			total = arg_13_0[2]
		}
	end))
end

function var_0_1.getItems(arg_14_0)
	local var_14_0 = arg_14_0:filterItems(true)
	local var_14_1 = arg_14_0:filterItems(false)

	return var_14_0, var_14_1
end

function var_0_1.canOpenNext(arg_15_0)
	_ = var_1_10001

	return var_1_10001.all(arg_15_0:getMainItems(), function(arg_16_0)
		return arg_16_0.surplus == 0
	end)
end

function var_0_1.getTempleNewChar(arg_17_0, arg_17_1)
	if not arg_17_0.charAwardDisplayData then
		arg_17_0.charAwardDisplayData = {}
		ipairs = var_2
		pg = var_1_10003

		for iter_17_0, iter_17_1 in var_2(var_1_10003.guardian_template.all) do
			pg = var_1_10007

			if var_1_10007.guardian_template[iter_17_1].guardian_gain_pool == arg_17_0.configId then
				local var_17_0 = arg_17_0

				var_1_10008 = arg_17_0.getCharLotteryCount(var_17_0, iter_17_1)
				table = var_17_0

				var_17_0.insert(arg_17_0.charAwardDisplayData, {
					iter_17_1,
					var_1_10008
				})
			end
		end
	end

	local var_17_1 = {}
	local var_17_2 = arg_17_0:getFetchCount()

	for iter_17_2 = arg_17_1 + 1, var_17_2 do
		ipairs = var_1_10008

		for iter_17_3, iter_17_4 in var_1_10008(arg_17_0.charAwardDisplayData) do
			if iter_17_4[2] == iter_17_2 then
				table = var_13

				var_13.insert(var_17_1, iter_17_4[1])
			end
		end
	end

	return var_17_1
end

var_0_1.guardian_type_lottery = 1
var_0_1.guardian_type_lock = 2

function var_0_1.getCharLotteryCount(arg_18_0, arg_18_1)
	pg = var_1_10002

	local var_18_0 = var_1_10002.guardian_template[arg_18_1].type

	ActivityItemPool = var_1_10004

	if var_18_0 == var_1_10004.guardian_type_lottery then
		return var_2.guardian_gain[2]
	else
		local var_18_1 = var_2.type

		ActivityItemPool = var_4

		if var_18_1 == var_4.guardian_type_lock then
			local var_18_2 = var_2.guardian_gain
			local var_18_3 = 0

			ipairs = var_1_10005

			for iter_18_0, iter_18_1 in var_1_10005(var_18_2) do
				math = var_1_10010
				var_18_3 = var_1_10010.max(var_18_3, arg_18_0:getCharLotteryCount(iter_18_1))
			end

			return var_18_3
		end
	end

	return -1
end

function var_0_1.getGuardianGot(arg_19_0, arg_19_1)
	pg = var_1_10002

	if var_1_10002.guardian_template[arg_19_1].guardian_gain_pool ~= arg_19_0.id then
		warning = var_3

		var_3("guardian id " .. arg_19_1 .. "不属于该池子 " .. arg_19_0.id .. " 所属对象")

		return false, 0
	end

	local var_19_0 = var_2.type

	ActivityItemPool = var_4

	local var_19_1

	if var_19_0 == var_4.guardian_type_lottery then
		var_19_1 = arg_19_0

		local var_19_2 = arg_19_0.getFetchCount(var_19_1)
		local var_19_3

		var_19_3 = var_2.guardian_gain[2] <= var_19_2
		math = var_19_1
		var_19_1 = var_19_1.max(var_2.guardian_gain[2] - arg_19_0:getFetchCount(), 0)

		return
	else
		local var_19_4 = var_2.type

		ActivityItemPool = var_19_1

		if var_19_4 == var_19_1.guardian_type_lock then
			local var_19_5 = var_2.guardian_gain
			local var_19_6 = 0

			ipairs = var_1_10005

			for iter_19_0, iter_19_1 in var_1_10005(var_19_5) do
				if not arg_19_0:getGuardianGot(iter_19_1) then
					var_19_6 = var_19_6 + 1
				end
			end

			return var_19_6 == 0, var_19_6
		end
	end

	return false, 0
end

function var_0_1.GetAllGuardianIds(arg_20_0)
	pg = var_1_10001

	if not var_1_10001.activity_template[arg_20_0] then
		return {}
	end

	local var_20_0 = var_1.type

	ActivityConst = var_1_10003

	if var_20_0 ~= var_1_10003.ACTIVITY_TYPE_LOTTERY then
		return {}
	end

	local var_20_1 = {}

	pg = var_3

	local var_20_2 = var_3.activity_template[arg_20_0].config_data

	ipairs = var_1_10004
	pg = var_1_10005

	for iter_20_0, iter_20_1 in var_1_10004(var_1_10005.guardian_template.all) do
		pg = var_1_10009
		var_1_10009 = var_1_10009.guardian_template[iter_20_1]
		table = var_1_10010

		if var_1_10010.contains(var_20_2, var_1_10009.guardian_gain_pool) then
			var_1_10010 = var_1_10009.id
			table = var_11

			var_11.insert(var_20_1, var_1_10010)
		end
	end

	return var_20_1
end

function var_0_1.GetAllGuardianIdsStatus(arg_21_0)
	pg = var_1_10001

	local var_21_0 = var_1_10001.activity_template[arg_21_0]

	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_21_1 = var_1_10002(var_1_10003)
	local var_21_2 = var_2.getActivityById(var_21_1, arg_21_0)

	if not var_21_0 then
		return {}
	end

	local var_21_3 = var_21_0.type

	ActivityConst = var_4

	if var_21_3 ~= var_4.ACTIVITY_TYPE_LOTTERY then
		return {}
	end

	if not var_21_2 then
		return
	end

	local var_21_4 = {}
	local var_21_5 = {}
	local var_21_6 = {}

	pg = var_1_10006

	local var_21_7 = var_1_10006.activity_template[arg_21_0].config_data

	ipairs = var_1_10007

	for iter_21_0, iter_21_1 in var_1_10007(var_21_7) do
		var_1_10013 = var_21_2
		var_1_10012 = var_21_2.getAwardInfos(var_1_10013)[iter_21_1]
		ActivityItemPool = var_1_10013
		var_21_6[iter_21_1] = var_1_10013.CreateItemPool(iter_21_1, var_1_10012, nil, iter_21_0)
	end

	ipairs = var_7
	pg = var_8

	for iter_21_2, iter_21_3 in var_7(var_8.guardian_template.all) do
		pg = var_1_10012
		var_1_10012 = var_1_10012.guardian_template[iter_21_3]
		table = var_1_10013

		if var_1_10013.contains(var_21_7, var_1_10012.guardian_gain_pool) then
			var_1_10013 = var_1_10012.id

			if var_21_6[var_1_10012.guardian_gain_pool] then
				local var_21_8, var_21_9 = var_14:getGuardianGot(var_1_10013)

				if var_21_8 then
					table = var_17

					var_17.insert(var_21_4, var_1_10013)
				else
					table = var_17

					var_17.insert(var_21_5, {
						var_1_10013,
						var_21_9
					})
				end
			end
		end
	end

	return var_21_4, var_21_5
end

function var_0_1.GetGuardianLastCount(arg_22_0, arg_22_1)
	pg = var_1_10002

	local var_22_0 = var_1_10002.activity_template[arg_22_0]

	getProxy = var_1_10003
	ActivityProxy = var_1_10004

	local var_22_1 = var_1_10003(var_1_10004)
	local var_22_2 = var_3.getActivityById(var_22_1, arg_22_0)

	if not var_22_0 then
		return {}
	end

	local var_22_3 = var_22_0.type

	ActivityConst = var_5

	if var_22_3 ~= var_5.ACTIVITY_TYPE_LOTTERY then
		return {}
	end

	if not var_22_2 then
		return
	end

	pg = var_22_3

	local var_22_4 = var_22_3.guardian_template[arg_22_1].guardian_gain_pool
	local var_22_5 = var_22_2
	local var_22_6 = var_22_2.getAwardInfos(var_22_5)[var_22_4]

	ActivityItemPool = var_22_5

	local var_22_7 = var_22_5.CreateItemPool(var_22_4, var_22_6, nil, 1)

	return var_6.getGuardianGot(var_22_7, arg_22_1)
end

function var_0_1.CreateItemPool(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	ActivityItemPool = var_1_10004

	return (var_1_10004.New({
		id = arg_23_0,
		awards = arg_23_1,
		index = arg_23_3
	}))
end

function var_0_1.GetTempleRedTip(arg_24_0, arg_24_1)
	pg = var_1_10002

	if not var_1_10002.activity_template[arg_24_0] then
		return false
	end

	getProxy = var_1_10003
	ActivityProxy = var_1_10004

	local var_24_0 = var_1_10003(var_1_10004)

	if not var_3.getActivityById(var_24_0, arg_24_0) then
		return false
	end

	arg_24_1 = arg_24_1 or 60
	getProxy = var_24_0
	PlayerProxy = var_5

	local var_24_1 = var_24_0(var_5)
	local var_24_2 = var_4.getData(var_24_1)

	pg = var_24_1

	local var_24_3 = var_24_1.activity_template[arg_24_0].config_data
	local var_24_4 = 0
	local var_24_5 = 0

	ipairs = var_1_10008

	for iter_24_0, iter_24_1 in var_1_10008(var_24_3) do
		pg = var_1_10013

		local var_24_6 = var_1_10013.activity_random_award_template[iter_24_1].resource_num
		local var_24_7 = var_24_2
		local var_24_8 = var_24_2.getResById(var_24_7, var_1_10013.resource_type)

		math = var_24_7

		local var_24_9 = var_24_7.max
		local var_24_10 = var_24_4

		math = var_1_10018
		var_24_4 = var_24_9(var_24_10, var_1_10018.floor(var_24_8 / var_24_6))

		local var_24_11 = var_3
		local var_24_12 = var_3.getAwardInfos(var_24_11)[iter_24_1]

		ActivityItemPool = var_24_11

		local var_24_13 = var_24_11.CreateItemPool(iter_24_1, var_24_12, nil, 1)

		var_24_5 = var_24_5 + var_17.getleftItemCount(var_24_13)
	end

	if var_24_5 <= 0 then
		return false
	end

	if arg_24_1 <= var_24_4 then
		return true
	end

	if var_2.config_client.red_tip_time then
		os = var_9

		local var_24_14 = var_9.time({
			year = var_8[1],
			month = var_8[2],
			day = var_8[3],
			hour = var_8[4],
			min = var_8[5],
			sec = var_8[6]
		})

		pg = var_10

		local var_24_15 = var_10.TimeMgr.GetInstance()

		return var_10.GetServerTime(var_24_15) - var_24_14 > 0 and var_24_4 > 1
	end

	return false
end

return var_0_1
