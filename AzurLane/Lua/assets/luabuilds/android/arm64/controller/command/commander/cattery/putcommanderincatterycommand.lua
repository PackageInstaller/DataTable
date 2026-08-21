local var_0_0 = class("PutCommanderInCatteryCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.commanderId
	local var_1_3 = var_1_0.commanderId == 0
	local var_1_4 = var_1_0.callback
	local var_1_5 = var_1_0.tip
	local var_1_6 = getProxy(CommanderProxy)

	if var_1_0.commanderId ~= 0 and not var_1_6:getCommanderById(var_1_2) then
		if var_1_4 then
			var_1_4()
		end

		return
	end

	local var_1_7 = var_1_6:GetCommanderHome()

	if not var_1_7 then
		if var_1_4 then
			var_1_4()
		end

		return
	end

	local var_1_8 = var_1_7:GetCatteryById(var_1_1)

	if not var_1_8 or not var_1_8:CanUse() then
		if var_1_4 then
			var_1_4()
		end

		return
	end

	if not var_1_3 and var_1_8:ExistCommander() and var_1_8:GetCommanderId() == var_1_2 then
		if var_1_4 then
			var_1_4()
		end

		return
	end

	if var_1_3 and not var_1_8:ExistCommander() then
		if var_1_4 then
			var_1_4()
		end

		return
	end

	pg.ConnectionMgr.GetInstance():Send(25030, {
		slotidx = var_1_1,
		commander_id = var_1_2
	}, 25031, function(arg_2_0)
		if arg_2_0.result == 0 then
			if var_1_3 then
				arg_1_0:UpdateCommanderLevelAndExp(var_1_8:GetCommanderId(), arg_2_0)
				var_1_8:RemoveCommander()

				if var_1_5 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("cattery_remove_commander_success"))
				end
			else
				if var_1_8:ExistCommander() then
					arg_1_0:UpdateCommanderLevelAndExp(var_1_8:GetCommanderId(), arg_2_0)
				end

				var_1_8:AddCommander(var_1_2, arg_2_0.time)

				local var_2_0 = var_1_6:getCommanderById(var_1_2)
				local var_2_1 = var_2_0:ExistCleanFlag()
				local var_2_2 = var_2_0:ExitFeedFlag()
				local var_2_3 = var_2_0:ExitPlayFlag()

				if var_2_1 and var_1_8:ExistCleanOP() then
					var_1_8:ResetCleanOP()
				end

				if var_2_2 and var_1_8:ExiseFeedOP() then
					var_1_8:ResetFeedOP()
				end

				if var_2_3 and var_1_8:ExistPlayOP() then
					var_1_8:ResetPlayOP()
				end

				local var_2_4 = {}

				if not var_2_1 then
					table.insert(var_2_4, i18n("common_clean"))
				end

				if not var_2_2 then
					table.insert(var_2_4, i18n("common_feed"))
				end

				if not var_2_3 then
					table.insert(var_2_4, i18n("common_play"))
				end

				if #var_2_4 > 0 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("cat_home_interaction", (table.concat(var_2_4, ", "))))
				elseif var_1_5 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("cattery_add_commander_success"))
				end
			end

			if var_1_4 then
				var_1_4()
			end

			arg_1_0:sendNotification(GAME.PUT_COMMANDER_IN_CATTERY_DONE, {
				id = var_1_8.id
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

function var_0_0.UpdateCommanderLevelAndExp(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2.commander_level > 0 then
		local var_3_0 = getProxy(CommanderProxy)
		local var_3_1 = var_3_0:getCommanderById(arg_3_1)

		var_3_1:UpdateLevelAndExp(arg_3_2.commander_level, arg_3_2.commander_exp)
		var_3_0:updateCommander(var_3_1)
	end

	return
end

return var_0_0
