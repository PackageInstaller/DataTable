local NewEducateMakeChoiceCommand = class("NewEducateMakeChoiceCommand", pm.SimpleCommand)

function NewEducateMakeChoiceCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(29103, {
		id = var_1_0.id,
		index = var_1_0.idx
	}, 29104, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NewEducateProxy):GetCurChar():GetFSM()

			var_2_0:GetPriorityState():MarkFinish()
			var_2_0:CheckPriorityStystem()
			self:sendNotification(GAME.NEW_EDUCATE_MAKE_CHOICE_DONE, {
				drops = NewEducateDropHelper.HandleDrops(arg_2_0.drop)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_MakeChoice_Error: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return NewEducateMakeChoiceCommand
