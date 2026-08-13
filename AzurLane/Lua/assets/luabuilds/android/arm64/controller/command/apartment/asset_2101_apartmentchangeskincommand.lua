class = var_0_10000

local var_0_0 = "ApartmentChangeSkinCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().groupId
	local var_1_1 = var_2.skinId

	getProxy = var_1_10005
	ApartmentProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)

	if var_5.getApartment(var_1_2, var_1_0).skinId == var_1_1 then
		return
	end

	pg = var_7

	local var_1_3 = var_7.ConnectionMgr.GetInstance()

	var_7.Send(var_1_3, 28013, {
		ship_group = var_1_0,
		skin = var_1_1
	}, 28014, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_2.ModifyApartment(var_2_0, var_1_0, {
				skinId = var_1_1
			})

			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10004
			var_2_10004 = var_2_10004.APARTMENT_CHANGE_SKIN_DONE

			local var_2_3 = var_0

			var_2_2(var_2_1, var_2_10004, var_5.getApartment(var_2_3, var_1_0))

			pg = var_2_2

			local var_2_4 = var_2_2.m02

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10004
			var_2_10004 = var_2_10004.APARTMENT_TRACK
			Dorm3dTrackCommand = var_5

			var_2_2(var_2_4, var_2_10004, var_5.BuildDataChangeSkin(var_1_1))
		else
			pg = var_2_2

			local var_2_5 = var_2_2.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_6(var_2_5, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
