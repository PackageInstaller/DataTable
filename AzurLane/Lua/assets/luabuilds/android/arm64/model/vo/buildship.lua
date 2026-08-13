class = var_0_10000

local var_0_0 = "BuildShip"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

var_0_1.INACTIVE = 1
var_0_1.ACTIVE = 2
var_0_1.FINISH = 3

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.type = arg_1_1.build_id
	arg_1_0.time = arg_1_1.time
	arg_1_0.finishTime = arg_1_1.finish_time
	arg_1_0.state = arg_1_0.INACTIVE

	return
end

function var_0_1.setId(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1

	return
end

function var_0_1.setState(arg_3_0, arg_3_1)
	arg_3_0.state = arg_3_1

	return
end

function var_0_1.isFinish(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_4_0) >= arg_4_0.finishTime
end

function var_0_1.finish(arg_5_0)
	arg_5_0.time = 0
	pg = var_1

	local var_5_0 = var_1.TimeMgr.GetInstance()

	arg_5_0.finishTime = var_1.GetServerTime(var_5_0)
	arg_5_0.state = arg_5_0.FINISH

	return
end

function var_0_1.active(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.TimeMgr.GetInstance()

	arg_6_0.finishTime = var_1.GetServerTime(var_6_0) + arg_6_0.time
	arg_6_0.state = arg_6_0.ACTIVE

	return
end

function var_0_1.setIsStart(arg_7_0, arg_7_1)
	arg_7_0.isStart = arg_7_1

	return
end

function var_0_1.getLeftTime(arg_8_0)
	local var_8_0 = arg_8_0.finishTime

	pg = var_1_10002

	local var_8_1 = var_1_10002.TimeMgr.GetInstance()

	return var_8_0 - var_2.GetServerTime(var_8_1)
end

function var_0_1.getBuildConsume(arg_9_0, arg_9_1, arg_9_2)
	pg = var_1_10003

	local var_9_0 = var_1_10003.draw_data_template[arg_9_0]
	local var_9_1

	if arg_9_1 == 1 then
		math = var_1_10005
		arg_9_2 = var_1_10005.min(arg_9_2 + 1, #var_9_0.use_gem_1)
		var_9_1 = var_9_0.use_gem_1[arg_9_2]
	else
		math = var_1_10005
		arg_9_2 = var_1_10005.min(arg_9_2 + 1, #var_9_0.use_gem_10)
		var_9_1 = var_9_0.use_gem_10[arg_9_2]
	end

	return var_9_1
end

function var_0_1.canBuildShipByBuildId(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1 = arg_10_1 or 1
	pg = var_1_10003

	if not var_1_10003.ship_data_create_material[arg_10_0] then
		var_1_10004 = false
		i18n = var_1_10005

		local var_10_0 = var_1_10005("ship_buildShip_error_noTemplate", arg_10_0)

		return
	end

	getProxy = var_1_10004
	BuildShipProxy = var_1_10006

	local var_10_1 = var_1_10004(var_1_10006)
	local var_10_2 = var_4.getData(var_10_1)

	table = var_1_10006

	local var_10_3 = var_1_10006.getCount(var_10_2) + arg_10_1

	MAX_BUILD_WORK_COUNT = var_10_1

	if var_10_1 < var_10_3 then
		var_10_3 = false
		i18n = var_10_1
		var_10_1 = var_10_1("ship_buildShip_not_position")

		return
	end

	if arg_10_2 then
		getProxy = var_10_3
		ActivityProxy = var_8

		local var_10_4 = var_10_3(var_8)

		var_1_10009 = var_6.getBuildFreeActivityByBuildId(var_10_4, arg_10_0)
		var_10_1 = var_6.getConfig(var_1_10009, "config_client")[1]
		Drop = var_10_4

		local var_10_5 = var_10_4.New
		local var_10_6 = {}

		DROP_TYPE_VITEM = var_1_10011
		var_10_6.type = var_1_10011
		var_10_6.id = var_10_1

		local var_10_7 = var_10_5(var_10_6)
		local var_10_8 = var_8.getName(var_10_7)

		if var_6 then
			var_1_10011 = var_6

			if var_6.isEnd(var_1_10011) then
				var_1_10009 = false
				i18n = var_10_7
				var_10_7 = var_10_7("tip_build_ticket_expired", var_10_8)

				return
			elseif var_6.data1 < arg_10_1 then
				var_1_10009 = false
				i18n = var_10_7

				local var_10_9 = var_10_7("tip_build_ticket_not_enough", var_10_8)

				return
			end

			if false then
				local var_10_10 = {}

				getProxy = var_10_1
				PlayerProxy = var_1_10009

				local var_10_11 = var_10_1(var_1_10009)

				if var_7.getData(var_10_11).gold < var_3.use_gold * arg_10_1 then
					table = var_9

					var_9.insert(var_10_10, {
						59001,
						var_3.use_gold * arg_10_1 - var_8.gold,
						var_3.use_gold * arg_10_1
					})
				end

				getProxy = var_9
				BagProxy = var_1_10011

				local var_10_12 = var_9(var_1_10011)

				if not var_9.getData(var_10_12)[var_3.use_item] or var_10[var_3.use_item].count < var_3.number_1 * arg_10_1 then
					local var_10_13 = var_3.number_1 * arg_10_1
					local var_10_14 = var_3.use_item

					if var_10[var_3.use_item] then
						var_10_13 = var_3.number_1 * arg_10_1 - var_10[var_10_14].count
					end

					table = var_13

					var_13.insert(var_10_10, {
						var_10_14,
						var_10_13,
						var_3.number_1 * arg_10_1
					})
				end

				local var_10_15 = #var_10_10

				if 0 < var_10_15 then
					local var_10_16 = false

					i18n = var_12

					return var_10_16, var_12("ship_buildShip_error_notEnoughItem"), var_10_10
				end
			end

			return true
		end
	end
end

function var_0_1.canQuickBuildShip(arg_11_0)
	getProxy = var_1_10001
	BuildShipProxy = var_1_10003

	local var_11_0 = var_1_10001(var_1_10003)

	if not var_1.getBuildShip(var_11_0, arg_11_0) then
		local var_11_1 = false

		i18n = var_11_0
		var_11_0 = var_11_0("ship_buildShipImmediately_error_noSHip")

		return
	end

	local var_11_2 = var_2
	local var_11_3

	if var_2.isFinish(var_11_2) then
		var_11_3 = false
		i18n = var_11_0

		local var_11_4 = var_11_0("ship_buildShipImmediately_error_finished")

		return
	end

	getProxy = var_11_3
	BagProxy = var_11_2

	local var_11_5 = var_11_3(var_11_2)
	local var_11_6 = var_3.getItemById

	ITEM_ID_EQUIP_QUICK_FINISH = var_1_10007

	local var_11_7

	if not var_11_6(var_11_5, var_1_10007) then
		var_11_7 = {
			count = 0
		}
	end

	if var_11_7.count <= 0 then
		local var_11_8 = {}
		local var_11_9 = {
			nil,
			nil,
			1
		}

		ITEM_ID_EQUIP_QUICK_FINISH = var_1_10007
		var_11_9[1] = var_1_10007
		var_11_9[2] = 1 - var_11_7.count
		var_11_8[1] = var_11_9

		local var_11_10 = false

		i18n = var_7

		return var_11_10, var_7("ship_buildShip_error_notEnoughItem"), var_11_8
	end

	return true
end

function var_0_1.getPageFromPoolType(arg_12_0)
	local var_12_0 = {}

	BuildShipScene = var_1_10002
	var_12_0[var_1_10002.PAGE_BUILD] = {
		1,
		2,
		3,
		4,
		5
	}
	BuildShipScene = var_2
	var_12_0[var_2.PAGE_PRAY] = {
		6,
		7,
		8
	}
	BuildShipScene = var_2
	var_12_0[var_2.PAGE_NEWSERVER] = {
		11
	}
	pairs = var_2

	for iter_12_0, iter_12_1 in var_2(var_12_0) do
		table = var_1_10007

		if var_1_10007.contains(iter_12_1, arg_12_0) then
			return iter_12_0
		end
	end

	return
end

return var_0_1
