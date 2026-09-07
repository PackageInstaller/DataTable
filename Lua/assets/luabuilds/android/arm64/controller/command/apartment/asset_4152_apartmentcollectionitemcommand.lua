local ApartmentCollectionItemCommand = class("ApartmentCollectionItemCommand", pm.SimpleCommand)

function ApartmentCollectionItemCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.roomId
	local var_1_2 = var_1_0.groupId
	local var_1_3 = var_1_0.itemId
	local var_1_4 = pg.dorm3d_collection_template[var_1_0.itemId]

	if var_1_0.groupId == 0 and pg.dorm3d_collection_template[var_1_0.itemId].award ~= 0 then
		pg.TipsMgr.GetInstance():ShowTips("error collection favor trigger link:" .. var_1_0.itemId)

		return
	end

	local var_1_5 = getProxy(ApartmentProxy)

	if var_1_5:getRoom(var_1_0.roomId).collectItemDic[var_1_0.itemId] then
		self:sendNotification(GAME.APARTMENT_COLLECTION_ITEM_DONE, {
			itemId = var_1_0.itemId
		})

		return
	end

	local var_1_6 = var_1_5:getApartment(var_1_0.groupId)

	pg.ConnectionMgr.GetInstance():Send(28011, {
		room_id = var_1_0.roomId,
		collection_id = var_1_0.itemId,
		ship_group = var_1_0.groupId
	}, 28012, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_5:ModifyRoom(var_1_1, function(arg_3_0)
				arg_3_0.collectItemDic[var_1_3] = true

				return
			end)

			if var_1_4.award > 0 then
				local var_2_0, var_2_1 = var_1_5:triggerFavor(var_1_2, var_1_4.award)

				self:sendNotification(GAME.APARTMENT_TRIGGER_FAVOR_DONE, {
					triggerId = var_1_4.award,
					cost = var_2_1,
					delta = var_2_0,
					apartment = var_1_6
				})
			end

			PlayerPrefs.SetInt("apartment_collection_item", var_1_3)
			self:sendNotification(GAME.APARTMENT_COLLECTION_ITEM_DONE, {
				isNew = true,
				itemId = var_1_3
			})
			pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataCollectionItem(var_1_3, 2))
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return ApartmentCollectionItemCommand
