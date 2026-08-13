class = var_0_10000

local var_0_0 = "ApartmentRoomUnlockCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).roomId

	pg = var_1_0

	local var_1_2 = var_1_0.dorm3d_rooms[var_1_1]

	underscore = var_1_10005

	local var_1_3, var_1_4

	if #var_1_10005.map(var_1_2.unlock_item, function(arg_2_0)
		Drop = var_2_10001

		return var_2_10001.Create(arg_2_0)
	end) > 0 then
		underscore = var_1_4

		if var_1_4.any(var_5, function(arg_3_0)
			return arg_3_0:getOwnedCount() < arg_3_0.count
		end) then
			pg = var_1_4
			var_1_3 = var_1_4.TipsMgr.GetInstance()
			var_1_4 = var_1_4.ShowTips
			i18n = var_9

			var_1_4(var_1_3, var_9("temple_consume_not_enough"))

			return
		end
	end

	getProxy = var_1_4
	ApartmentProxy = var_1_3

	local var_1_5 = var_1_4(var_1_3)

	if var_6.getRoom(var_1_5, var_1_1) then
		pg = var_7

		local var_1_6 = var_7.TipsMgr.GetInstance()

		var_7.ShowTips(var_1_6, "this room already unlock")

		return
	end

	pg = var_7

	local var_1_7 = var_7.ConnectionMgr.GetInstance()

	var_7.Send(var_1_7, 28001, {
		room_id = var_1_1
	}, 28002, function(arg_4_0)
		local var_4_0

		if arg_4_0.result == 0 then
			ipairs = var_4_0

			for iter_4_0, iter_4_1 in var_4_0(var_0) do
				reducePlayerOwn = var_2_10006

				var_2_10006(iter_4_1)
			end

			ApartmentRoom = var_4_0
			var_4_0 = var_4_0.New(arg_4_0.room)
			iter_4_0 = var_0

			var_2.updateRoom(iter_4_0, var_4_0)

			iter_4_0 = var_4_0

			if var_4_0.isPersonalRoom(iter_4_0) then
				iter_4_0 = var_0

				local var_4_1 = var_2.updateApartment

				Apartment = var_5

				var_4_1(iter_4_0, var_5.New({
					daily_favor = 0,
					favor_lv = 1,
					cur_skin = 0,
					favor_exp = 0,
					ship_group = var_4_0:getPersonalGroupId()
				}))
			end

			;(function()
				local var_5_0 = var_1_2.type == 1 and 4 or 2
				local var_5_1 = ""

				if not var_0 then
					table = var_3_10003
					var_5_1 = var_3_10003.concat(var_1_2.character, ",")
				end

				pg = var_3_10003

				local var_5_2 = var_3_10003.m02
				local var_5_3 = var_3.sendNotification

				GAME = var_3_10006

				local var_5_4 = var_3_10006.APARTMENT_TRACK

				Dorm3dTrackCommand = var_3_10007

				var_5_3(var_5_2, var_5_4, var_3_10007.BuildDataRoom(var_1_1, var_5_0, var_5_1))

				return
			end)()

			DORM_LOCK_INS = var_3

			if not var_3 then
				getProxy = var_3
				Dorm3dInsProxy = var_5

				local var_4_2 = var_3(var_5)

				var_3.HandleInsData(var_4_2, arg_4_0.ins)
			end

			local var_4_3 = arg_1_0
			local var_4_4 = var_3.sendNotification

			GAME = var_2_10006

			var_4_4(var_4_3, var_2_10006.APARTMENT_ROOM_UNLOCK_DONE, {
				roomId = var_1_1
			})
		else
			pg = var_4_0

			local var_4_5 = var_4_0.TipsMgr.GetInstance()
			local var_4_6 = var_1.ShowTips

			ERROR_MESSAGE = iter_4_0

			var_4_6(var_4_5, iter_4_0[arg_4_0.result] .. arg_4_0.result)
		end

		return
	end)

	return
end

return var_0_1
