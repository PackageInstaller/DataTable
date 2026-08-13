class = var_0_10000

local var_0_0 = "ActivityShopWithProgressRewardCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

var_0_1.SHOW_SHOP_REWARD = "ActivityShopWithProgressRewardCommand Show shop reward"

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	ActivityProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)
	local var_1_2 = var_3.getActivityById(var_1_1, var_1_0.activity_id)
	local var_1_3 = var_3.getConfig(var_1_2, "type")

	assert = var_1_1
	ActivityConst = var_7

	var_1_1(var_1_3 == var_7.ACTIVITY_TYPE_SHOP_PROGRESS_REWARD, "Operation Cant Fit ActivityType " .. var_1_3)

	ActivityConst = var_1_1

	local var_1_5

	if var_1_3 == var_1_1.ACTIVITY_TYPE_SHOP_PROGRESS_REWARD then
		if var_1_0.cmd == 1 then
			getProxy = var_1_5
			PlayerProxy = var_7

			local var_1_4 = var_1_5(var_7)

			var_1_5 = var_1_5.getData(var_1_4)
			pg = var_1_2

			local var_1_6 = var_1_2.activity_shop_template[var_1_0.arg1]
			local var_1_7

			if not var_1_0.arg2 then
				var_1_7 = 1
			end

			id2res = var_8

			if var_1_5[var_8(var_1_6.resource_type)] < var_1_6.resource_num * var_1_7 then
				pg = var_8

				local var_1_8 = var_8.TipsMgr.GetInstance()
				local var_1_9 = var_8.ShowTips

				i18n = var_1_10011

				var_1_9(var_1_8, var_1_10011("common_no_resource"))

				return
			end

			if var_1_6.commodity_type == 1 then
				if var_1_6.commodity_id == 1 and var_1_5:GoldMax(var_1_6.num * var_1_7) then
					pg = var_8

					local var_1_10 = var_8.TipsMgr.GetInstance()
					local var_1_11 = var_8.ShowTips

					i18n = var_11

					local var_1_12 = var_11("gold_max_tip_title")

					i18n = var_1_10012

					var_1_11(var_1_10, var_1_12 .. var_1_10012("resource_max_tip_shop"))

					return
				end

				if var_1_6.commodity_id == 2 and var_1_5:OilMax(var_1_6.num * var_1_7) then
					pg = var_8

					local var_1_13 = var_8.TipsMgr.GetInstance()
					local var_1_14 = var_8.ShowTips

					i18n = var_11

					local var_1_15 = var_11("oil_max_tip_title")

					i18n = var_1_10012

					var_1_14(var_1_13, var_1_15 .. var_1_10012("resource_max_tip_shop"))

					return
				end
			end
		elseif var_1_0.cmd == 2 then
			table = var_1_5

			if var_1_5.contains(var_3.data3_list, var_1_0.arg1) then
				pg = var_1_5

				local var_1_16 = var_1_5.TipsMgr.GetInstance()

				var_1_5 = var_1_5.ShowTips
				i18n = var_8

				var_1_5(var_1_16, var_8("common_count_noenough"))

				return
			end
		end
	end

	pg = var_1_5

	local var_1_17 = var_1_5.ConnectionMgr.GetInstance()

	var_5.Send(var_1_17, 11202, {
		activity_id = var_1_0.activity_id,
		cmd = var_1_0.cmd,
		arg1 = var_1_0.arg1,
		arg2 = var_1_0.arg2,
		arg_list = {}
	}, 11203, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = arg_1_0

			var_2_1 = var_2_1.getAwards(var_2_0, var_1_0, arg_2_0)
			getProxy = var_2_10002
			ActivityProxy = var_4

			local var_2_2 = var_2_10002(var_4)
			local var_2_3 = var_2.getActivityById(var_2_2, var_1_0.activity_id)
			local var_2_4 = arg_1_0
			local var_2_5 = var_3.updateActivityData(var_2_4, var_1_0, arg_2_0, var_2_3, var_2_1)
			local var_2_6 = arg_1_0

			var_3.performance(var_2_6, var_1_0, arg_2_0, var_2_5, var_2_1)
		else
			print = var_2_1

			var_2_1("activity op ret code: " .. arg_2_0.result)

			local var_2_8

			if arg_2_0.result == 3 or arg_2_0.result == 4 then
				pg = var_2_8

				local var_2_7 = var_2_8.TipsMgr.GetInstance()

				var_2_8 = var_2_8.ShowTips
				i18n = var_4

				var_2_8(var_2_7, var_4("common_activity_end"))
			else
				pg = var_2_8

				local var_2_9 = var_2_8.TipsMgr.GetInstance()
				local var_2_10 = var_1.ShowTips

				errorTip = var_4

				var_2_10(var_2_9, var_4("activity_op_error", arg_2_0.result))
			end

			local var_2_11 = arg_1_0
			local var_2_12 = var_1.sendNotification

			ActivityProxy = var_4

			var_2_12(var_2_11, var_4.ACTIVITY_OPERATION_ERRO, {
				actId = var_1_0.activity_id,
				code = arg_2_0.result
			})
		end

		return
	end)

	return
