class = var_0_10000

local var_0_0 = "ChangeLivingAreaCoverCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().coverId
	local var_1_1 = var_2.callback

	getProxy = var_1_10005
	LivingAreaCoverProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 11030, {
		livingarea_cover_id = var_1_0
	}, 11031, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_2

			var_2_2.UpdateCoverId(var_2_0, var_1_0)

			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10003

			var_2_2(var_2_1, var_2_10003.CHANGE_LIVINGAREA_COVER_DONE)

			pg = var_2_2

			local var_2_3 = var_2_2.m02

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10003
			var_2_10003 = var_2_10003.APARTMENT_TRACK
			Dorm3dTrackCommand = var_2_10004

			var_2_2(var_2_3, var_2_10003, var_2_10004.BuildDataCover(var_1_0, 2))

			if var_1_1 then
				var_1_1()
			end
		else
			pg = var_2_2

			local var_2_4 = var_2_2.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_5(var_2_4, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
