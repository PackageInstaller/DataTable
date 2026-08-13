class = var_0_10000

local var_0_0 = "ActivityOperationCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	ActivityProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)
	local var_1_3 = var_3.getActivityById(var_1_2, var_1_1.activity_id)

	assert = var_1_2

	var_1_2(var_1_3)

	local var_1_4 = var_1_3
	local var_1_5 = var_1_3.getConfig(var_1_4, "type")

	switch = var_1_4

	local var_1_6 = var_1_5
	local var_1_7 = {}

	ActivityConst = var_1_10008
	var_1_7[var_1_10008.ACTIVITY_TYPE_BUILDSHIP_1] = function()
		BuildShip = var_2_10000

		local var_2_0, var_2_1, var_2_2 = var_2_10000.canBuildShipByBuildId(var_1_1.buildId, var_1_1.arg1, var_1_1.arg2 == 1)

		if not var_2_0 then
			if var_2_2 then
				GoShoppingMsgBox = var_3
				i18n = var_2_10004

				local var_2_3 = var_2_10004("switch_to_shop_tip_1")

				ChargeScene = var_5

				var_3(var_2_3, var_5.TYPE_ITEM, var_2_2)
			else
				pg = var_3

				local var_2_4 = var_3.TipsMgr.GetInstance()

				var_3.ShowTips(var_2_4, var_2_1)
			end

			return true
		end

		return
	end
	ActivityConst = var_8

	local var_1_8 = var_8.ACTIVITY_TYPE_BUILDSHIP_PRAY

	ActivityConst = var_9
	var_1_7[var_1_8] = var_9.ACTIVITY_TYPE_BUILDSHIP_1
	ActivityConst = var_1_8

	local var_1_9 = var_1_8.ACTIVITY_TYPE_NEWSERVER_BUILD

	ActivityConst = var_9
	var_1_7[var_1_9] = var_9.ACTIVITY_TYPE_BUILDSHIP_1
	ActivityConst = var_1_9
	var_1_7[var_1_9.ACTIVITY_TYPE_SHOP] = function()
		getProxy = var_2_10000
		PlayerProxy = var_2_10001

		local var_3_0 = var_2_10000(var_2_10001)
		local var_3_1 = var_0.getData(var_3_0)

		getProxy = var_3_0
		ShopsProxy = var_2_10002

		local var_3_2 = var_3_0(var_2_10002)
		local var_3_3 = var_1.getActivityShopById(var_3_2, var_1_3.id)
		local var_3_4 = var_1.bindConfigTable(var_3_3)[var_1_1.arg1]
		local var_3_5

		if not var_1_1.arg2 then
			var_3_5 = 1
		end

		id2res = var_2_10004

		if var_3_1[var_2_10004(var_3_4.resource_type)] < var_3_4.resource_num * var_3_5 then
			pg = var_4

			local var_3_6 = var_4.TipsMgr.GetInstance()
			local var_3_7 = var_4.ShowTips

			i18n = var_2_10006

			var_3_7(var_3_6, var_2_10006("common_no_resource"))

			return true
		end

		if var_3_4.commodity_type == 1 then
			if var_3_4.commodity_id == 1 and var_3_1:GoldMax(var_3_4.num * var_3_5) then
				pg = var_4

				local var_3_8 = var_4.TipsMgr.GetInstance()
				local var_3_9 = var_4.ShowTips

				i18n = var_6

				local var_3_10 = var_6("gold_max_tip_title")

				i18n = var_7

				var_3_9(var_3_8, var_3_10 .. var_7("resource_max_tip_shop"))

				return true
			end

			if var_3_4.commodity_id == 2 and var_3_1:OilMax(var_3_4.num * var_3_5) then
				pg = var_4

				local var_3_11 = var_4.TipsMgr.GetInstance()
				local var_3_12 = var_4.ShowTips

				i18n = var_6

				local var_3_13 = var_6("oil_max_tip_title")

				i18n = var_7

				var_3_12(var_3_11, var_3_13 .. var_7("resource_max_tip_shop"))

				return true
			end
		end

		return
	end
	ActivityConst = var_8
	var_1_7[var_8.ACTIVITY_TYPE_BUILDING_BUFF_2] = function()
		if var_1_1.cmd == 2 then
			local var_4_0 = var_1_3

			if not var_0.CanRequest(var_4_0) then
				return true
			end
		end

		return
	end
	ActivityConst = var_8
	var_1_7[var_8.ACTIVITY_TYPE_SKIN_FAKE_PACKAGE] = function()
		local var_5_0 = var_1_1.costDrop.count
		local var_5_1 = var_0

		if var_5_0 > var_0.getOwnedCount(var_5_1) then
			pg = var_5_0

			local var_5_2 = var_5_0.TipsMgr.GetInstance()
			local var_5_3 = var_1.ShowTips

			i18n = var_5_1

			var_5_3(var_5_2, var_5_1("common_no_resource"))

			return true
		end

		return
	end
	ActivityConst = var_8
	var_1_7[var_8.ACTIVITY_TYPE_TIMES_FAKE_PACKAGE] = function()
		local var_6_0 = var_1_1.costDrop.count
		local var_6_1 = var_0

		if var_6_0 > var_0.getOwnedCount(var_6_1) then
			pg = var_6_0

			local var_6_2 = var_6_0.TipsMgr.GetInstance()
			local var_6_3 = var_1.ShowTips

			i18n = var_6_1

			var_6_3(var_6_2, var_6_1("common_no_resource"))

			return true
		end

		return
	end

	if var_1_4(var_1_6, var_1_7) then
		return
	end

	pg = var_1_6

	local var_1_10 = var_1_6.ConnectionMgr.GetInstance()
	local var_1_11 = var_6.Send
	local var_1_12 = 11202
	local var_1_13 = {
		activity_id = var_1_1.activity_id,
		cmd = var_1_1.cmd,
		arg1 = var_1_1.arg1,
		arg2 = var_1_1.arg2
	}
	local var_1_14

	if not var_1_1.arg_list then
		var_1_14 = {}
	end

	var_1_13.arg_list = var_1_14
	var_1_13.kvargs1 = var_1_1.kvargs1

	var_1_11(var_1_10, var_1_12, var_1_13, 11203, function(arg_7_0)
		local var_7_0

		if arg_7_0.result == 0 then
			PlayerConst = var_7_0
			var_7_0 = var_7_0.GetTranAwards(var_1_1, arg_7_0)

			local var_7_1 = arg_1_0
			local var_7_2 = var_2.updateActivityData(var_7_1, var_1_1, arg_7_0, var_1_3, var_7_0)

			getProxy = var_7_1
			ActivityTaskProxy = var_4

			local var_7_3 = var_7_1(var_4)

			var_3.checkAutoSubmit(var_7_3)

			local var_7_4 = arg_1_0

			var_3.performance(var_7_4, var_1_1, arg_7_0, var_7_2, var_7_0)

			goto label_7_1
		end

		originalPrint = var_7_0

		var_7_0("activity op ret code: " .. arg_7_0.result)

		local var_7_5 = var_1_5

		ActivityConst = var_2

		if var_7_5 ~= var_2.ACTIVITY_TYPE_7DAYSLOGIN then
			local var_7_6 = var_1_5

			ActivityConst = var_7_10

			if var_7_6 ~= var_7_10.ACTIVITY_TYPE_PROGRESSLOGIN then
				local var_7_7 = var_1_5

				ActivityConst = var_7_10

				if var_7_7 ~= var_7_10.ACTIVITY_TYPE_MONTHSIGN then
					local var_7_8 = var_1_5

					ActivityConst = var_7_10

					local var_7_10

					if var_7_8 == var_7_10.ACTIVITY_TYPE_REFLUX then
						local var_7_9 = var_1_3

						var_7_9.autoActionForbidden = true
						getProxy = var_7_9
						ActivityProxy = var_7_10
						var_7_10 = var_7_9(var_7_10)

						var_1.updateActivity(var_7_10, var_1_3)

						goto label_7_0
					end

					local var_7_11 = var_1_5

					ActivityConst = var_7_10

					if var_7_11 ~= var_7_10.ACTIVITY_TYPE_BUILDSHIP_1 then
						do
							local var_7_12 = var_1_5

							ActivityConst = var_7_13

							local var_7_13

							if var_7_12 == var_7_13.ACTIVITY_TYPE_NEWSERVER_BUILD then
								if arg_7_0.result == 1 then
									pg = var_1
									var_7_13 = var_1.TipsMgr.GetInstance()

									local var_7_14 = var_1.ShowTips

									i18n = var_3

									var_7_14(var_7_13, var_3("activity_build_end_tip"))
								end
							elseif var_1_5 == 17 then
								pg = var_1
								var_7_13 = var_1.TipsMgr.GetInstance()

								var_1.ShowTips(var_7_13, "错误!:" .. arg_7_0.result)
							else
								local var_7_15 = var_1_5

								ActivityConst = var_7_13

								local var_7_16

								if var_7_15 == var_7_13.ACTIVITY_TYPE_FRESH_TEC_CATCHUP then
									pg = var_7_15
									var_7_16 = var_7_15.TipsMgr.GetInstance()

									local var_7_17 = var_1.ShowTips

									errorTip = var_3

									var_7_17(var_7_16, var_3("activity_op_error", arg_7_0.result))
								else
									local var_7_18 = var_1_5

									ActivityConst = var_7_16

									if var_7_18 == var_7_16.ACTIVITY_TYPE_BUILDING_BUFF then
										local var_7_19 = var_1_3
										local var_7_20 = var_1.getConfig(var_7_19, "config_client").resource_ID

										BossRushDALUpgradeView = var_7_19

										if var_7_20 == var_7_19.RES_ID then
											pg = var_7_20

											local var_7_21 = var_7_20.TipsMgr.GetInstance()
											local var_7_22 = var_1.ShowTips

											i18n = var_3

											var_7_22(var_7_21, var_3("DAL_upgrade_not_enough"))
										end
									else
										local var_7_24

										if arg_7_0.result == 3 or arg_7_0.result == 4 then
											pg = var_7_24

											local var_7_23 = var_7_24.TipsMgr.GetInstance()

											var_7_24 = var_7_24.ShowTips
											i18n = var_3

											var_7_24(var_7_23, var_3("common_activity_end"))
										else
											pg = var_7_24

											local var_7_25 = var_7_24.TipsMgr.GetInstance()
											local var_7_26 = var_1.ShowTips

											errorTip = var_3

											var_7_26(var_7_25, var_3("activity_op_error", arg_7_0.result))
										end
									end
								end
							end
						end

						::label_7_0::

						do
							local var_7_27 = arg_1_0
							local var_7_28 = var_1.sendNotification

							ActivityProxy = var_3

							var_7_28(var_7_27, var_3.ACTIVITY_OPERATION_ERRO, {
								actId = var_1_1.activity_id,
								code = arg_7_0.result
							})
						end

						::label_7_1::

						return
					end
				end
			end
		end
	end)

	return
