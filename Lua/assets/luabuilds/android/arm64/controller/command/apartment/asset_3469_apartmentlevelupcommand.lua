local ApartmentLevelUpCommand = class("ApartmentLevelUpCommand", pm.SimpleCommand)

function ApartmentLevelUpCommand:execute(arg_1_1)
	local var_1_1 = arg_1_1:getBody().groupId
	local var_1_3 = getProxy(ApartmentProxy)
	local var_1_4 = var_1_3:getApartment(arg_1_1:getBody().groupId)

	if not var_1_4:canLevelUp() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(28005, {
		ship_group = arg_1_1:getBody().groupId
	}, 28006, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_3:ModifyApartment(var_1_1, function(arg_3_0)
				arg_3_0:addLevel()

				return
			end)

			var_1_4 = var_1_3:getApartment(var_1_1)

			self:sendNotification(GAME.APARTMENT_LEVEL_UP_DONE, {
				apartment = var_1_4,
				award = PlayerConst.addTranDrop(arg_2_0.drop_list)
			})

			local var_2_0 = var_1_4:getLevel()

			_.each(pg.dorm3d_collection_template.all, function(arg_4_0)
				if pg.dorm3d_collection_template[arg_4_0].unlock[1] ~= 1 then
					return
				end

				if pg.dorm3d_collection_template[arg_4_0].unlock[2] ~= var_2_0 then
					return
				end

				pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataCollectionItem(arg_4_0, 1))

				return
			end)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return ApartmentLevelUpCommand
