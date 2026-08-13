class = var_0_10000

local var_0_0 = "EquipmentProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.EQUIPMENT_UPDATED = "equipment updated"
var_0_1.EQUIPMENT_SKIN_UPDATED = "equipment skin updated"
var_0_1.SPWEAPONS_UPDATED = "spweapons updated"
var_0_1.MAX_SPWEAPON_BAG = 2000

function var_0_1.register(arg_1_0)
	arg_1_0.data = {}
	arg_1_0.equipmentSkinIds = {}
	arg_1_0.shipIdListInTimeLimit = {}
	arg_1_0.spWeapons = {}
	arg_1_0.spWeaponCapacity = 0

	arg_1_0:on(14001, function(arg_2_0)
		local var_2_0 = arg_1_0.data

		var_2_0.equipments = {}
		ipairs = var_2_0

		for iter_2_0, iter_2_1 in var_2_0(arg_2_0.equip_list) do
			Equipment = var_2_10006
			var_2_10006 = var_2_10006.New(iter_2_1)
			arg_1_0.data.equipments[var_2_10006.id] = var_2_10006
		end

		ipairs = var_1

		for iter_2_2, iter_2_3 in var_1(arg_2_0.ship_id_list) do
			table = var_2_10006

			var_2_10006.insert(arg_1_0.shipIdListInTimeLimit, iter_2_3)
		end

		ipairs = var_1

		for iter_2_4, iter_2_5 in var_1(arg_2_0.spweapon_list) do
			local var_2_1 = arg_1_0
			local var_2_2 = var_6.AddSpWeapon

			SpWeapon = var_2_10009

			var_2_2(var_2_1, var_2_10009.CreateByNet(iter_2_5))
		end

		local var_2_3 = arg_1_0

		var_1.AddSpWeaponCapacity(var_2_3, arg_2_0.spweapon_bag_size)

		return
	end)
	arg_1_0:on(14101, function(arg_3_0)
		ipairs = var_2_10001

		for iter_3_0, iter_3_1 in var_2_10001(arg_3_0.equip_skin_list) do
			arg_1_0.equipmentSkinIds[iter_3_1.id] = {
				id = iter_3_1.id,
				count = iter_3_1.count
			}
		end

		return
	end)
	arg_1_0:on(14200, function(arg_4_0)
		ipairs = var_2_10001

		for iter_4_0, iter_4_1 in var_2_10001(arg_4_0.spweapon_list) do
			SpWeapon = var_2_10006
			var_2_10006 = var_2_10006.CreateByNet(iter_4_1)

			local var_4_0 = arg_1_0

			var_7.AddSpWeapon(var_4_0, var_2_10006)
		end

		return
	end)

	setmetatable = var_1
	arg_1_0.weakTable = var_1({}, {
		__mode = "v"
	})
	arg_1_0.equipmentDesignObtainWays = {}
	arg_1_0.equipmentDesignObtainWayIndexed = false

	return
end

function var_0_1.getEquipmentSkins(arg_5_0)
	local var_5_0

	if not arg_5_0.equipmentSkinIds then
		var_5_0 = {}
	end

	return var_5_0
end

function var_0_1.getSkinsByType(arg_6_0, arg_6_1)
	local var_6_0 = {}

	pg = var_1_10003

	local var_6_1 = var_1_10003.equip_skin_template
	local var_6_2 = arg_6_0:getEquipmentSkins()

	pairs = var_1_10005

	for iter_6_0, iter_6_1 in var_1_10005(var_6_2) do
		assert = var_1_10010

		var_1_10010(var_6_1[iter_6_1.id], "miss config equip_skin_template >> " .. iter_6_1.id)

		table = var_1_10010

		if var_1_10010.contains(var_6_1[iter_6_1.id].equip_type, arg_6_1) then
			table = var_1_10010

			var_1_10010.insert(var_6_0, iter_6_1)
		end
	end

	return var_6_0
end

