class = var_0_10000

local var_0_0 = "ActivityPuzzlePicecOPCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1:getBody().id then
		var_1_0 = 0
	end

	local var_1_1 = var_2.cmd
	local var_1_2 = var_2.actId
	local var_1_3 = var_2.callback

	getProxy = var_1_10007
	ActivityProxy = var_1_10009

	local var_1_4 = var_1_10007(var_1_10009)

	getProxy = var_1_10008
	ActivityProxy = var_1_10010

	local var_1_5 = var_1_10008(var_1_10010)

	if not var_8.getActivityById(var_1_5, var_1_2) or var_8:isEnd() then
		return
	end

	pg = var_1_10009

	if not var_1_10009.activity_event_picturepuzzle[var_1_2] then
		return
	end

	PuzzleActivity = var_1_5

	local var_1_7

	if var_1_1 == var_1_5.CMD_COMPLETE then
		if #var_8.data2_list > #var_9.pickup_picturepuzzle + #var_9.drop_picturepuzzle then
			return
		end

		if var_8.data1 ~= 0 then
			return
		end

		local var_1_6 = arg_1_0

		var_1_7 = arg_1_0.sendNotification
		GAME = var_1_10013
		var_1_10013 = var_1_10013.ACTIVITY_OPERATION

		local var_1_8 = {
			activity_id = var_1_2
		}

		PuzzleActivity = var_1_10015
		var_1_8.cmd = var_1_10015.CMD_COMPLETE

		var_1_7(var_1_6, var_1_10013, var_1_8)

		return
	else
		PuzzleActivity = var_1_7

		if var_1_1 == var_1_7.CMD_ACTIVATE then
			table = var_1_7

			if not var_1_7.contains(var_8.data1_list, var_1_0) then
				table = var_1_7

				if not var_1_7.contains(var_9.pickup_picturepuzzle, var_1_0) then
					return
				end
			end

			table = var_1_7

			if var_1_7.contains(var_8.data2_list, var_1_0) then
				return
			end
		else
			PuzzleActivity = var_1_7

			if var_1_1 == var_1_7.CMD_UNLCOK_TIP then
				table = var_1_7

				if var_1_7.contains(var_8.data3_list, var_1_0) then
					return
				end

				pg = var_1_7

				local var_1_9 = var_1_7.TimeMgr.GetInstance()

				if var_1_7.GetServerTime(var_1_9) < var_8.data2 then
					pg = var_1_7

					local var_1_10 = var_1_7.TipsMgr.GetInstance()

					var_1_7 = var_1_7.ShowTips
					i18n = var_1_10013

					var_1_7(var_1_10, var_1_10013("bulin_tip_other2"))

					return
				end
			else
				PuzzleActivity = var_1_7

				if var_1_1 == var_1_7.CMD_EARN_EXTRA then
					if var_8.data1 ~= 1 then
						return
					end

					local var_1_11 = arg_1_0

					var_1_7 = arg_1_0.sendNotification
					GAME = var_1_10013

					var_1_7(var_1_11, var_1_10013.ACTIVITY_OPERATION, {
						cmd = 4,
						activity_id = var_1_2
					})

					return
				end
			end
		end
	end

	pg = var_1_7

	local var_1_12 = var_1_7.ConnectionMgr.GetInstance()

	var_10.Send(var_1_12, 11202, {
		arg2 = 0,
		activity_id = var_1_2,
		cmd = var_1_1,
		arg1 = var_1_0,
		arg_list = {}
	}, 11203, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			getProxy = var_2_1
			ActivityProxy = var_2_10003

			local var_2_0 = var_2_1(var_2_10003)

			var_0 = var_2_1.getActivityById(var_2_0, var_1_2)
			var_2_1 = var_1_1
			PuzzleActivity = var_2_10002

			if var_2_1 == var_2_10002.CMD_COMPLETE then
				var_2_1 = var_0
				var_2_1.data1 = 1
			else
				var_2_1 = var_1_1
				PuzzleActivity = var_2

				if var_2_1 == var_2.CMD_ACTIVATE then
					table = var_2_1

					var_2_1.insert(var_0.data2_list, var_1_0)
				else
					var_2_1 = var_1_1
					PuzzleActivity = var_2

					if var_2_1 == var_2.CMD_UNLCOK_TIP then
						table = var_2_1

						var_2_1.insert(var_0.data3_list, var_1_0)

						var_2_1 = var_0
						pg = var_2
						var_2_10004 = var_2.TimeMgr.GetInstance()
						var_2_1.data2 = var_2.GetServerTime(var_2_10004) + var_0.cd
					else
						var_2_1 = var_1_1
						PuzzleActivity = var_2

						if var_2_1 == var_2.CMD_EARN_EXTRA then
							var_2_1 = var_0
							var_2_1.data1 = 2
						end
					end
				end
			end

			local var_2_2 = var_1_4

			var_2_1.updateActivity(var_2_2, var_0)

			if var_1_3 then
				var_1_3()
			end
		else
			pg = var_2_1

			local var_2_3 = var_2_1.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_4(var_2_3, var_2_10004("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
