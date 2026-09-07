local CommanderCatteryOPCommand = class("CommanderCatteryOPCommand", pm.SimpleCommand)

function CommanderCatteryOPCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().op
	local var_1_1 = getProxy(CommanderProxy):GetCommanderHome()

	pg.ConnectionMgr.GetInstance():Send(25028, {
		type = var_1_0
	}, 25029, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = PlayerConst.addTranDrop(arg_2_0.awards)
			local var_2_2 = 0
			local var_2_3 = {}

			if var_1_0 == 1 then
				var_1_1:IncCleanValue()
			elseif var_1_0 == 2 then
				var_2_3 = self:AddCommanderExpByFeed()
			else
				local var_2_4

				if var_1_0 == 3 then
					var_2_4 = {}
				end
			end

			for iter_2_0, iter_2_1 in pairs((var_1_1:GetCatteries())) do
				if iter_2_1:ExistOP(var_1_0) and iter_2_1:CommanderCanOP(var_1_0) then
					local var_2_5 = iter_2_1:GetCommander()

					iter_2_1:ClearOP(var_1_0)
					var_2_5:UpdateHomeOpTime(var_1_0, arg_2_0.op_time)
					getProxy(CommanderProxy):updateCommander(var_2_5)
					table.insert(var_2_4, iter_2_1.id)
				end
			end

			local var_2_6 = Clone(var_1_1)

			var_1_1:UpdateExpAndLevel(arg_2_0.level, arg_2_0.exp)

			var_2_2 = var_1_1.level > var_2_6.level and var_2_6:GetNextLevelExp() - var_2_6.exp + var_1_1.exp or var_1_1.exp - var_2_6.exp

			self:sendNotification(GAME.COMMANDER_CATTERY_OP_DONE, {
				awards = var_2_0,
				cmd = var_1_0,
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

function CommanderCatteryOPCommand:AddCommanderExpByFeed()
	local var_3_0 = {}

	local function var_3_1(arg_4_0, arg_4_1)
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
	end

	local var_3_2 = getProxy(CommanderProxy):GetCommanderHome()
	local var_3_3 = var_3_2:getConfig("feed_level")[2]

	for iter_3_0, iter_3_1 in pairs((var_3_2:GetCatteries())) do
		if iter_3_1:ExistCommander() and iter_3_1:ExiseFeedOP() then
			var_3_1(iter_3_1, var_3_3)
		end
	end

	return var_3_0
end

return CommanderCatteryOPCommand
