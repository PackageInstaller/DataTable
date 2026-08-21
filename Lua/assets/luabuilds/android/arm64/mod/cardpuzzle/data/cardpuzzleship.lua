local var_0_0 = class("CardPuzzleShip", BaseVO)

function var_0_0.getShipArmor(arg_1_0)
	return arg_1_0:getConfig("armor")
end

function var_0_0.getShipArmorName(arg_2_0)
	return ArmorType.Type2Name((arg_2_0:getShipArmor()))
end

function var_0_0.getGroupId(arg_3_0)
	return pg.ship_data_template[arg_3_0.configId].group_type
end

function var_0_0.getGroupIdByConfigId(arg_4_0)
	return math.floor(arg_4_0 / 10)
end

function var_0_0.getShipType(arg_5_0)
	return pg.ship_data_statistics[arg_5_0.configId].type
end

function var_0_0.getNation(arg_6_0)
	assert(false)

	return
end

function var_0_0.getPaintingName(arg_7_0)
	assert(pg.ship_skin_template[pg.ship_data_statistics[arg_7_0].skin_id], "ship_skin_template not exist: " .. arg_7_0 .. " " .. pg.ship_data_statistics[arg_7_0].skin_id)

	return pg.ship_skin_template[pg.ship_data_statistics[arg_7_0].skin_id].painting
end

function var_0_0.getName(arg_8_0)
	return pg.ship_data_statistics[arg_8_0.configId].name
end

function var_0_0.getShipName(arg_9_0)
	return pg.ship_data_statistics[arg_9_0].name
end

function var_0_0.Ctor(arg_10_0, arg_10_1)
	arg_10_0.configId = arg_10_1.template_id or arg_10_1.configId
	arg_10_0.level = arg_10_1.level
	arg_10_0.exp = arg_10_1.exp

	if arg_10_1.name and arg_10_1.name ~= "" then
		arg_10_0.name = arg_10_1.name
	else
		assert(pg.ship_data_statistics[arg_10_0.configId], "必须存在配置" .. arg_10_0.configId)

		arg_10_0.name = pg.ship_data_statistics[arg_10_0.configId].name
	end

	arg_10_0.equipmentSkins = {}
	arg_10_0.equipments = {}

	if arg_10_1.equip_info_list then
		local var_10_0 = arg_10_1.equip_info_list or {}

		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			local var_10_1 = arg_10_0.equipments

			var_10_1[iter_10_0] = iter_10_1.id > 0 and Equipment.New({
				count = 1,
				id = iter_10_1.id,
				config_id = iter_10_1.id,
				skinId = iter_10_1.skinId
			}) or false

			local var_10_2 = arg_10_0.equipmentSkins

			if iter_10_1.skinId > 0 then
				var_10_2[iter_10_0] = iter_10_1.skinId or 0

				arg_10_0:reletiveEquipSkin(iter_10_0)
			end
		end
	end

	arg_10_0.skills = {}

	local var_10_3 = arg_10_1.skill_id_list or {}

	for iter_10_2, iter_10_3 in ipairs(var_10_3) do
		arg_10_0:updateSkill(iter_10_3)
	end

	arg_10_0.star = arg_10_0:getConfig("rarity")
	arg_10_0.transforms = {}
	arg_10_0.skinId = not HXSet.isHxSkin() and (arg_10_1.skin_id or 0) or 0

	if arg_10_0.skinId == 0 then
		arg_10_0.skinId = arg_10_0:getConfig("skin_id")
	end

	return
end

function var_0_0.getActiveEquipments(arg_11_0)
	local var_11_0 = Clone(arg_11_0.equipments)

	for iter_11_0 = #var_11_0, 1, -1 do
		if var_11_0[iter_11_0] then
			for iter_11_1 = 1, iter_11_0 - 1 do
				if var_11_0[iter_11_1] and var_11_0[iter_11_0]:getConfig("equip_limit") ~= 0 and var_11_0[iter_11_1]:getConfig("equip_limit") == var_11_0[iter_11_0]:getConfig("equip_limit") then
					var_11_0[iter_11_0] = false
				end
			end
		end
	end

	return var_11_0
end

function var_0_0.getAllEquipments(arg_12_0)
	return arg_12_0.equipments
end

function var_0_0.updateSkinId(arg_13_0, arg_13_1)
	arg_13_0.skinId = arg_13_1

	return
end

function var_0_0.getPrefab(arg_14_0)
	assert(pg.ship_skin_template[arg_14_0.skinId], "ship_skin_template not exist: " .. arg_14_0.configId .. " " .. arg_14_0.skinId)

	return pg.ship_skin_template[arg_14_0.skinId].prefab
end

