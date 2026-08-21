local var_0_0 = class("EquipCodeLikeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(CollectionProxy)
	local var_1_2 = getProxy(CollectionProxy):getShipGroup(var_1_0.groupId)
	local var_1_3 = underscore.detect(getProxy(CollectionProxy):getShipGroup(var_1_0.groupId):getEquipCodes(), function(arg_2_0)
		return arg_2_0.id == var_0
	end)

	pg.ConnectionMgr.GetInstance():Send(17605, {
		shipgroup = var_1_0.groupId,
		shareid = var_1_0.shareId
	}, 17606, function(arg_3_0)
		if arg_3_0.result == 0 then
			var_1_3.afterLike = true
			var_1_3.like = var_1_3.like + 1

			var_1_1:updateShipGroup(var_1_2)
			arg_1_0:sendNotification(GAME.EQUIP_CODE_LIKE_DONE, {
				like = true,
				shareId = var_0
			})
			pg.TipsMgr.GetInstance():ShowTips(i18n("equipcode_like_success"))
		elseif arg_3_0.result == 7 then
			var_1_3.afterLike = true

			var_1_1:updateShipGroup(var_1_2)
			arg_1_0:sendNotification(GAME.EQUIP_CODE_LIKE_DONE, {
				shareId = var_0
			})
			pg.TipsMgr.GetInstance():ShowTips(i18n("equipcode_like_limited"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_3_0.result))
		end

		return
	end)

	return
end

return var_0_0
