local EducateAddTaskProgressCommand = class("EducateAddTaskProgressCommand", pm.SimpleCommand)

function EducateAddTaskProgressCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(27037, {
		type_1 = var_1_0.system,
		progresses = var_1_0.progresses
	}, 27038, function(arg_2_0)
		if arg_2_0.result == 0 then
			-- block empty
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("educate add task progress error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return EducateAddTaskProgressCommand
