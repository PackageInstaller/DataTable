local ApartmentReplaceFurnitureCommand = class("ApartmentReplaceFurnitureCommand", pm.SimpleCommand)

function ApartmentReplaceFurnitureCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1.body.roomId
	local var_1_1 = arg_1_1.body.furnitures

	pg.ConnectionMgr.GetInstance():Send(28007, {
		room_id = arg_1_1.body.roomId,
		furnitures = _.map(arg_1_1.body.furnitures, function(arg_2_0)
			return {
				slot_id = arg_2_0.slotId,
				furniture_id = arg_2_0.furnitureId
			}
		end)
	}, 28008, function(arg_3_0)
		if arg_3_0.result ~= 0 then
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_3_0.result))
			self:sendNotification(GAME.APARTMENT_REPLACE_FURNITURE_ERROR)

			return
		end

		getProxy(ApartmentProxy):ModifyRoom(var_1_0, function(arg_4_0)
			arg_4_0:ReplaceFurnitures(var_1_1)

			return
		end)
		pg.TipsMgr.GetInstance():ShowTips(i18n("dorm3d_furniture_save_success"))
		self:sendNotification(GAME.APARTMENT_REPLACE_FURNITURE_DONE)

		return
	end)

	return
end

return ApartmentReplaceFurnitureCommand
