class = var_0_10000

local var_0_0 = "NewEducateSelEndingCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.endingId
	local var_1_2 = var_2.isMain

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 29005, {
		id = var_1_0,
		ending_id = var_1_1
	}, 29006, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			NewEducateProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)

			var_1.AddFinishedEnding(var_2_0, var_1_1)

			local var_2_1 = var_1:GetCurChar()
			local var_2_2 = var_2.GetFSM(var_2_1)
			local var_2_3 = var_2.GetState

			NewEducateFSM = var_2_10006

			local var_2_4 = var_2_3(var_2_2, var_2_10006.SYSTEM.ENDING)

			var_3.SelEnding(var_2_4, var_1_1)

			local var_2_5 = arg_1_0
			local var_2_6 = var_4.sendNotification

			GAME = var_7

			var_2_6(var_2_5, var_7.NEW_EDUCATE_SEL_ENDING_DONE, {
				id = var_1_1,
				isMain = var_1_2
			})

			local var_2_7 = var_1:GetCurChar()
			local var_2_8 = var_4.GetGameCnt(var_2_7)

			pg = var_2_2

			local var_2_9 = var_2_2.m02
			local var_2_10 = var_5.sendNotification

			GAME = var_8

			local var_2_11 = var_8.NEW_EDUCATE_TRACK

			NewEducateTrackCommand = var_9

			var_2_10(var_2_9, var_2_11, var_9.BuildDataEnding(var_1_0, var_2_8, var_1_1))
		else
			pg = var_1

			local var_2_12 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_12, "NewEducate_SelTalent: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
