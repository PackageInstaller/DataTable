class = var_0_10000

local var_0_0 = "WorldInventoryMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.OnUseItem = "WorldInventoryMediator.OnUseItem"
var_0_1.OnMap = "WorldInventoryMediator.OnMap"
var_0_1.OnOpenAllocateLayer = "WorldInventoryMediator.OnOpenAllocateLayer"
var_0_1.OPEN_MODULEINFO_LAYER = "WorldInventoryMediator:OPEN_MODULEINFO_LAYER"
var_0_1.OPEN_EQUIPMENT_INDEX = "OPEN_EQUIPMENT_INDEX"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OnUseItem, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = arg_1_0
		local var_2_1 = var_4.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.WORLD_ITEM_USE, {
			itemID = arg_2_1,
			count = arg_2_2 or 1,
			args = arg_2_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.OnMap, function(arg_3_0, arg_3_1)
		nowWorld = var_2_10002

		local var_3_0 = var_2_10002()
		local var_3_1 = var_2.FindTreasureEntrance(var_3_0, arg_3_1)
		local var_3_2

		ipairs = var_4

		for iter_3_0, iter_3_1 in var_4(var_3_1.config.teasure_chapter) do
			if arg_3_1 == iter_3_1[1] then
				var_3_2 = iter_3_1[2]

				break
			end
		end

		local var_3_3 = arg_1_0

		var_4.sendNotification(var_3_3, var_0_1.OnMap, {
			entrance = var_3_1,
			mapId = var_3_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.OnOpenAllocateLayer, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_4_2 = var_2_10004.New
		local var_4_3 = {}

		WorldAllocateMediator = var_2_10006
		var_4_3.mediator = var_2_10006
		WorldAllocateLayer = var_2_10006
		var_4_3.viewComponent = var_2_10006
		var_4_3.data = arg_4_1

		var_4_1(var_4_0, var_4_2(var_4_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_MODULEINFO_LAYER, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
		return
	end)
	arg_1_0:bind(var_0_1.OPEN_EQUIPMENT_INDEX, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_6_2 = var_2_10004.New
		local var_6_3 = {}

		CustomIndexLayer = var_2_10006
		var_6_3.viewComponent = var_2_10006
		CustomIndexMediator = var_2_10006
		var_6_3.mediator = var_2_10006
		var_6_3.data = arg_6_1

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)

	nowWorld = var_1

	local var_1_0 = var_1()
	local var_1_1 = arg_1_0.viewComponent

	var_2.setInventoryProxy(var_1_1, var_1_0:GetInventoryProxy())

	local var_1_2 = arg_1_0.viewComponent

	var_2.setWorldFleet(var_1_2, var_1_0:GetFleets())

	getProxy = var_2
	BayProxy = var_1_2

	local var_1_3 = var_2(var_1_2)

	getProxy = var_1_2
	EquipmentProxy = var_4

	local var_1_4 = var_1_2(var_4)
	local var_1_5 = var_3.getEquipments(var_1_4, true)

	ipairs = var_1_4

	for iter_1_0, iter_1_1 in var_1_4(var_1_3:getEquipsInShips()) do
		table = var_1_10010

		var_1_10010.insert(var_1_5, iter_1_1)
	end

	local var_1_6 = arg_1_0.viewComponent

	var_5.setEquipments(var_1_6, var_1_5)

	getProxy = var_5
	BagProxy = var_1_6

	local var_1_7 = var_5(var_1_6)
	local var_1_8 = var_5.GetItemsByCondition(var_1_7, {
		is_world = 1
	})
	local var_1_9 = arg_1_0.viewComponent

	var_7.SetMaterials(var_1_9, var_1_8)

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	EquipmentProxy = var_1_10002
	var_7_0[1] = var_1_10002.EQUIPMENT_UPDATED
	GAME = var_2
	var_7_0[2] = var_2.USE_ITEM_DONE
	GAME = var_2
	var_7_0[3] = var_2.DESTROY_EQUIPMENTS_DONE
	BagProxy = var_2
	var_7_0[4] = var_2.ITEM_UPDATED
	var_7_0[5] = var_0_1.BATCHDESTROY_MODE
	GAME = var_2
	var_7_0[6] = var_2.REVERT_EQUIPMENT_DONE
	GAME = var_2
	var_7_0[7] = var_2.FRAG_SELL_DONE
	GAME = var_2
	var_7_0[8] = var_2.TRANSFORM_EQUIPMENT_AWARD_FINISHED

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1
	local var_8_2 = arg_8_1.getBody(var_8_1)

	EquipmentProxy = var_8_1

	if var_8_0 == var_8_1.EQUIPMENT_UPDATED then
		var_1_10005 = arg_8_0.viewComponent

		var_4.setEquipment(var_1_10005, var_8_2)
	else
		GAME = var_4

		local var_8_3

		if var_8_0 == var_4.USE_ITEM_DONE then
			if #var_8_2.drops ~= 0 then
				var_1_10005 = arg_8_0.viewComponent
				var_8_3 = var_8_3.emit
				BaseUI = var_1_10006

				var_8_3(var_1_10005, var_1_10006.ON_AWARD, {
					animation = true,
					items = var_8_2.drops
				})
			end
		else
			GAME = var_8_3

			local var_8_4

			if var_8_0 == var_8_3.FRAG_SELL_DONE then
				var_1_10005 = arg_8_0.viewComponent
				var_8_4 = var_8_4.emit
				BaseUI = var_1_10006

				var_8_4(var_1_10005, var_1_10006.ON_ACHIEVE, var_8_2.awards)
			else
				GAME = var_8_4

				local var_8_5

				if var_8_0 == var_8_4.DESTROY_EQUIPMENTS_DONE then
					table = var_8_5

					if var_8_5.getCount(var_8_2) ~= 0 then
						var_1_10005 = arg_8_0.viewComponent
						var_8_5 = var_8_5.emit
						BaseUI = var_1_10006

						var_8_5(var_1_10005, var_1_10006.ON_AWARD, {
							items = var_8_2
						})
					end
				else
					BagProxy = var_8_5

					if var_8_0 == var_8_5.ITEM_UPDATED then
						if arg_8_0.canUpdate then
							getProxy = var_4
							BagProxy = var_1_10005
							var_1_10006 = var_4(var_1_10005)

							local var_8_6 = var_4.GetItemsByCondition(var_1_10006, {
								is_world = 1
							})
							local var_8_7 = arg_8_0.viewComponent

							var_1_10006.SetMaterials(var_8_7, var_8_6)
						end
					else
						GAME = var_4

						local var_8_9

						if var_8_0 == var_4.REVERT_EQUIPMENT_DONE then
							table = var_8_9

							if var_8_9.getCount(var_8_2.awards) > 0 then
								local var_8_8 = arg_8_0.viewComponent

								var_8_9 = var_8_9.emit
								BaseUI = var_1_10006

								var_8_9(var_8_8, var_1_10006.ON_AWARD, {
									items = var_8_2.awards
								})
							end
						else
							GAME = var_8_9

							if var_8_0 == var_8_9.TRANSFORM_EQUIPMENT_AWARD_FINISHED then
								local var_8_10 = arg_8_0:getViewComponent()

								var_4.Scroll2Equip(var_8_10, var_8_2.newEquip)
							end
						end
					end
				end
			end
		end
	end

	return
end

return var_0_1
