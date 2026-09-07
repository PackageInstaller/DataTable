local EquipmentProxy = class("EquipmentProxy", import(".NetProxy"))

EquipmentProxy.EQUIPMENT_UPDATED = "equipment updated"
EquipmentProxy.EQUIPMENT_SKIN_UPDATED = "equipment skin updated"
EquipmentProxy.SPWEAPONS_UPDATED = "spweapons updated"
EquipmentProxy.MAX_SPWEAPON_BAG = 2000

function EquipmentProxy:register()
	self.data = {}
	self.equipmentSkinIds = {}
	self.shipIdListInTimeLimit = {}
	self.spWeapons = {}
	self.spWeaponCapacity = 0

	self:on(14001, function(arg_2_0)
		self.data.equipments = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.equip_list) do
			local var_2_0 = Equipment.New(iter_2_1)

			self.data.equipments[var_2_0.id] = var_2_0
		end

		for iter_2_2, iter_2_3 in ipairs(arg_2_0.ship_id_list) do
			table.insert(self.shipIdListInTimeLimit, iter_2_3)
		end

		for iter_2_4, iter_2_5 in ipairs(arg_2_0.spweapon_list) do
			self:AddSpWeapon(SpWeapon.CreateByNet(iter_2_5))
		end

		self:AddSpWeaponCapacity(arg_2_0.spweapon_bag_size)

		return
	end)
	self:on(14101, function(arg_3_0)
		for iter_3_0, iter_3_1 in ipairs(arg_3_0.equip_skin_list) do
			self.equipmentSkinIds[iter_3_1.id] = {
				id = iter_3_1.id,
				count = iter_3_1.count
			}
		end

		return
	end)
	self:on(14200, function(arg_4_0)
		for iter_4_0, iter_4_1 in ipairs(arg_4_0.spweapon_list) do
			self:AddSpWeapon((SpWeapon.CreateByNet(iter_4_1)))
		end

		return
	end)

	self.weakTable = setmetatable({}, {
		__mode = "v"
	})
	self.equipmentDesignObtainWays = {}
	self.equipmentDesignObtainWayIndexed = false

	return
end

function EquipmentProxy:getEquipmentSkins()
	return self.equipmentSkinIds or {}
end

