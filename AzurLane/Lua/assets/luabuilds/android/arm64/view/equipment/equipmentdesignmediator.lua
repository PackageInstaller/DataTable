class = var_0_10000

local var_0_0 = "EquipmentDesignMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.MAKE_EQUIPMENT = "EquipmentDesignMediator:MAKE_EQUIPMENT"
var_0_1.OPEN_EQUIPMENTDESIGN_INDEX = "EquipmentDesignMediator:OPEN_EQUIPMENTDESIGN_INDEX"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	BagProxy = var_1_10003
	arg_1_0.bagProxy = var_1_10001(var_1_10003)

	local var_1_0 = arg_1_0.viewComponent
	local var_1_1 = var_1.setItems
	local var_1_2 = arg_1_0.bagProxy

	var_1_1(var_1_0, var_4.getData(var_1_2))

	getProxy = var_1_1
	EquipmentProxy = var_1_0
	arg_1_0.equipmentProxy = var_1_1(var_1_0)

	local var_1_3 = arg_1_0.equipmentProxy
	local var_1_4 = var_1.getCapacity(var_1_3)
	local var_1_5 = arg_1_0.viewComponent

	var_2.setCapacity(var_1_5, var_1_4)

	getProxy = var_2
	PlayerProxy = var_1_5
	arg_1_0.playerProxy = var_2(var_1_5)

	local var_1_6 = arg_1_0.playerProxy
	local var_1_7 = var_2.getData(var_1_6)
	local var_1_8 = arg_1_0.viewComponent

	var_3.setPlayer(var_1_8, var_1_7)

	local var_1_9 = arg_1_0:getFacade()
	local var_1_10 = var_3.retrieveMediator

	EquipmentMediator = var_6

	local var_1_11 = var_1_10(var_1_9, var_6.__cname)
	local var_1_12 = var_3.getViewComponent(var_1_11)
	local var_1_13 = arg_1_0.viewComponent

	var_5.SetParentTF(var_1_13, var_1_12._tf)

	local var_1_14 = arg_1_0.viewComponent

	var_5.SetTopContainer(var_1_14, var_1_12.topPanel)
	arg_1_0:bind(var_0_1.MAKE_EQUIPMENT, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.COMPOSITE_EQUIPMENT, {
			id = arg_2_1,
			count = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_EQUIPMENTDESIGN_INDEX, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_3_2 = var_2_10005.New
		local var_3_3 = {}

		CustomIndexLayer = var_2_10008
		var_3_3.viewComponent = var_2_10008
		CustomIndexMediator = var_2_10008
		var_3_3.mediator = var_2_10008
		var_3_3.data = arg_3_1

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	GAME = var_1_10002
	var_4_0[1] = var_1_10002.COMPOSITE_EQUIPMENT_DONE
	BagProxy = var_2
	var_4_0[2] = var_2.ITEM_UPDATED
	PlayerProxy = var_2
	var_4_0[3] = var_2.UPDATED
	EquipmentProxy = var_2
	var_4_0[4] = var_2.EQUIPMENT_UPDATED
	GAME = var_2
	var_4_0[5] = var_2.TOGGLE_ALL_DESIGN_EQUIPMENT

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1
	local var_5_1 = arg_5_1.getName(var_5_0)
	local var_5_2 = arg_5_1:getBody()

	GAME = var_5_0

	local var_5_3

	if var_5_1 == var_5_0.COMPOSITE_EQUIPMENT_DONE then
		var_5_3 = var_5_2.equipment

		local var_5_4 = var_5_2.count
		local var_5_5 = arg_5_0.viewComponent
		local var_5_6 = var_6.filter
		local var_5_7

		if not arg_5_0.contextData.index then
			var_5_7 = 1
		end

		var_5_6(var_5_5, var_5_7, true)

		local var_5_8 = var_5_3:getConfig("name")

		pg = var_1_10007

		local var_5_9 = var_1_10007.TipsMgr.GetInstance()
		local var_5_10 = var_7.ShowTips

		i18n = var_10

		var_5_10(var_5_9, var_10("equipment_newEquipLayer_getNewEquip", var_5_8 .. " X" .. var_5_4))
	else
		BagProxy = var_5_3

		local var_5_12

		if var_5_1 == var_5_3.ITEM_UPDATED then
			local var_5_11 = arg_5_0.viewComponent

			var_5_12 = var_5_12.setItems

			local var_5_13 = arg_5_0.bagProxy

			var_5_12(var_5_11, var_7.getData(var_5_13))
		else
			PlayerProxy = var_5_12

			local var_5_15

			if var_5_1 == var_5_12.UPDATED then
				local var_5_14 = arg_5_0.viewComponent

				var_5_15 = var_5_15.setPlayer

				local var_5_16 = arg_5_0.playerProxy

				var_5_15(var_5_14, var_7.getData(var_5_16))
			else
				EquipmentProxy = var_5_15

				local var_5_18

				if var_5_1 == var_5_15.EQUIPMENT_UPDATED then
					local var_5_17 = arg_5_0.viewComponent

					var_5_18 = var_5_18.setCapacity

					local var_5_19 = arg_5_0.equipmentProxy

					var_5_18(var_5_17, var_7.getCapacity(var_5_19))
				else
					GAME = var_5_18

					if var_5_1 == var_5_18.TOGGLE_ALL_DESIGN_EQUIPMENT then
						arg_5_0.contextData.isShowAllDesign = var_5_2

						local var_5_20 = arg_5_0.viewComponent
						local var_5_21 = var_4.filter
						local var_5_22

						if not arg_5_0.contextData.index then
							var_5_22 = 1
						end

						var_5_21(var_5_20, var_5_22, true)
					end
				end
			end
		end
	end

	return
end

return var_0_1
