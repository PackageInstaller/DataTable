local var_0_0 = class("EquipCodeShareMediator", import("..base.ContextMediator"))

var_0_0.OPEN_TAG_INDEX = "EquipCodeShareMediator.OPEN_TAG_INDEX"
var_0_0.LIKE_EQUIP_CODE = "EquipCodeShareMediator.LIKE_EQUIP_CODE"
var_0_0.IMPEACH_EQUIP_CODE = "EquipCodeShareMediator.IMPEACH_EQUIP_CODE"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.IMPEACH_EQUIP_CODE, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		arg_1_0:sendNotification(GAME.EQUIP_CODE_IMPEACH, {
			groupId = arg_2_1,
			shareId = arg_2_2,
			type = arg_2_3
		})

		return
	end)
	arg_1_0:bind(var_0_0.LIKE_EQUIP_CODE, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:sendNotification(GAME.EQUIP_CODE_LIKE, {
			groupId = arg_3_1,
			shareId = arg_3_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_TAG_INDEX, function(arg_4_0, arg_4_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_4_1
		}))

		return
	end)
	arg_1_0.viewComponent:setShipGroup((getProxy(CollectionProxy):getShipGroup(arg_1_0.contextData.shipGroupId)))

	return
end

function var_0_0.initNotificationHandleDic(arg_5_0)
	arg_5_0.handleDic = {
		[GAME.EQUIP_CODE_LIKE_DONE] = function(arg_6_0, arg_6_1)
			local var_6_0 = arg_6_1:getBody()

			arg_6_0.viewComponent:refreshLikeCommand(var_6_0.shareId, var_6_0.like)

			return
		end
	}

	return
end

return var_0_0
