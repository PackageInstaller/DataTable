local ReversePacmanHireRoleCommand = class("ReversePacmanHireRoleCommand", pm.SimpleCommand)

function ReversePacmanHireRoleCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.roleID

	pg.ConnectionMgr.GetInstance():Send(11202, {
		cmd = 1,
		activity_id = var_1_0.activityID,
		arg1 = var_1_0.roleID
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = ReversePacmanTools.GetActivity()

			var_2_0:AddFavorability(var_1_1, pg.activity_chasing_character[var_1_1].love_point)
			var_2_0:AddVitemNumber(pg.activity_chasing_character[var_1_1].need[1], pg.activity_chasing_character[var_1_1].need[2] * -1)
			getProxy(ReversePacmanDormProxy):AddShip(var_1_1)
			self:sendNotification(GAME.REVERSE_PACMAN_HIRE_ROLE_DONE, var_1_1)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return ReversePacmanHireRoleCommand
