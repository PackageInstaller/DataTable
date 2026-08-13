class = var_0_10000

local var_0_0 = "EducateAddTaskProgressCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0

	var_1_0 = arg_1_1:getBody() and var_2.callback
	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 27037, {
		type_1 = var_2.system,
		progresses = var_2.progresses
	}, 27038, function(arg_2_0)
		if arg_2_0.result == 0 then
			-- block empty
		else
			pg = var_1

			local var_2_0 = var_1.TipsMgr.GetInstance()
			local var_2_1 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_1(var_2_0, var_2_10003("educate add task progress error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
