local ReversePacmanPassLevelCommand = class("ReversePacmanPassLevelCommand", pm.SimpleCommand)

function ReversePacmanPassLevelCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_2 = var_1_0.levelId
	local var_1_3 = var_1_0.time

	pg.ConnectionMgr.GetInstance():Send(11202, {
		cmd = 3,
		activity_id = var_1_0.actId,
		arg1 = var_1_0.levelId,
		arg2 = var_1_0.time
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			ReversePacmanTools.GetActivity():UpdatePassStage(var_1_2, var_1_3)
			self:sendNotification(GAME.REVERSE_PACMAN_PASS_LEVEL_DONE, {
				awards = PlayerConst.addTranDrop(arg_2_0.award_list)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return ReversePacmanPassLevelCommand
