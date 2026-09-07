local IslandCheaterReconectCommand = class("IslandCheaterReconectCommand", pm.SimpleCommand)

function IslandCheaterReconectCommand:execute(arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(23113, {
		Type = arg_1_1:getBody().type
	}, 23114, function(arg_2_0)
		if arg_2_0.result == 0 then
			-- block empty
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end, false)

	return
end

return IslandCheaterReconectCommand
