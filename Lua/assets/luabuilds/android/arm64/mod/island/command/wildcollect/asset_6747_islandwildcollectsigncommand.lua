local IslandWildCollectSignCommand = class("IslandWildCollectSignCommand", pm.SimpleCommand)

function IslandWildCollectSignCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(21531, {
		island_id = var_1_0.island_id,
		gather_id = var_1_0.gather_id
	}, 21532, function(arg_2_0)
		if arg_2_0.result == 0 then
			-- block empty
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return IslandWildCollectSignCommand