function var_0_1.getSkinsByTypes(arg_7_0, arg_7_1)
	if not arg_7_1 or #arg_7_1 <= 0 then
		return {}
	end

	local var_7_0 = {}

	pg = var_1_10003

	local var_7_1 = var_1_10003.equip_skin_template
	local var_7_2 = arg_7_0:getEquipmentSkins()

	pairs = var_1_10005

	for iter_7_0, iter_7_1 in var_1_10005(var_7_2) do
		assert = var_1_10010

		var_1_10010(var_7_1[iter_7_1.id], "miss config equip_skin_template >> " .. iter_7_1.id)

		var_1_10010 = false

		for iter_7_2 = 1, #arg_7_1 do
			table = var_1_10015

			if var_1_10015.contains(var_7_1[iter_7_1.id].equip_type, arg_7_1[iter_7_2]) then
				var_1_10010 = true
			end
		end

		if var_1_10010 then
			table = var_11

			var_11.insert(var_7_0, iter_7_1)
		end
	end

	return var_7_0
end

function var_0_1.getEquipmnentSkinById(arg_8_0, arg_8_1)
	return arg_8_0.equipmentSkinIds[arg_8_1]
end

function var_0_1.addEquipmentSkin(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0.equipmentSkinIds[arg_9_1] then
		arg_9_0.equipmentSkinIds[arg_9_1].count = arg_9_0.equipmentSkinIds[arg_9_1].count + arg_9_2
	else
		arg_9_0.equipmentSkinIds[arg_9_1] = {
			id = arg_9_1,
			count = arg_9_2
		}
	end

	arg_9_0:sendNotification(var_0_1.EQUIPMENT_SKIN_UPDATED, {
		id = arg_9_1,
		count = arg_9_0.equipmentSkinIds[arg_9_1].count
	})

	return
end

function var_0_1.useageEquipmnentSkin(arg_10_0, arg_10_1)
	assert = var_1_10002

	var_1_10002(arg_10_0.equipmentSkinIds[arg_10_1], "equipmentSkin is nil--" .. arg_10_1)

	assert = var_1_10002

	var_1_10002(arg_10_0.equipmentSkinIds[arg_10_1].count > 0, "equipmentSkin count should greater than zero")

	arg_10_0.equipmentSkinIds[arg_10_1].count = arg_10_0.equipmentSkinIds[arg_10_1].count - 1

	arg_10_0:sendNotification(var_0_1.EQUIPMENT_SKIN_UPDATED, {
		id = arg_10_1,
		count = arg_10_0.equipmentSkinIds[arg_10_1].count
	})

	return
end

function var_0_1.addEquipment(arg_11_0, arg_11_1)
	assert = var_1_10002
	isa = var_1_10004

	local var_11_0 = arg_11_1

	Equipment = var_1_10007

	var_1_10002(var_1_10004(var_11_0, var_1_10007), "should be an instance of Equipment")

	local var_11_1

	if not arg_11_0.data.equipments[arg_11_1.id] or not arg_11_0.data.equipments[arg_11_1.id].count then
		var_11_1 = 0
	end

	arg_11_1.count, arg_11_1 = var_11_1 + arg_11_1.count, arg_11_0.data.equipments[arg_11_1.id] or arg_11_1

	arg_11_0:updateEquipment(arg_11_1)

	return
end

function var_0_1.addEquipmentById(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	assert = var_1_10004

	var_1_10004(arg_12_1 ~= 0, "equipmentProxy装备的id==0")

	assert = var_1_10004

	var_1_10004(arg_12_1 ~= 1, "equipmentProxy装备的id==1")

	assert = var_1_10004

	var_1_10004(arg_12_2 > 0, "count should greater than zero")

	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.addEquipment

	Equipment = var_7

	var_12_1(var_12_0, var_7.New({
		id = arg_12_1,
		count = arg_12_2,
		new = arg_12_3 and 0 or 1
	}))

	return
end

function var_0_1.updateEquipment(arg_13_0, arg_13_1)
	assert = var_1_10002
	isa = var_1_10004

	local var_13_0 = arg_13_1

	Equipment = var_1_10007

	var_1_10002(var_1_10004(var_13_0, var_1_10007), "should be an instance of Equipment")

	local var_13_1 = arg_13_0.data.equipments
	local var_13_2 = arg_13_1.id
	local var_13_3

	if arg_13_1.count == 0 or not arg_13_1:clone() then
		var_13_3 = nil
	end

	var_13_1[var_13_2] = var_13_3

	arg_13_1:display("updated")
	arg_13_0:OnEquipsUpdate(arg_13_1)

	local var_13_4 = arg_13_0.facade

	var_2.sendNotification(var_13_4, var_0_1.EQUIPMENT_UPDATED, arg_13_1:clone())

	return
end

function var_0_1.removeEquipmentById(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.data.equipments[arg_14_1]

	assert = var_1_10004

	var_1_10004(var_14_0 ~= nil, "equipment should exist")

	assert = var_1_10004

	var_1_10004(arg_14_2 > 0, "count should greater than zero")

	assert = var_1_10004

	var_1_10004(arg_14_2 <= var_14_0.count, "number of equipment should enough")

	math = var_1_10004
	var_14_0.count = var_1_10004.max(var_14_0.count - arg_14_2, 0)

	arg_14_0:updateEquipment(var_14_0)

	return
end

function var_0_1.getEquipments(arg_15_0, arg_15_1)
	local var_15_0 = {}

	pairs = var_1_10003

	for iter_15_0, iter_15_1 in var_1_10003(arg_15_0.data.equipments) do
		if iter_15_1.count > 0 then
			table = var_8

			var_8.insert(var_15_0, iter_15_1:clone())

			if arg_15_1 then
				iter_15_1.new = 0
			end
		end
	end

	return var_15_0
end

function var_0_1.getEquipmentsByFillter(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = {}

	pairs = var_1_10004

	for iter_16_0, iter_16_1 in var_1_10004(arg_16_0.data.equipments) do
		if iter_16_1.count > 0 then
			table = var_9

			if var_9.contains(arg_16_2, iter_16_1:getConfig("type")) then
				table = var_9

				if not var_9.contains(iter_16_1:getConfig("ship_type_forbidden"), arg_16_1) then
					table = var_9

					var_9.insert(var_16_0, iter_16_1:clone())
				end
			end
		end
	end

	return var_16_0
end

function var_0_1.GetEquipmentsRaw(arg_17_0)
	local var_17_0 = {}

	pairs = var_1_10002

	for iter_17_0, iter_17_1 in var_1_10002(arg_17_0.data.equipments) do
		if iter_17_1.count > 0 then
			table = var_7

			var_7.insert(var_17_0, iter_17_1)
		end
	end

	return var_17_0
end

function var_0_1.getEquipmentById(arg_18_0, arg_18_1)
	if arg_18_0.data.equipments[arg_18_1] ~= nil then
		local var_18_0 = arg_18_0.data.equipments[arg_18_1]

		return var_2.clone(var_18_0)
	end

	return nil
end

function var_0_1.getSameTypeEquipmentId(arg_19_0, arg_19_1)
	Equipment = var_1_10002

	local var_19_0 = var_1_10002.New({
		id = arg_19_1:getConfig("id")
	})
	local var_19_1

	while var_19_0.config.next ~= 0 do
		if arg_19_0:getEquipmentById(var_19_0.config.next) and var_4.count > 0 then
			var_19_1 = var_4
		end

		Equipment = var_5
		var_19_0 = var_5.New({
			id = var_19_0.config.next
		})
	end

	if not var_19_1 then
		Equipment = var_4

		local var_19_2 = var_4.New({
			id = arg_19_1:getConfig("id")
		})

		while var_19_2.config.prev ~= 0 do
			if arg_19_0:getEquipmentById(var_19_2.config.prev) and var_4.count > 0 then
				var_19_1 = var_4

				break
			end

			Equipment = var_5
			var_19_2 = var_5.New({
				id = var_19_2.config.prev
			})
		end
	end

	if var_19_1 then
		return var_19_1.id
	end

	return
end

function var_0_1.getEquipCount(arg_20_0)
	local var_20_0 = 0

	pairs = var_1_10002

	for iter_20_0, iter_20_1 in var_1_10002(arg_20_0.data.equipments) do
		var_20_0 = var_20_0 + iter_20_1.count
	end

	return var_20_0
end

function var_0_1.getEquipmentSkinCount(arg_21_0)
	local var_21_0 = arg_21_0
	local var_21_1 = arg_21_0.getEquipmentSkins(var_21_0)
	local var_21_2 = 0

	pairs = var_21_0

	for iter_21_0, iter_21_1 in var_21_0(var_21_1) do
		var_21_2 = var_21_2 + iter_21_1.count
	end

	return var_21_2
end

function var_0_1.getCapacity(arg_22_0)
	return (arg_22_0:getEquipCount())
end

function var_0_1.getTimeLimitShipList(arg_23_0)
	getProxy = var_1_10001
	BayProxy = var_1_10003

	local var_23_0 = var_1_10001(var_1_10003)
	local var_23_1 = {}
	local var_23_2

	ipairs = var_1_10004

	for iter_23_0, iter_23_1 in var_1_10004(arg_23_0.shipIdListInTimeLimit) do
		if var_23_0:getShipById(iter_23_1) then
			table = var_9

			var_9.insert(var_23_1, {
				count = 1,
				type = 4,
				id = var_3.configId
			})
		end
	end

	return var_23_1
end

function var_0_1.clearTimeLimitShipList(arg_24_0)
	arg_24_0.shipIdListInTimeLimit = {}

	return
end

function var_0_1.GetSpWeapons(arg_25_0)
	return arg_25_0.spWeapons
end

function var_0_1.GetSpWeaponByUid(arg_26_0, arg_26_1)
	return arg_26_0.spWeapons[arg_26_1]
end

function var_0_1.StaticGetSpWeapon(arg_27_0, arg_27_1)
	local var_27_0
	local var_27_1

	if arg_27_0 and 0 < arg_27_0 then
		getProxy = var_1_10004
		BayProxy = var_1_10006
		var_1_10006 = var_1_10004(var_1_10006)

		if var_1_10004.getShipById(var_1_10006, arg_27_0) then
			::label_27_0::

			var_1_10006 = var_27_0
			var_27_1 = var_27_0.GetSpWeapon(var_1_10006)
		end
	else
		getProxy = var_1_10004
		EquipmentProxy = var_1_10006

		local var_27_2 = var_1_10004(var_1_10006)

		var_27_1 = var_4.GetSpWeaponByUid(var_27_2, arg_27_1)
	end

	return var_27_1, var_27_0
end

function var_0_1.GetSameTypeSpWeapon(arg_28_0, arg_28_1)
	local var_28_0
	local var_28_1 = arg_28_1
	local var_28_2 = arg_28_1.GetConfigID(var_28_1)
	local var_28_3

	while var_28_2 ~= 0 do
		SpWeapon = var_28_1

		local var_28_4 = var_28_1.New({
			id = var_28_2
		})

		if var_4.GetRarity(var_28_4) ~= arg_28_1:GetRarity() then
			break
		end

		pairs = var_28_1

		for iter_28_0, iter_28_1 in var_28_1(arg_28_0:GetSpWeapons()) do
			if iter_28_1:GetConfigID() == var_28_2 then
				var_28_0 = iter_28_1

				break
			end
		end

		if var_28_0 then
			break
		else
			var_28_2 = var_4:GetNextUpgradeID()
		end
	end

	if not var_28_0 then
		local var_28_5 = arg_28_1
		local var_28_6 = arg_28_1.GetPrevUpgradeID(var_28_5)
		local var_28_7

		while var_28_6 ~= 0 do
			SpWeapon = var_28_5

			local var_28_8 = var_28_5.New({
				id = var_28_6
			})

			if var_6.GetRarity(var_28_8) ~= arg_28_1:GetRarity() then
				break
			end

			pairs = var_28_5

			for iter_28_2, iter_28_3 in var_28_5(arg_28_0:GetSpWeapons()) do
				if iter_28_3:GetConfigID() == var_28_6 then
					var_28_0 = iter_28_3

					break
				end
			end

			if var_28_0 then
				break
			else
				var_28_6 = var_6:GetPrevUpgradeID()
			end
		end
	end

	return var_28_0
end

function var_0_1.GetSpWeaponCapacity(arg_29_0)
	return arg_29_0.spWeaponCapacity
end

function var_0_1.AddSpWeaponCapacity(arg_30_0, arg_30_1)
	arg_30_0.spWeaponCapacity = arg_30_0.spWeaponCapacity + arg_30_1

	return
end

function var_0_1.GetSpWeaponCount(arg_31_0)
	table = var_1_10001

	return var_1_10001.getCount(arg_31_0:GetSpWeapons())
end

function var_0_1.AddSpWeapon(arg_32_0, arg_32_1)
	arg_32_1:SetShipId(nil)

	arg_32_0.spWeapons[arg_32_1:GetUID()] = arg_32_1

	local var_32_0 = arg_32_0.facade

	var_2.sendNotification(var_32_0, var_0_1.SPWEAPONS_UPDATED)

	return
end

function var_0_1.RemoveSpWeapon(arg_33_0, arg_33_1)
	arg_33_0.spWeapons[arg_33_1:GetUID()] = nil

	local var_33_0 = arg_33_0.facade

	var_2.sendNotification(var_33_0, var_0_1.SPWEAPONS_UPDATED)

	return
end

var_0_1.EquipTransformTargetDict = {}
ipairs = var_1
pg = var_3

for iter_0_0, iter_0_1 in var_1(var_3.equip_upgrade_data.all) do
	pg = var_0_10006
	var_0_10006 = var_0_10006.equip_upgrade_data[iter_0_1]

	local var_0_2 = var_0_1.EquipTransformTargetDict
	local var_0_3 = var_0_10006.upgrade_from
	local var_0_4

	if not var_0_1.EquipTransformTargetDict[var_0_10006.upgrade_from] then
		var_0_4 = {}
	end

	var_0_2[var_0_3] = var_0_4

	local var_0_5 = var_0_1.EquipTransformTargetDict[var_0_10006.upgrade_from]
	local var_0_6

	if not var_0_1.EquipTransformTargetDict[var_0_10006.upgrade_from].targets then
		var_0_6 = {}
	end

	var_0_5.targets = var_0_6
	table = var_0_5

	var_0_5.insert(var_0_1.EquipTransformTargetDict[var_0_10006.upgrade_from].targets, iter_0_1)

	local var_0_7 = var_0_1.EquipTransformTargetDict
	local var_0_8 = var_0_10006.target_id
	local var_0_9

	if not var_0_1.EquipTransformTargetDict[var_0_10006.target_id] then
		var_0_9 = {}
	end

	var_0_7[var_0_8] = var_0_9

	local var_0_10 = var_0_1.EquipTransformTargetDict[var_0_10006.target_id]
	local var_0_11

	if not var_0_1.EquipTransformTargetDict[var_0_10006.target_id].sources then
		var_0_11 = {}
	end

	var_0_10.sources = var_0_11
	table = var_0_10

	var_0_10.insert(var_0_1.EquipTransformTargetDict[var_0_10006.target_id].sources, iter_0_1)
end

function var_0_1.GetTransformTargets(arg_34_0)
	local var_34_0

	if not var_0_1.EquipTransformTargetDict[arg_34_0] or not var_0_1.EquipTransformTargetDict[arg_34_0].targets then
		var_34_0 = {}
	end

	return var_34_0
end

function var_0_1.GetTransformSources(arg_35_0)
	local var_35_0

	if not var_0_1.EquipTransformTargetDict[arg_35_0] or not var_0_1.EquipTransformTargetDict[arg_35_0].sources then
		var_35_0 = {}
	end

	return var_35_0
end

var_0_1.EquipmentTransformTreeTemplate = {}

for iter_0_2 = 1, 4 do
	var_0_1.EquipmentTransformTreeTemplate[iter_0_2] = {}
end

ipairs = var_1
pg = var_3

for iter_0_3, iter_0_4 in var_1(var_3.equip_upgrade_template.all) do
	pg = var_0_10006
	var_0_10006 = var_0_10006.equip_upgrade_template[iter_0_4]

	local var_0_12 = var_0_1.EquipmentTransformTreeTemplate
	local var_0_13 = var_0_10006.category1
	local var_0_14

	if not var_0_1.EquipmentTransformTreeTemplate[var_0_10006.category1] then
		var_0_14 = {}
	end

	var_0_12[var_0_13] = var_0_14
	var_0_1.EquipmentTransformTreeTemplate[var_0_10006.category1][var_0_10006.category2] = var_0_10006
end

function var_0_1.SameEquip(arg_36_0, arg_36_1)
	assert = var_1_10002

	var_1_10002(arg_36_0 and arg_36_1, "Compare NIL Equip")

	if not arg_36_0 or not arg_36_1 then
		return false
	end

	return arg_36_0.id == arg_36_1.id and arg_36_0.shipId == arg_36_1.shipId and arg_36_0.shipPos == arg_36_1.shipPos
end

function var_0_1.GetWeakEquipsDict(arg_37_0)
	if arg_37_0.weakTable.equipsDict then
		return arg_37_0.weakTable.equipsDict
	end

	EquipmentsDict = var_1

	local var_37_0 = var_1.New()
	local var_37_1 = arg_37_0.weakTable

	var_37_1.equipsDict = var_37_0
	collectgarbage = var_37_1

	var_37_1("collect")

	return var_37_0
end

function var_0_1.OnEquipsUpdate(arg_38_0, arg_38_1)
	if not arg_38_0.weakTable.equipsDict then
		return
	end

	local var_38_0 = arg_38_0.weakTable.equipsDict

	var_2.UpdateEquipment(var_38_0, arg_38_1)

	return
end

function var_0_1.OnShipEquipsAdd(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	if not arg_39_0.weakTable.equipsDict then
		return
	end

	CreateShell = var_4
	arg_39_1 = var_4(arg_39_1)
	arg_39_1.shipId = arg_39_2
	arg_39_1.shipPos = arg_39_3

	local var_39_0 = arg_39_0.weakTable.equipsDict

	var_4.AddEquipment(var_39_0, arg_39_1)

	return
end

function var_0_1.OnShipEquipsRemove(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	if not arg_40_0.weakTable.equipsDict then
		return
	end

	CreateShell = var_4
	arg_40_1 = var_4(arg_40_1)
	arg_40_1.shipId = arg_40_2
	arg_40_1.shipPos = arg_40_3

	local var_40_0 = arg_40_0.weakTable.equipsDict

	var_4.RemoveEquipment(var_40_0, arg_40_1)

	return
end

function var_0_1.BuildEquipmentDesignObtainWayIndex(arg_41_0)
	if arg_41_0.equipmentDesignObtainWayIndexed then
		return
	end

	local function var_41_0(arg_42_0)
		DROP_TYPE_ITEM = var_2_10001

		local var_42_0

		if arg_42_0 ~= var_2_10001 then
			DROP_TYPE_VITEM = var_2_10001

			if arg_42_0 ~= var_2_10001 then
				var_42_0 = false

				goto label_42_0
			end
		end

		var_42_0 = true

		::label_42_0::

		return var_42_0
	end

	local var_41_1 = {}

	local function var_41_2(arg_43_0)
		if var_41_1[arg_43_0] then
			return var_41_1[arg_43_0]
		end

		local var_43_0 = {}

		Item = var_2_10002

		if var_2_10002.getConfigData(arg_43_0) then
			local var_43_1 = var_2.type

			Item = var_4

			if var_43_1 == var_4.DESIGN_TYPE then
				table = var_43_1

				var_43_1.insert(var_43_0, arg_43_0)
			end

			ipairs = var_43_1

			local var_43_2

			if not var_2.display_icon then
				var_43_2 = {}
			end

			for iter_43_0, iter_43_1 in var_43_1(var_43_2) do
				local var_43_3 = iter_43_1[1]
				local var_43_4 = iter_43_1[2]

				if var_41_0(var_43_3) then
					Item = var_10

					if var_10.getConfigData(var_43_4) then
						local var_43_5 = var_10.type

						Item = var_12

						if var_43_5 == var_12.DESIGN_TYPE then
							table = var_43_5

							var_43_5.insert(var_43_0, var_43_4)
						end
					end
				end
			end
		end

		var_41_1[arg_43_0] = var_43_0

		return var_43_0
	end

	local function var_41_3(arg_44_0)
		local var_44_0 = arg_41_0.equipmentDesignObtainWays
		local var_44_1

		if not arg_41_0.equipmentDesignObtainWays[arg_44_0] then
			var_44_1 = {
				{},
				false,
				false
			}
		end

		var_44_0[arg_44_0] = var_44_1

		return arg_41_0.equipmentDesignObtainWays[arg_44_0]
	end

	local function var_41_4(arg_45_0)
		return arg_45_0.act_id == 0 or arg_45_0.act_id == 100001
	end

	ipairs = var_1_10006
	pg = var_1_10008

	for iter_41_0, iter_41_1 in var_1_10006(var_1_10008.chapter_template.all) do
		pg = var_1_10011
		var_1_10011 = var_1_10011.chapter_template[iter_41_1]

		if var_41_4(var_1_10011) then
			if not var_1_10011.awards then
				var_1_10012 = {}
			end

			var_1_10013 = {}
			ipairs = var_14

			for iter_41_2, iter_41_3 in var_14(var_1_10012) do
				local var_41_5 = iter_41_3[1]

				var_1_10020 = iter_41_3[2]

				if var_41_0(var_41_5) then
					ipairs = var_21

					for iter_41_4, iter_41_5 in var_21(var_41_2(var_1_10020)) do
						if not var_1_10013[iter_41_5] then
							table = var_26

							var_26.insert(var_41_3(iter_41_5)[1], iter_41_1)

							var_1_10013[iter_41_5] = true
						end
					end
				end
			end
		end
	end

	ipairs = var_6
	pg = var_8

	for iter_41_6, iter_41_7 in var_6(var_8.technology_data_template.all) do
		pg = var_1_10011

		if not var_1_10011.technology_data_template[iter_41_7].drop_client then
			var_1_10011 = {}
		end

		ipairs = var_1_10012

		for iter_41_8, iter_41_9 in var_1_10012(var_1_10011) do
			local var_41_6 = iter_41_9[1]
			local var_41_7 = iter_41_9[2]

			if var_41_0(var_41_6) then
				ipairs = var_19

				for iter_41_10, iter_41_11 in var_19(var_41_2(var_41_7)) do
					var_41_3(iter_41_11)[2] = true
				end
			end
		end
	end

	getProxy = var_6
	ShopsProxy = var_8

	local var_41_8 = var_6(var_8)

	if var_6.getFragmentShop(var_41_8) then
		local var_41_9 = var_6
		local var_41_10 = var_6.GetCommodities

		designId = iter_41_7

		local var_41_11 = var_41_10(var_41_9, iter_41_7)

		ipairs = var_41_8

		for iter_41_12, iter_41_13 in var_41_8(var_41_11) do
			ipairs = var_1_10013

			for iter_41_14, iter_41_15 in var_1_10013(iter_41_13:GetDropList()) do
				local var_41_12 = iter_41_15.type
				local var_41_13 = iter_41_15.id

				DROP_TYPE_ITEM = var_1_10020

				if var_41_12 == var_1_10020 then
					Item = var_1_10020

					if var_1_10020.getConfigData(var_41_13) then
						local var_41_14 = var_1_10020.type

						Item = var_22

						if var_41_14 == var_22.DESIGN_TYPE then
							var_41_3(var_1_10020.id)[3] = true
						end
					end
				end
			end
		end
	end

	arg_41_0.equipmentDesignObtainWayIndexed = true

	return
end

function var_0_1.ShouldShowEquipmentDesignObtainWay(arg_46_0, arg_46_1)
	arg_46_0:BuildEquipmentDesignObtainWayIndex()

	if not arg_46_0.equipmentDesignObtainWays[arg_46_1] then
		return false
	end

	if not (#var_2[1] > 0) then
		if not var_2[2] then
			local var_46_0 = var_2[3]
		end

		if false then
			var_46_0 = false
		end
	else
		var_46_0 = true
	end

	return var_46_0
end

function var_0_1.GetObtainWay4EquipmentDesign(arg_47_0, arg_47_1)
	arg_47_0:BuildEquipmentDesignObtainWayIndex()

	local var_47_0 = arg_47_0.equipmentDesignObtainWays
	local var_47_1

	if not arg_47_0.equipmentDesignObtainWays[arg_47_1] then
		var_47_1 = {
			{},
			false,
			false
		}
	end

	var_47_0[arg_47_1] = var_47_1

	return arg_47_0.equipmentDesignObtainWays[arg_47_1]
end

return var_0_1
