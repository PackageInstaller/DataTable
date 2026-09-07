local ColoringClearCommand = class("ColoringClearCommand", pm.SimpleCommand)

function ColoringClearCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id

	pg.ConnectionMgr.GetInstance():Send(26006, {
		act_id = var_1_0.activityId,
		id = var_1_0.id
	}, 26007, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(ColoringProxy):getColorGroup(var_1_1):clearFill()
			self:sendNotification(GAME.COLORING_CLEAR_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("coloring_clear", arg_2_0.result))
		end

		return
	end)

	return
end

return ColoringClearCommand
