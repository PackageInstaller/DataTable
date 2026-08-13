class = var_0_10000

local var_0_0 = "ApartmentCollectionItemCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().roomId
	local var_1_1 = var_2.groupId
	local var_1_2 = var_2.itemId

	pg = var_1_10006

	local var_1_3 = var_1_10006.dorm3d_collection_template[var_1_2].award

	if var_1_1 == 0 and var_1_3 ~= 0 then
		pg = var_1_10008
		var_1_10010 = var_1_10008.TipsMgr.GetInstance()

		var_1_10008.ShowTips(var_1_10010, "error collection favor trigger link:" .. var_1_2)

		return
	end

	getProxy = var_1_10008
	ApartmentProxy = var_1_10010

	local var_1_4 = var_1_10008(var_1_10010)

	if var_8.getRoom(var_1_4, var_1_0).collectItemDic[var_1_2] then
		local var_1_5 = arg_1_0
		local var_1_6 = arg_1_0.sendNotification

		GAME = var_1_10013

		var_1_6(var_1_5, var_1_10013.APARTMENT_COLLECTION_ITEM_DONE, {
			itemId = var_1_2
		})

		return
	end

	local var_1_7 = var_8:getApartment(var_1_1)

	pg = var_1_4

	local var_1_8 = var_1_4.ConnectionMgr.GetInstance()

	var_11.Send(var_1_8, 28011, {
		room_id = var_1_0,
		collection_id = var_1_2,
		ship_group = var_1_1
	}, 28012, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_1.ModifyRoom(var_2_0, var_1_0, function(arg_3_0)
				arg_3_0.collectItemDic[var_1_2] = true

				return
			end)

			var_2_1 = var_0.award

			local var_2_2

			if 0 < var_2_1 then
				var_2_10004 = var_0

				local var_2_3

				var_2_2, var_2_3 = var_2_2.triggerFavor(var_2_10004, var_1_1, var_2_1)

				local var_2_4 = arg_1_0

				var_2_10004 = var_2_10004.sendNotification
				GAME = var_2_10007

				var_2_10004(var_2_4, var_2_10007.APARTMENT_TRIGGER_FAVOR_DONE, {
					triggerId = var_2_1,
					cost = var_2_3,
					delta = var_2_2,
					apartment = var_1_7
				})
			end

			PlayerPrefs = var_2_2

			var_2_2.SetInt("apartment_collection_item", var_1_2)

			var_2_10004 = arg_1_0

			local var_2_5 = var_2.sendNotification

			GAME = var_5

			var_2_5(var_2_10004, var_5.APARTMENT_COLLECTION_ITEM_DONE, {
				isNew = true,
				itemId = var_1_2
			})

			pg = var_2_5
			var_2_10004 = var_2_5.m02

			local var_2_6 = var_2.sendNotification

			GAME = var_5

			local var_2_7 = var_5.APARTMENT_TRACK

			Dorm3dTrackCommand = var_6

			var_2_6(var_2_10004, var_2_7, var_6.BuildDataCollectionItem(var_1_2, 2))
		else
			pg = var_2_1

			local var_2_8 = var_2_1.TipsMgr.GetInstance()
			local var_2_9 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_9(var_2_8, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
