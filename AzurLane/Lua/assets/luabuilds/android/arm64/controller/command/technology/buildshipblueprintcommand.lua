class = var_0_10000

local var_0_0 = "BuildShipBluePrintCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.hideTip

	getProxy = var_1_10005
	TechnologyProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)
	local var_1_3 = var_5.getBluePrintById(var_1_2, var_1_0)
	local var_1_4, var_1_5 = var_6.isFinishPrevTask(var_1_3)

	if not var_1_5 then
		pg = var_1_3

		local var_1_6 = var_1_3.TipsMgr.GetInstance()

		var_9.ShowTips(var_1_6, "without finish pre task")

		return
	end

	local var_1_7 = var_5:getColdTime()

	pg = var_1_10010

	local var_1_8 = var_1_10010.TimeMgr.GetInstance()

	if var_10.GetServerTime(var_1_8) < var_1_7 then
		local var_1_9 = var_1_7 - var_10 < 0 and 0 or var_1_9

		math = var_12

		local var_1_10 = var_12.floor(var_1_9 / 0)

		var_1_10013 = nil

		local var_1_11

		if 0 < var_1_10 then
			i18n = var_1_11
			var_1_11 = var_1_11("time_remaining_tip")

			local var_1_12 = var_1_10

			i18n = var_16
			var_1_10013 = var_1_11 .. var_1_12 .. var_16("word_date")
		else
			math = var_1_11
			var_1_11 = var_1_11.floor(var_1_9 / 16)

			local var_1_13

			if 0 < var_1_11 then
				i18n = var_1_13
				var_1_13 = var_1_13("time_remaining_tip")

				local var_1_14 = var_1_11

				i18n = var_1_10017
				var_1_10013 = var_1_13 .. var_1_14 .. var_1_10017("word_hour")
			else
				math = var_1_13

				local var_1_15 = var_1_13.floor(var_1_9 / 60)
				local var_1_16

				if 0 < var_1_15 then
					i18n = var_1_16
					var_1_16 = var_1_16("time_remaining_tip")
					var_1_10017 = var_1_15
					i18n = var_18
					var_1_10013 = var_1_16 .. var_1_10017 .. var_18("word_minute")
				else
					i18n = var_1_16

					local var_1_17 = var_1_16("time_remaining_tip")

					var_1_10017 = var_1_9
					i18n = var_18
					var_1_10013 = var_1_17 .. var_1_10017 .. var_18("word_second")
				end
			end
		end

		pg = var_1_11

		local var_1_18 = var_1_11.TipsMgr.GetInstance()
		local var_1_19 = var_14.ShowTips

		i18n = var_1_10017

		var_1_19(var_1_18, var_1_10017("blueprint_cannot_build_tip", var_1_10013))

		return
	end

	local var_1_20 = {}

	if var_5:getBuildingBluePrint() then
		table = var_1_10013

		var_1_10013.insert(var_1_20, function(arg_2_0)
			local var_2_0 = var_0
			local var_2_1 = var_1.getShipVO(var_2_0)
			local var_2_2 = var_0
			local var_2_3 = var_2.getShipVO(var_2_2)

			pg = var_2_0

			local var_2_4 = var_2_0.MsgboxMgr.GetInstance()
			local var_2_5 = var_3.ShowMsgBox
			local var_2_6 = {}

			i18n = var_2_10007
			var_2_6.content = var_2_10007("cannot_build_multiple_printblue", var_2_1:getConfig("name"), var_2_3:getConfig("name"))

			function var_2_6.onYes()
				local var_3_0 = arg_1_0
				local var_3_1 = var_0.sendNotification

				GAME = var_3_10003

				var_3_1(var_3_0, var_3_10003.STOP_BLUEPRINT, {
					id = var_0.id,
					callback = arg_2_0
				})

				return
			end

			var_2_5(var_2_4, var_2_6)

			return
		end)
	else
		table = var_1_10013

		var_1_10013.insert(var_1_20, function(arg_4_0)
			pg = var_2_10001

			local var_4_0 = var_2_10001.MsgboxMgr.GetInstance()
			local var_4_1 = var_1.ShowMsgBox
			local var_4_2 = {}

			i18n = var_2_10005
			var_4_2.content = var_2_10005("blueprint_build_time_tip")
			var_4_2.onYes = arg_4_0

			var_4_1(var_4_0, var_4_2)

			return
		end)
	end

	seriesAsync = var_1_10013

	var_1_10013(var_1_20, function()
		pg = var_2_10000

		local var_5_0 = var_2_10000.ConnectionMgr.GetInstance()

		var_0.Send(var_5_0, 63200, {
			blueprint_id = var_1_0
		}, 63201, function(arg_6_0)
			local var_6_4

			if arg_6_0.result == 0 then
				local var_6_0 = var_0

				var_6_4.updateColdTime(var_6_0)

				local var_6_1 = var_0

				var_6_4.start(var_6_1, arg_6_0.time)

				local var_6_2 = var_0

				var_6_4.updateBluePrint(var_6_2, var_0)

				local var_6_3 = arg_1_0

				var_6_4 = var_6_4.sendNotification
				GAME = var_3_10004

				var_6_4(var_6_3, var_3_10004.BUILD_SHIP_BLUEPRINT_DONE)
			else
				pg = var_6_4

				local var_6_5 = var_6_4.TipsMgr.GetInstance()
				local var_6_6 = var_1.ShowTips

				i18n = var_3_10004

				var_6_6(var_6_5, var_3_10004("printblue_build_erro") .. arg_6_0.result)
			end

			return
		end)

		return
	end)

	return
end

return var_0_1
