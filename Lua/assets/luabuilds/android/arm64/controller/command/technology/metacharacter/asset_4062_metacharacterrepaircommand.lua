local MetaCharacterRepairCommand = class("MetaCharacterRepairCommand", pm.SimpleCommand)

function MetaCharacterRepairCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(BayProxy)
	local var_1_2 = var_1_1:getShipById(var_1_0.shipID)
	local var_1_3 = var_1_2:getMetaCharacter()
	local var_1_4 = var_1_3:getAttrVO(var_1_0.attr)
	local var_1_5 = var_1_4:getItem()
	local var_1_6 = var_1_5:getTotalCnt()
	local var_1_7 = var_1_5:getItemId()

	if var_1_6 > getProxy(BagProxy):getItemCountById(var_1_7) then
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
			self:sendNotification(GAME.CONSUME_ITEM, Drop.New({
				type = DROP_TYPE_ITEM,
				id = var_1_7,
				count = var_1_6
			}))
			self:sendNotification(GAME.REPAIR_META_CHARACTER_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return MetaCharacterRepairCommand
