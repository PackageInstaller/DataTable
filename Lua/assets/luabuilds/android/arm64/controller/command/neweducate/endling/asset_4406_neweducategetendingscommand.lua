local NewEducateGetEndingsCommand = class("NewEducateGetEndingsCommand", pm.SimpleCommand)

function NewEducateGetEndingsCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0 and var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(29003, {
		id = var_1_0.id
	}, 29004, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NewEducateProxy)

			var_2_0:AddActivatedEndings(arg_2_0.endings)

			local var_2_1 = var_2_0:GetCurChar():GetFSM()

			var_2_1:SetSystemNo(NewEducateFSM.SYSTEM.ENDING)
			var_2_1:SetState(NewEducateFSM.SYSTEM.ENDING, (NewEducateEndingState.New({
				select = 0,
				ends = arg_2_0.endings
			})))
			existCall(var_1_1)
			NewEducateHelper.TrackRoundEnd()
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_GetEndings: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return NewEducateGetEndingsCommand
