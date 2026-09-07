local GetCommanderHomeCommand = class("GetCommanderHomeCommand", pm.SimpleCommand)

function GetCommanderHomeCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(CommanderProxy)

	if var_1_1:GetCommanderHome() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(25026, {
		type = 0
	}, 25027, function(arg_2_0)
		var_1_1:AddCommanderHome((CommanderHome.New(arg_2_0)))

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.slots) do
			if iter_2_1.commander_id ~= 0 and iter_2_1.commander_level and iter_2_1.commander_level ~= 0 and iter_2_1.commander_exp then
				self:UpdateCommanderLevelAndExp(iter_2_1.commander_id, iter_2_1.commander_level, iter_2_1.commander_exp)
			end
		end

		return
	end)

	return
end

function GetCommanderHomeCommand:UpdateCommanderLevelAndExp(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = getProxy(CommanderProxy)
	local var_3_1 = var_3_0:getCommanderById(arg_3_1)

	if var_3_1 then
		var_3_1:UpdateLevelAndExp(arg_3_2, arg_3_3)
		var_3_0:updateCommander(var_3_1)
	end

	return
end

return GetCommanderHomeCommand
