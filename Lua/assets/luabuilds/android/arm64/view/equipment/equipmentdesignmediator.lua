local var_0_0 = class("EquipmentDesignMediator", import("..base.ContextMediator"))

var_0_0.MAKE_EQUIPMENT = "EquipmentDesignMediator:MAKE_EQUIPMENT"
var_0_0.OPEN_EQUIPMENTDESIGN_INDEX = "EquipmentDesignMediator:OPEN_EQUIPMENTDESIGN_INDEX"

function var_0_0.register(arg_1_0)
	arg_1_0.bagProxy = getProxy(BagProxy)

	arg_1_0.viewComponent:setItems(arg_1_0.bagProxy:getData())

	arg_1_0.equipmentProxy = getProxy(EquipmentProxy)

	arg_1_0.viewComponent:setCapacity((arg_1_0.equipmentProxy:getCapacity()))

	arg_1_0.playerProxy = getProxy(PlayerProxy)

	arg_1_0.viewComponent:setPlayer((arg_1_0.playerProxy:getData()))

	local var_1_0 = arg_1_0:getFacade():retrieveMediator(EquipmentMediator.__cname):getViewComponent()

	arg_1_0.viewComponent:SetParentTF(var_1_0._tf)
	arg_1_0.viewComponent:SetTopContainer(var_1_0.topPanel)
	arg_1_0:bind(var_0_0.MAKE_EQUIPMENT, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.COMPOSITE_EQUIPMENT, {
			id = arg_2_1,
			count = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_EQUIPMENTDESIGN_INDEX, function(arg_3_0, arg_3_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_3_1
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		GAME.COMPOSITE_EQUIPMENT_DONE,
		BagProxy.ITEM_UPDATED,
		PlayerProxy.UPDATED,
		EquipmentProxy.EQUIPMENT_UPDATED,
		GAME.TOGGLE_ALL_DESIGN_EQUIPMENT
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.COMPOSITE_EQUIPMENT_DONE then
		local var_5_2 = arg_5_0.contextData.index or 1

		arg_5_0.viewComponent:filter(var_5_2, true)
		pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_newEquipLayer_getNewEquip", var_5_1.equipment:getConfig("name") .. " X" .. var_5_1.count))
	elseif var_5_0 == BagProxy.ITEM_UPDATED then
		arg_5_0.viewComponent:setItems(arg_5_0.bagProxy:getData())
	elseif var_5_0 == PlayerProxy.UPDATED then
		arg_5_0.viewComponent:setPlayer(arg_5_0.playerProxy:getData())
	elseif var_5_0 == EquipmentProxy.EQUIPMENT_UPDATED then
		arg_5_0.viewComponent:setCapacity(arg_5_0.equipmentProxy:getCapacity())
	elseif var_5_0 == GAME.TOGGLE_ALL_DESIGN_EQUIPMENT then
		arg_5_0.contextData.isShowAllDesign = var_5_1

		local var_5_3 = arg_5_0.contextData.index or 1

		arg_5_0.viewComponent:filter(var_5_3, true)
	end

	return
end

return var_0_0
