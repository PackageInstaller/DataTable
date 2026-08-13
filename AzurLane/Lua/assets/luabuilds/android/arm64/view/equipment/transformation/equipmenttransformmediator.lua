class = var_0_10000

local var_0_0 = "EquipmentTransformMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.TRANSFORM_EQUIP = "transform equip"
var_0_1.UPDATE_NEW_FLAG = "UPDATE NEW FLAG"
var_0_1.OPEN_TRANSFORM_TREE = "OPEN TRANSFORM TREE"
var_0_1.SELECT_TRANSFORM_FROM_STOREHOUSE = "SELECT_TRANSFORM_FROM_STOREHOUSE"
var_0_1.OPEN_LAYER = "OPEN_LAYER"

function var_0_1.register(arg_1_0)
	arg_1_0:BindEvent()

	arg_1_0.env = {}

	local var_1_0 = arg_1_0:getViewComponent()

	var_1.SetEnv(var_1_0, arg_1_0.env)

	local var_1_1 = arg_1_0.env

	getProxy = var_1_10002
	EquipmentProxy = var_4

	local var_1_2 = var_1_10002(var_4)

	var_1_1.tracebackHelper = var_2.GetWeakEquipsDict(var_1_2)

	local var_1_3 = arg_1_0:getViewComponent()
	local var_1_4 = var_1.UpdatePlayer

	getProxy = var_1_2
	PlayerProxy = var_1_10006

	local var_1_5 = var_1_2(var_1_10006)

	var_1_4(var_1_3, var_4.getData(var_1_5))

	return
end

function var_0_1.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_1.TRANSFORM_EQUIP, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_2_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10006

		var_3_1(var_3_0, var_2_10006.TRANSFORM_EQUIPMENT, {
			candicate = arg_3_1,
			formulaIds = {
				arg_3_2
			}
		})

		return
	end)
	arg_2_0:bind(var_0_1.UPDATE_NEW_FLAG, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.sendNotification(var_4_0, var_0_1.UPDATE_NEW_FLAG, arg_4_1)

		return
	end)
	arg_2_0:bind(var_0_1.OPEN_TRANSFORM_TREE, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_2_0
		local var_5_1 = var_2.getViewComponent(var_5_0)

		var_2.closeView(var_5_1)

		local var_5_2 = arg_2_0
		local var_5_3 = var_2.sendNotification

		GAME = var_2_10005

		local var_5_4 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		local var_5_5 = var_2_10006.EQUIPMENT_TRANSFORM
		local var_5_6 = {
			targetEquipId = arg_5_1
		}

		EquipmentTransformTreeScene = var_2_10008
		var_5_6.mode = var_2_10008.MODE_HIDESIDE

		var_5_3(var_5_2, var_5_4, var_5_5, var_5_6)

		return
	end)
	arg_2_0:bind(var_0_1.SELECT_TRANSFORM_FROM_STOREHOUSE, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_2_0.env.tracebackHelper
		local var_6_1 = var_2.GetEquipmentTransformCandicates(var_6_0, arg_6_1)
		local var_6_2 = arg_2_0
		local var_6_3 = var_3.sendNotification

		GAME = var_2_10006

		local var_6_4 = var_2_10006.GO_SCENE

		SCENE = var_2_10007

		local var_6_5 = var_2_10007.SELECT_TRANSFORM_EQUIPMENT
		local var_6_6 = {}

		StoreHouseConst = var_2_10009
		var_6_6.warp = var_2_10009.WARP_TO_WEAPON
		var_6_6.sourceVOs = var_6_1

		function var_6_6.onSelect(arg_7_0)
			local var_7_0 = arg_7_0.type

			DROP_TYPE_ITEM = var_3_10002

			if var_7_0 == var_3_10002 and arg_7_0.template.count < arg_7_0.composeCfg.material_num then
				pg = var_1

				local var_7_1 = var_1.TipsMgr.GetInstance()
				local var_7_2 = var_1.ShowTips

				i18n = var_3_10004

				local var_7_3 = "equipment_upgrade_feedback_lack_of_fragment"
				local var_7_4 = arg_7_0.template

				var_7_2(var_7_1, var_3_10004(var_7_3, var_7.getConfig(var_7_4, "name")))

				return false
			else
				local var_7_5 = arg_7_0.type

				DROP_TYPE_EQUIP = var_3_10002

				if var_7_5 == var_3_10002 and arg_7_0.template.count <= 0 then
					pg = var_1

					local var_7_6 = var_1.TipsMgr.GetInstance()
					local var_7_7 = var_1.ShowTips

					i18n = var_3_10004

					local var_7_8 = "common_no_x"
					local var_7_9 = arg_7_0.template

					var_7_7(var_7_6, var_3_10004(var_7_8, var_7.getConfig(var_7_9, "name")))

					return false
				end
			end

			return true
		end

		function var_6_6.onConfirm(arg_8_0)
			local var_8_0 = arg_2_0.contextData
			local var_8_1

			if not arg_8_0[1] then
				var_8_1 = arg_2_0.contextData.sourceEquipmentInstance
			end

			var_8_0.sourceEquipmentInstance = var_8_1

			return true
		end

		var_6_3(var_6_2, var_6_4, var_6_5, var_6_6)

		return
	end)
	arg_2_0:bind(var_0_1.OPEN_LAYER, function(arg_9_0, ...)
		local var_9_0 = arg_2_0

		var_1.addSubLayers(var_9_0, ...)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_10_0)
	local var_10_0 = {}

	GAME = var_1_10002
	var_10_0[1] = var_1_10002.TRANSFORM_EQUIPMENT_DONE
	GAME = var_2
	var_10_0[2] = var_2.TRANSFORM_EQUIPMENT_FAIL
	PlayerProxy = var_2
	var_10_0[3] = var_2.UPDATED
	BagProxy = var_2
	var_10_0[4] = var_2.ITEM_UPDATED
	EquipmentProxy = var_2
	var_10_0[5] = var_2.EQUIPMENT_UPDATED
	GAME = var_2
	var_10_0[6] = var_2.EQUIP_TO_SHIP_DONE
	GAME = var_2
	var_10_0[7] = var_2.UNEQUIP_FROM_SHIP_DONE

	return var_10_0
