local EquipCodeLikeCommand = class("EquipCodeLikeCommand", pm.SimpleCommand)

function EquipCodeLikeCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.shareId
	local var_1_2 = getProxy(CollectionProxy)
	local var_1_3 = var_1_2:getShipGroup(var_1_0.groupId)
	local var_1_4 = underscore.detect(var_1_3:getEquipCodes(), function(arg_2_0)
		return arg_2_0.id == var_1_1
	end)

	pg.ConnectionMgr.GetInstance():Send(17605, {
		shipgroup = var_1_0.groupId,
		shareid = var_1_0.shareId
	}, 17606, function(arg_3_0)
		if arg_3_0.result == 0 then
			var_1_4.afterLike = true
			var_1_4.like = var_1_4.like + 1

			var_1_2:updateShipGroup(var_1_3)
			self:sendNotification(GAME.EQUIP_CODE_LIKE_DONE, {
				like = true,
				shareId = var_1_1
			})
			pg.TipsMgr.GetInstance():ShowTips(i18n("equipcode_like_success"))
		elseif arg_3_0.result == 7 then
			var_1_4.afterLike = true

			var_1_2:updateShipGroup(var_1_3)
			self:sendNotification(GAME.EQUIP_CODE_LIKE_DONE, {
				shareId = var_1_1
			})
			pg.TipsMgr.GetInstance():ShowTips(i18n("equipcode_like_limited"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_3_0.result))
		end

		return
	end)

	return
end

return EquipCodeLikeCommand
