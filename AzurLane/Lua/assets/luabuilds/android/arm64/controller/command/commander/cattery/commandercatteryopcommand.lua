local var_0_0 = class("CommanderCatteryOPCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(CommanderProxy):GetCommanderHome()

	pg.ConnectionMgr.GetInstance():Send(25028, {
		type = arg_1_1:getBody().op
	}, 25029, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = PlayerConst.addTranDrop(arg_2_0.awards)
			local var_2_2 = 0
			local var_2_3 = {}
			local var_2_4

			if var_0 == 1 then
				var_1_0:IncCleanValue()
			elseif var_0 == 2 then
				var_2_3 = arg_1_0:AddCommanderExpByFeed()
			elseif var_0 == 3 then
				var_2_4 = {}
			end

			for iter_2_0, iter_2_1 in pairs((var_1_0:GetCatteries())) do
				if iter_2_1:ExistOP(var_0) and iter_2_1:CommanderCanOP(var_0) then
					local var_2_5 = iter_2_1:GetCommander()

					iter_2_1:ClearOP(var_0)
					var_2_5:UpdateHomeOpTime(var_0, arg_2_0.op_time)
					getProxy(CommanderProxy):updateCommander(var_2_5)
					table.insert(var_2_4, iter_2_1.id)
				end
			end

			local var_2_6 = Clone(var_1_0)

			var_1_0:UpdateExpAndLevel(arg_2_0.level, arg_2_0.exp)

			var_2_2 = var_1_0.level > var_2_6.level and var_2_6:GetNextLevelExp() - var_2_6.exp + var_1_0.exp or var_1_0.exp - var_2_6.exp

			arg_1_0:sendNotification(GAME.COMMANDER_CATTERY_OP_DONE, {
				awards = var_2_0,
				cmd = var_0,
				opCatteries = var_2_4,
				commanderExps = var_2_3,
				homeExp = var_2_2
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

function var_0_0.AddCommanderExpByFeed(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = getProxy(CommanderProxy):GetCommanderHome()
	local var_3_2 = var_3_1:getConfig("feed_level")[2]

	for iter_3_0, iter_3_1 in pairs((var_3_1:GetCatteries())) do
		if iter_3_1:ExistCommander() and iter_3_1:ExiseFeedOP() then
			(function(arg_4_0, arg_4_1)
				local var_4_0 = getProxy(CommanderProxy)
				local var_4_1 = var_4_0:getCommanderById((arg_4_0:GetCommanderId()))
				local var_4_2 = var_4_1:isMaxLevel()

				if var_4_2 then
					arg_4_1 = 0
				end

				var_4_1:addExp(arg_4_1)

				if not var_4_2 and var_4_1:isMaxLevel() then
					arg_4_1 = arg_4_1 - var_4_1.exp
				end

				table.insert(var_3_0, {
					id = arg_4_0.id,
					value = arg_4_1
				})
				var_4_0:updateCommander(var_4_1)

				return
			end)(iter_3_1, var_3_2)
		end
	end

	return {}
end

return var_0_0
