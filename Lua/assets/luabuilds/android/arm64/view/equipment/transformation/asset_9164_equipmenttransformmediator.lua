local EquipmentTransformMediator = class("EquipmentTransformMediator", import("view.base.ContextMediator"))

EquipmentTransformMediator.TRANSFORM_EQUIP = "transform equip"
EquipmentTransformMediator.UPDATE_NEW_FLAG = "UPDATE NEW FLAG"
EquipmentTransformMediator.OPEN_TRANSFORM_TREE = "OPEN TRANSFORM TREE"
EquipmentTransformMediator.SELECT_TRANSFORM_FROM_STOREHOUSE = "SELECT_TRANSFORM_FROM_STOREHOUSE"
EquipmentTransformMediator.OPEN_LAYER = "OPEN_LAYER"

function EquipmentTransformMediator:register()
	self:BindEvent()

	self.env = {}

	self:getViewComponent():SetEnv(self.env)

	self.env.tracebackHelper = getProxy(EquipmentProxy):GetWeakEquipsDict()

	self:getViewComponent():UpdatePlayer(getProxy(PlayerProxy):getData())

	return
end

function EquipmentTransformMediator:BindEvent()
	self:bind(EquipmentTransformMediator.TRANSFORM_EQUIP, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.TRANSFORM_EQUIPMENT, {
			candicate = arg_3_1,
			formulaIds = {
				arg_3_2
			}
		})

		return
	end)
	self:bind(EquipmentTransformMediator.UPDATE_NEW_FLAG, function(arg_4_0, arg_4_1)
		self:sendNotification(EquipmentTransformMediator.UPDATE_NEW_FLAG, arg_4_1)

		return
	end)
	self:bind(EquipmentTransformMediator.OPEN_TRANSFORM_TREE, function(arg_5_0, arg_5_1)
		self:getViewComponent():closeView()
		self:sendNotification(GAME.GO_SCENE, SCENE.EQUIPMENT_TRANSFORM, {
			targetEquipId = arg_5_1,
			mode = EquipmentTransformTreeScene.MODE_HIDESIDE
		})

		return
	end)
	self:bind(EquipmentTransformMediator.SELECT_TRANSFORM_FROM_STOREHOUSE, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.SELECT_TRANSFORM_EQUIPMENT, {
			warp = StoreHouseConst.WARP_TO_WEAPON,
			sourceVOs = self.env.tracebackHelper:GetEquipmentTransformCandicates(arg_6_1),
			onSelect = function(self)
				if self.type == DROP_TYPE_ITEM and self.template.count < self.composeCfg.material_num then
					pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_upgrade_feedback_lack_of_fragment", self.template:getConfig("name")))

					return false
				elseif self.type == DROP_TYPE_EQUIP and self.template.count <= 0 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_x", self.template:getConfig("name")))

					return false
				end

				return true
			end,
			onConfirm = function(self)
				self.contextData.sourceEquipmentInstance = self[1] or self.contextData.sourceEquipmentInstance

				return true
			end
		})

		return
	end)
	self:bind(EquipmentTransformMediator.OPEN_LAYER, function(arg_9_0, ...)
		self:addSubLayers(...)

		return
	end)

	return
end

function EquipmentTransformMediator:listNotificationInterests()
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

function EquipmentTransformMediator:handleNotification(arg_11_1)
	local var_11_0 = arg_11_1:getName()
	local var_11_1 = arg_11_1:getBody()

	if var_11_0 == PlayerProxy.UPDATED then
		self:getViewComponent():UpdatePlayer(var_11_1)
	elseif var_11_0 == BagProxy.ITEM_UPDATED then
		self:getViewComponent():UpdatePage()
	elseif var_11_0 == EquipmentProxy.EQUIPMENT_UPDATED then
		if self.contextData.sourceEquipmentInstance then
			local var_11_2 = self.contextData.sourceEquipmentInstance

			if var_11_1.count == 0 and var_11_2.type == DROP_TYPE_EQUIP and EquipmentProxy.SameEquip(var_11_1, var_11_2.template) then
				self.contextData.sourceEquipmentInstance = nil
			end
		end

		local var_11_3 = self:getViewComponent()

		var_11_3:UpdateSourceEquipmentPaths()
		var_11_3:UpdateSourceInfo()
		var_11_3:UpdateTargetInfo()
	elseif var_11_0 == GAME.UNEQUIP_FROM_SHIP_DONE or var_11_0 == GAME.EQUIP_TO_SHIP_DONE then
		local var_11_4 = self.contextData.sourceEquipmentInstance

		if self.contextData.sourceEquipmentInstance and var_11_4.type == DROP_TYPE_EQUIP then
			local var_11_5 = var_11_1:getEquip(var_11_4.template.shipPos)

			if var_11_4.template.shipId == var_11_1.id and (not var_11_5 or var_11_5.id ~= var_11_4.id) then
				self.contextData.sourceEquipmentInstance = nil
			end
		end

		local var_11_6 = self:getViewComponent()

		var_11_6:UpdateSourceEquipmentPaths()
		var_11_6:UpdateSourceInfo()
		var_11_6:UpdateTargetInfo()
	elseif var_11_0 == GAME.TRANSFORM_EQUIPMENT_DONE then
		self.contextData.sourceEquipmentInstance = nil

		self:getViewComponent():UpdatePage()
	elseif var_11_0 == GAME.TRANSFORM_EQUIPMENT_FAIL then
		self:getViewComponent():UpdatePage()
	end

	return
end

return EquipmentTransformMediator