end

function var_0_1.updateActivityData(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = arg_8_3
	local var_8_1 = arg_8_3.getConfig(var_8_0, "type")

	getProxy = var_8_0
	PlayerProxy = var_7

	local var_8_2 = var_8_0(var_7)

	getProxy = var_7
	TaskProxy = var_1_10008

	local var_8_3 = var_7(var_1_10008)

	switch = var_1_10008

	local var_8_4 = var_8_1
	local var_8_5 = {}

	ActivityConst = var_1_10011
	var_8_5[var_1_10011.ACTIVITY_TYPE_7DAYSLOGIN] = function()
		arg_8_3.data1 = arg_8_3.data1 + 1

		local var_9_0 = arg_8_3

		pg = var_1

		local var_9_1 = var_1.TimeMgr.GetInstance()

		var_9_0.data2 = var_1.GetServerTime(var_9_1)

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_PROGRESSLOGIN] = function()
		if arg_8_1.cmd == 1 then
			arg_8_3.data1 = arg_8_3.data1 + 1

			local var_10_0 = arg_8_3

			pg = var_1

			local var_10_1 = var_1.TimeMgr.GetInstance()

			var_10_0.data2 = var_1.GetServerTime(var_10_1)
		elseif arg_8_1.cmd == 2 then
			arg_8_3.achieved = true
		end

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_LEVELAWARD] = function()
		table = var_2_10000

		var_2_10000.insert(arg_8_3.data1_list, arg_8_1.arg1)

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_STORY_AWARD] = function()
		table = var_2_10000

		var_2_10000.insert(arg_8_3.data1_list, arg_8_1.arg1)

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_LEVELPLAN] = function()
		if arg_8_1.cmd == 1 then
			arg_8_3.data1 = true
		elseif arg_8_1.cmd == 2 then
			table = var_0

			var_0.insert(arg_8_3.data1_list, arg_8_1.arg1)
		end

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_MONTHSIGN] = function()
		pg = var_2_10000

		local var_14_0 = var_2_10000.TimeMgr.GetInstance()
		local var_14_1 = var_0.GetServerTime(var_14_0)

		pg = var_14_0

		local var_14_2 = var_14_0.TimeMgr.GetInstance()
		local var_14_3 = var_1.STimeDescS(var_14_2, var_14_1, "*t")
		local var_14_4 = arg_8_3

		if var_2.getSpecialData(var_14_4, "reMonthSignDay") ~= nil then
			local var_14_5 = arg_8_3
			local var_14_6 = var_2.getSpecialData(var_14_5, "reMonthSignDay")
			local var_14_7 = day
			local var_14_8 = arg_8_3
			local var_14_9

			if not arg_8_3.data3 or not (arg_8_3.data3 + 1) then
				var_14_9 = 1
			end

			var_14_8.data3 = var_14_9
		else
			local var_14_10 = var_14_3.day
			local var_14_11 = day
		end

		local var_14_12 = arg_8_3
		local var_14_13 = var_2.setSpecialData

		MonthSignPage = var_4

		var_14_13(var_14_12, var_4.MILESTONE_SPECIAL_DATA, nil)

		table = var_14_13

		local var_14_14 = var_14_13.insert
		local var_14_15 = arg_8_3.data1_list

		day = var_4

		var_14_14(var_14_15, var_4)

		getProxy = var_14_14
		ActivityProxy = var_14_15

		local var_14_16 = var_14_14(var_14_15)
		local var_14_17 = var_2.getActivityByType

		ActivityConst = var_4

		local var_14_18

		if var_14_17(var_14_16, var_4.ACTIVITY_TYPE_LOGIN_RECORD) then
			var_14_18 = var_2

			if not var_2.isEnd(var_14_18) then
				var_2.data1 = var_2.data1 + 1
				var_2.data2 = var_2.data2 + 1
				math = var_14_16
				var_2.data3 = var_14_16.max(var_2.data3, var_2.data2)
				ipairs = var_14_16
				MonthSignPage = var_14_18

				for iter_14_0, iter_14_1 in var_14_16(var_14_18.MONTH_SIGN_SP_DAYS) do
					if iter_14_1 == var_2.data1 then
						local var_14_19 = arg_8_3
						local var_14_20 = var_8.setSpecialData

						MonthSignPage = var_2_10010

						var_14_20(var_14_19, var_2_10010.MILESTONE_SPECIAL_DATA, iter_14_1)
					end
				end

				getProxy = var_14_16
				ActivityProxy = var_14_18
				var_14_18 = var_14_16(var_14_18)

				var_14_16.updateActivity(var_14_18, var_2)
			end
		end

		getProxy = var_14_16
		ActivityProxy = var_14_18

		local var_14_21 = var_14_16(var_14_18)

		var_3.updateActivity(var_14_21, arg_8_3)

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_CHARGEAWARD] = function()
		arg_8_3.data2 = 1

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_BUILDSHIP_1] = function()
		pg = var_2_10000

		local var_16_0 = var_2_10000.TrackerMgr.GetInstance()
		local var_16_1 = var_0.Tracking

		TRACKING_BUILD_SHIP = var_2_10002

		var_16_1(var_16_0, var_2_10002, arg_8_1.arg1)

		pg = var_16_1

		local var_16_2 = var_16_1.ship_data_create_material[arg_8_1.buildId]

		if arg_8_1.arg2 == 1 then
			getProxy = var_1
			ActivityProxy = var_2_10002

			local var_16_3 = var_1(var_2_10002)

			var_2_10002.data1 = var_1.getBuildFreeActivityByBuildId(var_16_3, arg_8_1.buildId).data1 - arg_8_1.arg1

			var_1:updateActivity(var_2_10002)
		else
			getProxy = var_1
			BagProxy = var_2_10002
			var_2_10002 = var_1(var_2_10002)

			var_1.removeItemById(var_2_10002, var_16_2.use_item, var_16_2.number_1 * arg_8_1.arg1)

			var_2_10002 = var_8_2

			local var_16_4 = var_1.getData(var_2_10002)

			var_1.consume(var_16_4, {
				gold = var_16_2.use_gold * arg_8_1.arg1
			})

			local var_16_5 = var_8_2

			var_2_10002.updatePlayer(var_16_5, var_1)
		end

		getProxy = var_1
		BuildShipProxy = var_2_10002

		local var_16_6 = var_1(var_2_10002)

		if var_16_2.exchange_count > 0 then
			var_16_6:changeRegularExchangeCount(arg_8_1.arg1 * var_16_2.exchange_count)
		end

		ipairs = var_2

		for iter_16_0, iter_16_1 in var_2(arg_8_2.build) do
			BuildShip = var_2_10007
			var_2_10007 = var_2_10007.New(iter_16_1)

			var_16_6:addBuildShip(var_2_10007)
		end

		arg_8_3.data1 = arg_8_3.data1 + arg_8_1.arg1

		local var_16_7 = arg_8_0
		local var_16_8 = var_2.sendNotification

		GAME = var_4

		var_16_8(var_16_7, var_4.BUILD_SHIP_DONE)

		return
	end
	ActivityConst = var_11

	local var_8_6 = var_11.ACTIVITY_TYPE_BUILDSHIP_PRAY

	ActivityConst = var_12
	var_8_5[var_8_6] = var_12.ACTIVITY_TYPE_BUILDSHIP_1
	ActivityConst = var_8_6

	local var_8_7 = var_8_6.ACTIVITY_TYPE_NEWSERVER_BUILD

	ActivityConst = var_12
	var_8_5[var_8_7] = var_12.ACTIVITY_TYPE_BUILDSHIP_1
	ActivityConst = var_8_7
	var_8_5[var_8_7.ACTIVITY_TYPE_SHOP] = function()
		getProxy = var_2_10000
		ShopsProxy = var_2_10001

		local var_17_0 = var_2_10000(var_2_10001)
		local var_17_1 = var_0.getActivityShopById(var_17_0, arg_8_3.id)

		var_0:UpdateActivityGoods(arg_8_3.id, arg_8_1.arg1, arg_8_1.arg2)

		table = var_2

		if var_2.contains(arg_8_3.data1_list, arg_8_1.arg1) then
			ipairs = var_2

			for iter_17_0, iter_17_1 in var_2(arg_8_3.data1_list) do
				if iter_17_1 == arg_8_1.arg1 then
					arg_8_3.data2_list[iter_17_0] = arg_8_3.data2_list[iter_17_0] + arg_8_1.arg2

					break
				end
			end
		else
			table = var_2

			var_2.insert(arg_8_3.data1_list, arg_8_1.arg1)

			table = var_2

			var_2.insert(arg_8_3.data2_list, arg_8_1.arg2)
		end

		local var_17_2 = var_17_1:bindConfigTable()[arg_8_1.arg1].resource_num * arg_8_1.arg2
		local var_17_3 = var_8_2
		local var_17_4 = var_4.getData(var_17_3)
		local var_17_5 = var_4.consume
		local var_17_6 = {}

		id2res = var_2_10008
		var_17_6[var_2_10008(var_2.resource_type)] = var_17_2

		var_17_5(var_17_4, var_17_6)

		local var_17_7 = var_8_2

		var_5.updatePlayer(var_17_7, var_4)

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_TASK_LIST] = function()
		if arg_8_1.cmd == 1 then
			getActivityTask = var_0

			local var_18_0, var_18_1 = var_0(arg_8_3)

			if var_18_1 and not var_18_1:isReceive() then
				local var_18_2 = arg_8_3
				local var_18_3 = var_2.getConfig(var_18_2, "config_data")

				ipairs = var_18_2

				for iter_18_0, iter_18_1 in var_18_2(var_18_3) do
					_ = var_2_10008
					var_2_10008 = var_2_10008.flatten({
						iter_18_1
					})
					table = var_9

					if var_9.contains(var_2_10008, var_18_0) then
						arg_8_3.data3 = iter_18_0

						break
					end
				end
			end
		end

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_TASK_RES] = function()
		if arg_8_1.cmd == 1 then
			getActivityTask = var_0

			local var_19_0, var_19_1 = var_0(arg_8_3)

			if var_19_1 and not var_19_1:isReceive() then
				local var_19_2 = arg_8_3
				local var_19_3 = var_2.getConfig(var_19_2, "config_data")

				ipairs = var_19_2

				for iter_19_0, iter_19_1 in var_19_2(var_19_3) do
					_ = var_2_10008
					var_2_10008 = var_2_10008.flatten({
						iter_19_1
					})
					table = var_9

					if var_9.contains(var_2_10008, var_19_0) then
						arg_8_3.data3 = iter_19_0

						break
					end
				end
			end
		end

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_PUZZLA] = function()
		local var_20_0 = arg_8_1.cmd

		PuzzleActivity = var_2_10001

		if var_20_0 == var_2_10001.CMD_COMPLETE then
			var_20_0 = arg_8_3
			var_20_0.data1 = 1
		else
			var_20_0 = arg_8_1.cmd
			PuzzleActivity = var_1

			if var_20_0 == var_1.CMD_EARN_EXTRA then
				var_20_0 = arg_8_3
				var_20_0.data1 = 2
			else
				var_20_0 = arg_8_1.cmd
				PuzzleActivity = var_1

				if var_20_0 == var_1.CMD_ACTIVATE then
					table = var_20_0

					var_20_0.insert(arg_8_3.data2_list, arg_8_1.arg1)
				end
			end
		end

		getProxy = var_20_0
		ActivityProxy = var_1

		local var_20_1 = var_20_0(var_1)

		var_0.updateActivity(var_20_1, arg_8_3)

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_BB] = function()
		arg_8_3.data1 = arg_8_3.data1 + 1
		arg_8_3.data2 = arg_8_3.data2 - 1
		arg_8_3.data1_list = arg_8_2.number

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_LOTTERY] = function()
		if arg_8_1.cmd == 1 then
			ActivityItemPool = var_0

			local var_22_0 = var_0.New({
				id = arg_8_1.arg2
			})

			var_2_10001 = var_0.getComsume(var_22_0)

			local var_22_1 = arg_8_1.arg1 * var_2_10001.count
			local var_22_2 = var_2_10001.type

			DROP_TYPE_RESOURCE = var_2_10004

			if var_22_2 == var_2_10004 then
				var_2_10004 = var_8_2

				local var_22_3 = var_3.getData(var_2_10004)

				var_2_10004 = var_3.consume

				local var_22_4 = {}

				id2res = var_2_10007
				var_22_4[var_2_10007(var_2_10001.id)] = var_22_1

				var_2_10004(var_22_3, var_22_4)

				local var_22_5 = var_8_2

				var_2_10004.updatePlayer(var_22_5, var_3)
			else
				local var_22_6 = var_2_10001.type

				DROP_TYPE_ITEM = var_2_10004

				if var_22_6 == var_2_10004 then
					getProxy = var_22_6
					BagProxy = var_2_10004

					local var_22_7 = var_22_6(var_2_10004)

					var_3.removeItemById(var_22_7, var_2_10001.id, var_22_1)
				end
			end

			local var_22_8 = arg_8_3

			var_3.updateData(var_22_8, var_0.id, arg_8_2.number)
		elseif arg_8_1.cmd == 2 then
			arg_8_3.data1 = arg_8_1.arg1
		elseif arg_8_1.cmd == 3 then
			local var_22_9 = arg_8_3

			_ = var_2_10001
			var_22_9.data2_list = var_2_10001.map(arg_8_1.arg_list, function(arg_23_0)
				return arg_23_0
			end)
		end

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_CARD_PAIRS] = function()
		if arg_8_1.cmd == 1 then
			local var_24_0 = arg_8_3
			local var_24_1 = var_0.getConfig(var_24_0, "config_data")[4]

			if #arg_8_4 > 0 then
				arg_8_3.data2 = arg_8_3.data2 + 1

				if var_24_1 <= arg_8_3.data2 then
					arg_8_3.data1 = 1
				end
			end

			if arg_8_3.data4 == 0 then
				arg_8_3.data4 = arg_8_1.arg2
			elseif arg_8_1.arg2 < arg_8_3.data4 then
				arg_8_3.data4 = arg_8_1.arg2
			end
		end

		return
	end
	ActivityConst = var_11

	local var_8_8 = var_11.ACTIVITY_TYPE_LINK_LINK

	ActivityConst = var_12
	var_8_5[var_8_8] = var_12.ACTIVITY_TYPE_CARD_PAIRS
	ActivityConst = var_8_8
	var_8_5[var_8_8.ACTIVITY_TYPE_REFLUX] = function()
		if arg_8_1.cmd == 1 then
			local var_25_0 = arg_8_3.data1_list

			pg = var_2_10001

			local var_25_1 = var_2_10001.TimeMgr.GetInstance()

			var_25_0[1] = var_1.GetServerTime(var_25_1)
			arg_8_3.data1_list[2] = arg_8_3.data1_list[2] + 1
		elseif arg_8_1.cmd == 2 then
			arg_8_3.data4 = arg_8_1.arg1
		end

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_LOTTERY_AWARD] = function()
		if arg_8_1.cmd == 1 then
			arg_8_3.data1 = arg_8_3.data1 + 1
			arg_8_3.data2 = arg_8_2.number[1]
		elseif arg_8_1.cmd == 2 then
			table = var_0

			var_0.insert(arg_8_3.data1_list, arg_8_3.data1)
		end

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_DODGEM] = function()
		if arg_8_1.cmd == 1 then
			var_2_10001 = arg_8_0

			local var_27_0 = var_0.sendNotification

			GAME = var_2_10002

			local var_27_1 = var_2_10002.FINISH_STAGE_DONE
			local var_27_2 = {
				statistics = arg_8_1.statistics,
				score = arg_8_1.statistics._battleScore
			}

			SYSTEM_DODGEM = var_4
			var_27_2.system = var_4

			var_27_0(var_2_10001, var_27_1, var_27_2)

			local var_27_3 = arg_8_3.data1_list

			math = var_2_10001
			var_27_3[1] = var_2_10001.max(arg_8_3.data1_list[1], arg_8_1.arg2)
			arg_8_3.data2_list[1] = arg_8_2.number[1]
			arg_8_3.data2_list[2] = arg_8_2.number[2]
		elseif arg_8_1.cmd == 2 then
			arg_8_3.data2 = arg_8_2.number[1]
			arg_8_3.data3 = arg_8_2.number[2]
			arg_8_3.data2_list[1] = 0
			arg_8_3.data2_list[2] = 0
		elseif arg_8_1.cmd == 3 then
			local var_27_4 = arg_8_3

			defaultValue = var_2_10001
			var_27_4.data4 = var_2_10001(arg_8_3.data4, 0) + 1
		end

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_SUBMARINE_RUN] = function()
		if arg_8_1.cmd == 1 then
			var_2_10001 = arg_8_0

			local var_28_0 = var_0.sendNotification

			GAME = var_2_10002

			local var_28_1 = var_2_10002.FINISH_STAGE_DONE
			local var_28_2 = {
				statistics = arg_8_1.statistics,
				score = arg_8_1.statistics._battleScore
			}

			SYSTEM_SUBMARINE_RUN = var_4
			var_28_2.system = var_4

			var_28_0(var_2_10001, var_28_1, var_28_2)

			local var_28_3 = arg_8_3.data1_list

			math = var_2_10001
			var_28_3[1] = var_2_10001.max(arg_8_3.data1_list[1], arg_8_1.arg2)
			arg_8_3.data2_list[1] = arg_8_2.number[1]
			arg_8_3.data2_list[2] = arg_8_2.number[2]
		elseif arg_8_1.cmd == 2 then
			arg_8_3.data2 = arg_8_2.number[1]
			arg_8_3.data3 = arg_8_2.number[2]
			arg_8_3.data2_list[1] = 0
			arg_8_3.data2_list[2] = 0
		elseif arg_8_1.cmd == 3 then
			local var_28_4 = arg_8_3

			defaultValue = var_2_10001
			var_28_4.data4 = var_2_10001(arg_8_3.data4, 0) + 1
		end

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_TURNTABLE] = function()
		if arg_8_1.cmd == 2 then
			arg_8_3.data4 = 0
		elseif arg_8_1.cmd == 1 then
			local var_29_0 = arg_8_3
			local var_29_1 = var_0.getConfig(var_29_0, "config_id")

			pg = var_29_0

			local var_29_2 = var_29_0.activity_event_turning[var_29_1].total_num

			if arg_8_3.data3 == var_29_2 then
				arg_8_3.data2 = 1
				arg_8_3.data3 = arg_8_3.data3 + 1
			else
				arg_8_3.data3 = arg_8_3.data3 + 1
				arg_8_3.data4 = arg_8_2.number[1]
				arg_8_3.data1_list[arg_8_1.arg1] = arg_8_3.data4
			end
		end

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_SHRINE] = function()
		arg_8_3.data1 = 1

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_RED_PACKETS] = function()
		arg_8_3.data1 = arg_8_3.data1 - 1

		if arg_8_3.data2 > 0 then
			arg_8_3.data2 = arg_8_3.data2 - 1
		end

		local var_31_0 = arg_8_3.data1_list

		var_31_0[2] = arg_8_3.data1_list[2] + 1
		getProxy = var_31_0
		ActivityProxy = var_1

		local var_31_1 = var_31_0(var_1)
		local var_31_2 = var_0.getActivityByType

		ActivityConst = var_2_10003

		if var_31_2(var_31_1, var_2_10003.ACTIVITY_TYPE_MONOPOLY) and not var_1:isEnd() and var_1.data2_list[1] > var_1.data2_list[2] then
			var_1.data2_list[2] = var_1.data2_list[2] + 1

			var_0:updateActivity(var_1)
		end

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_RED_PACKET_LOTTER] = function()
		local var_32_0 = arg_8_3

		var_32_0.data1 = arg_8_3.data1 + 1
		table = var_32_0

		if not var_32_0.contains(arg_8_3.data2_list, arg_8_1.arg1) then
			table = var_0

			var_0.insert(arg_8_3.data2_list, arg_8_1.arg1)
		end

		table = var_0

		if not var_0.contains(arg_8_3.data1_list, arg_8_2.number[1]) then
			table = var_0

			var_0.insert(arg_8_3.data1_list, arg_8_2.number[1])
		end

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_BUILDING_BUFF] = function()
		if arg_8_1.cmd == 1 then
			pg = var_0

			local var_33_0 = var_0.activity_event_building[arg_8_1.arg1]
			local var_33_1 = arg_8_3

			var_2_10001 = var_2_10001.GetBuildingLevel(var_33_1, arg_8_1.arg1)

			local var_33_2 = arg_8_3

			var_2.SetBuildingLevel(var_33_2, arg_8_1.arg1, var_2_10001 + 1)

			if var_2_10001 < #var_33_0.buff then
				_ = var_2

				var_2.each(var_33_0.material[var_2_10001], function(arg_34_0)
					local var_34_0 = arg_34_0[1]
					local var_34_1 = arg_34_0[2]
					local var_34_2 = arg_34_0[3]
					local var_34_3

					DROP_TYPE_VITEM = var_3_10005

					if var_34_0 == var_3_10005 then
						AcessWithinNull = var_3_10005
						Item = var_3_10006
						var_3_10005 = var_3_10005(var_3_10006.getConfigData(var_34_1), "link_id")
						assert = var_3_10006

						var_3_10006(var_3_10005 == arg_8_3.id)

						var_34_3 = arg_8_3
					else
						DROP_TYPE_USE_ACTIVITY_DROP = var_3_10005

						if var_3_10005 < var_34_0 then
							AcessWithinNull = var_3_10005
							pg = var_3_10006

							local var_34_4 = var_3_10005(var_3_10006.activity_drop_type[var_34_0], "activity_id")

							getProxy = var_3_10006
							ActivityProxy = var_7

							local var_34_5 = var_3_10006(var_7)

							var_34_3 = var_3_10006.getActivityById(var_34_5, var_34_4)
						end
					end

					local var_34_6

					if not var_34_3.data1KeyValueList[1][var_34_1] then
						var_34_6 = 0
					end

					math = var_3_10006

					local var_34_7

					var_34_7[var_34_1], var_34_7 = var_3_10006.max(0, var_34_6 - var_34_2), var_34_3.data1KeyValueList[1]
					DROP_TYPE_USE_ACTIVITY_DROP = var_34_7

					if var_34_7 < var_34_0 then
						getProxy = var_34_7
						ActivityProxy = var_8

						local var_34_8 = var_34_7(var_8)

						var_7.updateActivity(var_34_8, var_34_3)
					end

					return
				end)
			end
		elseif arg_8_1.cmd == 2 then
			local var_33_3 = var_8_1

			ActivityConst = var_2_10001

			if var_33_3 == var_2_10001.ACTIVITY_TYPE_BUILDING_BUFF_2 then
				local var_33_4 = arg_8_3

				var_0.RecordLastRequestTime(var_33_4)
			end
		end

		return
	end
	ActivityConst = var_11

	local var_8_9 = var_11.ACTIVITY_TYPE_BUILDING_BUFF_2

	ActivityConst = var_12
	var_8_5[var_8_9] = var_12.ACTIVITY_TYPE_BUILDING_BUFF
	ActivityConst = var_8_9
	var_8_5[var_8_9.ACTIVITY_TYPE_BOSSSINGLE] = function()
		if arg_8_1.cmd == 2 then
			table = var_0

			var_0.insert(arg_8_3.data2_list, arg_8_1.arg1)

			local var_35_0 = arg_8_0
			local var_35_1 = var_0.sendNotification

			GAME = var_2

			local var_35_2 = var_2.FINISH_STAGE_DONE
			local var_35_3 = {
				statistics = arg_8_1.statistics,
				score = arg_8_1.statistics._battleScore
			}

			SYSTEM_REWARD_PERFORM = var_4
			var_35_3.system = var_4

			var_35_1(var_35_0, var_35_2, var_35_3)

			return arg_8_3
		end

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_EXPEDITION] = function()
		if arg_8_1.cmd == 0 then
			return arg_8_3
		end

		if arg_8_1.cmd == 3 then
			local var_36_0 = arg_8_0
			local var_36_1 = var_0.sendNotification

			GAME = var_2_10002

			local var_36_2 = var_2_10002.FINISH_STAGE_DONE
			local var_36_3 = {
				statistics = arg_8_1.statistics,
				score = arg_8_1.statistics._battleScore
			}

			SYSTEM_REWARD_PERFORM = var_4
			var_36_3.system = var_4

			var_36_1(var_36_0, var_36_2, var_36_3)

			return arg_8_3
		end

		if arg_8_1.cmd == 4 then
			arg_8_3.data2_list[1] = arg_8_3.data2_list[1] + 1

			return arg_8_3
		end

		if arg_8_1.cmd == 1 then
			arg_8_3.data3 = arg_8_3.data3 - 1
		end

		local var_36_4 = arg_8_1.arg1

		if arg_8_1.cmd ~= 2 then
			arg_8_3.data2 = var_36_4
		end

		local var_36_5

		var_36_5[var_36_4], var_36_5 = arg_8_2.number[1], arg_8_3.data1_list
		print = var_36_5

		var_36_5("格子:" .. var_36_4 .. " 值:" .. arg_8_2.number[1])

		if arg_8_2.number[2] and arg_8_3.data1 ~= arg_8_2.number[2] then
			print = var_2

			var_2("关卡变更" .. arg_8_2.number[2])

			arg_8_3.data1 = arg_8_3.data1 + 1
			arg_8_3.data2 = 0

			for iter_36_0 = 1, #arg_8_3.data1_list do
				arg_8_3.data1_list[iter_36_0] = 0
			end
		end

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_AIRFIGHT_BATTLE] = function()
		if arg_8_1.cmd == 1 then
			local var_37_0 = arg_8_0
			local var_37_1 = var_0.sendNotification

			GAME = var_2_10002

			local var_37_2 = var_2_10002.FINISH_STAGE_DONE
			local var_37_3 = {
				statistics = arg_8_1.statistics,
				score = arg_8_1.statistics._battleScore
			}

			SYSTEM_AIRFIGHT = var_4
			var_37_3.system = var_4

			var_37_1(var_37_0, var_37_2, var_37_3)

			local var_37_4 = arg_8_3.data1KeyValueList
			local var_37_5

			if not arg_8_3.data1KeyValueList[1] then
				var_37_5 = {}
			end

			var_37_4[1] = var_37_5

			local var_37_6 = arg_8_3.data1KeyValueList[1]
			local var_37_7 = arg_8_1.arg1
			local var_37_8

			if not arg_8_3.data1KeyValueList[1][arg_8_1.arg1] then
				var_37_8 = 0
			end

			var_37_6[var_37_7] = var_37_8 + 1
		elseif arg_8_1.cmd == 2 then
			local var_37_9 = arg_8_3.data1KeyValueList
			local var_37_10

			if not arg_8_3.data1KeyValueList[2] then
				var_37_10 = {}
			end

			var_37_9[2] = var_37_10
			arg_8_3.data1KeyValueList[2][arg_8_1.arg1] = 1
		end

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_SHAKE_BEADS] = function()
		if arg_8_1.cmd == 1 then
			arg_8_3.data1 = arg_8_3.data1 - 1

			local var_38_0 = arg_8_2.number[1]

			arg_8_3.data1KeyValueList[1][var_38_0] = arg_8_3.data1KeyValueList[1][var_38_0] + 1
		elseif arg_8_1.cmd == 2 then
			arg_8_3.data2 = 1
		end

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_PT_OTHER] = function()
		if arg_8_1.cmd == 1 then
			arg_8_3.data2 = 1
		end

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_HOTSPRING] = function()
		local var_40_0 = arg_8_1.cmd

		SpringActivity = var_2_10001

		local var_40_1

		if var_40_0 == var_2_10001.OPERATION_UNLOCK then
			var_40_1 = arg_8_3

			var_0.AddSlotCount(var_40_1)
		else
			local var_40_2 = arg_8_1.cmd

			SpringActivity = var_40_1

			if var_40_2 == var_40_1.OPERATION_SETSHIP then
				local var_40_3 = arg_8_3

				var_0.SetShipIds(var_40_3, arg_8_1.kvargs1)
			end
		end

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_HOTSPRING_2] = function()
		local var_41_0 = arg_8_1.cmd

		Spring2Activity = var_2_10001

		if var_41_0 == var_2_10001.OPERATION_SETSHIP then
			local var_41_1 = arg_8_3

			var_0.SetShipIds(var_41_1, arg_8_1.kvargs1)
		end

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_FIREWORK] = function()
		if arg_8_1.cmd == 1 then
			local var_42_0 = arg_8_3

			var_42_0.data1 = arg_8_3.data1 - 1
			table = var_42_0

			if not var_42_0.contains(arg_8_3.data1_list, arg_8_1.arg1) then
				table = var_0

				var_0.insert(arg_8_3.data1_list, arg_8_1.arg1)
			end

			Item = var_0

			local var_42_1 = var_0.getConfigData(arg_8_1.arg1).link_id

			if 0 < var_42_1 then
				getProxy = var_1
				ActivityProxy = var_2

				local var_42_2 = var_1(var_2)

				if var_1.getActivityById(var_42_2, var_42_1) and not var_2:isEnd() then
					var_2.data1 = var_2.data1 + 1

					var_1:updateActivity(var_2)
				end
			end

			getProxy = var_1
			PlayerProxy = var_2

			local var_42_3 = var_1(var_2)
			local var_42_4 = var_1.getRawData(var_42_3)
			local var_42_5 = arg_8_3
			local var_42_6 = var_3.getConfig(var_42_5, "config_data")[2][1]
			local var_42_7 = arg_8_3
			local var_42_8 = var_4.getConfig(var_42_7, "config_data")[2][2]
			local var_42_9 = var_42_4
			local var_42_10 = var_42_4.consume
			local var_42_11 = {}

			id2res = var_2_10008
			var_42_11[var_2_10008(var_42_6)] = var_42_8

			var_42_10(var_42_9, var_42_11)
			var_1:updatePlayer(var_42_4)
		end

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_CARD_PUZZLE] = function()
		table = var_2_10000

		if not var_2_10000.contains(arg_8_3.data1_list, arg_8_1.arg1) then
			table = var_0

			var_0.insert(arg_8_3.data1_list, arg_8_1.arg1)
		end

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_ZUMA] = function()
		local var_44_0

		if arg_8_1.cmd == 1 then
			var_44_0 = arg_8_1.arg1
			LaunchBallGameConst = var_2_10001

			if var_44_0 == var_2_10001.round_type_juqing then
				var_44_0 = arg_8_3
				var_44_0.data1 = arg_8_3.data1 + 1
			elseif arg_8_1.arg1 == 2 then
				if not arg_8_3.data1_list then
					var_44_0 = arg_8_3
					var_44_0.data1_list = {}
				end

				table = var_44_0

				var_44_0.insert(arg_8_3.data1_list, arg_8_1.arg2)
			elseif arg_8_1.arg1 == 3 then
				var_44_0 = arg_8_3
				var_44_0.data2 = arg_8_1.arg2
			end
		elseif arg_8_1.cmd == 2 then
			var_44_0 = arg_8_3
			var_44_0.data3 = 1
		end

		getProxy = var_44_0
		ActivityProxy = var_2_10001

		local var_44_1 = var_44_0(var_2_10001)

		var_0.updateActivity(var_44_1, arg_8_3)

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_PUZZLE_CONNECT] = function()
		getProxy = var_2_10000
		ActivityProxy = var_2_10001

		local var_45_0 = var_2_10000(var_2_10001)
		local var_45_1 = arg_8_3.data1_list
		local var_45_2 = arg_8_3.data2_list
		local var_45_3 = arg_8_3.data3_list

		if arg_8_1.cmd == 1 then
			pg = var_4

			local var_45_4 = var_4.activity_tolove_jigsaw[arg_8_1.arg1].need[2]

			pg = var_5

			local var_45_5 = var_5.player_resource[var_45_4].name

			pg = var_2_10006

			local var_45_6 = var_2_10006.activity_tolove_jigsaw[arg_8_1.arg1].need[3]
			local var_45_7 = var_8_2
			local var_45_8 = var_7.getData(var_45_7)

			var_7.consume(var_45_8, {
				[var_45_5] = var_45_6
			})

			local var_45_9 = var_8_2

			var_8.updatePlayer(var_45_9, var_7)

			table = var_8

			var_8.insert(var_45_1, arg_8_1.arg1)
		elseif arg_8_1.cmd == 2 then
			table = var_4

			var_4.insert(var_45_2, arg_8_1.arg1)
		elseif arg_8_1.cmd == 3 then
			table = var_4

			var_4.insert(var_45_3, arg_8_1.arg1)
		end

		var_45_0:updateActivity(arg_8_3)

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_SKIN_COUPON_COUNTING] = function()
		getProxy = var_2_10000
		ActivityProxy = var_2_10001

		local var_46_0 = var_2_10000(var_2_10001)

		arg_8_3.data2 = arg_8_3.data2 + arg_8_3.data1
		arg_8_3.data1 = 0

		var_46_0:updateActivity(arg_8_3)

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_FRESH_TEC_CATCHUP] = function()
		local var_47_0

		if arg_8_1.cmd == 1 then
			table = var_47_0

			if not var_47_0.contains(arg_8_3.data1_list, arg_8_3.data1) then
				table = var_47_0

				var_47_0.insert(arg_8_3.data1_list, arg_8_3.data1)
			end

			var_47_0 = arg_8_3
			var_47_0.data1 = arg_8_1.arg1
		elseif arg_8_1.cmd == 2 then
			-- block empty
		elseif arg_8_1.cmd == 3 then
			table = var_47_0

			if not var_47_0.contains(arg_8_3.data1_list, arg_8_3.data1) then
				table = var_47_0

				var_47_0.insert(arg_8_3.data1_list, arg_8_3.data1)
			end

			var_47_0 = arg_8_3
			var_47_0.data1 = 1
			var_47_0 = arg_8_3
			var_47_0.data2 = 1
			getProxy = var_47_0
			TaskProxy = var_2_10001
			var_2_10001 = var_47_0(var_2_10001)
			var_47_0 = var_47_0.removeFinishTaskById

			local var_47_1 = arg_8_3

			var_47_0(var_2_10001, var_2.getConfig(var_47_1, "config_data")[3][1][2])
		else
			assert = var_47_0

			var_47_0(false)
		end

		getProxy = var_47_0
		ActivityProxy = var_2_10001

		local var_47_2 = var_47_0(var_2_10001)

		var_0.updateActivity(var_47_2, arg_8_3)

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_HOLIDAY_VILLA] = function()
		if arg_8_1.cmd == 1 then
			arg_8_3.data1 = 1

			local var_48_0 = arg_8_3

			var_0.setVitemNumber(var_48_0, 66001, 0)

			local var_48_1 = arg_8_3

			var_0.setVitemNumber(var_48_1, 66002, 0)

			local var_48_2 = arg_8_3

			var_0.setVitemNumber(var_48_2, 66003, 0)

			local var_48_3 = arg_8_3

			var_0.setVitemNumber(var_48_3, 66004, 0)

			local var_48_4 = arg_8_3

			var_0.addVitemNumber(var_48_4, 66005, arg_8_2.number[1])

			getProxy = var_0
			ActivityProxy = var_48_4

			local var_48_5 = var_0(var_48_4)

			var_0.updateActivity(var_48_5, arg_8_3)

			local var_48_6 = arg_8_0
			local var_48_7 = var_0.sendNotification

			ActivityProxy = var_2

			var_48_7(var_48_6, var_2.ACTIVITY_EXCHANGE_RESOURCES, arg_8_1.activity_id)
		elseif arg_8_1.cmd == 2 then
			local var_48_8 = arg_8_3

			var_0.updateDataList(var_48_8, arg_8_1.arg1)

			getProxy = var_0
			ActivityProxy = var_48_8

			local var_48_9 = var_0(var_48_8)

			var_0.updateActivity(var_48_9, arg_8_3)
		end

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_STRONGHOLD] = function()
		if arg_8_1.cmd == 1 then
			local var_49_0 = arg_8_3

			var_0.updateDataList(var_49_0, arg_8_1.arg1)

			getProxy = var_0
			ActivityProxy = var_49_0

			local var_49_1 = var_0(var_49_0)
			local var_49_2 = var_0.getActivityByType

			ActivityConst = var_2

			local var_49_3 = var_49_2(var_49_1, var_2.ACTIVITY_TYPE_ATELIER_LINK)

			ipairs = var_49_1

			for iter_49_0, iter_49_1 in var_49_1(arg_8_1.consumes) do
				local var_49_4 = iter_49_1[2]
				local var_49_5 = iter_49_1[3]

				if var_49_4 == 6 then
					local var_49_6 = var_8_2
					local var_49_7 = var_8.getData(var_49_6)
					local var_49_8 = var_8.consume
					local var_49_9 = {}

					id2res = var_2_10012
					var_49_9[var_2_10012(var_49_4)] = var_49_5

					var_49_8(var_49_7, var_49_9)

					local var_49_10 = var_8_2

					var_9.updatePlayer(var_49_10, var_8)
				else
					var_49_3:subItemCount(var_49_4, var_49_5)
				end
			end
		elseif arg_8_1.cmd == 2 then
			local var_49_11 = arg_8_3

			var_0.updateKVPList(var_49_11, 1, arg_8_1.arg1, arg_8_1.canGetIndex)
		end

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_SKIN_FAKE_PACKAGE] = function()
		assert = var_2_10000

		var_2_10000(arg_8_3.data1 == 0)

		local var_50_0 = arg_8_3

		var_50_0.data1 = 1
		reducePlayerOwn = var_50_0

		var_50_0(arg_8_1.costDrop)

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_TIMES_FAKE_PACKAGE] = function()
		local var_51_0 = arg_8_3

		var_51_0.data1 = arg_8_3.data1 + 1
		reducePlayerOwn = var_51_0

		var_51_0(arg_8_1.costDrop)

		return
	end
	ActivityConst = var_11
	var_8_5[var_11.ACTIVITY_TYPE_LOVE_LETTER_UP] = function()
		local var_52_0 = arg_8_3

		var_0.SetTargetGroupId(var_52_0, arg_8_1.arg1)

		local var_52_1 = arg_8_3

		var_0.AddChangeCount(var_52_1)

		return
	end

	var_1_10008(var_8_4, var_8_5)

	return arg_8_3
