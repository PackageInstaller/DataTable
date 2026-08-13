class = var_0_10000

local var_0_0 = "ApartmentLevelUpCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().groupId
	local var_1_1 = var_2.triggerId

	getProxy = var_1_10005
	ApartmentProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.getApartment(var_1_2, var_1_0)

	if not var_6.canLevelUp(var_1_3) then
		return
	end

	pg = var_7

	local var_1_4 = var_7.ConnectionMgr.GetInstance()

	var_7.Send(var_1_4, 28005, {
		ship_group = var_1_0
	}, 28006, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_2.ModifyApartment(var_2_0, var_1_0, function(arg_3_0)
				arg_3_0:addLevel()

				return
			end)

			local var_2_1 = var_0

			var_0 = var_2_2.getApartment(var_2_1, var_1_0)
			PlayerConst = var_2_2
			var_2_2 = var_2_2.addTranDrop(arg_2_0.drop_list)
			var_2_10003 = arg_1_0

			local var_2_3 = var_2.sendNotification

			GAME = var_4

			var_2_3(var_2_10003, var_4.APARTMENT_LEVEL_UP_DONE, {
				apartment = var_0,
				award = var_2_2
			})

			var_2_10003 = var_0

			local var_2_4 = var_2.getLevel(var_2_10003)

			_ = var_2_10003
			var_2_10003 = var_2_10003.each
			pg = var_4

			var_2_10003(var_4.dorm3d_collection_template.all, function(arg_4_0)
				pg = var_3_10001

				if var_3_10001.dorm3d_collection_template[arg_4_0].unlock[1] ~= 1 then
					return
				end

				if var_2[2] ~= var_2_4 then
					return
				end

				pg = var_3

				local var_4_0 = var_3.m02
				local var_4_1 = var_3.sendNotification

				GAME = var_3_10005

				local var_4_2 = var_3_10005.APARTMENT_TRACK

				Dorm3dTrackCommand = var_3_10006

				var_4_1(var_4_0, var_4_2, var_3_10006.BuildDataCollectionItem(arg_4_0, 1))

				return
			end)
		else
			pg = var_2_2

			local var_2_5 = var_2_2.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_6(var_2_5, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