function var_0_0.getPainting(arg_15_0)
	assert(pg.ship_skin_template[arg_15_0.skinId], "ship_skin_template not exist: " .. arg_15_0.configId .. " " .. arg_15_0.skinId)

	return pg.ship_skin_template[arg_15_0.skinId].painting
end

function var_0_0.GetSkinConfig(arg_16_0)
	assert(pg.ship_skin_template[arg_16_0.skinId], "ship_skin_template not exist: " .. arg_16_0.configId .. " " .. arg_16_0.skinId)

	return pg.ship_skin_template[arg_16_0.skinId]
end

function var_0_0.updateEquip(arg_17_0, arg_17_1, arg_17_2)
	assert(arg_17_2 == nil or arg_17_2.count == 1)

	local var_17_1 = arg_17_0.equipments

	var_17_1[arg_17_1] = arg_17_2 and Clone(arg_17_2) or false

	return
end

function var_0_0.getEquip(arg_18_0, arg_18_1)
	return Clone(arg_18_0.equipments[arg_18_1])
end

function var_0_0.bindConfigTable(arg_19_0)
	return pg.puzzle_ship_template
end

function var_0_0.isAvaiable(arg_20_0)
	return true
end

var_0_0.PROPERTIES = {
	AttributeType.Durability,
	AttributeType.Cannon,
	AttributeType.Torpedo,
	AttributeType.AntiAircraft,
	AttributeType.AntiSub,
	AttributeType.Air,
	AttributeType.Reload,
	AttributeType.Armor,
	AttributeType.Hit,
	AttributeType.Speed,
	AttributeType.Dodge,
	AttributeType.Luck
}
var_0_0.DIVE_PROPERTIES = {
	AttributeType.OxyMax,
	AttributeType.OxyCost,
	AttributeType.OxyRecovery,
	AttributeType.OxyRecoveryBench,
	AttributeType.OxyAttackDuration,
	AttributeType.OxyRaidDistance
}
var_0_0.SONAR_PROPERTIES = {
	AttributeType.SonarRange
}

function var_0_0.getShipProperties(arg_21_0)
	return (arg_21_0:getBaseProperties())
end

function var_0_0.getBaseProperties(arg_22_0)
	local var_22_0 = arg_22_0:getConfigTable()

	assert(var_22_0, "配置表没有这艘船" .. arg_22_0.configId)

	for iter_22_0, iter_22_1 in ipairs(var_0_0.PROPERTIES) do
		({})[iter_22_1] = var_22_0[iter_22_1]
	end

	for iter_22_2, iter_22_3 in ipairs(var_0_0.DIVE_PROPERTIES) do
		({})[iter_22_3] = 0
	end

	for iter_22_4, iter_22_5 in ipairs(var_0_0.SONAR_PROPERTIES) do
		({})[iter_22_5] = 0
	end

	return {}
end

