local BeginStageCommand = class("BeginStageCommand", pm.SimpleCommand)

function BeginStageCommand:execute(arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(40005, {
		system = arg_1_1:getBody().system
	}, 40006, function(arg_2_0)
		if arg_2_0.result == 0 then
			-- block empty
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("stage_beginStage", arg_2_0.result))
		end

		return
	end)

	return
end

return BeginStageCommand
