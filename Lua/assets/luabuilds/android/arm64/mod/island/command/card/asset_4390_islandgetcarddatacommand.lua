local IslandGetCardDataCommand = class("IslandGetCardDataCommand", pm.SimpleCommand)

function IslandGetCardDataCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = var_1_0.userId

	pg.ConnectionMgr.GetInstance():Send(21326, {
		user_id = var_1_0.userId
	}, 21327, function(arg_2_0)
		existCall(var_1_1, (IslandCard.New(var_1_2, arg_2_0)))

		return
	end)

	return
end

return IslandGetCardDataCommand
