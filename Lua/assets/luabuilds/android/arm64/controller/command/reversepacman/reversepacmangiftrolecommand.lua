local ReversePacmanGiftRoleCommand = class("ReversePacmanGiftRoleCommand", pm.SimpleCommand)

function ReversePacmanGiftRoleCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.roleID

	pg.ConnectionMgr.GetInstance():Send(11202, {
		cmd = 2,
		activity_id = var_1_0.activityID,
		arg1 = var_1_0.roleID,
		arg2 = var_1_0.itemID
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = ReversePacmanTools.GetActivity()

			var_2_0:AddFavorability(var_1_1, 1)
			var_2_0:AddVitemNumber(ReversePacmanTools.GetGiftItemID(), -1)
			self:sendNotification(GAME.REVERSE_PACMAN_GIFT_ROLE_DONE, var_1_1)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return ReversePacmanGiftRoleCommand
