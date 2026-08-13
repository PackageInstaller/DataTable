class = var_0_10000

local var_0_0 = "PutCommanderInCatteryCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.commanderId == 0
	local var_1_2 = var_2.callback
	local var_1_3 = var_2.tip

	getProxy = var_1_10008
	CommanderProxy = var_1_10009

	local var_1_4 = var_1_10008(var_1_10009)

	if not var_1_1 and not var_1_4:getCommanderById(var_4) then
		if var_1_2 then
			var_1_2()
		end

		return
	end

	if not var_1_4:GetCommanderHome() then
		if var_1_2 then
			var_1_2()
		end

		return
	end

	local var_1_5 = var_9

	if not var_9.GetCatteryById(var_1_5, var_1_0) or not var_10:CanUse() then
		if var_1_2 then
			var_1_2()
		end

		return
	end

	if not var_1_1 and var_10:ExistCommander() and var_10:GetCommanderId() == var_4 then
		if var_1_2 then
			var_1_2()
		end

		return
	end

	if var_1_1 and not var_10:ExistCommander() then
		if var_1_2 then
			var_1_2()
		end

		return
	end

	pg = var_1_5

	local var_1_6 = var_1_5.ConnectionMgr.GetInstance()

	var_11.Send(var_1_6, 25030, {
		slotidx = var_1_0,
		commander_id = var_4
	}, 25031, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			if var_1_1 then
				local var_2_0 = var_0

				var_2_1 = var_2_1.GetCommanderId(var_2_0)
				var_2_10003 = arg_1_0

				var_2.UpdateCommanderLevelAndExp(var_2_10003, var_2_1, arg_2_0)

				var_2_10003 = var_0

				var_2.RemoveCommander(var_2_10003)

				if var_1_3 then
					pg = var_2
					var_2_10003 = var_2.TipsMgr.GetInstance()

					local var_2_2 = var_2.ShowTips

					i18n = var_4

					var_2_2(var_2_10003, var_4("cattery_remove_commander_success"))
				end
			else
				local var_2_3 = var_0

				if var_2_1.ExistCommander(var_2_3) then
					local var_2_4 = var_0

					var_2_1 = var_2_1.GetCommanderId(var_2_4)
					var_2_10003 = arg_1_0

					var_2.UpdateCommanderLevelAndExp(var_2_10003, var_2_1, arg_2_0)
				end

				local var_2_5 = var_0

				var_2_1.AddCommander(var_2_5, var_0, arg_2_0.time)

				local var_2_6 = var_1_4

				var_2_10003 = var_2_1.getCommanderById(var_2_6, var_0)

				local var_2_7 = var_2_1.ExistCleanFlag(var_2_10003)

				var_2_10003 = var_2_1:ExitFeedFlag()

				local var_2_8 = var_2_1:ExitPlayFlag()

				if var_2_7 then
					var_2_10006 = var_0

					if var_5.ExistCleanOP(var_2_10006) then
						var_2_10006 = var_0

						var_5.ResetCleanOP(var_2_10006)
					end
				end

				if var_2_10003 then
					var_2_10006 = var_0

					if var_5.ExiseFeedOP(var_2_10006) then
						var_2_10006 = var_0

						var_5.ResetFeedOP(var_2_10006)
					end
				end

				if var_2_8 then
					var_2_10006 = var_0

					if var_5.ExistPlayOP(var_2_10006) then
						var_2_10006 = var_0

						var_5.ResetPlayOP(var_2_10006)
					end
				end

				local var_2_9 = {}

				if not var_2_7 then
					table = var_2_10006
					var_2_10006 = var_2_10006.insert

					local var_2_10 = var_2_9

					i18n = var_2_10008

					var_2_10006(var_2_10, var_2_10008("common_clean"))
				end

				if not var_2_10003 then
					table = var_2_10006
					var_2_10006 = var_2_10006.insert

					local var_2_11 = var_2_9

					i18n = var_2_10008

					var_2_10006(var_2_11, var_2_10008("common_feed"))
				end

				if not var_2_8 then
					table = var_2_10006

					local var_2_12 = var_2_10006.insert
					local var_2_13 = var_2_9

					i18n = var_2_10008

					var_2_12(var_2_13, var_2_10008("common_play"))
				end

				if #var_2_9 > 0 then
					table = var_6

					local var_2_14 = var_6.concat(var_2_9, ", ")

					pg = var_7
					var_2_10008 = var_7.TipsMgr.GetInstance()

					local var_2_15 = var_7.ShowTips

					i18n = var_2_10009

					var_2_15(var_2_10008, var_2_10009("cat_home_interaction", var_2_14))
				elseif var_1_3 then
					pg = var_6

					local var_2_16 = var_6.TipsMgr.GetInstance()
					local var_2_17 = var_6.ShowTips

					i18n = var_2_10008

					var_2_17(var_2_16, var_2_10008("cattery_add_commander_success"))
				end
			end

			if var_1_2 then
				var_1_2()
			end

			local var_2_18 = arg_1_0

			var_2_1 = var_2_1.sendNotification
			GAME = var_2_10003

			var_2_1(var_2_18, var_2_10003.PUT_COMMANDER_IN_CATTERY_DONE, {
				id = var_0.id
			})
		else
			pg = var_2_1

			local var_2_19 = var_2_1.TipsMgr.GetInstance()
			local var_2_20 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_20(var_2_19, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

function var_0_1.UpdateCommanderLevelAndExp(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_2.commander_level
	local var_3_1 = arg_3_2.commander_exp

	if 0 < var_3_0 then
		getProxy = var_5
		CommanderProxy = var_1_10006

		local var_3_2 = var_5(var_1_10006)
		local var_3_3 = var_5.getCommanderById(var_3_2, arg_3_1)

		var_6.UpdateLevelAndExp(var_3_3, var_3_0, var_3_1)
		var_5:updateCommander(var_6)
	end

	return
end

return var_0_1
