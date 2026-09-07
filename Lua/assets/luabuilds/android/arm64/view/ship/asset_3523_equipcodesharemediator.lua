local EquipCodeShareMediator = class("EquipCodeShareMediator", import("..base.ContextMediator"))

EquipCodeShareMediator.OPEN_TAG_INDEX = "EquipCodeShareMediator.OPEN_TAG_INDEX"
EquipCodeShareMediator.LIKE_EQUIP_CODE = "EquipCodeShareMediator.LIKE_EQUIP_CODE"
EquipCodeShareMediator.IMPEACH_EQUIP_CODE = "EquipCodeShareMediator.IMPEACH_EQUIP_CODE"

function EquipCodeShareMediator:register()
	self:bind(EquipCodeShareMediator.IMPEACH_EQUIP_CODE, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		self:sendNotification(GAME.EQUIP_CODE_IMPEACH, {
			groupId = arg_2_1,
			shareId = arg_2_2,
			type = arg_2_3
		})

		return
	end)
	self:bind(EquipCodeShareMediator.LIKE_EQUIP_CODE, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.EQUIP_CODE_LIKE, {
			groupId = arg_3_1,
			shareId = arg_3_2
		})

		return
	end)
	self:bind(EquipCodeShareMediator.OPEN_TAG_INDEX, function(arg_4_0, arg_4_1)
		self:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_4_1
		}))

		return
	end)
	self.viewComponent:setShipGroup((getProxy(CollectionProxy):getShipGroup(self.contextData.shipGroupId)))

	return
end

function EquipCodeShareMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.EQUIP_CODE_LIKE_DONE] = function(arg_6_0, arg_6_1)
			local var_6_0 = arg_6_1:getBody()

			arg_6_0.viewComponent:refreshLikeCommand(var_6_0.shareId, var_6_0.like)

			return
		end
	}

	return
end

return EquipCodeShareMediator