end

function var_0_1.getAwards(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {}

	ipairs = var_1_10004

	for iter_3_0, iter_3_1 in var_1_10004(arg_3_2.award_list) do
		local var_3_1 = {
			type = iter_3_1.type,
			id = iter_3_1.id,
			number = iter_3_1.number
		}

		table = var_10

		var_10.insert(var_3_0, var_3_1)
	end

	PlayerConst = var_4

	local var_3_2 = var_4.addTranDrop(var_3_0)

	ipairs = var_5

	for iter_3_2, iter_3_3 in var_5(var_3_0) do
		local var_3_3 = iter_3_3.type

		DROP_TYPE_SHIP = var_1_10011

		if var_3_3 == var_1_10011 then
			pg = var_3_3

			local var_3_4 = var_3_3.ship_data_template[iter_3_3.id]

			getProxy = var_1_10011
			CollectionProxy = var_1_10013
			var_1_10013 = var_1_10011(var_1_10013)

			if not var_1_10011.getShipGroup(var_1_10013, var_3_4.group_type) then
				Ship = var_1_10012

				if var_1_10012.inUnlockTip(iter_3_3.id) then
					pg = var_1_10012

					local var_3_5 = var_1_10012.TipsMgr.GetInstance()

					var_1_10012 = var_1_10012.ShowTips
					i18n = var_1_10015

					var_1_10012(var_3_5, var_1_10015("collection_award_ship", var_3_4.name))
				end
			end
		end
	end

	if arg_3_1.isAwardMerge then
		local var_3_6 = {}
		local var_3_7

		ipairs = var_7

		for iter_3_4, iter_3_5 in var_7(var_3_2) do
			if (function()
				ipairs = var_2_10000

				for iter_4_0, iter_4_1 in var_2_10000(var_3_6) do
					if iter_3_5.id == iter_4_1.id then
						var_3_6[iter_4_0].count = var_3_6[iter_4_0].count + iter_3_5.count

						return false
					end
				end

				return true
			end)() then
				table = var_13

				var_13.insert(var_3_6, iter_3_5)
			end
		end

		var_3_2 = var_3_6
	end

	return var_3_2
end

function var_0_1.updateActivityData(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = arg_5_3
	local var_5_1 = arg_5_3.getConfig(var_5_0, "type")

	getProxy = var_1_10006
	PlayerProxy = var_8

	local var_5_2 = var_1_10006(var_8)

	getProxy = var_5_0
	TaskProxy = var_1_10009

	local var_5_3 = var_5_0(var_1_10009)

	ActivityConst = var_8

	if var_5_1 == var_8.ACTIVITY_TYPE_SHOP_PROGRESS_REWARD then
		if arg_5_1.cmd == 1 then
			table = var_8

			if var_8.contains(arg_5_3.data1_list, arg_5_1.arg1) then
				ipairs = var_8

				for iter_5_0, iter_5_1 in var_8(arg_5_3.data1_list) do
					if iter_5_1 == arg_5_1.arg1 then
						arg_5_3.data2_list[iter_5_0] = arg_5_3.data2_list[iter_5_0] + arg_5_1.arg2

						break
					end
				end
			else
				table = var_8

				var_8.insert(arg_5_3.data1_list, arg_5_1.arg1)

				table = var_8

				var_8.insert(arg_5_3.data2_list, arg_5_1.arg2)
			end

			pg = var_8

			local var_5_4 = var_8.activity_shop_template[arg_5_1.arg1].resource_num * arg_5_1.arg2
			local var_5_5 = var_5_2:getData()
			local var_5_6 = var_10.consume
			local var_5_7 = {}

			id2res = var_1_10015
			var_5_7[var_1_10015(var_8.resource_type)] = var_5_4

			var_5_6(var_5_5, var_5_7)
			var_5_2:updatePlayer(var_10)
		elseif arg_5_1.cmd == 2 then
			table = var_8

			var_8.insert(arg_5_3.data3_list, arg_5_1.arg1)
		end
	end

	return arg_5_3
end

function var_0_1.performance(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	arg_6_0:sendNotification(var_0_1.SHOW_SHOP_REWARD, {
		activityId = arg_6_1.activity_id,
		shopType = arg_6_1.cmd,
		awards = arg_6_4,
		callback = function()
			getProxy = var_2_10000
			ActivityProxy = var_2_10002

			local var_7_0 = var_2_10000(var_2_10002)

			var_0.updateActivity(var_7_0, arg_6_3)

			return
		end
	})

	return
end

return var_0_1
