local var_0_0 = class("ApartmentRoomInviteUnlockCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.roomId
	local var_1_2 = var_1_0.groupId
	local var_1_3 = getProxy(ApartmentProxy)
	local var_1_4 = getProxy(ApartmentProxy):getRoom(var_1_0.roomId)

	assert(underscore.any(var_1_4:getConfig("character_pay"), function(arg_2_0)
		return arg_2_0 == var_1_2
	end))

	local var_1_5 = CommonCommodity.New({
		id = Apartment.getGroupConfig(var_1_2, var_1_4:getConfig("invite_cost"))
	}, Goods.TYPE_SHOPSTREET)
	local var_1_6, var_1_7, var_1_8 = var_1_5:GetPrice()
	local var_1_9 = {
		(Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = var_1_5:GetResType(),
			count = var_1_6
		}))
	}

	if #var_1_9 > 0 and underscore.any(var_1_9, function(arg_3_0)
		return arg_3_0:getOwnedCount() < arg_3_0.count
	end) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("temple_consume_not_enough"))

		return
	end

	if not var_1_4 or var_1_4.unlockCharacter[var_1_2] then
		local var_1_10 = pg.TipsMgr.GetInstance()
		local var_1_11 = var_1_10
		local var_1_13 = "unlock error:%d, %d"
		local var_1_14 = var_1_4 and var_1_0.roomId or 0

		if var_1_4 then
			local var_1_15 = var_1_4.unlockCharacter[var_1_2] or 0

			var_1_12(var_1_11, var_1_13, var_1_14, var_1_15)

			do return end

			pg.ConnectionMgr.GetInstance():Send(28019, {
				room_id = var_1_0.roomId,
				ship_group = var_1_2
			}, 28020, function(arg_4_0)
				if arg_4_0.result == 0 then
					for iter_4_0, iter_4_1 in ipairs(var_1_9) do
						reducePlayerOwn(iter_4_1)
					end

					var_1_3:ModifyRoom(var_1_1, function(arg_5_0)
						arg_5_0.unlockCharacter[var_1_2] = true

						return
					end)
					arg_1_0:sendNotification(GAME.APARTMENT_ROOM_INVITE_UNLOCK_DONE, {
						roomId = var_1_1,
						groupId = var_1_2
					})
				else
					pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_4_0.result] .. arg_4_0.result)
				end

				return
			end)

			return
		end
	end
end

return var_0_0
