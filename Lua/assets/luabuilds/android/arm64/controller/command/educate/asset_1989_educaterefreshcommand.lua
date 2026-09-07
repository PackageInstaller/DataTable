local EducateRefreshCommand = class("EducateRefreshCommand", pm.SimpleCommand)

function EducateRefreshCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(27047, {
		type = 1
	}, 27048, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(EducateProxy):Refresh(function()
				self:sendNotification(GAME.EDUCATE_REFRESH_DONE)

				return
			end)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("educate refresh error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return EducateRefreshCommand
