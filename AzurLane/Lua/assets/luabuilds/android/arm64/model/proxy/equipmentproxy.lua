local var_0_0 = class("EquipmentProxy", import(".NetProxy"))

var_0_0.EQUIPMENT_UPDATED = "equipment updated"
var_0_0.EQUIPMENT_SKIN_UPDATED = "equipment skin updated"
var_0_0.SPWEAPONS_UPDATED = "spweapons updated"
var_0_0.MAX_SPWEAPON_BAG = 2000

function var_0_0.register(arg_1_0)
	arg_1_0.data = {}
	arg_1_0.equipmentSkinIds = {}
	arg_1_0.shipIdListInTimeLimit = {}
	arg_1_0.spWeapons = {}
	arg_1_0.spWeaponCapacity = 0

	arg_1_0:on(14001, function(arg_2_0)
		arg_1_0.data.equipments = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.equip_list) do
			local var_2_0 = Equipment.New(iter_2_1)

			arg_1_0.data.equipments[var_2_0.id] = var_2_0
		end

		for iter_2_2, iter_2_3 in ipairs(arg_2_0.ship_id_list) do
			table.insert(arg_1_0.shipIdListInTimeLimit, iter_2_3)
		end

		for iter_2_4, iter_2_5 in ipairs(arg_2_0.spweapon_list) do
			arg_1_0:AddSpWeapon(SpWeapon.CreateByNet(iter_2_5))
		end

		arg_1_0:AddSpWeaponCapacity(arg_2_0.spweapon_bag_size)

		return
	end)
	arg_1_0:on(14101, function(arg_3_0)
		for iter_3_0, iter_3_1 in ipairs(arg_3_0.equip_skin_list) do
			arg_1_0.equipmentSkinIds[iter_3_1.id] = {
				id = iter_3_1.id,
				count = iter_3_1.count
			}
		end

		return
	end)
	arg_1_0:on(14200, function(arg_4_0)
		for iter_4_0, iter_4_1 in ipairs(arg_4_0.spweapon_list) do
			arg_1_0:AddSpWeapon((SpWeapon.CreateByNet(iter_4_1)))
		end

		return
	end)

	arg_1_0.weakTable = setmetatable({}, {
		__mode = "v"
	})
	arg_1_0.equipmentDesignObtainWays = {}
	arg_1_0.equipmentDesignObtainWayIndexed = false

	return
end

function var_0_0.getEquipmentSkins(arg_5_0)
	return arg_5_0.equipmentSkinIds or {}
end