function var_0_0.getGiftProperties(arg_23_0, arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(var_0_0.PROPERTIES) do
		({})[iter_23_1] = 0
	end

	for iter_23_2, iter_23_3 in ipairs(var_0_0.DIVE_PROPERTIES) do
		({})[iter_23_3] = 0
	end

	for iter_23_4, iter_23_5 in ipairs(var_0_0.SONAR_PROPERTIES) do
		({})[iter_23_5] = 0
	end

	for iter_23_6, iter_23_7 in ipairs(arg_23_1) do
		if iter_23_7 then
			for iter_23_8, iter_23_9 in ipairs((iter_23_7:GetAttributeBonus(arg_23_0))) do
				if iter_23_9 and ({})[iter_23_9.type] then
					({})[iter_23_9.type] = ({})[iter_23_9.type] + iter_23_9.value
				end
			end
		end
	end

	return {}
end

function var_0_0.getProperties(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:getShipProperties()
	local var_24_1 = arg_24_0:getGiftProperties(arg_24_1)

	for iter_24_0, iter_24_1 in ipairs(var_0_0.PROPERTIES) do
		var_24_0[iter_24_1] = iter_24_1 == AttributeType.Speed and var_24_0[iter_24_1] + var_24_1[iter_24_1] or calcFloor(var_24_0[iter_24_1] + var_24_1[iter_24_1])
	end

	for iter_24_2, iter_24_3 in ipairs(var_0_0.DIVE_PROPERTIES) do
		var_24_0[iter_24_3] = var_24_0[iter_24_3] + var_24_1[iter_24_3]
	end

	for iter_24_4, iter_24_5 in ipairs(var_0_0.SONAR_PROPERTIES) do
		var_24_0[iter_24_5] = var_24_0[iter_24_5] + var_24_1[iter_24_5]
	end

	return var_24_0
end

function var_0_0.getTriggerSkills(arg_25_0)
	local var_25_0 = {}

	_.each(arg_25_0:getSkillEffects(), function(arg_26_0)
		if arg_26_0.type == "AddBuff" and arg_26_0.arg_list and arg_26_0.arg_list.buff_id then
			var_25_0[arg_26_0.arg_list.buff_id] = {
				id = arg_26_0.arg_list.buff_id,
				level = arg_26_0.level
			}
		end

		return
	end)

	return {}
end

function var_0_0.GetEquipmentSkills(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs((arg_27_0:getActiveEquipments())) do
		if iter_27_1 then
			local var_27_0 = iter_27_1:getConfig("skill_id")[1]

			if var_27_0 then
				({})[var_27_0] = {
					level = 1,
					id = var_27_0
				}
			end
		end
	end

	return {}
end

function var_0_0.getAllSkills(arg_28_0)
	local var_28_0 = Clone(arg_28_0.skills)

	for iter_28_0, iter_28_1 in pairs(arg_28_0:GetEquipmentSkills()) do
		var_28_0[iter_28_0] = iter_28_1
	end

	for iter_28_2, iter_28_3 in pairs(arg_28_0:getTriggerSkills()) do
		var_28_0[iter_28_2] = iter_28_3
	end

	return var_28_0
end

function var_0_0.getRarity(arg_29_0)
	assert(false)

	return
end

function var_0_0.upgrade(arg_30_0)
	assert(false)

	return
end

function var_0_0.getTeamType(arg_31_0)
	return ShipType.GetTeamFromShipType(arg_31_0:getShipType())
end

function var_0_0.getMaxConfigId(arg_32_0)
	local var_32_0

	for iter_32_0 = 4, 1, -1 do
		local var_32_1 = tonumber(arg_32_0.groupId .. iter_32_0)

		if pg.ship_data_template[var_32_1] then
			var_32_0 = var_32_1

			break
		end
	end

	return var_32_0
end

function var_0_0.fateSkillChange(arg_33_0, arg_33_1)
	if not arg_33_0.skillChangeList then
		if arg_33_0:isBluePrintShip() then
			arg_33_0.skillChangeList = arg_33_0:getBluePrint():getChangeSkillList() or {}

			for iter_33_0, iter_33_1 in ipairs(arg_33_0.skillChangeList) do
				if iter_33_1[1] == arg_33_1 and arg_33_0.skills[iter_33_1[2]] then
					return iter_33_1[2]
				end
			end

			return arg_33_1
		end
	end
end

function var_0_0.getSkillList(arg_34_0)
	local var_34_0 = Clone(pg.ship_data_template[arg_34_0.configId].buff_list)

	if pg.ship_data_trans[arg_34_0.groupId] and pg.ship_data_trans[arg_34_0.groupId].skill_id ~= 0 then
		if arg_34_0.transforms[pg.ship_data_trans[arg_34_0.groupId].skill_id] and pg.transform_data_template[pg.ship_data_trans[arg_34_0.groupId].skill_id].skill_id ~= 0 then
			table.insert(var_34_0, pg.transform_data_template[pg.ship_data_trans[arg_34_0.groupId].skill_id].skill_id)
		end
	end

	local var_34_2 = {}

	for iter_34_0, iter_34_1 in ipairs((Clone(pg.ship_data_template[arg_34_0.configId].buff_list_display))) do
		for iter_34_2, iter_34_3 in ipairs(var_34_0) do
			if iter_34_1 == iter_34_3 then
				table.insert(var_34_2, arg_34_0:fateSkillChange(iter_34_1))
			end
		end
	end

	return var_34_2
end

function var_0_0.getDisplaySkillIds(arg_35_0)
	return _.map(pg.ship_data_template[arg_35_0.configId].buff_list_display, function(arg_36_0)
		return arg_35_0:fateSkillChange(arg_36_0)
	end)
end

function var_0_0.getSkillIndex(arg_37_0, arg_37_1)
	for iter_37_0, iter_37_1 in ipairs((arg_37_0:getSkillList())) do
		if arg_37_1 == iter_37_1 then
			return iter_37_0
		end
	end

	return
end

function var_0_0.IsBgmSkin(arg_38_0)
	return table.contains(arg_38_0:GetSkinConfig().tag, ShipSkin.WITH_BGM)
end

function var_0_0.GetSkinBgm(arg_39_0)
	if arg_39_0:IsBgmSkin() then
		return arg_39_0:GetSkinConfig().bgm
	end

	return
end

function var_0_0.GetConfigId(arg_40_0)
	return arg_40_0.configId
end

function var_0_0.GetDefaultCards(arg_41_0)
	return arg_41_0:getConfig("default_card")
end

return var_0_0
