class = var_0_10000

local var_0_0 = "ApartmentCollectionItemCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().roomId
	local var_1_1 = var_2.groupId
	local var_1_2 = var_2.itemId

	pg = var_1_10006

	local var_1_3 = var_1_10006.dorm3d_collection_template[var_1_2].award

	if var_1_1 == 0 and var_1_3 ~= 0 then
		pg = var_1_10008
		var_1_10009 = var_1_10008.TipsMgr.GetInstance()

		var_1_10008.ShowTips(var_1_10009, "error collection favor trigger link:" .. var_1_2)

		return
	end

	getProxy = var_1_10008
	ApartmentProxy = var_1_10009

	local var_1_4 = var_1_10008(var_1_10009)

	if var_8.getRoom(var_1_4, var_1_0).collectItemDic[var_1_2] then
		local var_1_5 = arg_1_0
		local var_1_6 = arg_1_0.sendNotification

		GAME = var_1_10012

		var_1_6(var_1_5, var_1_10012.APARTMENT_COLLECTION_ITEM_DONE, {
			itemId = var_1_2
		})

		return
	end

	local var_1_7 = var_8
	local var_1_8 = var_8.getApartment(var_1_7, var_1_1)

	pg = var_1_7

	local var_1_9 = var_1_7.ConnectionMgr.GetInstance()

	var_11.Send(var_1_9, 28011, {
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
				var_2_10003 = var_0
				var_2_2, var_2_10003 = var_2_2.triggerFavor(var_2_10003, var_1_1, var_2_1)

				local var_2_3 = arg_1_0
				local var_2_4 = var_4.sendNotification

				GAME = var_2_10006

				var_2_4(var_2_3, var_2_10006.APARTMENT_TRIGGER_FAVOR_DONE, {
					triggerId = var_2_1,
					cost = var_2_10003,
					delta = var_2_2,
					apartment = var_1_8
				})
			end

			PlayerPrefs = var_2_2

			var_2_2.SetInt("apartment_collection_item", var_1_2)

			var_2_10003 = arg_1_0

			local var_2_5 = var_2.sendNotification

			GAME = var_4

			var_2_5(var_2_10003, var_4.APARTMENT_COLLECTION_ITEM_DONE, {
				isNew = true,
				itemId = var_1_2
			})

			pg = var_2_5
			var_2_10003 = var_2_5.m02

			local var_2_6 = var_2.sendNotification

			GAME = var_4

			local var_2_7 = var_4.APARTMENT_TRACK

			Dorm3dTrackCommand = var_5

			var_2_6(var_2_10003, var_2_7, var_5.BuildDataCollectionItem(var_1_2, 2))
		else
			pg = var_2_1

			local var_2_8 = var_2_1.TipsMgr.GetInstance()
			local var_2_9 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_9(var_2_8, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
