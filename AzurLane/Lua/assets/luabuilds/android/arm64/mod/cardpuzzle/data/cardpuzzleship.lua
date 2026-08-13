class = var_0_10000

local var_0_0 = "CardPuzzleShip"

BaseVO = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003)

function var_0_1.getShipArmor(arg_1_0)
	return arg_1_0:getConfig("armor")
end

function var_0_1.getShipArmorName(arg_2_0)
	local var_2_0 = arg_2_0:getShipArmor()

	ArmorType = var_1_10002

	return var_1_10002.Type2Name(var_2_0)
end

function var_0_1.getGroupId(arg_3_0)
	pg = var_1_10001

	return var_1_10001.ship_data_template[arg_3_0.configId].group_type
end

function var_0_1.getGroupIdByConfigId(arg_4_0)
	math = var_1_10001

	return var_1_10001.floor(arg_4_0 / 10)
end

function var_0_1.getShipType(arg_5_0)
	pg = var_1_10001

	return var_1_10001.ship_data_statistics[arg_5_0.configId].type
end

function var_0_1.getNation(arg_6_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.getPaintingName(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.ship_data_statistics[arg_7_0].skin_id

	pg = var_1_10002

	local var_7_1 = var_1_10002.ship_skin_template[var_7_0]

	assert = var_1_10003

	var_1_10003(var_7_1, "ship_skin_template not exist: " .. arg_7_0 .. " " .. var_7_0)

	return var_7_1.painting
end

function var_0_1.getName(arg_8_0)
	pg = var_1_10001

	return var_1_10001.ship_data_statistics[arg_8_0.configId].name
end

function var_0_1.getShipName(arg_9_0)
	pg = var_1_10001

	return var_1_10001.ship_data_statistics[arg_9_0].name
end

function var_0_1.Ctor(arg_10_0, arg_10_1)
	local var_10_0

	if not arg_10_1.template_id then
		var_10_0 = arg_10_1.configId
	end

	arg_10_0.configId = var_10_0
	arg_10_0.level = arg_10_1.level
	arg_10_0.exp = arg_10_1.exp

	if arg_10_1.name and arg_10_1.name ~= "" then
		arg_10_0.name = arg_10_1.name
	else
		assert = var_2
		pg = var_1_10004

		var_2(var_1_10004.ship_data_statistics[arg_10_0.configId], "必须存在配置" .. arg_10_0.configId)

		pg = var_2
		arg_10_0.name = var_2.ship_data_statistics[arg_10_0.configId].name
	end

	arg_10_0.equipmentSkins = {}
	arg_10_0.equipments = {}

	if arg_10_1.equip_info_list then
		ipairs = var_2

		local var_10_1

		if not arg_10_1.equip_info_list then
			var_10_1 = {}
		end

		for iter_10_0, iter_10_1 in var_2(var_10_1) do
			local var_10_2 = arg_10_0.equipments

			if iter_10_1.id > 0 then
				Equipment = var_8

				local var_10_3

				if not var_8.New({
					count = 1,
					id = iter_10_1.id,
					config_id = iter_10_1.id,
					skinId = iter_10_1.skinId
				}) then
					var_10_3 = false
				end

				var_10_2[iter_10_0] = var_10_3

				local var_10_4 = arg_10_0.equipmentSkins
				local var_10_5

				if not (iter_10_1.skinId > 0) or not iter_10_1.skinId then
					var_10_5 = 0
				end

				var_10_4[iter_10_0] = var_10_5

				arg_10_0:reletiveEquipSkin(iter_10_0)
			end
		end
	end

	arg_10_0.skills = {}
	ipairs = var_2

	local var_10_6

	if not arg_10_1.skill_id_list then
		var_10_6 = {}
	end

	for iter_10_2, iter_10_3 in var_2(var_10_6) do
		arg_10_0:updateSkill(iter_10_3)
	end

	arg_10_0.star = arg_10_0:getConfig("rarity")
	arg_10_0.transforms = {}
	HXSet = var_2

	if not var_2.isHxSkin() then
		local var_10_7

		if not arg_10_1.skin_id then
			var_10_7 = 0
		end

		arg_10_0.skinId = var_10_7
	else
		arg_10_0.skinId = 0
	end

	if arg_10_0.skinId == 0 then
		arg_10_0.skinId = arg_10_0:getConfig("skin_id")
	end

	return
end

function var_0_1.getActiveEquipments(arg_11_0)
	Clone = var_1_10001

	for iter_11_0 = #var_1_10001(arg_11_0.equipments), 1, -1 do
		if var_1[iter_11_0] then
			for iter_11_1 = 1, iter_11_0 - 1 do
				if var_1[iter_11_1] and var_6:getConfig("equip_limit") ~= 0 and var_11:getConfig("equip_limit") == var_6:getConfig("equip_limit") then
					var_1[iter_11_0] = false
				end
			end
		end
	end

	return var_1
end

function var_0_1.getAllEquipments(arg_12_0)
	return arg_12_0.equipments
end

function var_0_1.updateSkinId(arg_13_0, arg_13_1)
	arg_13_0.skinId = arg_13_1

	return
end

function var_0_1.getPrefab(arg_14_0)
	local var_14_0 = arg_14_0.skinId

	pg = var_1_10002

	local var_14_1 = var_1_10002.ship_skin_template[var_14_0]

	assert = var_1_10003

	var_1_10003(var_14_1, "ship_skin_template not exist: " .. arg_14_0.configId .. " " .. var_14_0)

	return var_14_1.prefab
end

function var_0_1.getPainting(arg_15_0)
	pg = var_1_10001

	local var_15_0 = var_1_10001.ship_skin_template[arg_15_0.skinId]

	assert = var_2

	var_2(var_15_0, "ship_skin_template not exist: " .. arg_15_0.configId .. " " .. arg_15_0.skinId)

	return var_15_0.painting
end

function var_0_1.GetSkinConfig(arg_16_0)
	pg = var_1_10001

	local var_16_0 = var_1_10001.ship_skin_template[arg_16_0.skinId]

	assert = var_2

	var_2(var_16_0, "ship_skin_template not exist: " .. arg_16_0.configId .. " " .. arg_16_0.skinId)

	return var_16_0
end

function var_0_1.updateEquip(arg_17_0, arg_17_1, arg_17_2)
	assert = var_1_10003

	var_1_10003(arg_17_2 == nil or arg_17_2.count == 1)

	local var_17_0 = arg_17_0.equipments[arg_17_1]
	local var_17_1 = arg_17_0.equipments

	if arg_17_2 then
		Clone = var_5

		local var_17_2

		if not var_5(arg_17_2) then
			var_17_2 = false
		end

		var_17_1[arg_17_1] = var_17_2

		return
	end
end

function var_0_1.getEquip(arg_18_0, arg_18_1)
	Clone = var_1_10002

	return var_1_10002(arg_18_0.equipments[arg_18_1])
end

function var_0_1.bindConfigTable(arg_19_0)
	pg = var_1_10001

	return var_1_10001.puzzle_ship_template
end

function var_0_1.isAvaiable(arg_20_0)
	return true
end

local var_0_2 = {}

AttributeType = var_0_0
var_0_2[1] = var_0_0.Durability
AttributeType = var_2
var_0_2[2] = var_2.Cannon
AttributeType = var_2
var_0_2[3] = var_2.Torpedo
AttributeType = var_2
var_0_2[4] = var_2.AntiAircraft
AttributeType = var_2
var_0_2[5] = var_2.AntiSub
AttributeType = var_2
var_0_2[6] = var_2.Air
AttributeType = var_2
var_0_2[7] = var_2.Reload
AttributeType = var_2
var_0_2[8] = var_2.Armor
AttributeType = var_2
var_0_2[9] = var_2.Hit
AttributeType = var_2
var_0_2[10] = var_2.Speed
AttributeType = var_2
var_0_2[11] = var_2.Dodge
AttributeType = var_2
var_0_2[12] = var_2.Luck
var_0_1.PROPERTIES = var_0_2

local var_0_3 = {}

AttributeType = var_2
var_0_3[1] = var_2.OxyMax
AttributeType = var_2
var_0_3[2] = var_2.OxyCost
AttributeType = var_2
var_0_3[3] = var_2.OxyRecovery
AttributeType = var_2
var_0_3[4] = var_2.OxyRecoveryBench
AttributeType = var_2
var_0_3[5] = var_2.OxyAttackDuration
AttributeType = var_2
var_0_3[6] = var_2.OxyRaidDistance
var_0_1.DIVE_PROPERTIES = var_0_3

local var_0_4 = {}

AttributeType = var_2
var_0_4[1] = var_2.SonarRange
var_0_1.SONAR_PROPERTIES = var_0_4

function var_0_1.getShipProperties(arg_21_0)
	return (arg_21_0:getBaseProperties())
end

function var_0_1.getBaseProperties(arg_22_0)
	local var_22_0 = arg_22_0
	local var_22_1 = arg_22_0.getConfigTable(var_22_0)

	assert = var_1_10002

	var_1_10002(var_22_1, "配置表没有这艘船" .. arg_22_0.configId)

	local var_22_2 = {}

	ipairs = var_22_0

	for iter_22_0, iter_22_1 in var_22_0(var_0_1.PROPERTIES) do
		var_22_2[iter_22_1] = var_22_1[iter_22_1]
	end

	ipairs = var_3

	for iter_22_2, iter_22_3 in var_3(var_0_1.DIVE_PROPERTIES) do
		var_22_2[iter_22_3] = 0
	end

	ipairs = var_3

	for iter_22_4, iter_22_5 in var_3(var_0_1.SONAR_PROPERTIES) do
		var_22_2[iter_22_5] = 0
	end

	return var_22_2
end

function var_0_1.getGiftProperties(arg_23_0, arg_23_1)
	local var_23_0 = {}

	ipairs = var_1_10003

	for iter_23_0, iter_23_1 in var_1_10003(var_0_1.PROPERTIES) do
		var_23_0[iter_23_1] = 0
	end

	ipairs = var_3

	for iter_23_2, iter_23_3 in var_3(var_0_1.DIVE_PROPERTIES) do
		var_23_0[iter_23_3] = 0
	end

	ipairs = var_3

	for iter_23_4, iter_23_5 in var_3(var_0_1.SONAR_PROPERTIES) do
		var_23_0[iter_23_5] = 0
	end

	ipairs = var_3

	for iter_23_6, iter_23_7 in var_3(arg_23_1) do
		if iter_23_7 then
			local var_23_1 = iter_23_7:GetAttributeBonus(arg_23_0)

			ipairs = var_1_10009

			for iter_23_8, iter_23_9 in var_1_10009(var_23_1) do
				if iter_23_9 and var_23_0[iter_23_9.type] then
					var_23_0[iter_23_9.type] = var_23_0[iter_23_9.type] + iter_23_9.value
				end
			end
		end
	end

	return var_23_0
end

function var_0_1.getProperties(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0
	local var_24_1 = arg_24_0.getShipProperties(var_24_0)
	local var_24_2 = arg_24_0:getGiftProperties(arg_24_1)

	ipairs = var_24_0

	for iter_24_0, iter_24_1 in var_24_0(var_0_1.PROPERTIES) do
		AttributeType = var_1_10009

		if iter_24_1 == var_1_10009.Speed then
			var_24_1[iter_24_1] = var_24_1[iter_24_1] + var_24_2[iter_24_1]
		else
			calcFloor = var_1_10009
			var_24_1[iter_24_1] = var_1_10009(var_24_1[iter_24_1] + var_24_2[iter_24_1])
		end
	end

	ipairs = var_4

	for iter_24_2, iter_24_3 in var_4(var_0_1.DIVE_PROPERTIES) do
		var_24_1[iter_24_3] = var_24_1[iter_24_3] + var_24_2[iter_24_3]
	end

	ipairs = var_4

	for iter_24_4, iter_24_5 in var_4(var_0_1.SONAR_PROPERTIES) do
		var_24_1[iter_24_5] = var_24_1[iter_24_5] + var_24_2[iter_24_5]
	end

	return var_24_1
end

function var_0_1.getTriggerSkills(arg_25_0)
	local var_25_0 = {}
	local var_25_1 = arg_25_0:getSkillEffects()

	_ = var_1_10003

	var_1_10003.each(var_25_1, function(arg_26_0)
		if arg_26_0.type == "AddBuff" and arg_26_0.arg_list and arg_26_0.arg_list.buff_id then
			local var_26_0 = arg_26_0.arg_list.buff_id

			var_25_0[var_26_0] = {
				id = var_26_0,
				level = arg_26_0.level
			}
		end

		return
	end)

	return var_25_0
end

function var_0_1.GetEquipmentSkills(arg_27_0)
	local var_27_0 = {}
	local var_27_1 = arg_27_0:getActiveEquipments()

	ipairs = var_1_10003

	for iter_27_0, iter_27_1 in var_1_10003(var_27_1) do
		if iter_27_1 and iter_27_1:getConfig("skill_id")[1] then
			var_27_0[var_8] = {
				level = 1,
				id = var_8
			}
		end
	end

	return var_27_0
end

function var_0_1.getAllSkills(arg_28_0)
	Clone = var_1_10001

	local var_28_0 = var_1_10001(arg_28_0.skills)

	pairs = var_1_10002

	for iter_28_0, iter_28_1 in var_1_10002(arg_28_0:GetEquipmentSkills()) do
		var_28_0[iter_28_0] = iter_28_1
	end

	pairs = var_2

	for iter_28_2, iter_28_3 in var_2(arg_28_0:getTriggerSkills()) do
		var_28_0[iter_28_2] = iter_28_3
	end

	return var_28_0
end

function var_0_1.getRarity(arg_29_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.upgrade(arg_30_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.getTeamType(arg_31_0)
	ShipType = var_1_10001

	return var_1_10001.GetTeamFromShipType(arg_31_0:getShipType())
end

function var_0_1.getMaxConfigId(arg_32_0)
	pg = var_1_10001

	local var_32_0 = var_1_10001.ship_data_template
	local var_32_1

	for iter_32_0 = 4, 1, -1 do
		tonumber = var_1_10007

		if var_32_0[var_1_10007(arg_32_0.groupId .. iter_32_0)] then
			var_32_1 = var_1_10007

			break
		end
	end

	return var_32_1
end

function var_0_1.fateSkillChange(arg_33_0, arg_33_1)
	if not arg_33_0.skillChangeList then
		if arg_33_0:isBluePrintShip() then
			local var_33_0 = arg_33_0:getBluePrint()
			local var_33_1

			if not var_33_1.getChangeSkillList(var_33_0) then
				var_33_1 = {}
			end

			arg_33_0.skillChangeList = var_33_1
			ipairs = var_33_1

			for iter_33_0, iter_33_1 in var_33_1(arg_33_0.skillChangeList) do
				if iter_33_1[1] == arg_33_1 and arg_33_0.skills[iter_33_1[2]] then
					return iter_33_1[2]
				end
			end

			return arg_33_1
		end
	end
end

function var_0_1.getSkillList(arg_34_0)
	pg = var_1_10001

	local var_34_0 = var_1_10001.ship_data_template[arg_34_0.configId]

	Clone = var_2

	local var_34_1 = var_2(var_34_0.buff_list_display)

	Clone = var_1_10003

	local var_34_2 = var_1_10003(var_34_0.buff_list)

	pg = var_4

	local var_34_3 = var_4.ship_data_trans[arg_34_0.groupId]
	local var_34_4 = 0

	if var_34_3 and var_34_3.skill_id ~= 0 then
		local var_34_5 = var_34_3.skill_id

		pg = var_1_10007
		var_1_10007 = var_1_10007.transform_data_template[var_34_5]

		if arg_34_0.transforms[var_34_5] and var_1_10007.skill_id ~= 0 then
			table = var_8

			var_8.insert(var_34_2, var_1_10007.skill_id)
		end
	end

	local var_34_6 = {}

	ipairs = var_1_10007

	for iter_34_0, iter_34_1 in var_1_10007(var_34_1) do
		ipairs = var_1_10012

		for iter_34_2, iter_34_3 in var_1_10012(var_34_2) do
			if iter_34_1 == iter_34_3 then
				table = var_1_10017

				var_1_10017.insert(var_34_6, arg_34_0:fateSkillChange(iter_34_1))
			end
		end
	end

	return var_34_6
end

function var_0_1.getDisplaySkillIds(arg_35_0)
	_ = var_1_10001

	local var_35_0 = var_1_10001.map

	pg = var_1_10003

	return var_35_0(var_1_10003.ship_data_template[arg_35_0.configId].buff_list_display, function(arg_36_0)
		local var_36_0 = arg_35_0

		return var_1.fateSkillChange(var_36_0, arg_36_0)
	end)
end

function var_0_1.getSkillIndex(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0:getSkillList()

	ipairs = var_1_10003

	for iter_37_0, iter_37_1 in var_1_10003(var_37_0) do
		if arg_37_1 == iter_37_1 then
			return iter_37_0
		end
	end

	return
end

function var_0_1.IsBgmSkin(arg_38_0)
	local var_38_0 = arg_38_0:GetSkinConfig()

	table = var_1_10002

	local var_38_1 = var_1_10002.contains
	local var_38_2 = var_38_0.tag

	ShipSkin = var_1_10005

	return var_38_1(var_38_2, var_1_10005.WITH_BGM)
end

function var_0_1.GetSkinBgm(arg_39_0)
	if arg_39_0:IsBgmSkin() then
		return arg_39_0:GetSkinConfig().bgm
	end

	return
end

function var_0_1.GetConfigId(arg_40_0)
	return arg_40_0.configId
end

function var_0_1.GetDefaultCards(arg_41_0)
	return arg_41_0:getConfig("default_card")
end

return var_0_1
