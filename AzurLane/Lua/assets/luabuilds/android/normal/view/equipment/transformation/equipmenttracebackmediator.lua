class = var_0_10000

local var_0_0 = "EquipmentTraceBackMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.TRANSFORM_EQUIP = "transform equip"

function var_0_1.register(arg_1_0)
	arg_1_0:BindEvent()

	arg_1_0.env = {}

	local var_1_0 = arg_1_0:getViewComponent()

	var_1.SetEnv(var_1_0, arg_1_0.env)

	assert = var_1

	var_1(arg_1_0.contextData.TargetEquipmentId, "Should Set TargetEquipment First")

	local var_1_1 = arg_1_0.env

	getProxy = var_2
	EquipmentProxy = var_3

	local var_1_2 = var_2(var_3)

	var_1_1.tracebackHelper = var_2.GetWeakEquipsDict(var_1_2)

	local var_1_3 = arg_1_0:getViewComponent()
	local var_1_4 = var_1.UpdatePlayer

	getProxy = var_1_2
	PlayerProxy = var_1_10004

	local var_1_5 = var_1_2(var_1_10004)

	var_1_4(var_1_3, var_3.getData(var_1_5))

	arg_1_0.stopUpdateView = false

	return
end

function var_0_1.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_1.TRANSFORM_EQUIP, function(arg_3_0, arg_3_1, arg_3_2)
		arg_2_0.stopUpdateView = true

		local var_3_0 = arg_2_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.TRANSFORM_EQUIPMENT, {
			candicate = arg_3_1,
			formulaIds = arg_3_2
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	PlayerProxy = var_1_10002
	var_4_0[1] = var_1_10002.UPDATED
	BagProxy = var_2
	var_4_0[2] = var_2.ITEM_UPDATED
	EquipmentProxy = var_2
	var_4_0[3] = var_2.EQUIPMENT_UPDATED
	GAME = var_2
	var_4_0[4] = var_2.EQUIP_TO_SHIP_DONE
	GAME = var_2
	var_4_0[5] = var_2.UNEQUIP_FROM_SHIP_DONE
	GAME = var_2
	var_4_0[6] = var_2.TRANSFORM_EQUIPMENT_DONE
	GAME = var_2
	var_4_0[7] = var_2.TRANSFORM_EQUIPMENT_FAIL

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1
	local var_5_2 = arg_5_1.getBody(var_5_1)

	PlayerProxy = var_5_1

	if var_5_0 == var_5_1.UPDATED then
		var_1_10006 = arg_5_0:getViewComponent()

		var_4.UpdatePlayer(var_1_10006, var_5_2)

		goto label_5_0
	end

	BagProxy = var_4

	if var_5_0 == var_4.ITEM_UPDATED then
		if arg_5_0.stopUpdateView then
			return
		end

		var_1_10006 = arg_5_0:getViewComponent()

		var_4.UpdateSort(var_1_10006)

		var_1_10006 = var_4

		var_4.UpdateSourceList(var_1_10006)

		var_1_10006 = var_4

		var_4.UpdateFormula(var_1_10006)

		goto label_5_0
	end

	EquipmentProxy = var_4

	local var_5_3

	if var_5_0 == var_4.EQUIPMENT_UPDATED then
		if arg_5_0.stopUpdateView then
			return
		end

		if arg_5_0.contextData.sourceEquipmentInstance then
			var_5_3 = var_5_2.count == 0

			local var_5_4 = arg_5_0.contextData.sourceEquipmentInstance

			if var_5_3 then
				var_1_10006 = var_5_4.type
				DROP_TYPE_EQUIP = var_1_10007

				if var_1_10006 == var_1_10007 then
					EquipmentProxy = var_1_10006

					if var_1_10006.SameEquip(var_5_2, var_5_4.template) then
						var_1_10006 = arg_5_0.contextData
						var_1_10006.sourceEquipmentInstance = nil
					end
				end
			end
		end

		var_1_10006 = arg_5_0:getViewComponent()

		var_5_3.UpdateSourceEquipmentPaths(var_1_10006)

		var_1_10006 = var_5_3

		var_5_3.UpdateSort(var_1_10006)

		var_1_10006 = var_5_3

		var_5_3.UpdateSourceList(var_1_10006)

		var_1_10006 = var_5_3

		var_5_3.UpdateFormula(var_1_10006)

		goto label_5_0
	end

	GAME = var_5_3

	if var_5_0 ~= var_5_3.UNEQUIP_FROM_SHIP_DONE then
		GAME = var_4

		if var_5_0 == var_4.EQUIP_TO_SHIP_DONE then
			if arg_5_0.stopUpdateView then
				return
			end

			if arg_5_0.contextData.sourceEquipmentInstance then
				local var_5_5 = var_4.type

				DROP_TYPE_EQUIP = var_1_10006

				if var_5_5 == var_1_10006 then
					local var_5_6 = var_5_2:getEquip(var_4.template.shipPos)

					if var_4.template.shipId == var_5_2.id and (not var_5_6 or var_5_6.id ~= var_4.id) then
						arg_5_0.contextData.sourceEquipmentInstance = nil
					end
				end
			end

			local var_5_7 = arg_5_0:getViewComponent()

			var_5.UpdateSourceEquipmentPaths(var_5_7)
			var_5:UpdateSort()
			var_5:UpdateSourceList()
			var_5:UpdateFormula()

			goto label_5_0
		end

		GAME = var_4

		if var_5_0 ~= var_4.TRANSFORM_EQUIPMENT_DONE then
			GAME = var_4

			if var_5_0 == var_4.TRANSFORM_EQUIPMENT_FAIL then
				arg_5_0.stopUpdateView = false

				local var_5_8 = arg_5_0:getViewComponent()

				var_4.UpdateSourceEquipmentPaths(var_5_8)
				var_4:UpdateSort()
				var_4:UpdateSourceList()
				var_4:UpdateFormula()
			end

			::label_5_0::

			return
		end
	end
end

return var_0_1