end

function var_0_1.handleNotification(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1
	local var_11_1 = arg_11_1.getName(var_11_0)
	local var_11_2 = arg_11_1:getBody()

	PlayerProxy = var_11_0

	if var_11_1 == var_11_0.UPDATED then
		var_1_10006 = arg_11_0
		var_1_10006 = arg_11_0.getViewComponent(var_1_10006)

		var_4.UpdatePlayer(var_1_10006, var_11_2)

		goto label_11_0
	end

	BagProxy = var_4

	if var_11_1 == var_4.ITEM_UPDATED then
		var_1_10006 = arg_11_0
		var_1_10006 = arg_11_0.getViewComponent(var_1_10006)

		var_4.UpdatePage(var_1_10006)

		goto label_11_0
	end

	EquipmentProxy = var_4

	local var_11_3

	if var_11_1 == var_4.EQUIPMENT_UPDATED then
		if arg_11_0.contextData.sourceEquipmentInstance then
			var_11_3 = var_11_2.count == 0

			local var_11_4 = arg_11_0.contextData.sourceEquipmentInstance

			if var_11_3 then
				var_1_10006 = var_11_4.type
				DROP_TYPE_EQUIP = var_1_10007

				if var_1_10006 == var_1_10007 then
					EquipmentProxy = var_1_10006

					if var_1_10006.SameEquip(var_11_2, var_11_4.template) then
						var_1_10006 = arg_11_0.contextData
						var_1_10006.sourceEquipmentInstance = nil
					end
				end
			end
		end

		var_1_10006 = arg_11_0

		local var_11_5 = arg_11_0.getViewComponent(var_1_10006)

		var_11_3.UpdateSourceEquipmentPaths(var_11_5)
		var_11_3:UpdateSourceInfo()
		var_11_3:UpdateTargetInfo()

		goto label_11_0
	end

	GAME = var_11_3

	if var_11_1 ~= var_11_3.UNEQUIP_FROM_SHIP_DONE then
		GAME = var_4

		if var_11_1 == var_4.EQUIP_TO_SHIP_DONE then
			if arg_11_0.contextData.sourceEquipmentInstance then
				local var_11_6 = var_4.type

				DROP_TYPE_EQUIP = var_1_10006

				if var_11_6 == var_1_10006 then
					local var_11_7 = var_11_2:getEquip(var_4.template.shipPos)

					if var_4.template.shipId == var_11_2.id and (not var_11_7 or var_11_7.id ~= var_4.id) then
						arg_11_0.contextData.sourceEquipmentInstance = nil
					end
				end
			end

			local var_11_8 = arg_11_0:getViewComponent()

			var_5.UpdateSourceEquipmentPaths(var_11_8)
			var_5:UpdateSourceInfo()
			var_5:UpdateTargetInfo()
		else
			GAME = var_4

			local var_11_9

			if var_11_1 == var_4.TRANSFORM_EQUIPMENT_DONE then
				var_11_9 = arg_11_0.contextData
				var_11_9.sourceEquipmentInstance = nil

				local var_11_10 = arg_11_0:getViewComponent()

				var_11_9.UpdatePage(var_11_10)
			else
				GAME = var_11_9

				if var_11_1 == var_11_9.TRANSFORM_EQUIPMENT_FAIL then
					local var_11_11 = arg_11_0:getViewComponent()

					var_4.UpdatePage(var_11_11)
				end
			end
		end

		::label_11_0::

		return
	end
end

return var_0_1