end

function var_0_1.performance(arg_53_0, arg_53_1, arg_53_2, arg_53_3, arg_53_4)
	local var_53_0 = arg_53_3:getConfig("type")
	local var_53_1

	local function var_53_2()
		if var_53_1 then
			coroutine = var_0

			if var_0.status(var_53_1) == "suspended" then
				coroutine = var_0

				local var_54_0, var_54_1 = var_0.resume(var_53_1)

				assert = var_2_10002

				var_2_10002(var_54_0, var_54_1)
			end
		end

		return
	end

	coroutine = var_1_10008
	var_53_1 = var_1_10008.create(function()
		switch = var_2_10000

		local var_55_0 = var_53_0
		local var_55_1 = {}

		ActivityConst = var_2_10003
		var_55_1[var_2_10003.ACTIVITY_TYPE_7DAYSLOGIN] = function()
			local var_56_0 = arg_53_3

			if var_0.getConfig(var_56_0, "config_client").story and var_0[arg_53_3.data1] and var_0[arg_53_3.data1][1] then
				pg = var_1

				local var_56_1 = var_1.NewStoryMgr.GetInstance()

				var_1.Play(var_56_1, var_0[arg_53_3.data1][1], var_53_2)

				coroutine = var_1

				var_1.yield()
			end

			return
		end
		ActivityConst = var_3
		var_55_1[var_3.ACTIVITY_TYPE_BB] = function()
			pg = var_3_10000

			if var_3_10000.gameset.bobing_memory.description[arg_53_3.data1] and #var_0 > 0 then
				pg = var_1

				local var_57_0 = var_1.NewStoryMgr.GetInstance()

				var_1.Play(var_57_0, var_0, var_53_2)

				coroutine = var_1

				var_1.yield()
			end

			local var_57_1 = arg_53_0
			local var_57_2 = var_1.sendNotification

			ActivityProxy = var_3_10003

			var_57_2(var_57_1, var_3_10003.ACTIVITY_SHOW_BB_RESULT, {
				numbers = arg_53_2.number,
				callback = var_53_2,
				awards = arg_53_4
			})

			coroutine = var_57_2

			var_57_2.yield()

			return
		end
		ActivityConst = var_3
		var_55_1[var_3.ACTIVITY_TYPE_LOTTERY_AWARD] = function()
			if arg_53_1.cmd == 1 then
				local var_58_0 = arg_53_3

				if var_0.getConfig(var_58_0, "config_client").story and var_0[arg_53_3.data1] and var_0[arg_53_3.data1][1] then
					pg = var_1

					local var_58_1 = var_1.NewStoryMgr.GetInstance()

					var_1.Play(var_58_1, var_0[arg_53_3.data1][1], var_53_2)

					coroutine = var_1

					var_1.yield()
				end

				local var_58_2 = arg_53_0
				local var_58_3 = var_1.sendNotification

				ActivityProxy = var_3_10003

				var_58_3(var_58_2, var_3_10003.ACTIVITY_SHOW_LOTTERY_AWARD_RESULT, {
					activityID = arg_53_3.id,
					awards = arg_53_4,
					number = arg_53_2.number[1],
					callback = var_53_2
				})

				arg_53_4 = {}
				coroutine = var_1

				var_1.yield()
			end

			return
		end
		ActivityConst = var_3
		var_55_1[var_3.ACTIVITY_TYPE_CARD_PAIRS] = function()
			local var_59_0 = arg_53_3

			if var_0.getConfig(var_59_0, "config_client")[1] then
				local var_59_1 = arg_53_3

				if var_0.getConfig(var_59_1, "config_client")[1][arg_53_3.data2 + 1] then
					pg = var_1

					local var_59_2 = var_1.NewStoryMgr.GetInstance()

					var_1.Play(var_59_2, var_0, var_53_2)

					coroutine = var_1

					var_1.yield()
				end
			end

			return
		end
		ActivityConst = var_3
		var_55_1[var_3.ACTIVITY_TYPE_LINK_LINK] = function()
			local var_60_0 = arg_53_3

			if var_0.getConfig(var_60_0, "config_client")[1] then
				local var_60_1 = arg_53_3

				if var_0.getConfig(var_60_1, "config_client")[1][arg_53_3.data2 + 1] then
					pg = var_1

					local var_60_2 = var_1.NewStoryMgr.GetInstance()

					var_1.Play(var_60_2, var_0, var_53_2)

					coroutine = var_1

					var_1.yield()
				end
			end

			return
		end
		ActivityConst = var_3
		var_55_1[var_3.ACTIVITY_TYPE_DODGEM] = function()
			if arg_53_1.cmd == 2 and arg_53_2.number[3] > 0 then
				local var_61_0 = arg_53_3
				local var_61_1 = var_0.getConfig(var_61_0, "config_client")[1]
				local var_61_2 = {
					type = var_61_1[1],
					id = var_61_1[2],
					count = var_61_1[3]
				}

				table = var_2

				var_2.insert(arg_53_4, var_61_2)
			end

			return
		end
		ActivityConst = var_3
		var_55_1[var_3.ACTIVITY_TYPE_SUBMARINE_RUN] = function()
			if arg_53_1.cmd == 2 and arg_53_2.number[3] > 0 then
				local var_62_0 = arg_53_3
				local var_62_1 = var_0.getConfig(var_62_0, "config_client")[1]
				local var_62_2 = {
					type = var_62_1[1],
					id = var_62_1[2],
					count = var_62_1[3]
				}

				table = var_2

				var_2.insert(arg_53_4, var_62_2)
			end

			return
		end
		ActivityConst = var_3
		var_55_1[var_3.ACTIVITY_TYPE_BUILDING_BUFF] = function()
			if arg_53_1.cmd == 1 then
				pg = var_0

				local var_63_0 = var_0.TipsMgr.GetInstance()
				local var_63_1 = var_0.ShowTips

				i18n = var_3_10002

				var_63_1(var_63_0, var_3_10002("building_complete_tip"))
			end

			return
		end
		ActivityConst = var_3
		var_55_1[var_3.ACTIVITY_TYPE_BUILDING_BUFF_2] = function()
			if arg_53_1.cmd == 1 then
				pg = var_0

				local var_64_0 = var_0.TipsMgr.GetInstance()
				local var_64_1 = var_0.ShowTips

				i18n = var_3_10002

				var_64_1(var_64_0, var_3_10002("building_complete_tip"))
			end

			return
		end
		ActivityConst = var_3
		var_55_1[var_3.ACTIVITY_TYPE_MONTHSIGN] = function()
			if arg_53_1.cmd == 3 then
				local var_65_0 = arg_53_3
				local var_65_1

				if not var_0.getSpecialData(var_65_0, "month_sign_awards") then
					var_65_1 = {}
				end

				for iter_65_0 = 1, #arg_53_4 do
					table = var_3_10005

					var_3_10005.insert(var_65_1, arg_53_4[iter_65_0])
				end

				local var_65_2 = arg_53_3

				var_1.setSpecialData(var_65_2, "month_sign_awards", var_65_1)

				arg_53_4 = {}
			end

			return
		end
		ActivityConst = var_3
		var_55_1[var_3.ACTIVITY_TYPE_SHAKE_BEADS] = function()
			if arg_53_1.cmd == 1 then
				local var_66_0 = arg_53_0
				local var_66_1 = var_0.sendNotification

				ActivityProxy = var_3_10002

				var_66_1(var_66_0, var_3_10002.ACTIVITY_SHOW_SHAKE_BEADS_RESULT, {
					number = arg_53_2.number[1],
					callback = var_53_2,
					awards = arg_53_4
				})

				coroutine = var_66_1

				var_66_1.yield()
			end

			return
		end
		ActivityConst = var_3
		var_55_1[var_3.ACTIVITY_TYPE_APRIL_REWARD] = function()
			if arg_53_1.cmd == 1 then
				arg_53_3.data1 = arg_53_1.arg1
			elseif arg_53_1.cmd == 2 then
				arg_53_3.data2 = 1
			end

			return
		end
		ActivityConst = var_3
		var_55_1[var_3.ACTIVITY_TYPE_FIREWORK] = function()
			pg = var_3_10000

			local var_68_0 = var_3_10000.TipsMgr.GetInstance()
			local var_68_1 = var_0.ShowTips

			i18n = var_3_10002

			var_68_1(var_68_0, var_3_10002("activity_yanhua_tip8"))

			local var_68_2 = arg_53_3
			local var_68_3 = #var_0.getData1List(var_68_2)
			local var_68_4 = arg_53_3

			if var_1.getConfig(var_68_4, "config_client").story then
				type = var_68_4

				if var_68_4(var_1) == "table" then
					ipairs = var_68_4

					for iter_68_0, iter_68_1 in var_68_4(var_1) do
						if var_68_3 == iter_68_1[1] then
							pg = var_7

							local var_68_5 = var_7.NewStoryMgr.GetInstance()

							var_7.Play(var_68_5, iter_68_1[2], var_53_2)

							coroutine = var_7

							var_7.yield()
						end
					end
				end
			end

			getProxy = var_68_4
			ActivityProxy = var_3

			local var_68_6 = var_68_4(var_3)

			var_2.updateActivity(var_68_6, arg_53_3)

			local var_68_7 = arg_53_3

			if var_3.getConfig(var_68_7, "config_client").ActID and var_2:getActivityById(var_3) then
				var_2:updateActivity(var_4)
			end

			return
		end
		ActivityConst = var_3
		var_55_1[var_3.ACTIVITY_TYPE_SKIN_FAKE_PACKAGE] = function()
			getProxy = var_3_10000
			ActivityProxy = var_3_10001

			local var_69_0 = var_3_10000(var_3_10001)

			var_0.updateActivity(var_69_0, arg_53_3)

			local var_69_1 = arg_53_0
			local var_69_2 = var_0.sendNotification

			NewShopMainMediator = var_2

			var_69_2(var_69_1, var_2.NOTI_UPDATE_CURRENT)

			return
		end
		ActivityConst = var_3
		var_55_1[var_3.ACTIVITY_TYPE_TIMES_FAKE_PACKAGE] = function()
			getProxy = var_3_10000
			ActivityProxy = var_3_10001

			local var_70_0 = var_3_10000(var_3_10001)

			var_0.updateActivity(var_70_0, arg_53_3)

			local var_70_1 = arg_53_0
			local var_70_2 = var_0.sendNotification

			NewShopMainMediator = var_2

			var_70_2(var_70_1, var_2.NOTI_UPDATE_CURRENT)

			return
		end

		var_2_10000(var_55_0, var_55_1)

		local var_55_2 = #arg_53_4
		local var_55_3

		if 0 < var_55_2 then
			var_55_3 = arg_53_0

			local var_55_4 = var_0.sendNotification
			local var_55_5 = arg_53_3

			var_55_4(var_55_3, var_55_1.getNotificationMsg(var_55_5), {
				activityId = arg_53_1.activity_id,
				awards = arg_53_4,
				callback = var_53_2
			})

			coroutine = var_55_4

			var_55_4.yield()
		end

		local var_55_6

		if var_53_0 == 17 and arg_53_1.cmd and arg_53_1.cmd == 2 then
			pg = var_55_6
			var_55_3 = var_55_6.TipsMgr.GetInstance()
			var_55_6 = var_55_6.ShowTips
			i18n = var_55_1

			var_55_6(var_55_3, var_55_1("mingshi_get_tip"))
		end

		getProxy = var_55_6
		ActivityProxy = var_55_3

		local var_55_7 = var_55_6(var_55_3)

		var_0.updateActivity(var_55_7, arg_53_3)

		local var_55_8 = arg_53_0
		local var_55_9 = var_0.sendNotification

		ActivityProxy = var_2

		var_55_9(var_55_8, var_2.ACTIVITY_OPERATION_DONE, arg_53_1.activity_id)

		existCall = var_55_9

		var_55_9(arg_53_1.callback)

		return
	end)

	var_53_2()

	return
end

return var_0_1
