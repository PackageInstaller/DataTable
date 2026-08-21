local var_0_0 = class("MetaCharacterRepairCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(BayProxy)
	local var_1_2 = getProxy(BayProxy):getShipById(var_1_0.shipID)
	local var_1_3 = getProxy(BayProxy):getShipById(var_1_0.shipID):getMetaCharacter()
	local var_1_4 = getProxy(BayProxy):getShipById(var_1_0.shipID):getMetaCharacter():getAttrVO(var_1_0.attr)
	local var_1_5 = var_1_4:getItem()

	if var_1_5:getTotalCnt() > getProxy(BagProxy):getItemCountById((var_1_5:getItemId())) then
		return
	end

	if var_1_4:isMaxLevel() then
		return
	end

	print("63301 meta repair:", var_1_0.shipID, var_1_5.id)
	pg.ConnectionMgr.GetInstance():Send(63301, {
		ship_id = var_1_0.shipID,
		repair_id = var_1_5.id
	}, 63302, function(arg_2_0)
		if arg_2_0.result == 0 then
			print("63302 meta repair success:")
			var_1_4:levelUp()
			var_1_1:updateShip(var_1_2)
			getProxy(MetaCharacterProxy):getMetaProgressVOByID(var_1_3.id):updateShip(var_1_2)
			arg_1_0:sendNotification(GAME.CONSUME_ITEM, Drop.New({
				type = DROP_TYPE_ITEM,
				id = var_0,
				count = var_0
			}))
			arg_1_0:sendNotification(GAME.REPAIR_META_CHARACTER_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