function var_0_0.getSkinsByType(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs((arg_6_0:getEquipmentSkins())) do
		assert(pg.equip_skin_template[iter_6_1.id], "miss config equip_skin_template >> " .. iter_6_1.id)

		if table.contains(pg.equip_skin_template[iter_6_1.id].equip_type, arg_6_1) then
			table.insert({}, iter_6_1)
		end
	end

	return {}
end

function var_0_0.getSkinsByTypes(arg_7_0, arg_7_1)
	if not arg_7_1 or #arg_7_1 <= 0 then
		return {}
	end

	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs((arg_7_0:getEquipmentSkins())) do
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

function var_0_0.getEquipmnentSkinById(arg_8_0, arg_8_1)
	return arg_8_0.equipmentSkinIds[arg_8_1]
end

function var_0_0.addEquipmentSkin(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0.equipmentSkinIds[arg_9_1] then
		arg_9_0.equipmentSkinIds[arg_9_1].count = arg_9_0.equipmentSkinIds[arg_9_1].count + arg_9_2
	else
		arg_9_0.equipmentSkinIds[arg_9_1] = {
			id = arg_9_1,
			count = arg_9_2
		}
	end

	arg_9_0:sendNotification(var_0_0.EQUIPMENT_SKIN_UPDATED, {
		id = arg_9_1,
		count = arg_9_0.equipmentSkinIds[arg_9_1].count
	})

	return
end

function var_0_0.useageEquipmnentSkin(arg_10_0, arg_10_1)
	assert(arg_10_0.equipmentSkinIds[arg_10_1], "equipmentSkin is nil--" .. arg_10_1)
	assert(arg_10_0.equipmentSkinIds[arg_10_1].count > 0, "equipmentSkin count should greater than zero")

	arg_10_0.equipmentSkinIds[arg_10_1].count = arg_10_0.equipmentSkinIds[arg_10_1].count - 1

	arg_10_0:sendNotification(var_0_0.EQUIPMENT_SKIN_UPDATED, {
		id = arg_10_1,
		count = arg_10_0.equipmentSkinIds[arg_10_1].count
	})

	return
end

function var_0_0.addEquipment(arg_11_0, arg_11_1)
	assert(isa(arg_11_1, Equipment), "should be an instance of Equipment")

	if arg_11_0.data.equipments[arg_11_1.id] then
		local var_11_0 = arg_11_0.data.equipments[arg_11_1.id].count or 0

		arg_11_1.count, arg_11_1 = var_11_0 + arg_11_1.count, arg_11_0.data.equipments[arg_11_1.id] or arg_11_1

		arg_11_0:updateEquipment(arg_11_1)

		return
	end
end

function var_0_0.addEquipmentById(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	assert(arg_12_1 ~= 0, "equipmentProxy装备的id==0")
	assert(arg_12_1 ~= 1, "equipmentProxy装备的id==1")
	assert(arg_12_2 > 0, "count should greater than zero")
	arg_12_0:addEquipment(Equipment.New({
		id = arg_12_1,
		count = arg_12_2,
		new = arg_12_3 and 0 or 1
	}))

	return
end

function var_0_0.updateEquipment(arg_13_0, arg_13_1)
	assert(isa(arg_13_1, Equipment), "should be an instance of Equipment")

	local var_13_0 = arg_13_0.data.equipments

	var_13_0[arg_13_1.id] = arg_13_1.count ~= 0 and arg_13_1:clone() or nil

	arg_13_1:display("updated")
	arg_13_0:OnEquipsUpdate(arg_13_1)
	arg_13_0.facade:sendNotification(var_0_0.EQUIPMENT_UPDATED, arg_13_1:clone())

	return
end

function var_0_0.removeEquipmentById(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.data.equipments[arg_14_1]

	assert(arg_14_0.data.equipments[arg_14_1] ~= nil, "equipment should exist")
	assert(arg_14_2 > 0, "count should greater than zero")
	assert(arg_14_2 <= var_14_0.count, "number of equipment should enough")

	var_14_0.count = math.max(var_14_0.count - arg_14_2, 0)

	arg_14_0:updateEquipment(var_14_0)

	return
end

function var_0_0.getEquipments(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.data.equipments) do
		if iter_15_1.count > 0 then
			table.insert({}, iter_15_1:clone())

			if arg_15_1 then
				iter_15_1.new = 0
			end
		end
	end

	return {}
end

function var_0_0.getEquipmentsByFillter(arg_16_0, arg_16_1, arg_16_2)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.data.equipments) do
		if iter_16_1.count > 0 and table.contains(arg_16_2, iter_16_1:getConfig("type")) and not table.contains(iter_16_1:getConfig("ship_type_forbidden"), arg_16_1) then
			table.insert({}, iter_16_1:clone())
		end
	end

	return {}
end

function var_0_0.GetEquipmentsRaw(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.data.equipments) do
		if iter_17_1.count > 0 then
			table.insert({}, iter_17_1)
		end
	end

	return {}
end

function var_0_0.getEquipmentById(arg_18_0, arg_18_1)
	if arg_18_0.data.equipments[arg_18_1] ~= nil then
		return arg_18_0.data.equipments[arg_18_1]:clone()
	end

	return nil
end

function var_0_0.getSameTypeEquipmentId(arg_19_0, arg_19_1)
	local var_19_0 = Equipment.New({
		id = arg_19_1:getConfig("id")
	})
	local var_19_1

	while var_19_0.config.next ~= 0 do
		local var_19_2 = arg_19_0:getEquipmentById(var_19_0.config.next)

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
			local var_19_4 = arg_19_0:getEquipmentById(var_19_3.config.prev)

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

function var_0_0.getEquipCount(arg_20_0)
	local var_20_0 = 0

	for iter_20_0, iter_20_1 in pairs(arg_20_0.data.equipments) do
		var_20_0 = var_20_0 + iter_20_1.count
	end

	return var_20_0
end

function var_0_0.getEquipmentSkinCount(arg_21_0)
	local var_21_0 = 0

	for iter_21_0, iter_21_1 in pairs((arg_21_0:getEquipmentSkins())) do
		var_21_0 = var_21_0 + iter_21_1.count
	end

	return var_21_0
end

function var_0_0.getCapacity(arg_22_0)
	return (arg_22_0:getEquipCount())
end

function var_0_0.getTimeLimitShipList(arg_23_0)
	local var_23_0 = getProxy(BayProxy)

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.shipIdListInTimeLimit) do
		local var_23_2 = var_23_0:getShipById(iter_23_1)

		if var_23_2 then
			table.insert({}, {
				count = 1,
				type = 4,
				id = var_23_2.configId
			})
		end
	end

	return {}
end

function var_0_0.clearTimeLimitShipList(arg_24_0)
	arg_24_0.shipIdListInTimeLimit = {}

	return
end

function var_0_0.GetSpWeapons(arg_25_0)
	return arg_25_0.spWeapons
end

function var_0_0.GetSpWeaponByUid(arg_26_0, arg_26_1)
	return arg_26_0.spWeapons[arg_26_1]
end

function var_0_0.StaticGetSpWeapon(arg_27_0, arg_27_1)
	local var_27_0
	local var_27_1

	if arg_27_0 and arg_27_0 > 0 then
		var_27_0 = getProxy(BayProxy):getShipById(arg_27_0)
		var_27_1 = var_27_0 and var_27_0:GetSpWeapon()
	else
		var_27_1 = getProxy(EquipmentProxy):GetSpWeaponByUid(arg_27_1)
	end

	return var_27_1, var_27_0
end

function var_0_0.GetSameTypeSpWeapon(arg_28_0, arg_28_1)
	local var_28_0
	local var_28_1 = arg_28_1:GetConfigID()

	while var_28_1 ~= 0 do
		local var_28_3 = SpWeapon.New({
			id = var_28_1
		})

		if var_28_3:GetRarity() ~= arg_28_1:GetRarity() then
			break
		end

		for iter_28_0, iter_28_1 in pairs(arg_28_0:GetSpWeapons()) do
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

			for iter_28_2, iter_28_3 in pairs(arg_28_0:GetSpWeapons()) do
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

function var_0_0.GetSpWeaponCapacity(arg_29_0)
	return arg_29_0.spWeaponCapacity
end

function var_0_0.AddSpWeaponCapacity(arg_30_0, arg_30_1)
	arg_30_0.spWeaponCapacity = arg_30_0.spWeaponCapacity + arg_30_1

	return
end

function var_0_0.GetSpWeaponCount(arg_31_0)
	return table.getCount(arg_31_0:GetSpWeapons())
end

function var_0_0.AddSpWeapon(arg_32_0, arg_32_1)
	arg_32_1:SetShipId(nil)

	arg_32_0.spWeapons[arg_32_1:GetUID()] = arg_32_1

	arg_32_0.facade:sendNotification(var_0_0.SPWEAPONS_UPDATED)

	return
end

function var_0_0.RemoveSpWeapon(arg_33_0, arg_33_1)
	arg_33_0.spWeapons[arg_33_1:GetUID()] = nil

	arg_33_0.facade:sendNotification(var_0_0.SPWEAPONS_UPDATED)

	return
end

var_0_0.EquipTransformTargetDict = {}

for iter_0_0, iter_0_1 in ipairs(pg.equip_upgrade_data.all) do
	var_0_0.EquipTransformTargetDict[pg.equip_upgrade_data[iter_0_1].upgrade_from] = var_0_0.EquipTransformTargetDict[pg.equip_upgrade_data[iter_0_1].upgrade_from] or {}
	var_0_0.EquipTransformTargetDict[pg.equip_upgrade_data[iter_0_1].upgrade_from].targets = var_0_0.EquipTransformTargetDict[pg.equip_upgrade_data[iter_0_1].upgrade_from].targets or {}

	table.insert(var_0_0.EquipTransformTargetDict[pg.equip_upgrade_data[iter_0_1].upgrade_from].targets, iter_0_1)

	var_0_0.EquipTransformTargetDict[pg.equip_upgrade_data[iter_0_1].target_id] = var_0_0.EquipTransformTargetDict[pg.equip_upgrade_data[iter_0_1].target_id] or {}
	var_0_0.EquipTransformTargetDict[pg.equip_upgrade_data[iter_0_1].target_id].sources = var_0_0.EquipTransformTargetDict[pg.equip_upgrade_data[iter_0_1].target_id].sources or {}

	table.insert(var_0_0.EquipTransformTargetDict[pg.equip_upgrade_data[iter_0_1].target_id].sources, iter_0_1)
end

function var_0_0.GetTransformTargets(arg_34_0)
	if var_0_0.EquipTransformTargetDict[arg_34_0] then
		return var_0_0.EquipTransformTargetDict[arg_34_0].targets or {}
	end
end

function var_0_0.GetTransformSources(arg_35_0)
	if var_0_0.EquipTransformTargetDict[arg_35_0] then
		return var_0_0.EquipTransformTargetDict[arg_35_0].sources or {}
	end
end

var_0_0.EquipmentTransformTreeTemplate = {}

for iter_0_2 = 1, 4 do
	var_0_0.EquipmentTransformTreeTemplate[iter_0_2] = {}
end

for iter_0_3, iter_0_4 in ipairs(pg.equip_upgrade_template.all) do
	var_0_0.EquipmentTransformTreeTemplate[pg.equip_upgrade_template[iter_0_4].category1] = var_0_0.EquipmentTransformTreeTemplate[pg.equip_upgrade_template[iter_0_4].category1] or {}
	var_0_0.EquipmentTransformTreeTemplate[pg.equip_upgrade_template[iter_0_4].category1][pg.equip_upgrade_template[iter_0_4].category2] = pg.equip_upgrade_template[iter_0_4]
end

function var_0_0.SameEquip(arg_36_0, arg_36_1)
	assert(arg_36_0 and arg_36_1, "Compare NIL Equip")

	if not arg_36_0 or not arg_36_1 then
		return false
	end

	return arg_36_0.id == arg_36_1.id and arg_36_0.shipId == arg_36_1.shipId and arg_36_0.shipPos == arg_36_1.shipPos
end

function var_0_0.GetWeakEquipsDict(arg_37_0)
	if arg_37_0.weakTable.equipsDict then
		return arg_37_0.weakTable.equipsDict
	end

	local var_37_0 = EquipmentsDict.New()

	arg_37_0.weakTable.equipsDict = var_37_0

	collectgarbage("collect")

	return var_37_0
end

function var_0_0.OnEquipsUpdate(arg_38_0, arg_38_1)
	if not arg_38_0.weakTable.equipsDict then
		return
	end

	arg_38_0.weakTable.equipsDict:UpdateEquipment(arg_38_1)

	return
end

function var_0_0.OnShipEquipsAdd(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	if not arg_39_0.weakTable.equipsDict then
		return
	end

	arg_39_1 = CreateShell(arg_39_1)
	arg_39_1.shipId = arg_39_2
	arg_39_1.shipPos = arg_39_3

	arg_39_0.weakTable.equipsDict:AddEquipment(arg_39_1)

	return
end

function var_0_0.OnShipEquipsRemove(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	if not arg_40_0.weakTable.equipsDict then
		return
	end

	arg_40_1 = CreateShell(arg_40_1)
	arg_40_1.shipId = arg_40_2
	arg_40_1.shipPos = arg_40_3

	arg_40_0.weakTable.equipsDict:RemoveEquipment(arg_40_1)

	return
end

function var_0_0.BuildEquipmentDesignObtainWayIndex(arg_41_0)
	if arg_41_0.equipmentDesignObtainWayIndexed then
		return
	end

	local function var_41_0(arg_42_0)
		return arg_42_0 == DROP_TYPE_ITEM or arg_42_0 == DROP_TYPE_VITEM
	end

	local var_41_1 = {}

	for iter_41_0, iter_41_1 in ipairs(pg.chapter_template.all) do
		if (function(arg_45_0)
			return arg_45_0.act_id == 0 or arg_45_0.act_id == 100001
		end)(pg.chapter_template[iter_41_1]) then
			local var_41_2 = pg.chapter_template[iter_41_1].awards or {}
			local var_41_3 = {}

			for iter_41_2, iter_41_3 in ipairs(var_41_2) do
				if var_41_0(iter_41_3[1]) then
					for iter_41_4, iter_41_5 in ipairs((function(arg_43_0)
						if var_41_1[arg_43_0] then
							return var_41_1[arg_43_0]
						end

						local var_43_0 = {}
						local var_43_1 = Item.getConfigData(arg_43_0)

						if var_43_1 then
							if var_43_1.type == Item.DESIGN_TYPE then
								table.insert(var_43_0, arg_43_0)
							end

							local var_43_3 = var_43_1.display_icon or {}

							for iter_43_0, iter_43_1 in var_43_2(var_43_3) do
								if var_41_0(iter_43_1[1]) then
									local var_43_4 = Item.getConfigData(iter_43_1[2])

									if var_43_4 and var_43_4.type == Item.DESIGN_TYPE then
										table.insert(var_43_0, iter_43_1[2])
									end
								end
							end
						end

						var_41_1[arg_43_0] = var_43_0

						return var_43_0
					end)(iter_41_3[2])) do
						if not var_41_3[iter_41_5] then
							table.insert((function(arg_44_0)
								arg_41_0.equipmentDesignObtainWays[arg_44_0] = arg_41_0.equipmentDesignObtainWays[arg_44_0] or {
									{},
									false,
									false
								}

								return arg_41_0.equipmentDesignObtainWays[arg_44_0]
							end)(iter_41_5)[1], iter_41_1)

							var_41_3[iter_41_5] = true
						end
					end
				end
			end
		end
	end

	for iter_41_6, iter_41_7 in ipairs(pg.technology_data_template.all) do
		local var_41_4 = pg.technology_data_template[iter_41_7].drop_client or {}

		for iter_41_8, iter_41_9 in ipairs(var_41_4) do
			if var_41_0(iter_41_9[1]) then
				for iter_41_10, iter_41_11 in ipairs((function(arg_43_0)
					if var_41_1[arg_43_0] then
						return var_41_1[arg_43_0]
					end

					local var_43_0 = {}
					local var_43_1 = Item.getConfigData(arg_43_0)

					if var_43_1 then
						if var_43_1.type == Item.DESIGN_TYPE then
							table.insert(var_43_0, arg_43_0)
						end

						local var_43_3 = var_43_1.display_icon or {}

						for iter_43_0, iter_43_1 in var_43_2(var_43_3) do
							if var_41_0(iter_43_1[1]) then
								local var_43_4 = Item.getConfigData(iter_43_1[2])

								if var_43_4 and var_43_4.type == Item.DESIGN_TYPE then
									table.insert(var_43_0, iter_43_1[2])
								end
							end
						end
					end

					var_41_1[arg_43_0] = var_43_0

					return var_43_0
				end)(iter_41_9[2])) do
					(function(arg_44_0)
						arg_41_0.equipmentDesignObtainWays[arg_44_0] = arg_41_0.equipmentDesignObtainWays[arg_44_0] or {
							{},
							false,
							false
						}

						return arg_41_0.equipmentDesignObtainWays[arg_44_0]
					end)(iter_41_11)[2] = true
				end
			end
		end
	end

	local var_41_5 = getProxy(ShopsProxy):getFragmentShop()

	if var_41_5 then
		for iter_41_12, iter_41_13 in ipairs((var_41_5:GetCommodities(designId))) do
			for iter_41_14, iter_41_15 in ipairs(iter_41_13:GetDropList()) do
				if iter_41_15.type == DROP_TYPE_ITEM then
					local var_41_6 = Item.getConfigData(iter_41_15.id)

					if var_41_6 and var_41_6.type == Item.DESIGN_TYPE then
						(function(arg_44_0)
							arg_41_0.equipmentDesignObtainWays[arg_44_0] = arg_41_0.equipmentDesignObtainWays[arg_44_0] or {
								{},
								false,
								false
							}

							return arg_41_0.equipmentDesignObtainWays[arg_44_0]
						end)(var_41_6.id)[3] = true
					end
				end
			end
		end
	end

	arg_41_0.equipmentDesignObtainWayIndexed = true

	return
end

function var_0_0.ShouldShowEquipmentDesignObtainWay(arg_46_0, arg_46_1)
	arg_46_0:BuildEquipmentDesignObtainWayIndex()

	if not arg_46_0.equipmentDesignObtainWays[arg_46_1] then
		return false
	end

	local var_46_0

	if #arg_46_0.equipmentDesignObtainWays[arg_46_1][1] <= 0 then
		var_46_0 = arg_46_0.equipmentDesignObtainWays[arg_46_1][2] or arg_46_0.equipmentDesignObtainWays[arg_46_1][3]

		if false then
			var_46_0 = false
		end
	else
		var_46_0 = true
	end

	return var_46_0
end

function var_0_0.GetObtainWay4EquipmentDesign(arg_47_0, arg_47_1)
	arg_47_0:BuildEquipmentDesignObtainWayIndex()

	arg_47_0.equipmentDesignObtainWays[arg_47_1] = arg_47_0.equipmentDesignObtainWays[arg_47_1] or {
		{},
		false,
		false
	}

	return arg_47_0.equipmentDesignObtainWays[arg_47_1]
end

return var_0_0
