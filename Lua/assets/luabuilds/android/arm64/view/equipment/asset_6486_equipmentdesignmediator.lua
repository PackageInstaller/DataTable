local EquipmentDesignMediator = class("EquipmentDesignMediator", import("..base.ContextMediator"))

EquipmentDesignMediator.MAKE_EQUIPMENT = "EquipmentDesignMediator:MAKE_EQUIPMENT"
EquipmentDesignMediator.OPEN_EQUIPMENTDESIGN_INDEX = "EquipmentDesignMediator:OPEN_EQUIPMENTDESIGN_INDEX"

function EquipmentDesignMediator:register()
	self.bagProxy = getProxy(BagProxy)

	self.viewComponent:setItems(self.bagProxy:getData())

	self.equipmentProxy = getProxy(EquipmentProxy)

	self.viewComponent:setCapacity((self.equipmentProxy:getCapacity()))

	self.playerProxy = getProxy(PlayerProxy)

	self.viewComponent:setPlayer((self.playerProxy:getData()))

	local var_1_0 = self:getFacade():retrieveMediator(EquipmentMediator.__cname):getViewComponent()

	self.viewComponent:SetParentTF(var_1_0._tf)
	self.viewComponent:SetTopContainer(var_1_0.topPanel)
	self:bind(EquipmentDesignMediator.MAKE_EQUIPMENT, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.COMPOSITE_EQUIPMENT, {
			id = arg_2_1,
			count = arg_2_2
		})

		return
	end)
	self:bind(EquipmentDesignMediator.OPEN_EQUIPMENTDESIGN_INDEX, function(arg_3_0, arg_3_1)
		self:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_3_1
		}))

		return
	end)

	return
end

function EquipmentDesignMediator:listNotificationInterests()
	return {
		GAME.COMPOSITE_EQUIPMENT_DONE,
		BagProxy.ITEM_UPDATED,
		PlayerProxy.UPDATED,
		EquipmentProxy.EQUIPMENT_UPDATED,
		GAME.TOGGLE_ALL_DESIGN_EQUIPMENT
	}
end

function EquipmentDesignMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.COMPOSITE_EQUIPMENT_DONE then
		self.viewComponent:filter(self.contextData.index or 1, true)
		pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_newEquipLayer_getNewEquip", var_5_1.equipment:getConfig("name") .. " X" .. var_5_1.count))
	elseif var_5_0 == BagProxy.ITEM_UPDATED then
		self.viewComponent:setItems(self.bagProxy:getData())
	elseif var_5_0 == PlayerProxy.UPDATED then
		self.viewComponent:setPlayer(self.playerProxy:getData())
	elseif var_5_0 == EquipmentProxy.EQUIPMENT_UPDATED then
		self.viewComponent:setCapacity(self.equipmentProxy:getCapacity())
	elseif var_5_0 == GAME.TOGGLE_ALL_DESIGN_EQUIPMENT then
		self.contextData.isShowAllDesign = var_5_1

		self.viewComponent:filter(self.contextData.index or 1, true)
	end

	return
end

return EquipmentDesignMediator
