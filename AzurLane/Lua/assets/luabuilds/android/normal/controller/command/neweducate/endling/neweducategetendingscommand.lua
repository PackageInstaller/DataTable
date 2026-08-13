class = var_0_10000

local var_0_0 = "NewEducateGetEndingsCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody() and var_2.callback
	local var_1_1 = var_2.id

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 29003, {
		id = var_1_1
	}, 29004, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			NewEducateProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)

			var_1.AddActivatedEndings(var_2_0, arg_2_0.endings)

			local var_2_1 = var_1:GetCurChar()
			local var_2_2 = var_2.GetFSM(var_2_1)
			local var_2_3 = var_2.SetSystemNo

			NewEducateFSM = var_2_10005

			var_2_3(var_2_2, var_2_10005.SYSTEM.ENDING)

			NewEducateEndingState = var_2_3

			local var_2_4 = var_2_3.New({
				select = 0,
				ends = arg_2_0.endings
			})
			local var_2_5 = var_2
			local var_2_6 = var_2.SetState

			NewEducateFSM = var_2_10006

			var_2_6(var_2_5, var_2_10006.SYSTEM.ENDING, var_2_4)

			existCall = var_2_6

			var_2_6(var_1_0)

			NewEducateHelper = var_2_6

			var_2_6.TrackRoundEnd()
		else
			pg = var_1

			local var_2_7 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_7, "NewEducate_GetEndings: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