function EquipmentProxy:getSkinsByType(arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs((self:getEquipmentSkins())) do
		assert(pg.equip_skin_template[iter_6_1.id], "miss config equip_skin_template >> " .. iter_6_1.id)

		if table.contains(pg.equip_skin_template[iter_6_1.id].equip_type, arg_6_1) then
			table.insert(var_6_0, iter_6_1)
		end
	end

	return var_6_0
end

function EquipmentProxy:getSkinsByTypes(arg_7_1)
	if not arg_7_1 or #arg_7_1 <= 0 then
		return {}
	end

	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs((self:getEquipmentSkins())) do
		assert(pg.equip_skin_template[iter_7_1.id], "miss config equip_skin_template >> " .. iter_7_1.id)

		local var_7_1 = false

		for iter_7_2 = 1, #arg_7_1 do
			if table.contains(pg.equip_skin_template[iter_7_1.id].equip_type, arg_7_1[iter_7_2]) then
				var_7_1 = true
			end
		end

		if var_7_1 then
			table.insert(var_7_0, iter_7_1)
		end
	end

	return var_7_0
end

function EquipmentProxy:getEquipmnentSkinById(arg_8_1)
	return self.equipmentSkinIds[arg_8_1]
end

function EquipmentProxy:addEquipmentSkin(arg_9_1, arg_9_2)
	if self.equipmentSkinIds[arg_9_1] then
		self.equipmentSkinIds[arg_9_1].count = self.equipmentSkinIds[arg_9_1].count + arg_9_2
	else
		self.equipmentSkinIds[arg_9_1] = {
			id = arg_9_1,
			count = arg_9_2
		}
	end

	self:sendNotification(EquipmentProxy.EQUIPMENT_SKIN_UPDATED, {
		id = arg_9_1,
		count = self.equipmentSkinIds[arg_9_1].count
	})

	return
end

function EquipmentProxy:useageEquipmnentSkin(arg_10_1)
	assert(self.equipmentSkinIds[arg_10_1], "equipmentSkin is nil--" .. arg_10_1)
	assert(self.equipmentSkinIds[arg_10_1].count > 0, "equipmentSkin count should greater than zero")

	self.equipmentSkinIds[arg_10_1].count = self.equipmentSkinIds[arg_10_1].count - 1

	self:sendNotification(EquipmentProxy.EQUIPMENT_SKIN_UPDATED, {
		id = arg_10_1,
		count = self.equipmentSkinIds[arg_10_1].count
	})

	return
end

function EquipmentProxy:addEquipment(arg_11_1)
	assert(isa(arg_11_1, Equipment), "should be an instance of Equipment")

	arg_11_1.count, arg_11_1 = ((self.data.equipments[arg_11_1.id] or nil) and (self.data.equipments[arg_11_1.id].count or 0)) + arg_11_1.count, self.data.equipments[arg_11_1.id] or arg_11_1

	self:updateEquipment(arg_11_1)

	return
end

function EquipmentProxy:addEquipmentById(arg_12_1, arg_12_2, arg_12_3)
	assert(arg_12_1 ~= 0, "equipmentProxy装备的id==0")
	assert(arg_12_1 ~= 1, "equipmentProxy装备的id==1")
	assert(arg_12_2 > 0, "count should greater than zero")
	self:addEquipment(Equipment.New({
		id = arg_12_1,
		count = arg_12_2,
		new = arg_12_3 and 0 or 1
	}))

	return
end

function EquipmentProxy:updateEquipment(arg_13_1)
	assert(isa(arg_13_1, Equipment), "should be an instance of Equipment")

	self.data.equipments[arg_13_1.id] = arg_13_1.count ~= 0 and arg_13_1:clone() or nil

	arg_13_1:display("updated")
	self:OnEquipsUpdate(arg_13_1)
	self.facade:sendNotification(EquipmentProxy.EQUIPMENT_UPDATED, arg_13_1:clone())

	return
end

function EquipmentProxy:removeEquipmentById(arg_14_1, arg_14_2)
	local var_14_0 = self.data.equipments[arg_14_1]

	assert(self.data.equipments[arg_14_1] ~= nil, "equipment should exist")
	assert(arg_14_2 > 0, "count should greater than zero")
	assert(arg_14_2 <= var_14_0.count, "number of equipment should enough")

	var_14_0.count = math.max(var_14_0.count - arg_14_2, 0)

	self:updateEquipment(var_14_0)

	return
end

function EquipmentProxy:getEquipments(arg_15_1)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(self.data.equipments) do
		if iter_15_1.count > 0 then
			table.insert(var_15_0, iter_15_1:clone())

			if arg_15_1 then
				iter_15_1.new = 0
			end
		end
	end

	return var_15_0
end

function EquipmentProxy:getEquipmentsByFillter(arg_16_1, arg_16_2)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(self.data.equipments) do
		if iter_16_1.count > 0 and table.contains(arg_16_2, iter_16_1:getConfig("type")) and not table.contains(iter_16_1:getConfig("ship_type_forbidden"), arg_16_1) then
			table.insert(var_16_0, iter_16_1:clone())
		end
	end

	return var_16_0
end

function EquipmentProxy:GetEquipmentsRaw()
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in pairs(self.data.equipments) do
		if iter_17_1.count > 0 then
			table.insert(var_17_0, iter_17_1)
		end
	end

	return var_17_0
end

function EquipmentProxy:getEquipmentById(arg_18_1)
	if self.data.equipments[arg_18_1] ~= nil then
		return self.data.equipments[arg_18_1]:clone()
	end

	return nil
end

function EquipmentProxy:getSameTypeEquipmentId(arg_19_1)
	local var_19_0 = Equipment.New({
		id = arg_19_1:getConfig("id")
	})
	local var_19_1

	while var_19_0.config.next ~= 0 do
		local var_19_2 = self:getEquipmentById(var_19_0.config.next)

		if var_19_2 and var_19_2.count > 0 then
			var_19_1 = var_19_2
		end

		var_19_0 = Equipment.New({
			id = var_19_0.config.next
		})
	end

	if not var_19_1 then
		local var_19_3 = Equipment.New({
			id = arg_19_1:getConfig("id")
		})

		while var_19_3.config.prev ~= 0 do
			local var_19_4 = self:getEquipmentById(var_19_3.config.prev)

			if var_19_4 and var_19_4.count > 0 then
				var_19_1 = var_19_4

				break
			end

			var_19_3 = Equipment.New({
				id = var_19_3.config.prev
			})
		end
	end

	if var_19_1 then
		return var_19_1.id
	end

	return
end

function EquipmentProxy:getEquipCount()
	local var_20_0 = 0

	for iter_20_0, iter_20_1 in pairs(self.data.equipments) do
		var_20_0 = var_20_0 + iter_20_1.count
	end

	return var_20_0
end

function EquipmentProxy:getEquipmentSkinCount()
	local var_21_0 = 0

	for iter_21_0, iter_21_1 in pairs((self:getEquipmentSkins())) do
		var_21_0 = var_21_0 + iter_21_1.count
	end

	return var_21_0
end

function EquipmentProxy:getCapacity()
	return (self:getEquipCount())
end

function EquipmentProxy:getTimeLimitShipList()
	local var_23_0 = getProxy(BayProxy)
	local var_23_1 = {}

	for iter_23_0, iter_23_1 in ipairs(self.shipIdListInTimeLimit) do
		local var_23_3 = var_23_0:getShipById(iter_23_1)

		if var_23_3 then
			table.insert(var_23_1, {
				count = 1,
				type = 4,
				id = var_23_3.configId
			})
		end
	end

	return var_23_1
end

function EquipmentProxy:clearTimeLimitShipList()
	self.shipIdListInTimeLimit = {}

	return
end

function EquipmentProxy:GetSpWeapons()
	return self.spWeapons
end

function EquipmentProxy:GetSpWeaponByUid(arg_26_1)
	return self.spWeapons[arg_26_1]
end

function EquipmentProxy:StaticGetSpWeapon(arg_27_1)
	local var_27_0
	local var_27_1

	if self and self > 0 then
		var_27_0 = getProxy(BayProxy):getShipById(self)
		var_27_1 = var_27_0 and var_27_0:GetSpWeapon()
	else
		var_27_1 = getProxy(EquipmentProxy):GetSpWeaponByUid(arg_27_1)
	end

	return var_27_1, var_27_0
end

function EquipmentProxy:GetSameTypeSpWeapon(arg_28_1)
	local var_28_0
	local var_28_1 = arg_28_1:GetConfigID()

	while var_28_1 ~= 0 do
		local var_28_3 = SpWeapon.New({
			id = var_28_1
		})

		if var_28_3:GetRarity() ~= arg_28_1:GetRarity() then
			break
		end

		for iter_28_0, iter_28_1 in pairs(self:GetSpWeapons()) do
			if iter_28_1:GetConfigID() == var_28_1 then
				var_28_0 = iter_28_1

				break
			end
		end

		if var_28_0 then
			break
		else
			var_28_1 = var_28_3:GetNextUpgradeID()
		end
	end

	if not var_28_0 then
		local var_28_4 = arg_28_1:GetPrevUpgradeID()

		while var_28_4 ~= 0 do
			local var_28_6 = SpWeapon.New({
				id = var_28_4
			})

			if var_28_6:GetRarity() ~= arg_28_1:GetRarity() then
				break
			end

			for iter_28_2, iter_28_3 in pairs(self:GetSpWeapons()) do
				if iter_28_3:GetConfigID() == var_28_4 then
					var_28_0 = iter_28_3

					break
				end
			end

			if var_28_0 then
				break
			else
				var_28_4 = var_28_6:GetPrevUpgradeID()
			end
		end
	end

	return var_28_0
end

function EquipmentProxy:GetSpWeaponCapacity()
	return self.spWeaponCapacity
end

function EquipmentProxy:AddSpWeaponCapacity(arg_30_1)
	self.spWeaponCapacity = self.spWeaponCapacity + arg_30_1

	return
end

function EquipmentProxy:GetSpWeaponCount()
	return table.getCount(self:GetSpWeapons())
end

function EquipmentProxy:AddSpWeapon(arg_32_1)
	arg_32_1:SetShipId(nil)

	self.spWeapons[arg_32_1:GetUID()] = arg_32_1

	self.facade:sendNotification(EquipmentProxy.SPWEAPONS_UPDATED)

	return
end

function EquipmentProxy:RemoveSpWeapon(arg_33_1)
	self.spWeapons[arg_33_1:GetUID()] = nil

	self.facade:sendNotification(EquipmentProxy.SPWEAPONS_UPDATED)

	return
end

EquipmentProxy.EquipTransformTargetDict = {}

for iter_0_0, iter_0_1 in ipairs(pg.equip_upgrade_data.all) do
	EquipmentProxy.EquipTransformTargetDict[pg.equip_upgrade_data[iter_0_1].upgrade_from] = EquipmentProxy.EquipTransformTargetDict[pg.equip_upgrade_data[iter_0_1].upgrade_from] or {}
	EquipmentProxy.EquipTransformTargetDict[pg.equip_upgrade_data[iter_0_1].upgrade_from].targets = EquipmentProxy.EquipTransformTargetDict[pg.equip_upgrade_data[iter_0_1].upgrade_from].targets or {}

	table.insert(EquipmentProxy.EquipTransformTargetDict[pg.equip_upgrade_data[iter_0_1].upgrade_from].targets, iter_0_1)

	EquipmentProxy.EquipTransformTargetDict[pg.equip_upgrade_data[iter_0_1].target_id] = EquipmentProxy.EquipTransformTargetDict[pg.equip_upgrade_data[iter_0_1].target_id] or {}
	EquipmentProxy.EquipTransformTargetDict[pg.equip_upgrade_data[iter_0_1].target_id].sources = EquipmentProxy.EquipTransformTargetDict[pg.equip_upgrade_data[iter_0_1].target_id].sources or {}

	table.insert(EquipmentProxy.EquipTransformTargetDict[pg.equip_upgrade_data[iter_0_1].target_id].sources, iter_0_1)
end

function EquipmentProxy:GetTransformTargets()
	return (EquipmentProxy.EquipTransformTargetDict[self] or nil) and (EquipmentProxy.EquipTransformTargetDict[self].targets or {})
end

function EquipmentProxy:GetTransformSources()
	return (EquipmentProxy.EquipTransformTargetDict[self] or nil) and (EquipmentProxy.EquipTransformTargetDict[self].sources or {})
end

EquipmentProxy.EquipmentTransformTreeTemplate = {}

for iter_0_2 = 1, 4 do
	EquipmentProxy.EquipmentTransformTreeTemplate[iter_0_2] = {}
end

for iter_0_3, iter_0_4 in ipairs(pg.equip_upgrade_template.all) do
	EquipmentProxy.EquipmentTransformTreeTemplate[pg.equip_upgrade_template[iter_0_4].category1] = EquipmentProxy.EquipmentTransformTreeTemplate[pg.equip_upgrade_template[iter_0_4].category1] or {}
	EquipmentProxy.EquipmentTransformTreeTemplate[pg.equip_upgrade_template[iter_0_4].category1][pg.equip_upgrade_template[iter_0_4].category2] = pg.equip_upgrade_template[iter_0_4]
end

function EquipmentProxy:SameEquip(arg_36_1)
	assert(self and arg_36_1, "Compare NIL Equip")

	if not self or not arg_36_1 then
		return false
	end

	return self.id == arg_36_1.id and self.shipId == arg_36_1.shipId and self.shipPos == arg_36_1.shipPos
end

function EquipmentProxy:GetWeakEquipsDict()
	if self.weakTable.equipsDict then
		return self.weakTable.equipsDict
	end

	local var_37_0 = EquipmentsDict.New()

	self.weakTable.equipsDict = var_37_0

	collectgarbage("collect")

	return var_37_0
end

function EquipmentProxy:OnEquipsUpdate(arg_38_1)
	if not self.weakTable.equipsDict then
		return
	end

	self.weakTable.equipsDict:UpdateEquipment(arg_38_1)

	return
end

function EquipmentProxy:OnShipEquipsAdd(arg_39_1, arg_39_2, arg_39_3)
	if not self.weakTable.equipsDict then
		return
	end

	arg_39_1 = CreateShell(arg_39_1)
	arg_39_1.shipId = arg_39_2
	arg_39_1.shipPos = arg_39_3

	self.weakTable.equipsDict:AddEquipment(arg_39_1)

	return
end

function EquipmentProxy:OnShipEquipsRemove(arg_40_1, arg_40_2, arg_40_3)
	if not self.weakTable.equipsDict then
		return
	end

	arg_40_1 = CreateShell(arg_40_1)
	arg_40_1.shipId = arg_40_2
	arg_40_1.shipPos = arg_40_3

	self.weakTable.equipsDict:RemoveEquipment(arg_40_1)

	return
end

function EquipmentProxy:BuildEquipmentDesignObtainWayIndex()
	if self.equipmentDesignObtainWayIndexed then
		return
	end

	local function var_41_0(arg_42_0)
		return arg_42_0 == DROP_TYPE_ITEM or arg_42_0 == DROP_TYPE_VITEM
	end

	local var_41_1 = {}

	local function var_41_2(arg_43_0)
		if var_41_1[arg_43_0] then
			return var_41_1[arg_43_0]
		end

		local var_43_0 = {}
		local var_43_1 = Item.getConfigData(arg_43_0)

		if var_43_1 then
			if var_43_1.type == Item.DESIGN_TYPE then
				table.insert(var_43_0, arg_43_0)
			end

			for iter_43_0, iter_43_1 in ipairs(var_43_1.display_icon or {}) do
				if var_41_0(iter_43_1[1]) then
					local var_43_2 = Item.getConfigData(iter_43_1[2])

					if var_43_2 and var_43_2.type == Item.DESIGN_TYPE then
						table.insert(var_43_0, iter_43_1[2])
					end
				end
			end
		end

		var_41_1[arg_43_0] = var_43_0

		return var_43_0
	end

	local function var_41_3(arg_44_0)
		self.equipmentDesignObtainWays[arg_44_0] = self.equipmentDesignObtainWays[arg_44_0] or {
			{},
			false,
			false
		}

		return self.equipmentDesignObtainWays[arg_44_0]
	end

	local function var_41_4(arg_45_0)
		return arg_45_0.act_id == 0 or arg_45_0.act_id == 100001
	end

	for iter_41_0, iter_41_1 in ipairs(pg.chapter_template.all) do
		if var_41_4(pg.chapter_template[iter_41_1]) then
			local var_41_6 = {}

			for iter_41_2, iter_41_3 in ipairs(pg.chapter_template[iter_41_1].awards or {}) do
				if var_41_0(iter_41_3[1]) then
					for iter_41_4, iter_41_5 in ipairs(var_41_2(iter_41_3[2])) do
						if not var_41_6[iter_41_5] then
							table.insert(var_41_3(iter_41_5)[1], iter_41_1)

							var_41_6[iter_41_5] = true
						end
					end
				end
			end
		end
	end

	for iter_41_6, iter_41_7 in ipairs(pg.technology_data_template.all) do
		for iter_41_8, iter_41_9 in ipairs(pg.technology_data_template[iter_41_7].drop_client or {}) do
			if var_41_0(iter_41_9[1]) then
				for iter_41_10, iter_41_11 in ipairs(var_41_2(iter_41_9[2])) do
					var_41_3(iter_41_11)[2] = true
				end
			end
		end
	end

	local var_41_8 = getProxy(ShopsProxy):getFragmentShop()

	if var_41_8 then
		for iter_41_12, iter_41_13 in ipairs((var_41_8:GetCommodities(designId))) do
			for iter_41_14, iter_41_15 in ipairs(iter_41_13:GetDropList()) do
				if iter_41_15.type == DROP_TYPE_ITEM then
					local var_41_9 = Item.getConfigData(iter_41_15.id)

					if var_41_9 and var_41_9.type == Item.DESIGN_TYPE then
						var_41_3(var_41_9.id)[3] = true
					end
				end
			end
		end
	end

	self.equipmentDesignObtainWayIndexed = true

	return
end

function EquipmentProxy:ShouldShowEquipmentDesignObtainWay(arg_46_1)
	self:BuildEquipmentDesignObtainWayIndex()

	if not self.equipmentDesignObtainWays[arg_46_1] then
		return false
	end

	return #self.equipmentDesignObtainWays[arg_46_1][1] <= 0 and (self.equipmentDesignObtainWays[arg_46_1][2] or self.equipmentDesignObtainWays[arg_46_1][3]) or true
end

function EquipmentProxy:GetObtainWay4EquipmentDesign(arg_47_1)
	self:BuildEquipmentDesignObtainWayIndex()

	self.equipmentDesignObtainWays[arg_47_1] = self.equipmentDesignObtainWays[arg_47_1] or {
		{},
		false,
		false
	}

	return self.equipmentDesignObtainWays[arg_47_1]
end

return EquipmentProxy
