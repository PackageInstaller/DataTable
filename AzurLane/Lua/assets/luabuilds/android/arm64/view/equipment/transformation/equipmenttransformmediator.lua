local var_0_0 = class("EquipmentTransformMediator", import("view.base.ContextMediator"))

var_0_0.TRANSFORM_EQUIP = "transform equip"
var_0_0.UPDATE_NEW_FLAG = "UPDATE NEW FLAG"
var_0_0.OPEN_TRANSFORM_TREE = "OPEN TRANSFORM TREE"
var_0_0.SELECT_TRANSFORM_FROM_STOREHOUSE = "SELECT_TRANSFORM_FROM_STOREHOUSE"
var_0_0.OPEN_LAYER = "OPEN_LAYER"

function var_0_0.register(arg_1_0)
	arg_1_0:BindEvent()

	arg_1_0.env = {}

	arg_1_0:getViewComponent():SetEnv(arg_1_0.env)

	arg_1_0.env.tracebackHelper = getProxy(EquipmentProxy):GetWeakEquipsDict()

	arg_1_0:getViewComponent():UpdatePlayer(getProxy(PlayerProxy):getData())

	return
end

function var_0_0.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_0.TRANSFORM_EQUIP, function(arg_3_0, arg_3_1, arg_3_2)
		arg_2_0:sendNotification(GAME.TRANSFORM_EQUIPMENT, {
			candicate = arg_3_1,
			formulaIds = {
				arg_3_2
			}
		})

		return
	end)
	arg_2_0:bind(var_0_0.UPDATE_NEW_FLAG, function(arg_4_0, arg_4_1)
		arg_2_0:sendNotification(var_0_0.UPDATE_NEW_FLAG, arg_4_1)

		return
	end)
	arg_2_0:bind(var_0_0.OPEN_TRANSFORM_TREE, function(arg_5_0, arg_5_1)
		arg_2_0:getViewComponent():closeView()
		arg_2_0:sendNotification(GAME.GO_SCENE, SCENE.EQUIPMENT_TRANSFORM, {
			targetEquipId = arg_5_1,
			mode = EquipmentTransformTreeScene.MODE_HIDESIDE
		})

		return
	end)
	arg_2_0:bind(var_0_0.SELECT_TRANSFORM_FROM_STOREHOUSE, function(arg_6_0, arg_6_1)
		arg_2_0:sendNotification(GAME.GO_SCENE, SCENE.SELECT_TRANSFORM_EQUIPMENT, {
			warp = StoreHouseConst.WARP_TO_WEAPON,
			sourceVOs = arg_2_0.env.tracebackHelper:GetEquipmentTransformCandicates(arg_6_1),
			onSelect = function(arg_7_0)
				if arg_7_0.type == DROP_TYPE_ITEM and arg_7_0.template.count < arg_7_0.composeCfg.material_num then
					pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_upgrade_feedback_lack_of_fragment", arg_7_0.template:getConfig("name")))

					return false
				elseif arg_7_0.type == DROP_TYPE_EQUIP and arg_7_0.template.count <= 0 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_x", arg_7_0.template:getConfig("name")))

					return false
				end

				return true
			end,
			onConfirm = function(arg_8_0)
				arg_2_0.contextData.sourceEquipmentInstance = arg_8_0[1] or arg_2_0.contextData.sourceEquipmentInstance

				return true
			end
		})

		return
	end)
	arg_2_0:bind(var_0_0.OPEN_LAYER, function(arg_9_0, ...)
		arg_2_0:addSubLayers(...)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_10_0)
	return {
		GAME.TRANSFORM_EQUIPMENT_DONE,
		GAME.TRANSFORM_EQUIPMENT_FAIL,
		PlayerProxy.UPDATED,
		BagProxy.ITEM_UPDATED,
		EquipmentProxy.EQUIPMENT_UPDATED,
		GAME.EQUIP_TO_SHIP_DONE,
		GAME.UNEQUIP_FROM_SHIP_DONE
	}
end

function var_0_0.handleNotification(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:getName()
	local var_11_1 = arg_11_1:getBody()

	if var_11_0 == PlayerProxy.UPDATED then
		arg_11_0:getViewComponent():UpdatePlayer(var_11_1)
	elseif var_11_0 == BagProxy.ITEM_UPDATED then
		arg_11_0:getViewComponent():UpdatePage()
	elseif var_11_0 == EquipmentProxy.EQUIPMENT_UPDATED then
		if arg_11_0.contextData.sourceEquipmentInstance then
			local var_11_2 = arg_11_0.contextData.sourceEquipmentInstance

			if var_11_1.count == 0 and var_11_2.type == DROP_TYPE_EQUIP and EquipmentProxy.SameEquip(var_11_1, var_11_2.template) then
				arg_11_0.contextData.sourceEquipmentInstance = nil
			end
		end

		local var_11_3 = arg_11_0:getViewComponent()

		var_11_3:UpdateSourceEquipmentPaths()
		var_11_3:UpdateSourceInfo()
		var_11_3:UpdateTargetInfo()
	elseif var_11_0 == GAME.UNEQUIP_FROM_SHIP_DONE or var_11_0 == GAME.EQUIP_TO_SHIP_DONE then
		local var_11_4 = arg_11_0.contextData.sourceEquipmentInstance

		if arg_11_0.contextData.sourceEquipmentInstance and var_11_4.type == DROP_TYPE_EQUIP then
			local var_11_5 = var_11_1:getEquip(var_11_4.template.shipPos)

			if var_11_4.template.shipId == var_11_1.id and (not var_11_5 or var_11_5.id ~= var_11_4.id) then
				arg_11_0.contextData.sourceEquipmentInstance = nil
			end
		end

		local var_11_6 = arg_11_0:getViewComponent()

		var_11_6:UpdateSourceEquipmentPaths()
		var_11_6:UpdateSourceInfo()
		var_11_6:UpdateTargetInfo()
	elseif var_11_0 == GAME.TRANSFORM_EQUIPMENT_DONE then
		arg_11_0.contextData.sourceEquipmentInstance = nil

		arg_11_0:getViewComponent():UpdatePage()
	elseif var_11_0 == GAME.TRANSFORM_EQUIPMENT_FAIL then
		arg_11_0:getViewComponent():UpdatePage()
	end

	return
end

return var_0_0
