class = var_0_10000

local var_0_0 = "Ship"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

var_0_1.ENERGY_MID = 40
var_0_1.ENERGY_LOW = 0
var_0_1.RECOVER_ENERGY_POINT = 2
var_0_1.INTIMACY_PROPOSE = 6
var_0_1.CONFIG_MAX_STAR = 6
var_0_1.BACKYARD_1F_ENERGY_ADDITION = 2
var_0_1.BACKYARD_2F_ENERGY_ADDITION = 3
var_0_1.PREFERENCE_TAG_NONE = 0
var_0_1.PREFERENCE_TAG_COMMON = 1

local var_0_2 = {}

i18n = var_0_0
var_0_2.vanguard = var_0_0("word_vanguard_fleet")
i18n = var_2
var_0_2.main = var_2("word_main_fleet")
var_0_1.LOCK_STATE_UNLOCK = 0
var_0_1.LOCK_STATE_LOCK = 1
var_0_1.WEAPON_COUNT = 3
var_0_1.PREFAB_EQUIP = 4
var_0_1.MAX_SKILL_LEVEL = 10
var_0_1.ENERGY_RECOVER_TIME = 360

local var_0_3 = 4
local var_0_4 = 100
local var_0_5 = 120

pg = var_5

local var_0_6 = var_5.ship_data_strengthen

pg = var_0_10006

local var_0_7 = var_0_10006.ship_level

pg = var_0_10007

local var_0_8 = var_0_10007.equip_skin_template

pg = var_0_10008

local var_0_9 = var_0_10008.ship_data_breakout

local function var_0_10(arg_1_0)
	Nation = var_1_10001

	return var_1_10001.Nation2Print(arg_1_0)
end

local var_0_11 = nation2print

function var_0_1.getRecoverEnergyPoint(arg_2_0)
	return arg_2_0.propose and 3 or 2
end

local function var_0_12(arg_3_0)
	ShipType = var_1_10001

	return var_1_10001.Type2Name(arg_3_0)
end

local var_0_13 = shipType2name

local function var_0_14(arg_4_0)
	ShipType = var_1_10001

	return var_1_10001.Type2Print(arg_4_0)
end

local var_0_15 = shipType2print

local function var_0_16(arg_5_0)
	ShipType = var_1_10001

	return var_1_10001.Type2BattlePrint(arg_5_0)
end

local var_0_17 = shipType2Battleprint

local function var_0_18(arg_6_0)
	pg = var_1_10001

	if var_1_10001.ship_skin_template[arg_6_0].rarity_bg and var_2 ~= "" then
		return var_2
	end

	return
end

local var_0_19 = skinId2bgPrint

function var_0_1.useSkin(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0

	if arg_7_0.getSkinId(var_7_0) == arg_7_1 then
		return true
	end

	ShipSkin = var_1_10003

	local var_7_1 = var_1_10003.GetChangeSkinGroupId(var_2)

	ShipSkin = var_7_0

	local var_7_2 = var_7_0.GetChangeSkinGroupId(arg_7_1)

	if var_7_1 and var_7_2 and var_7_1 == var_7_2 then
		return true
	end

	return false
end

function var_0_1.rarity2bgPrint(arg_8_0)
	shipRarity2bgPrint = var_1_10001

	return var_1_10001(arg_8_0:getRarity(), arg_8_0:isBluePrintShip(), arg_8_0:isMetaShip())
end

function var_0_1.rarity2bgPrintForGet(arg_9_0)
	skinId2bgPrint = var_1_10001

	local var_9_0

	if not var_1_10001(arg_9_0:getSkinId()) then
		var_9_0 = arg_9_0:rarity2bgPrint()
	end

	return var_9_0
end

function var_0_1.getShipBgPrint(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.getSkinId(var_10_0)

	pg = var_1_10003

	local var_10_2 = var_1_10003.ship_skin_template[var_10_1]

	assert = var_10_0

	var_10_0(var_10_2, "ship_skin_template not exist: " .. var_10_1)

	local var_10_3

	if not arg_10_1 and var_10_2.bg_sp and var_10_2.bg_sp ~= "" then
		PlayerPrefs = var_5

		if var_5.GetInt("paint_hide_other_obj_" .. var_10_2.painting, 0) == 0 then
			var_10_3 = var_10_2.bg_sp
		end
	end

	local var_10_4

	if (not var_10_3 or not var_10_3) and (not var_10_2.bg or not (#var_10_2.bg > 0) or not var_10_2.bg) then
		var_10_4 = arg_10_0:rarity2bgPrintForGet()
	end

	return var_10_4
end

function var_0_1.getStar(arg_11_0)
	return arg_11_0:getConfig("star")
end

function var_0_1.getMaxStar(arg_12_0)
	pg = var_1_10001

	return var_1_10001.ship_data_template[arg_12_0.configId].star_max
end

function var_0_1.getShipArmor(arg_13_0)
	return arg_13_0:getConfig("armor_type")
end

function var_0_1.getShipArmorName(arg_14_0)
	local var_14_0 = arg_14_0:getShipArmor()

	ArmorType = var_1_10002

	return var_1_10002.Type2Name(var_14_0)
end

function var_0_1.getGroupId(arg_15_0)
	pg = var_1_10001

	return var_1_10001.ship_data_template[arg_15_0.configId].group_type
end

function var_0_1.getGroupIdByConfigId(arg_16_0)
	math = var_1_10001

	return var_1_10001.floor(arg_16_0 / 10)
end

function var_0_1.getTransformShipId(arg_17_0)
	pg = var_1_10001

	local var_17_0 = var_1_10001.ship_data_template[arg_17_0].group_type

	pg = var_1_10002

	if var_1_10002.ship_data_trans[var_17_0] then
		ipairs = var_1_10003

		for iter_17_0, iter_17_1 in var_1_10003(var_2.transform_list) do
			ipairs = var_1_10008

			for iter_17_2, iter_17_3 in var_1_10008(iter_17_1) do
				pg = var_1_10013
				var_1_10013 = var_1_10013.transform_data_template[iter_17_3[2]]
				ipairs = var_14

				for iter_17_4, iter_17_5 in var_14(var_1_10013.ship_id) do
					if iter_17_5[1] == arg_17_0 then
						return iter_17_5[2]
					end
				end
			end
		end
	end

	return
end

function var_0_1.getAircraftCount(arg_18_0)
	local var_18_0 = arg_18_0:getConfigTable().base_list
	local var_18_1 = arg_18_0:getConfigTable().default_equip_list
	local var_18_2 = {}

	for iter_18_0 = 1, 3 do
		local var_18_3 = arg_18_0

		if arg_18_0.getEquip(var_18_3, iter_18_0) then
			var_18_3 = arg_18_0

			local var_18_4

			if not arg_18_0.getEquip(var_18_3, iter_18_0).configId then
				var_18_4 = var_18_1[iter_18_0]
			end

			Equipment = var_1_10009
			var_1_10009 = var_1_10009.getConfigData(var_18_4).type
			table = var_18_3

			local var_18_5 = var_18_3.contains

			EquipType = var_1_10012

			if var_18_5(var_1_10012.AirDomainEquip, var_1_10009) then
				defaultValue = var_10
				var_18_2[var_1_10009] = var_10(var_18_2[var_1_10009], 0) + var_18_0[iter_18_0]
			end
		end
	end

	return var_18_2
end

function var_0_1.getShipType(arg_19_0)
	return arg_19_0:getConfig("type")
end

function var_0_1.getEnergy(arg_20_0)
	return arg_20_0.energy
end

function var_0_1.getEnergeConfig(arg_21_0)
	local var_21_0 = arg_21_0:getEnergy()

	ipairs = var_1_10002
	pg = var_1_10004

	for iter_21_0, iter_21_1 in var_1_10002(var_1_10004.energy_template.all) do
		pg = var_1_10007
		var_1_10007 = var_1_10007.energy_template[iter_21_1]
		type = var_1_10008

		if var_1_10008(iter_21_1) == "number" and var_1_10007.lower_bound <= var_21_0 and var_21_0 <= var_1_10007.upper_bound then
			return var_1_10007
		end
	end

	assert = var_2

	var_2(false, "疲劳配置不存在：" .. arg_21_0.energy)

	return
end

function var_0_1.isLowEnergy(arg_22_0)
	return arg_22_0:getEnergeConfig().id < 3
end

function var_0_1.getEnergyPrint(arg_23_0)
	return arg_23_0:getEnergeConfig().icon, var_1.desc
end

function var_0_1.getIntimacy(arg_24_0)
	local var_24_0

	if not arg_24_0.intimacy then
		var_24_0 = 0
	end

	return var_24_0
end

function var_0_1.getCVIntimacy(arg_25_0)
	return arg_25_0:getIntimacy() / 100 + (arg_25_0.propose and 1000 or 0)
end

function var_0_1.getIntimacyMax(arg_26_0)
	if arg_26_0.propose then
		return 200
	else
		return arg_26_0:GetNoProposeIntimacyMax()
	end

	return
end

function var_0_1.GetNoProposeIntimacyMax(arg_27_0)
	return 100
end

function var_0_1.getIntimacyIcon(arg_28_0)
	pg = var_1_10001

	local var_28_0 = var_1_10001.intimacy_template[arg_28_0:getIntimacyLevel()]
	local var_28_1 = ""

	if arg_28_0:isMetaShip() then
		var_28_1 = "_meta"
	elseif arg_28_0:IsXIdol() then
		var_28_1 = "_imas"
	end

	if not arg_28_0.propose then
		math = var_3

		if var_3.floor(arg_28_0:getIntimacy() / 100) >= arg_28_0:getIntimacyMax() then
			do return var_28_0.icon .. var_28_1, "heart" .. var_28_1 end

			goto label_28_0
		end
	end

	do return var_28_0.icon .. var_28_1 end

	::label_28_0::

	return
end

function var_0_1.getIntimacyDetail(arg_29_0)
	local var_29_0 = arg_29_0:getIntimacyMax()

	math = var_1_10002

	local var_29_1 = var_1_10002.floor(arg_29_0:getIntimacy() / 100)
end

function var_0_1.getIntimacyInfo(arg_30_0)
	pg = var_1_10001

	return var_1_10001.intimacy_template[arg_30_0:getIntimacyLevel()].icon, var_1.desc
end

function var_0_1.getIntimacyLevel(arg_31_0)
	local var_31_0 = 0

	pairs = var_1_10002
	pg = var_1_10004

	for iter_31_0, iter_31_1 in var_1_10002(var_1_10004.intimacy_template.all) do
		pg = var_1_10007
		var_1_10007 = var_1_10007.intimacy_template[iter_31_1]
		type = var_1_10008

		if var_1_10008(iter_31_1) == "number" and arg_31_0:getIntimacy() >= var_1_10007.lower_bound and arg_31_0:getIntimacy() <= var_1_10007.upper_bound then
			var_31_0 = iter_31_1

			break
		end
	end

	if var_31_0 < arg_31_0.INTIMACY_PROPOSE and arg_31_0.propose then
		var_31_0 = arg_31_0.INTIMACY_PROPOSE
	end

	return var_31_0
end

function var_0_1.getBluePrint(arg_32_0)
	ShipBluePrint = var_1_10001

	local var_32_0 = var_1_10001.New({
		id = arg_32_0.groupId
	})
	local var_32_1

	if not arg_32_0.strengthList[1] then
		var_32_1 = {
			exp = 0,
			level = 0
		}
	end

	var_32_0:updateInfo({
		blue_print_level = var_32_1.level,
		exp = var_32_1.exp
	})

	return var_32_0
end

function var_0_1.getBaseList(arg_33_0)
	if arg_33_0:isBluePrintShip() then
		local var_33_0 = arg_33_0:getBluePrint()

		assert = var_1_10002

		var_1_10002(var_33_0, "blueprint can not be nil" .. arg_33_0.configId)

		return var_33_0:getBaseList(arg_33_0)
	else
		return arg_33_0:getConfig("base_list")
	end

	return
end

function var_0_1.getPreLoadCount(arg_34_0)
	if arg_34_0:isBluePrintShip() then
		local var_34_0 = arg_34_0:getBluePrint()

		return var_1.getPreLoadCount(var_34_0, arg_34_0)
	else
		return arg_34_0:getConfig("preload_count")
	end

	return
end

function var_0_1.getNation(arg_35_0)
	return arg_35_0:getConfig("nationality")
end

function var_0_1.getPaintingName(arg_36_0)
	pg = var_1_10001

	local var_36_0 = var_1_10001.ship_data_statistics[arg_36_0].skin_id

	pg = var_1_10002

	local var_36_1 = var_1_10002.ship_skin_template[var_36_0]

	assert = var_1_10003

	var_1_10003(var_36_1, "ship_skin_template not exist: " .. arg_36_0 .. " " .. var_36_0)

	return var_36_1.painting
end

function var_0_1.getName(arg_37_0)
	if arg_37_0.propose then
		pg = var_1

		local var_37_0 = var_1.PushNotificationMgr.GetInstance()

		if var_1.isEnableShipName(var_37_0) then
			return arg_37_0.name
		end
	end

	if arg_37_0:isRemoulded() then
		pg = var_1

		return var_1.ship_skin_template[arg_37_0:getRemouldSkinId()].name
	end

	pg = var_1

	return var_1.ship_data_statistics[arg_37_0.configId].name
end

function var_0_1.GetDefaultName(arg_38_0)
	if arg_38_0:isRemoulded() then
		pg = var_1

		return var_1.ship_skin_template[arg_38_0:getRemouldSkinId()].name
	else
		pg = var_1

		return var_1.ship_data_statistics[arg_38_0.configId].name
	end

	return
end

function var_0_1.getShipName(arg_39_0)
	pg = var_1_10001

	return var_1_10001.ship_data_statistics[arg_39_0].name
end

function var_0_1.getBreakOutLevel(arg_40_0)
	assert = var_1_10001

	var_1_10001(arg_40_0, "必须存在配置id")

	assert = var_1_10001
	pg = var_3

	var_1_10001(var_3.ship_data_statistics[arg_40_0], "必须存在配置" .. arg_40_0)

	pg = var_1_10001

	return var_1_10001.ship_data_statistics[arg_40_0].star
end

function var_0_1.Ctor(arg_41_0, arg_41_1)
	arg_41_0.id = arg_41_1.id

	local var_41_0

	if not arg_41_1.template_id then
		var_41_0 = arg_41_1.configId
	end

	arg_41_0.configId = var_41_0
	arg_41_0.level = arg_41_1.level
	arg_41_0.exp = arg_41_1.exp
	arg_41_0.energy = arg_41_1.energy
	arg_41_0.lockState = arg_41_1.is_locked
	arg_41_0.intimacy = arg_41_1.intimacy

	local var_41_1

	if arg_41_1.propose then
		var_41_1 = arg_41_1.propose > 0
	end

	arg_41_0.propose = var_41_1
	arg_41_0.proposeTime = arg_41_1.propose

	if arg_41_0.intimacy and arg_41_0.intimacy > 10000 and not arg_41_0.propose then
		arg_41_0.intimacy = 10000
	end

	arg_41_0.renameTime = arg_41_1.change_name_timestamp

	if arg_41_1.name and arg_41_1.name ~= "" then
		arg_41_0.name = arg_41_1.name
	else
		assert = var_2
		pg = var_1_10004

		var_2(var_1_10004.ship_data_statistics[arg_41_0.configId], "必须存在配置" .. arg_41_0.configId)

		pg = var_2
		arg_41_0.name = var_2.ship_data_statistics[arg_41_0.configId].name
	end

	pg = var_2
	arg_41_0.groupId = var_2.ship_data_template[arg_41_0.configId].group_type
	pg = var_2

	local var_41_2 = var_2.ship_data_group.get_id_list_by_group_type[arg_41_0.groupId][1]

	pg = var_3
	arg_41_0.bluePrintFlag = var_3.ship_data_group[var_41_2].handbook_type == 2
	arg_41_0.strengthList = {}
	ipairs = var_3

	local var_41_3

	if not arg_41_1.strength_list then
		var_41_3 = {}
	end

	for iter_41_2, iter_41_1 in var_3(var_41_3) do
		local var_41_4

		if not arg_41_0:isBluePrintShip() then
			ShipModAttr = var_41_4
			var_41_4 = var_41_4.ID_TO_ATTR[iter_41_1.id]
			arg_41_0.strengthList[var_41_4] = iter_41_1.exp
		else
			table = var_41_4

			var_41_4.insert(arg_41_0.strengthList, {
				level = iter_41_1.id,
				exp = iter_41_1.exp
			})
		end
	end

	arg_41_0.equipmentSkins = {}
	arg_41_0.equipments = {}

	if arg_41_1.equip_info_list then
		ipairs = var_3

		local var_41_5

		if not arg_41_1.equip_info_list then
			var_41_5 = {}
		end

		for iter_41_2, iter_41_3 in var_3(var_41_5) do
			local var_41_6 = arg_41_0.equipments

			if iter_41_3.id > 0 then
				Equipment = var_9

				local var_41_7

				if not var_9.New({
					count = 1,
					id = iter_41_3.id,
					config_id = iter_41_3.id,
					skinId = iter_41_3.skinId
				}) then
					var_41_7 = false
				end

				var_41_6[iter_41_2] = var_41_7

				local var_41_8 = arg_41_0.equipmentSkins
				local var_41_9

				if not (iter_41_3.skinId > 0) or not iter_41_3.skinId then
					var_41_9 = 0
				end

				var_41_8[iter_41_2] = var_41_9

				arg_41_0:reletiveEquipSkin(iter_41_2)
			end
		end
	end

	arg_41_0.spWeapon = nil

	if arg_41_1.spweapon then
		local var_41_10 = arg_41_0
		local var_41_11 = arg_41_0.UpdateSpWeapon

		SpWeapon = iter_41_2

		var_41_11(var_41_10, iter_41_2.CreateByNet(arg_41_1.spweapon))
	end

	arg_41_0.skills = {}
	ipairs = var_3

	local var_41_12

	if not arg_41_1.skill_id_list then
		var_41_12 = {}
	end

	for iter_41_4, iter_41_5 in var_3(var_41_12) do
		arg_41_0:updateSkill(iter_41_5)
	end

	arg_41_0.star = arg_41_0:getConfig("rarity")
	arg_41_0.transforms = {}
	ipairs = var_3

	local var_41_13

	if not arg_41_1.transform_list then
		var_41_13 = {}
	end

	for iter_41_6, iter_41_7 in var_3(var_41_13) do
		arg_41_0.transforms[iter_41_7.id] = {
			id = iter_41_7.id,
			level = iter_41_7.level
		}
	end

	local var_41_14

	if not arg_41_1.create_time then
		var_41_14 = 0
	end

	arg_41_0.createTime = var_41_14
	getProxy = var_41_14
	CollectionProxy = var_5
	arg_41_0.virgin = var_41_14(var_5) and var_3.shipGroups[arg_41_0.groupId] == nil

	local var_41_15 = {}

	pg = var_5
	var_41_15[1] = var_5.gameset.test_ship_config_1.key_value
	pg = var_5
	var_41_15[2] = var_5.gameset.test_ship_config_2.key_value
	pg = var_5
	var_41_15[3] = var_5.gameset.test_ship_config_3.key_value
	table = var_5

	if var_5.indexof(var_41_15, arg_41_0.configId) == 1 then
		arg_41_0.testShip = {
			2,
			3,
			4
		}
	elseif var_5 == 2 then
		arg_41_0.testShip = {
			5
		}
	elseif var_5 == 3 then
		arg_41_0.testShip = {
			6
		}
	else
		arg_41_0.testShip = nil
	end

	pg = iter_41_6

	local var_41_16 = iter_41_6.intimacy_template

	pg = var_7
	arg_41_0.maxIntimacy = var_41_16[#var_7.intimacy_template.all].upper_bound

	local var_41_17 = 0

	HXSet = var_7

	if not var_7.isHxSkin() then
		var_41_17 = arg_41_1.skin_id or 0
	end

	arg_41_0.phantomDic = {}

	arg_41_0:updateSkinId(var_41_17, 0)

	ipairs = var_7

	local var_41_18

	if not arg_41_1.skin_shadow_list then
		var_41_18 = {}
	end

	for iter_41_8, iter_41_9 in var_7(var_41_18) do
		arg_41_0:updateSkinId(iter_41_9.value, iter_41_9.key)
	end

	local var_41_19

	if not arg_41_1.noChangeSkin then
		var_41_19 = false
	end

	arg_41_0.noChangeSkin = var_41_19
	arg_41_0.phantomRandomFlag = {}
	ipairs = var_7

	local var_41_20

	if not arg_41_1.char_random_flag then
		var_41_20 = {}
	end

	for iter_41_10, iter_41_11 in var_7(var_41_20) do
		arg_41_0:updateRandomFlag(1, iter_41_11)
	end

	if arg_41_1.name and arg_41_1.name ~= "" then
		arg_41_0.name = arg_41_1.name
	elseif arg_41_0:isRemoulded() then
		pg = var_7
		arg_41_0.name = var_7.ship_skin_template[arg_41_0:getRemouldSkinId()].name
	else
		pg = var_7
		arg_41_0.name = var_7.ship_data_statistics[arg_41_0.configId].name
	end

	arg_41_0.maxLevel = arg_41_1.max_level

	local var_41_21

	if not arg_41_1.proficiency then
		var_41_21 = 0
	end

	arg_41_0.proficiency = var_41_21
	arg_41_0.preferenceTag = arg_41_1.common_flag
	arg_41_0.hpRant = 10000
	arg_41_0.strategies = {}
	arg_41_0.triggers = {}

	local var_41_22

	if not arg_41_1.commanderid then
		var_41_22 = 0
	end

	arg_41_0.commanderId = var_41_22

	local var_41_23

	if not arg_41_1.activity_npc then
		var_41_23 = 0
	end

	arg_41_0.activityNpc = var_41_23

	if var_0_1.isMetaShipByConfigID(arg_41_0.configId) then
		MetaCharacterConst = var_8

		local var_41_24 = var_8.GetMetaShipGroupIDByConfigID(arg_41_0.configId)

		MetaCharacter = var_9
		arg_41_0.metaCharacter = var_9.New({
			id = var_41_24,
			repair_attr_info = arg_41_1.meta_repair_list
		}, arg_41_0)
	end

	return
end

function var_0_1.isMetaShipByConfigID(arg_42_0)
	pg = var_1_10001

	local var_42_0 = var_1_10001.ship_meta_breakout.all[1]
	local var_42_1 = false

	if var_42_0 <= arg_42_0 then
		ipairs = var_1_10004

		for iter_42_0, iter_42_1 in var_1_10004(var_1) do
			if arg_42_0 == iter_42_1 then
				var_42_1 = true

				break
			end
		end
	end

	return var_42_1
end

function var_0_1.isMetaShip(arg_43_0)
	return arg_43_0.metaCharacter ~= nil
end

function var_0_1.getMetaCharacter(arg_44_0)
	return arg_44_0.metaCharacter
end

function var_0_1.unlockActivityNpc(arg_45_0, arg_45_1)
	arg_45_0.activityNpc = arg_45_1

	return
end

function var_0_1.isActivityNpc(arg_46_0)
	return arg_46_0.activityNpc > 0
end

function var_0_1.getActiveEquipments(arg_47_0)
	Clone = var_1_10001

	for iter_47_0 = #var_1_10001(arg_47_0.equipments), 1, -1 do
		if var_1[iter_47_0] then
			for iter_47_1 = 1, iter_47_0 - 1 do
				if var_1[iter_47_1] and var_6:getConfig("equip_limit") ~= 0 and var_11:getConfig("equip_limit") == var_6:getConfig("equip_limit") then
					var_1[iter_47_0] = false
				end
			end
		end
	end

	return var_1
end

function var_0_1.getAllEquipments(arg_48_0)
	return arg_48_0.equipments
end

function var_0_1.isBluePrintShip(arg_49_0)
	return arg_49_0.bluePrintFlag
end

function var_0_1.getSkinId(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_0:getPhantomSkin(arg_50_1 or 0)

	if not arg_50_0.noChangeSkin then
		tobool = var_3

		if var_3(arg_50_0.id) then
			ShipSkin = var_3

			if var_3.IsChangeSkin(var_50_0) then
				ShipSkin = var_3

				local var_50_1 = var_3.GetStoreChangeSkinId

				ShipSkin = var_5

				if var_50_1(var_5.GetChangeSkinGroupId(var_50_0), arg_50_0:GetShipPhantomMark()) then
					return var_3
				end
			end
		end
	end

	return var_50_0
end

function var_0_1.RevertAsmrSkin(arg_51_0)
	local var_51_0 = arg_51_0
	local var_51_1 = arg_51_0.getSkinId(var_51_0)

	if not arg_51_0.noChangeSkin then
		tobool = var_2

		if var_2(arg_51_0.id) then
			ShipSkin = var_2

			if var_2.IsChangeSkin(var_51_1) then
				ShipSkin = var_2

				local var_51_2 = var_2.GetChangeSkinCustomDataId(var_51_1, "asmr") == 1 and true or false

				ShipSkin = var_51_0

				local var_51_3 = var_51_0.GetChangeSkinCustomDataId(var_51_1, "index") == 1 and true or false

				if var_51_2 and not var_51_3 then
					ShipSkin = var_4

					local var_51_4 = var_4.GetChangeSkinMainId(var_51_1)

					ShipSkin = var_5

					var_5.SetStoreChangeSkinId(var_51_4, arg_51_0:GetShipPhantomMark())
				end
			end
		end
	end

	return
end

function var_0_1.getPhantomSkin(arg_52_0, arg_52_1)
	if not arg_52_1 or arg_52_1 == 0 then
		return arg_52_0.skinId
	else
		local var_52_0

		if not arg_52_0.phantomDic[arg_52_0.phantomId] then
			var_52_0 = arg_52_0:getConfig("skin_id")
		end

		return var_52_0
	end

	return
end

function var_0_1.updateSkinId(arg_53_0, arg_53_1, arg_53_2)
	if not arg_53_1 or arg_53_1 == 0 then
		arg_53_1 = arg_53_0:getConfig("skin_id")
	end

	if arg_53_2 == 0 then
		arg_53_0.skinId = arg_53_1
	else
		arg_53_0.phantomDic[arg_53_2] = arg_53_1
	end

	return
end

function var_0_1.getAllShipPhantomMarks(arg_54_0)
	getGameset = var_1_10001

	local var_54_0 = var_1_10001("technology_shadow_num")[1]
	local var_54_1 = {}

	for iter_54_0 = 0, var_54_0 do
		if iter_54_0 == 0 or arg_54_0.phantomDic[iter_54_0] then
			table = var_1_10007
			var_1_10007 = var_1_10007.insert

			local var_54_2 = var_54_1

			ShipPhantom = var_1_10010

			var_1_10007(var_54_2, var_1_10010.PackMark(arg_54_0.id, iter_54_0))
		end
	end

	return var_54_1
end

function var_0_1.getAllShipPhantom(arg_55_0)
	getGameset = var_1_10001

	local var_55_0 = var_1_10001("technology_shadow_num")[1]
	local var_55_1 = {}

	for iter_55_0 = 0, var_55_0 do
		if iter_55_0 == 0 or arg_55_0.phantomDic[iter_55_0] then
			table = var_1_10007
			var_1_10007 = var_1_10007.insert

			local var_55_2 = var_55_1

			ShipPhantom = var_1_10010

			var_1_10007(var_55_2, var_1_10010.Create(arg_55_0, iter_55_0))
		end
	end

	return var_55_1
end

function var_0_1.updateRandomFlag(arg_56_0, arg_56_1, arg_56_2)
	defaultValue = var_1_10003
	arg_56_2 = var_1_10003(arg_56_2, 0)
	arg_56_0.phantomRandomFlag[arg_56_2] = arg_56_1

	return
end

function var_0_1.getRandomFlag(arg_57_0, arg_57_1)
	defaultValue = var_1_10002

	return var_1_10002(arg_57_0.phantomRandomFlag[arg_57_1 or 0], 0) > 0
end

function var_0_1.getRandomFlagShipPhantomMarks(arg_58_0)
	getGameset = var_1_10001

	local var_58_0 = var_1_10001("technology_shadow_num")[1]
	local var_58_1 = {}

	for iter_58_0 = 0, var_58_0 do
		defaultValue = var_1_10007

		if var_1_10007(arg_58_0.phantomRandomFlag[iter_58_0], 0) > 0 then
			table = var_1_10007

			var_1_10007.insert(var_58_1, arg_58_0:GetShipPhantomMark(iter_58_0))
		end
	end

	return var_58_1
end

function var_0_1.updateName(arg_59_0)
	local var_59_0 = arg_59_0.name

	pg = var_1_10002

	if var_59_0 ~= var_1_10002.ship_data_statistics[arg_59_0.configId].name then
		return
	end

	if arg_59_0:isRemoulded() then
		pg = var_1
		arg_59_0.name = var_1.ship_skin_template[arg_59_0:getRemouldSkinId()].name
	else
		pg = var_1
		arg_59_0.name = var_1.ship_data_statistics[arg_59_0.configId].name
	end

	return
end

function var_0_1.isRemoulded(arg_60_0)
	if arg_60_0.remoulded then
		return true
	end

	pg = var_1

	if var_1.ship_data_trans[arg_60_0.groupId] then
		ipairs = var_2

		for iter_60_0, iter_60_1 in var_2(var_1.transform_list) do
			ipairs = var_1_10007

			for iter_60_2, iter_60_3 in var_1_10007(iter_60_1) do
				pg = var_1_10012

				if var_1_10012.transform_data_template[iter_60_3[2]].skin_id ~= 0 and arg_60_0.transforms[iter_60_3[2]] and arg_60_0.transforms[iter_60_3[2]].level == var_1_10012.max_level then
					return true
				end
			end
		end
	end

	return false
end

function var_0_1.getRemouldSkinId(arg_61_0)
	ShipGroup = var_1_10001

	if var_1_10001.getModSkin(arg_61_0.groupId) then
		return var_1.id
	end

	return nil
end

function var_0_1.hasEquipmentSkinInPos(arg_62_0, arg_62_1)
	return arg_62_0.equipments[arg_62_1] and var_2:hasSkin()
end

function var_0_1.getPrefab(arg_63_0, arg_63_1)
	local var_63_0 = arg_63_0
	local var_63_1 = arg_63_0.getSkinId(var_63_0)
	local var_63_2

	if arg_63_0:hasEquipmentSkinInPos(var_0_3) then
		var_63_2 = arg_63_0:getEquip(var_0_3)
		var_63_1 = var_0_8[var_63_2:getSkinId()].ship_skin_id ~= 0 and var_63_0 or var_63_1
	end

	pg = var_63_2

	local var_63_3 = var_63_2.ship_skin_template[var_63_1]

	assert = var_63_0

	var_63_0(var_63_3, "ship_skin_template not exist: " .. arg_63_0.configId .. " " .. var_63_1)

	if var_63_3.double_char and var_63_3.double_char == 1 and arg_63_1 ~= nil then
		local var_63_4

		if arg_63_1 == 1 then
			return var_63_3.prefab .. "_L"
		elseif arg_63_1 == 2 then
			return var_63_3.prefab .. "_R"
		end
	end

	return var_63_3.prefab
end

function var_0_1.IsDoubleSkin(arg_64_0)
	local var_64_0 = arg_64_0
	local var_64_1 = arg_64_0.getSkinId(var_64_0)

	pg = var_1_10002

	local var_64_2 = var_1_10002.ship_skin_template[var_64_1]

	assert = var_64_0

	var_64_0(var_64_2, "ship_skin_template not exist: " .. arg_64_0.configId .. " " .. var_64_1)

	return var_64_2.double_char and var_64_2.double_char == 1 or false
end

function var_0_1.getAttachmentPrefab(arg_65_0)
	local var_65_0 = {}

	ipairs = var_1_10002

	for iter_65_0, iter_65_1 in var_1_10002(arg_65_0.equipments) do
		if iter_65_1 and iter_65_1:hasSkinOrbit() then
			local var_65_1 = iter_65_1:getSkinId()
			local var_65_2 = var_0_8[var_65_1]

			var_65_0[var_65_1] = {
				config = var_65_2,
				index = iter_65_0
			}
		end
	end

	return var_65_0
end

function var_0_1.getPainting(arg_66_0)
	local var_66_0 = arg_66_0
	local var_66_1 = arg_66_0.getSkinId(var_66_0)

	pg = var_1_10002

	local var_66_2 = var_1_10002.ship_skin_template[var_66_1]

	assert = var_66_0

	var_66_0(var_66_2, "ship_skin_template not exist: " .. arg_66_0.configId .. " " .. var_66_1)

	return var_66_2.painting
end

function var_0_1.GetSkinConfig(arg_67_0, arg_67_1)
	local var_67_0 = arg_67_0
	local var_67_1 = arg_67_0.getSkinId(var_67_0)

	pg = var_1_10003

	local var_67_2 = var_1_10003.ship_skin_template[var_67_1]

	assert = var_67_0

	var_67_0(var_67_2, "ship_skin_template not exist: " .. arg_67_0.configId .. " " .. var_67_1)

	return var_67_2
end

function var_0_1.getRemouldPainting(arg_68_0)
	local var_68_0 = arg_68_0
	local var_68_1 = arg_68_0.getRemouldSkinId(var_68_0)

	pg = var_1_10002

	local var_68_2 = var_1_10002.ship_skin_template[var_68_1]

	assert = var_68_0

	var_68_0(var_68_2, "ship_skin_template not exist: " .. arg_68_0.configId .. " " .. var_68_1)

	return var_68_2.painting
end

function var_0_1.isTestShip(arg_69_0)
	return arg_69_0.testShip
end

function var_0_1.canUseTestShip(arg_70_0, arg_70_1)
	assert = var_1_10002

	var_1_10002(arg_70_0.testShip, "ship is not TestShip")

	table = var_1_10002

	return var_1_10002.contains(arg_70_0.testShip, arg_70_1)
end

function var_0_1.updateEquip(arg_71_0, arg_71_1, arg_71_2)
	assert = var_1_10003

	var_1_10003(arg_71_2 == nil or arg_71_2.count == 1)

	local var_71_0 = arg_71_0.equipments[arg_71_1]
	local var_71_1 = arg_71_0.equipments

	if arg_71_2 then
		Clone = var_5

		local var_71_2

		if not var_5(arg_71_2) then
			var_71_2 = false
		end

		var_71_1[arg_71_1] = var_71_2

		local function var_71_3(arg_72_0)
			CreateShell = var_2_10001
			arg_72_0 = var_2_10001(arg_72_0)
			arg_72_0.shipId = arg_71_0.id
			arg_72_0.shipPos = arg_71_1

			return arg_72_0
		end

		if var_71_0 then
			getProxy = var_71_2
			EquipmentProxy = var_1_10007
			var_1_10007 = var_71_2(var_1_10007)

			var_71_2.OnShipEquipsRemove(var_1_10007, var_71_0, arg_71_0.id, arg_71_1)

			var_1_10007 = var_71_0

			var_71_0.setSkinId(var_1_10007, 0)

			pg = var_71_2
			var_1_10007 = var_71_2.m02
			var_71_2 = var_71_2.sendNotification
			BayProxy = var_8

			var_71_2(var_1_10007, var_8.SHIP_EQUIPMENT_REMOVED, var_71_3(var_71_0))
		end

		if arg_71_2 then
			getProxy = var_71_2
			EquipmentProxy = var_1_10007

			local var_71_4 = var_71_2(var_1_10007)

			var_5.OnShipEquipsAdd(var_71_4, arg_71_2, arg_71_0.id, arg_71_1)
			arg_71_0:reletiveEquipSkin(arg_71_1)

			pg = var_5

			local var_71_5 = var_5.m02
			local var_71_6 = var_5.sendNotification

			BayProxy = var_8

			var_71_6(var_71_5, var_8.SHIP_EQUIPMENT_ADDED, var_71_3(arg_71_2))
		end

		return
	end
end

function var_0_1.reletiveEquipSkin(arg_73_0, arg_73_1)
	if arg_73_0.equipments[arg_73_1] and arg_73_0.equipmentSkins[arg_73_1] ~= 0 then
		pg = var_2

		local var_73_0 = var_2.equip_skin_template[arg_73_0.equipmentSkins[arg_73_1]].equip_type
		local var_73_1 = arg_73_0.equipments[arg_73_1]
		local var_73_2 = var_3.getType(var_73_1)

		table = var_1_10004

		if var_1_10004.contains(var_73_0, var_73_2) then
			local var_73_3 = arg_73_0.equipments[arg_73_1]

			var_4.setSkinId(var_73_3, arg_73_0.equipmentSkins[arg_73_1])
		else
			local var_73_4 = arg_73_0.equipments[arg_73_1]

			var_4.setSkinId(var_73_4, 0)
		end
	elseif arg_73_0.equipments[arg_73_1] then
		local var_73_5 = arg_73_0.equipments[arg_73_1]

		var_2.setSkinId(var_73_5, 0)
	end

	return
end

function var_0_1.updateEquipmentSkin(arg_74_0, arg_74_1, arg_74_2)
	if not arg_74_1 then
		return
	end

	if arg_74_2 and arg_74_2 > 0 then
		local var_74_0 = arg_74_0:getSkinTypes(arg_74_1)

		pg = var_1_10004

		local var_74_1 = var_1_10004.equip_skin_template[arg_74_2].equip_type
		local var_74_2 = false

		ipairs = var_6

		for iter_74_0, iter_74_1 in var_6(var_74_0) do
			ipairs = var_1_10011

			for iter_74_2, iter_74_3 in var_1_10011(var_74_1) do
				if iter_74_1 == iter_74_3 then
					var_74_2 = true

					break
				end
			end
		end

		if not var_74_2 then
			assert = var_6

			var_6(var_74_2, "部位" .. arg_74_1 .. " 无法穿戴皮肤 " .. arg_74_2)

			return
		end

		if arg_74_0.equipments[arg_74_1] then
			local var_74_3 = arg_74_0.equipments[arg_74_1]
			local var_74_4

			if not var_6.getType(var_74_3) then
				var_74_4 = false
			end

			local var_74_5 = arg_74_0.equipmentSkins

			var_74_5[arg_74_1] = arg_74_2

			if var_74_4 then
				table = var_74_5

				if var_74_5.contains(var_74_1, var_74_4) then
					local var_74_6 = arg_74_0.equipments[arg_74_1]

					var_74_5.setSkinId(var_74_6, arg_74_0.equipmentSkins[arg_74_1])

					goto label_74_0
				end
			end

			if var_74_4 then
				table = var_74_5

				if not var_74_5.contains(var_74_1, var_74_4) then
					local var_74_7 = arg_74_0.equipments[arg_74_1]

					var_7.setSkinId(var_74_7, 0)
				end
			end

			if false then
				arg_74_0.equipmentSkins[arg_74_1] = 0

				if arg_74_0.equipments[arg_74_1] then
					local var_74_8 = arg_74_0.equipments[arg_74_1]

					var_3.setSkinId(var_74_8, 0)
				end
			end

			::label_74_0::

			return
		end
	end
end

function var_0_1.getEquip(arg_75_0, arg_75_1)
	Clone = var_1_10002

	return var_1_10002(arg_75_0.equipments[arg_75_1])
end

function var_0_1.getEquipSkins(arg_76_0)
	Clone = var_1_10001

	return var_1_10001(arg_76_0.equipmentSkins)
end

function var_0_1.getEquipSkin(arg_77_0, arg_77_1)
	return arg_77_0.equipmentSkins[arg_77_1]
end

function var_0_1.getCanEquipSkin(arg_78_0, arg_78_1)
	if arg_78_0:getSkinTypes(arg_78_1) and #var_2 then
		ipairs = var_3

		for iter_78_0, iter_78_1 in var_3(var_2) do
			pg = var_1_10008

			if var_1_10008.equip_data_by_type[iter_78_1].equip_skin == 1 then
				return true
			end
		end
	end

	return false
end

function var_0_1.checkCanEquipSkin(arg_79_0, arg_79_1, arg_79_2)
	if not arg_79_1 or not arg_79_2 then
		return
	end

	local var_79_0 = arg_79_0
	local var_79_1 = arg_79_0.getSkinTypes(var_79_0, arg_79_1)

	pg = var_1_10004

	local var_79_2 = var_1_10004.equip_skin_template[arg_79_2].equip_type

	ipairs = var_79_0

	for iter_79_0, iter_79_1 in var_79_0(var_79_1) do
		table = var_1_10010

		if var_1_10010.contains(var_79_2, iter_79_1) then
			return true
		end
	end

	return false
end

function var_0_1.getSkinTypes(arg_80_0, arg_80_1)
	pg = var_1_10002

	return var_1_10002.ship_data_template[arg_80_0.configId]["equip_" .. arg_80_1] or {}
end

function var_0_1.addSkillExp(arg_81_0, arg_81_1, arg_81_2)
	local var_81_0

	if not arg_81_0.skills[arg_81_1] then
		var_81_0 = {
			exp = 0,
			level = 1,
			id = arg_81_1
		}
	end

	local var_81_1

	if not var_81_0.level or not var_81_0.level then
		var_81_1 = 1
	end

	pg = var_1_10005

	local var_81_2 = var_1_10005.skill_need_exp.all

	pg = var_1_10006

	if var_81_1 == var_81_2[#var_1_10006.skill_need_exp.all] then
		return
	end

	local var_81_3

	if not var_81_0.exp or not (arg_81_2 + var_81_0.exp) then
		var_81_3 = 0 + arg_81_2
	end

	::label_81_0::

	pg = var_1_10007

	if var_1_10007.skill_need_exp[var_81_1].exp <= var_81_3 then
		repeat
			pg = var_1_10007
			var_81_3 = var_81_3 - var_1_10007.skill_need_exp[var_81_1].exp

			if var_81_1 + 1 == var_5 then
				var_81_3 = 0

				break
			end

			goto label_81_0
		until true
	end

	arg_81_0:updateSkill({
		id = var_81_0.id,
		level = var_81_1,
		exp = var_81_3
	})

	return
end

function var_0_1.upSkillLevelForMeta(arg_82_0, arg_82_1)
	local var_82_0

	if not arg_82_0.skills[arg_82_1] then
		var_82_0 = {
			exp = 0,
			level = 0,
			id = arg_82_1
		}
	end

	local var_82_1 = arg_82_0:isSkillLevelMax(arg_82_1)
	local var_82_2 = var_82_0.level

	if not var_82_1 then
		var_82_2 = var_82_2 + 1
	end

	arg_82_0:updateSkill({
		exp = 0,
		id = var_82_0.id,
		level = var_82_2
	})

	return
end

function var_0_1.getMetaSkillLevelBySkillID(arg_83_0, arg_83_1)
	local var_83_0

	if not arg_83_0.skills[arg_83_1] then
		var_83_0 = {
			exp = 0,
			level = 0,
			id = arg_83_1
		}
	end

	return var_83_0.level
end

function var_0_1.isSkillLevelMax(arg_84_0, arg_84_1)
	local var_84_0

	if not arg_84_0.skills[arg_84_1] then
		var_84_0 = {
			exp = 0,
			level = 1,
			id = arg_84_1
		}
	end

	local var_84_1

	if not var_84_0.level or not var_84_0.level then
		var_84_1 = 1
	end

	pg = var_1_10004

	return var_84_1 >= var_1_10004.skill_data_template[arg_84_1].max_level
end

function var_0_1.isAllMetaSkillLevelMax(arg_85_0)
	local var_85_0 = true

	MetaCharacterConst = var_1_10002

	local var_85_1 = var_1_10002.getTacticsSkillIDListByShipConfigID(arg_85_0.configId)

	ipairs = var_1_10003

	for iter_85_0, iter_85_1 in var_1_10003(var_85_1) do
		if not arg_85_0:isSkillLevelMax(iter_85_1) then
			var_85_0 = false

			break
		end
	end

	return var_85_0
end

function var_0_1.isAllMetaSkillLock(arg_86_0)
	MetaCharacterConst = var_1_10001

	local var_86_0 = var_1_10001.getTacticsSkillIDListByShipConfigID(arg_86_0.configId)
	local var_86_1 = true

	ipairs = var_3

	for iter_86_0, iter_86_1 in var_3(var_86_0) do
		if arg_86_0:getMetaSkillLevelBySkillID(iter_86_1) > 0 then
			var_86_1 = false

			break
		end
	end

	return var_86_1
end

function var_0_1.bindConfigTable(arg_87_0)
	pg = var_1_10001

	return var_1_10001.ship_data_statistics
end

function var_0_1.isAvaiable(arg_88_0)
	return true
end

local var_0_20 = {}

AttributeType = var_0_10010
var_0_20[1] = var_0_10010.Durability
AttributeType = var_10
var_0_20[2] = var_10.Cannon
AttributeType = var_10
var_0_20[3] = var_10.Torpedo
AttributeType = var_10
var_0_20[4] = var_10.AntiAircraft
AttributeType = var_10
var_0_20[5] = var_10.Air
AttributeType = var_10
var_0_20[6] = var_10.Reload
AttributeType = var_10
var_0_20[7] = var_10.Armor
AttributeType = var_10
var_0_20[8] = var_10.Hit
AttributeType = var_10
var_0_20[9] = var_10.Dodge
AttributeType = var_10
var_0_20[10] = var_10.Speed
AttributeType = var_10
var_0_20[11] = var_10.Luck
AttributeType = var_10
var_0_20[12] = var_10.AntiSub
var_0_1.PROPERTIES = var_0_20

local var_0_21 = {}

AttributeType = var_10
var_0_21[1] = var_10.Durability
AttributeType = var_10
var_0_21[2] = var_10.Cannon
AttributeType = var_10
var_0_21[3] = var_10.Torpedo
AttributeType = var_10
var_0_21[4] = var_10.AntiAircraft
AttributeType = var_10
var_0_21[5] = var_10.Air
AttributeType = var_10
var_0_21[6] = var_10.Reload
AttributeType = var_10
var_0_21[7] = var_10.Hit
AttributeType = var_10
var_0_21[8] = var_10.Dodge
AttributeType = var_10
var_0_21[9] = var_10.Speed
AttributeType = var_10
var_0_21[10] = var_10.Luck
AttributeType = var_10
var_0_21[11] = var_10.AntiSub
var_0_1.PROPERTIES_ENHANCEMENT = var_0_21

local var_0_22 = {}

AttributeType = var_10
var_0_22[1] = var_10.OxyMax
AttributeType = var_10
var_0_22[2] = var_10.OxyCost
AttributeType = var_10
var_0_22[3] = var_10.OxyRecovery
AttributeType = var_10
var_0_22[4] = var_10.OxyRecoveryBench
AttributeType = var_10
var_0_22[5] = var_10.OxyRecoverySurface
AttributeType = var_10
var_0_22[6] = var_10.OxyAttackDuration
AttributeType = var_10
var_0_22[7] = var_10.OxyRaidDistance
var_0_1.DIVE_PROPERTIES = var_0_22

local var_0_23 = {}

AttributeType = var_10
var_0_23[1] = var_10.SonarRange
var_0_1.SONAR_PROPERTIES = var_0_23

function var_0_1.intimacyAdditions(arg_89_0, arg_89_1)
	pg = var_1_10002

	local var_89_0 = var_1_10002.intimacy_template[arg_89_0:getIntimacyLevel()].attr_bonus * 0.0001

	pairs = var_3

	for iter_89_0, iter_89_1 in var_3(arg_89_1) do
		AttributeType = var_1_10008

		if iter_89_0 ~= var_1_10008.Durability then
			AttributeType = var_1_10008

			if iter_89_0 ~= var_1_10008.Cannon then
				AttributeType = var_1_10008

				if iter_89_0 ~= var_1_10008.Torpedo then
					AttributeType = var_1_10008

					if iter_89_0 ~= var_1_10008.AntiAircraft then
						AttributeType = var_1_10008

						if iter_89_0 ~= var_1_10008.AntiSub then
							AttributeType = var_1_10008

							if iter_89_0 ~= var_1_10008.Air then
								AttributeType = var_1_10008

								if iter_89_0 ~= var_1_10008.Reload then
									AttributeType = var_1_10008

									if iter_89_0 ~= var_1_10008.Hit then
										AttributeType = var_1_10008

										if iter_89_0 == var_1_10008.Dodge then
											arg_89_1[iter_89_0] = arg_89_1[iter_89_0] * (var_89_0 + 1)
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return
end

function var_0_1.getShipProperties(arg_90_0)
	local var_90_0 = arg_90_0
	local var_90_1 = arg_90_0.getBaseProperties(var_90_0)

	if arg_90_0:isBluePrintShip() then
		local var_90_2 = arg_90_0
		local var_90_3 = arg_90_0.getBluePrint(var_90_2)

		assert = var_90_0

		var_90_0(var_90_3, "blueprint can not be nil" .. arg_90_0.configId)

		local var_90_4 = var_90_3:getTotalAdditions()

		pairs = var_90_2

		for iter_90_0, iter_90_1 in var_90_2(var_90_4) do
			var_1_10009 = var_90_1[iter_90_0]
			calcFloor = var_1_10010
			var_90_1[iter_90_0] = var_1_10009 + var_1_10010(iter_90_1)
		end

		arg_90_0:intimacyAdditions(var_90_1)
	else
		local var_90_5 = arg_90_0

		if arg_90_0.isMetaShip(var_90_5) then
			assert = var_2

			var_2(arg_90_0.metaCharacter)

			pairs = var_2

			for iter_90_2, iter_90_3 in var_2(var_90_1) do
				local var_90_6 = var_90_1[iter_90_2]

				var_1_10010 = arg_90_0.metaCharacter
				var_90_1[iter_90_2] = var_90_6 + var_8.getAttrAddition(var_1_10010, iter_90_2)
			end

			var_90_5 = arg_90_0

			arg_90_0.intimacyAdditions(var_90_5, var_90_1)
		else
			pg = var_2

			local var_90_7 = var_2.ship_data_template[arg_90_0.configId].strengthen_id
			local var_90_8 = var_0_6[var_90_7]

			pairs = var_90_5

			for iter_90_4, iter_90_5 in var_90_5(arg_90_0.strengthList) do
				ShipModAttr = var_1_10009
				var_1_10009 = var_1_10009.ATTR_TO_INDEX[iter_90_4]
				math = var_1_10010
				var_1_10010 = var_1_10010.min(iter_90_5, var_90_8.durability[var_1_10009] * var_90_8.level_exp[var_1_10009])
				math = var_1_10011
				var_1_10011 = var_1_10011.max
				var_1_10015 = arg_90_0
				var_1_10011 = var_1_10011(arg_90_0.getModExpRatio(var_1_10015, iter_90_4), 1)

				local var_90_9 = var_90_1[iter_90_4]

				calcFloor = var_13
				var_90_1[iter_90_4] = var_90_9 + var_13(var_1_10010 / var_1_10011)
			end

			arg_90_0:intimacyAdditions(var_90_1)

			pairs = var_4

			for iter_90_6, iter_90_7 in var_4(arg_90_0.transforms) do
				pg = var_1_10009
				var_1_10009 = var_1_10009.transform_data_template[iter_90_7.id].effect

				for iter_90_8 = 1, iter_90_7.level do
					local var_90_10

					if not var_1_10009[iter_90_8] then
						var_90_10 = {}
					end

					pairs = var_1_10015

					for iter_90_9, iter_90_10 in var_1_10015(var_90_1) do
						if var_90_10[iter_90_9] then
							var_90_1[iter_90_9] = var_90_1[iter_90_9] + var_90_10[iter_90_9]
						end
					end
				end
			end
		end
	end

	return var_90_1
end

function var_0_1.getTechNationAddition(arg_91_0, arg_91_1)
	getProxy = var_1_10002
	TechnologyNationProxy = var_1_10004

	local var_91_0 = var_1_10002(var_1_10004)
	local var_91_1 = arg_91_0:getConfig("type")

	ShipType = var_1_10004

	if var_91_1 ~= var_1_10004.DaoQuV then
		ShipType = var_4

		if var_91_1 == var_4.DaoQuM then
			ShipType = var_4
			var_91_1 = var_4.QuZhu
		end

		return var_91_0:getShipAddition(var_91_1, arg_91_1)
	end
end

function var_0_1.getTechNationMaxAddition(arg_92_0, arg_92_1)
	getProxy = var_1_10002
	TechnologyNationProxy = var_1_10004

	local var_92_0 = var_1_10002(var_1_10004)
	local var_92_1 = arg_92_0:getConfig("type")

	return var_92_0:getShipMaxAddition(var_92_1, arg_92_1)
end

function var_0_1.getEquipProficiencyByPos(arg_93_0, arg_93_1)
	return arg_93_0:getEquipProficiencyList()[arg_93_1]
end

function var_0_1.getEquipProficiencyList(arg_94_0)
	local var_94_0 = arg_94_0:getConfigTable()

	Clone = var_1_10002

	local var_94_1 = var_1_10002(var_94_0.equipment_proficiency)
	local var_94_2

	if arg_94_0:isBluePrintShip() then
		var_94_2 = arg_94_0:getBluePrint()
		assert = var_4

		var_4(var_94_2, "blueprint can not be nil >>>" .. arg_94_0.groupId)

		var_94_1 = var_94_2:getEquipProficiencyList(arg_94_0)
	else
		ipairs = var_94_2

		for iter_94_0, iter_94_1 in var_94_2(var_94_1) do
			local var_94_3 = 0

			pairs = var_1_10009

			for iter_94_2, iter_94_3 in var_1_10009(arg_94_0.transforms) do
				pg = var_1_10014
				var_1_10014 = var_1_10014.transform_data_template[iter_94_3.id].effect

				for iter_94_4 = 1, iter_94_3.level do
					local var_94_4

					if not var_1_10014[iter_94_4] then
						var_94_4 = {}
					end

					if var_94_4["equipment_proficiency_" .. iter_94_0] then
						var_94_3 = var_94_3 + var_94_4["equipment_proficiency_" .. iter_94_0]
					end
				end
			end

			var_94_1[iter_94_0] = iter_94_1 + var_94_3
		end
	end

	return var_94_1
end

function var_0_1.getBaseProperties(arg_95_0)
	local var_95_0 = arg_95_0:getConfigTable()

	assert = var_1_10002

	var_1_10002(var_95_0, "配置表没有这艘船" .. arg_95_0.configId)

	local var_95_1 = {}
	local var_95_2 = {}

	ipairs = var_4

	for iter_95_0, iter_95_1 in var_4(var_0_1.PROPERTIES) do
		var_95_1[iter_95_1] = arg_95_0:getGrowthForAttr(iter_95_1)
		var_95_2[iter_95_1] = var_95_1[iter_95_1]
	end

	ipairs = var_4

	for iter_95_2, iter_95_3 in var_4(arg_95_0:getConfig("lock")) do
		var_95_2[iter_95_3] = var_95_1[iter_95_3]
	end

	ipairs = var_4

	for iter_95_4, iter_95_5 in var_4(var_0_1.DIVE_PROPERTIES) do
		var_95_2[iter_95_5] = var_95_0[iter_95_5]
	end

	ipairs = var_4

	for iter_95_6, iter_95_7 in var_4(var_0_1.SONAR_PROPERTIES) do
		var_95_2[iter_95_7] = 0
	end

	return var_95_2
end

function var_0_1.getGrowthForAttr(arg_96_0, arg_96_1)
	local var_96_0 = arg_96_0
	local var_96_1 = arg_96_0.getConfigTable(var_96_0)

	table = var_1_10003

	local var_96_2 = var_1_10003.indexof(var_0_1.PROPERTIES, arg_96_1)

	pg = var_96_0

	local var_96_3 = var_96_0.gameset.extra_attr_level_limit.key_value
	local var_96_4 = var_96_1.attrs[var_96_2] + (arg_96_0.level - 1) * var_96_1.attrs_growth[var_96_2] / 1000

	if var_96_3 < arg_96_0.level then
		var_96_4 = var_96_4 + (arg_96_0.level - var_96_3) * var_96_1.attrs_growth_extra[var_96_2] / 1000
	end

	return var_96_4
end

function var_0_1.isMaxStar(arg_97_0)
	return arg_97_0:getStar() >= arg_97_0:getMaxStar()
end

function var_0_1.IsMaxStarByTmpID(arg_98_0)
	pg = var_1_10001

	return var_1_10001.ship_data_template[arg_98_0].star >= var_1.star_max
end

function var_0_1.IsSpweaponUnlock(arg_99_0)
	if not arg_99_0:CanAccumulateExp() then
		return false, "spweapon_tip_locked"
	else
		return true
	end

	return
end

function var_0_1.getModProperties(arg_100_0, arg_100_1)
	local var_100_0

	if not arg_100_0.strengthList[arg_100_1] then
		var_100_0 = 0
	end

	return var_100_0
end

function var_0_1.addModAttrExp(arg_101_0, arg_101_1, arg_101_2)
	if arg_101_0:getModAttrTopLimit(arg_101_1) == 0 then
		return
	end

	local var_101_0 = arg_101_0:getModExpRatio(arg_101_1)

	if arg_101_0:getModProperties(arg_101_1) + arg_101_2 > var_3 * var_101_0 then
		arg_101_0.strengthList[arg_101_1] = var_3 * var_101_0
	else
		arg_101_0.strengthList[arg_101_1] = var_5 + arg_101_2
	end

	return
end

function var_0_1.getNeedModExp(arg_102_0)
	local var_102_0 = {}

	pairs = var_1_10002
	ShipModAttr = var_1_10004

	for iter_102_0, iter_102_1 in var_1_10002(var_1_10004.ID_TO_ATTR) do
		if arg_102_0:getModAttrTopLimit(iter_102_1) == 0 then
			var_102_0[iter_102_1] = 0
		else
			var_102_0[iter_102_1] = var_7 * arg_102_0:getModExpRatio(iter_102_1) - arg_102_0:getModProperties(iter_102_1)
		end
	end

	return var_102_0
end

function var_0_1.attrVertify(arg_103_0)
	BayProxy = var_1_10001

	if not var_1_10001.checkShiplevelVertify(arg_103_0) then
		return false
	end

	ipairs = var_1

	for iter_103_0, iter_103_1 in var_1(arg_103_0.equipments) do
		if iter_103_1 and not iter_103_1:vertify() then
			return false
		end
	end

	return true
end

function var_0_1.getEquipmentProperties(arg_104_0)
	local var_104_0 = {}
	local var_104_1 = {}

	ipairs = var_1_10003

	for iter_104_0, iter_104_1 in var_1_10003(var_0_1.PROPERTIES) do
		var_104_0[iter_104_1] = 0
	end

	ipairs = var_3

	for iter_104_2, iter_104_3 in var_3(var_0_1.DIVE_PROPERTIES) do
		var_104_0[iter_104_3] = 0
	end

	ipairs = var_3

	for iter_104_4, iter_104_5 in var_3(var_0_1.SONAR_PROPERTIES) do
		var_104_0[iter_104_5] = 0
	end

	ipairs = var_3

	for iter_104_6, iter_104_7 in var_3(var_0_1.PROPERTIES_ENHANCEMENT) do
		var_104_1[iter_104_7] = 0
	end

	AttributeType = var_3
	var_104_0[var_3.AirDominate] = 0
	AttributeType = var_3
	var_104_0[var_3.AntiSiren] = 0

	local var_104_2 = arg_104_0:getActiveEquipments()

	ipairs = var_4

	for iter_104_8, iter_104_9 in var_4(var_104_2) do
		if iter_104_9 then
			local var_104_3 = iter_104_9:GetAttributes()

			ipairs = var_1_10010

			for iter_104_10, iter_104_11 in var_1_10010(var_104_3) do
				if iter_104_11 and var_104_0[iter_104_11.type] then
					var_104_0[iter_104_11.type] = var_104_0[iter_104_11.type] + iter_104_11.value
				end
			end

			var_1_10010 = iter_104_9:GetPropertyRate()
			pairs = var_11

			for iter_104_12, iter_104_13 in var_11(var_1_10010) do
				math = iter_104_15
				var_104_1[iter_104_12] = iter_104_15.max(var_104_1[iter_104_12], iter_104_13)
			end

			local var_104_4 = iter_104_9

			if iter_104_9.GetSonarProperty(var_104_4) then
				pairs = var_12

				for iter_104_14, iter_104_15 in var_12(var_11) do
					var_104_0[iter_104_14] = var_104_0[iter_104_14] + iter_104_15
				end
			end

			local var_104_5 = iter_104_9

			if iter_104_9.GetAntiSirenPower(var_104_5) then
				AttributeType = var_104_4

				local var_104_6 = var_104_4.AntiSiren

				AttributeType = var_104_5
				var_104_0[var_104_6] = var_104_0[var_104_5.AntiSiren] + var_12 / 16
			end
		end
	end

	;(function()
		local var_105_0 = arg_104_0

		if not var_0.GetSpWeapon(var_105_0) then
			return
		end

		local var_105_1 = var_0:GetPropertiesInfo().attrs

		ipairs = var_105_0

		for iter_105_0, iter_105_1 in var_105_0(var_105_1) do
			if iter_105_1 and var_104_0[iter_105_1.type] then
				var_104_0[iter_105_1.type] = var_104_0[iter_105_1.type] + iter_105_1.value
			end
		end

		return
	end)()

	pairs = var_5

	for iter_104_16, iter_104_17 in var_5(var_104_1) do
		var_104_1[iter_104_16] = iter_104_17 + 1
	end

	return var_104_0, var_104_1
end

function var_0_1.getSkillEffects(arg_106_0)
	local var_106_0 = arg_106_0:getShipSkillEffects()

	_ = var_1_10002

	var_1_10002.each(arg_106_0:getEquipmentSkillEffects(), function(arg_107_0)
		table = var_2_10001

		var_2_10001.insert(var_106_0, arg_107_0)

		return
	end)

	return var_106_0
end

function var_0_1.getShipSkillEffects(arg_108_0)
	local var_108_0 = {}
	local var_108_1 = arg_108_0:getSkillList()

	ipairs = var_1_10003

	for iter_108_0, iter_108_1 in var_1_10003(var_108_1) do
		local var_108_2 = arg_108_0:RemapSkillId(iter_108_1, true)

		pg = var_1_10009
		var_1_10009 = var_1_10009.buffCfg["buff_" .. var_108_2]

		arg_108_0:FilterActiveSkill(var_108_0, var_1_10009, arg_108_0.skills[iter_108_1])
	end

	return var_108_0
end

function var_0_1.getEquipmentSkillEffects(arg_109_0)
	local var_109_0 = {}
	local var_109_1 = arg_109_0:getActiveEquipments()

	ipairs = var_1_10003

	for iter_109_0, iter_109_1 in var_1_10003(var_109_1) do
		local var_109_2
		local var_109_3

		if iter_109_1 and iter_109_1:getConfig("skill_id")[1] then
			var_109_3 = iter_109_1:getConfig("skill_id")[1][1]
		end

		if var_109_3 then
			pg = var_1_10010
			var_109_2 = var_1_10010.buffCfg["buff_" .. var_109_3]
		end

		arg_109_0:FilterActiveSkill(var_109_0, var_109_2)
	end

	;(function()
		local var_110_0 = arg_109_0
		local var_110_1

		if not var_0.GetSpWeapon(var_110_0) or not var_0:GetEffect() then
			var_110_1 = 0
		end

		local var_110_2

		if 0 < var_110_1 then
			pg = var_3
			var_110_2 = var_3.buffCfg["buff_" .. var_110_1]
		end

		local var_110_3 = arg_109_0

		var_3.FilterActiveSkill(var_110_3, var_109_0, var_110_2)

		return
	end)()

	return var_109_0
end

function var_0_1.FilterActiveSkill(arg_111_0, arg_111_1, arg_111_2, arg_111_3)
	if not arg_111_2 or not arg_111_2.const_effect_list then
		return
	end

	for iter_111_0 = 1, #arg_111_2.const_effect_list do
		local var_111_0 = arg_111_2.const_effect_list[iter_111_0].trigger
		local var_111_1 = var_8.arg_list
		local var_111_2 = 1

		if arg_111_3 and arg_111_2[arg_111_3.level].const_effect_list and var_12[iter_111_0] then
			var_111_0 = var_12[iter_111_0].trigger or var_111_0
			var_111_1 = var_12[iter_111_0].arg_list or var_111_1
		end

		local var_111_3 = true

		pairs = var_1_10013

		for iter_111_1, iter_111_2 in var_1_10013(var_111_0) do
			if arg_111_0.triggers[iter_111_1] ~= iter_111_2 then
				var_111_3 = false

				break
			end
		end

		if var_111_3 then
			table = var_1_10013

			var_1_10013.insert(arg_111_1, {
				type = var_8.type,
				arg_list = var_111_1,
				level = var_111_2
			})
		end
	end

	return
end

function var_0_1.getEquipmentGearScore(arg_112_0)
	local var_112_0 = 0
	local var_112_1 = arg_112_0:getActiveEquipments()

	ipairs = var_1_10003

	for iter_112_0, iter_112_1 in var_1_10003(var_112_1) do
		if iter_112_1 then
			var_112_0 = var_112_0 + iter_112_1:GetGearScore()
		end
	end

	return var_112_0
end

function var_0_1.getProperties(arg_113_0, arg_113_1, arg_113_2, arg_113_3, arg_113_4)
	local var_113_0 = arg_113_1 or {}
	local var_113_1 = arg_113_0:getConfig("nationality")
	local var_113_2 = arg_113_0:getConfig("type")
	local var_113_3 = arg_113_0:getShipProperties()
	local var_113_4, var_113_5 = arg_113_0:getEquipmentProperties()
	local var_113_6
	local var_113_7
	local var_113_8

	if arg_113_3 and arg_113_0:getFlag("inWorld") then
		WorldConst = var_1_10014

		local var_113_9 = var_1_10014.FetchWorldShip(arg_113_0.id)

		var_113_6, var_113_7 = var_1_10014.GetShipBuffProperties(var_113_9)
		var_113_8 = var_1_10014:GetShipPowerBuffProperties()
	end

	ipairs = var_1_10014

	for iter_113_0, iter_113_1 in var_1_10014(var_0_1.PROPERTIES) do
		local var_113_10 = 0
		local var_113_11 = 0

		pairs = var_1_10021

		for iter_113_2, iter_113_3 in var_1_10021(var_113_0) do
			var_113_10 = var_113_10 + iter_113_3:getAttrRatioAddition(iter_113_1, var_113_1, var_113_2) / 100
			var_113_11 = var_113_11 + iter_113_3:getAttrValueAddition(iter_113_1, var_113_1, var_113_2)
		end

		if not var_113_5[iter_113_1] then
			var_1_10021 = 1
		end

		var_1_10021 = var_113_10 + var_1_10021

		local var_113_12

		if not var_113_7 or not var_113_7[iter_113_1] then
			var_113_12 = 1
		end

		local var_113_13

		if not var_113_6 or not var_113_6[iter_113_1] then
			var_113_13 = 0
		end

		AttributeType = iter_113_2

		if iter_113_1 == iter_113_2.Speed then
			var_113_3[iter_113_1] = var_113_3[iter_113_1] * var_1_10021 * var_113_12 + var_113_11 + var_113_4[iter_113_1] + var_113_13
		else
			calcFloor = var_24
			calcFloor = var_1_10026
			var_113_3[iter_113_1] = var_24(var_1_10026(var_113_3[iter_113_1]) * var_1_10021 * var_113_12) + var_113_11 + var_113_4[iter_113_1] + var_113_13
		end
	end

	if not arg_113_2 and arg_113_0:isMaxStar() then
		pairs = var_14

		for iter_113_4, iter_113_5 in var_14(var_113_3) do
			local var_113_14

			if not arg_113_4 or not arg_113_0:getTechNationMaxAddition(iter_113_4) then
				var_113_14 = arg_113_0:getTechNationAddition(iter_113_4)
			end

			var_113_3[iter_113_4] = var_113_3[iter_113_4] + var_113_14
		end
	end

	ipairs = var_14

	for iter_113_6, iter_113_7 in var_14(var_0_1.DIVE_PROPERTIES) do
		var_113_3[iter_113_7] = var_113_3[iter_113_7] + var_113_4[iter_113_7]
	end

	ipairs = var_14

	for iter_113_8, iter_113_9 in var_14(var_0_1.SONAR_PROPERTIES) do
		var_113_3[iter_113_9] = var_113_3[iter_113_9] + var_113_4[iter_113_9]
	end

	local var_113_15

	if arg_113_3 then
		AttributeType = var_113_15
		var_113_15 = var_113_15.AntiSiren
		AttributeType = var_15

		local var_113_16

		if not var_113_3[var_15.AntiSiren] then
			var_113_16 = 0
		end

		AttributeType = var_16
		var_113_3[var_113_15] = var_113_16 + var_113_4[var_16.AntiSiren]
	end

	if var_113_8 then
		pairs = var_113_15

		for iter_113_10, iter_113_11 in var_113_15(var_113_8) do
			if var_113_3[iter_113_10] then
				AttributeType = var_19

				if iter_113_10 == var_19.Speed then
					var_113_3[iter_113_10] = var_113_3[iter_113_10] * iter_113_11
				else
					math = var_19
					var_113_3[iter_113_10] = var_19.floor(var_113_3[iter_113_10] * iter_113_11)
				end
			end
		end
	end

	return var_113_3
end

function var_0_1.getTransGearScore(arg_114_0)
	local var_114_0 = 0

	pg = var_1_10002

	local var_114_1 = var_1_10002.transform_data_template

	pairs = var_1_10003

	for iter_114_0, iter_114_1 in var_1_10003(arg_114_0.transforms) do
		for iter_114_2 = 1, iter_114_1.level do
			local var_114_2

			if not var_114_1[iter_114_1.id].gear_score[iter_114_2] then
				var_114_2 = 0
			end

			var_114_0 = var_114_0 + var_114_2
		end
	end

	return var_114_0
end

function var_0_1.getShipCombatPower(arg_115_0, arg_115_1)
	local var_115_0 = arg_115_0
	local var_115_1 = arg_115_0.getProperties(var_115_0, arg_115_1, nil, nil, true)

	AttributeType = var_1_10003

	local var_115_2 = var_115_1[var_1_10003.Durability] / 5

	AttributeType = var_115_0

	local var_115_3 = var_115_2 + var_115_1[var_115_0.Cannon]

	AttributeType = var_4

	local var_115_4 = var_115_3 + var_115_1[var_4.Torpedo]

	AttributeType = var_4

	local var_115_5 = var_115_4 + var_115_1[var_4.AntiAircraft]

	AttributeType = var_4

	local var_115_6 = var_115_5 + var_115_1[var_4.Air]

	AttributeType = var_4

	local var_115_7 = var_115_6 + var_115_1[var_4.AntiSub]

	AttributeType = var_4

	local var_115_8 = var_115_7 + var_115_1[var_4.Reload]

	AttributeType = var_4

	local var_115_9 = var_115_8 + var_115_1[var_4.Hit] * 2

	AttributeType = var_4

	local var_115_10 = var_115_9 + var_115_1[var_4.Dodge] * 2

	AttributeType = var_4

	local var_115_11 = var_115_10 + var_115_1[var_4.Speed] + arg_115_0:getEquipmentGearScore() + arg_115_0:getTransGearScore()

	math = var_4

	return var_4.floor(var_115_11)
end

function var_0_1.cosumeEnergy(arg_116_0, arg_116_1)
	local var_116_0 = arg_116_0
	local var_116_1 = arg_116_0.setEnergy

	math = var_1_10005

	var_116_1(var_116_0, var_1_10005.max(arg_116_0:getEnergy() - arg_116_1, 0))

	return
end

function var_0_1.addEnergy(arg_117_0, arg_117_1)
	arg_117_0:setEnergy(arg_117_0:getEnergy() + arg_117_1)

	return
end

function var_0_1.setEnergy(arg_118_0, arg_118_1)
	arg_118_0.energy = arg_118_1

	return
end

function var_0_1.setLikability(arg_119_0, arg_119_1)
	assert = var_1_10002

	var_1_10002(arg_119_1 >= 0 and arg_119_1 <= arg_119_0.maxIntimacy, "intimacy value invaild" .. arg_119_1)
	arg_119_0:setIntimacy(arg_119_1)

	return
end

function var_0_1.addLikability(arg_120_0, arg_120_1)
	Mathf = var_1_10002

	local var_120_0 = var_1_10002.Clamp(arg_120_0:getIntimacy() + arg_120_1, 0, arg_120_0.maxIntimacy)

	arg_120_0:setIntimacy(var_120_0)

	return
end

function var_0_1.setIntimacy(arg_121_0, arg_121_1)
	if arg_121_1 > 10000 and not arg_121_0.propose then
		arg_121_1 = 10000
	end

	arg_121_0.intimacy = arg_121_1

	local var_121_0 = arg_121_0

	if not arg_121_0.isActivityNpc(var_121_0) then
		getProxy = var_2
		CollectionProxy = var_121_0

		local var_121_1 = var_2(var_121_0).shipGroups[arg_121_0.groupId]

		var_3.updateMaxIntimacy(var_121_1, arg_121_0:getIntimacy())
	end

	return
end

function var_0_1.getLevelExpConfig(arg_122_0, arg_122_1)
	local var_122_0 = arg_122_0
	local var_122_1 = arg_122_0.getConfig(var_122_0, "rarity")

	ShipRarity = var_1_10003

	if var_122_1 == var_1_10003.SSR then
		Clone = var_122_1
		getConfigFromLevel1 = var_122_0
		var_122_1.exp = var_122_1(var_122_0(var_0_7, arg_122_1 or arg_122_0.level)).exp_ur
		var_122_1.exp_start = var_122_1.exp_ur_start
		var_122_1.exp_interval = var_122_1.exp_ur_interval
		var_122_1.exp_end = var_122_1.exp_ur_end

		return var_122_1
	else
		getConfigFromLevel1 = var_122_1

		return var_122_1(var_0_7, arg_122_1 or arg_122_0.level)
	end

	return
end

function var_0_1.getExp(arg_123_0)
	local var_123_0 = arg_123_0:getMaxLevel()

	if arg_123_0.level == var_123_0 then
		LOCK_FULL_EXP = var_2

		if var_2 then
			return 0
		end
	end

	return arg_123_0.exp
end

function var_0_1.getProficiency(arg_124_0)
	return arg_124_0.proficiency
end

function var_0_1.addExp(arg_125_0, arg_125_1, arg_125_2)
	local var_125_0 = arg_125_0
	local var_125_1 = arg_125_0.getMaxLevel(var_125_0)

	if arg_125_0.level == var_125_1 then
		local var_125_2 = arg_125_0.exp

		pg = var_125_0

		if var_125_2 >= var_125_0.gameset.exp_overflow_max.key_value then
			return
		end

		LOCK_FULL_EXP = var_125_2

		if var_125_2 or not arg_125_2 or not arg_125_0:CanAccumulateExp() then
			arg_125_1 = 0
		end
	end

	arg_125_0.exp = arg_125_0.exp + arg_125_1

	local var_125_3 = false

	while arg_125_0:canLevelUp() do
		local var_125_4 = arg_125_0.exp

		var_1_10008 = arg_125_0
		arg_125_0.exp = var_125_4 - arg_125_0.getLevelExpConfig(var_1_10008).exp_interval
		math = var_5
		arg_125_0.level = var_5.min(arg_125_0.level + 1, var_125_1)
		var_125_3 = true
	end

	if arg_125_0.level == var_125_1 then
		if arg_125_2 and arg_125_0:CanAccumulateExp() then
			math = var_5

			local var_125_5 = var_5.min
			local var_125_6 = arg_125_0.exp

			pg = var_1_10008
			arg_125_0.exp = var_125_5(var_125_6, var_1_10008.gameset.exp_overflow_max.key_value)
		elseif var_125_3 then
			arg_125_0.exp = 0
		end
	end

	return
end

function var_0_1.getMaxLevel(arg_126_0)
	return arg_126_0.maxLevel
end

function var_0_1.canLevelUp(arg_127_0)
	local var_127_0 = arg_127_0:getLevelExpConfig(arg_127_0.level + 1)
	local var_127_1 = arg_127_0:getMaxLevel() <= arg_127_0.level

	return var_127_0 and arg_127_0:getLevelExpConfig().exp_interval <= arg_127_0.exp and not var_127_1
end

function var_0_1.getConfigMaxLevel(arg_128_0)
	return var_0_7.all[#var_0_7.all]
end

function var_0_1.isConfigMaxLevel(arg_129_0)
	return arg_129_0.level == arg_129_0:getConfigMaxLevel()
end

function var_0_1.updateMaxLevel(arg_130_0, arg_130_1)
	local var_130_0 = arg_130_0:getConfigMaxLevel()

	math = var_1_10003

	local var_130_1 = var_1_10003.max

	math = var_1_10005
	arg_130_0.maxLevel = var_130_1(var_1_10005.min(var_130_0, arg_130_1), arg_130_0.maxLevel)

	return
end

function var_0_1.getNextMaxLevel(arg_131_0)
	local var_131_0 = arg_131_0:getConfigMaxLevel()

	for iter_131_0 = arg_131_0:getMaxLevel() + 1, var_131_0 do
		if var_0_7[iter_131_0].level_limit == 1 then
			return iter_131_0
		end
	end

	return
end

function var_0_1.canUpgrade(arg_132_0)
	if arg_132_0:isBluePrintShip() then
		return false
	end

	if arg_132_0:isMetaShip() then
		if not arg_132_0:getMetaCharacter() then
			return false
		end

		local var_132_0 = var_1:getBreakOutInfo()

		if not var_2.hasNextInfo(var_132_0) then
			return false
		end

		local var_132_1, var_132_2 = var_2:getLimited()

		if var_132_1 > arg_132_0.level then
			return false
		end

		return true
	else
		local var_132_3 = var_0_9[arg_132_0.configId]

		assert = var_2

		var_2(var_132_3, "不存在配置" .. arg_132_0.configId)

		return not arg_132_0:isMaxStar() and arg_132_0.level >= var_132_3.level
	end

	return
end

function var_0_1.isReachNextMaxLevel(arg_133_0)
	if arg_133_0.level == arg_133_0:getMaxLevel() then
		local var_133_0

		if arg_133_0:CanAccumulateExp() then
			if arg_133_0:getNextMaxLevel() == nil then
				var_133_0 = false
			else
				var_133_0 = true
			end
		end

		return var_133_0
	end
end

function var_0_1.isAwakening(arg_134_0)
	local var_134_0

	if arg_134_0:isReachNextMaxLevel() then
		var_134_0 = arg_134_0.level < var_0_5
	end

	return var_134_0
end

function var_0_1.isAwakening2(arg_135_0)
	local var_135_0

	if arg_135_0:isReachNextMaxLevel() then
		var_135_0 = arg_135_0.level >= var_0_5
	end

	return var_135_0
end

function var_0_1.notMaxLevelForFilter(arg_136_0)
	return arg_136_0.level ~= arg_136_0:getMaxLevel()
end

function var_0_1.getNextMaxLevelConsume(arg_137_0)
	local var_137_0 = arg_137_0:getMaxLevel()
	local var_137_1 = var_0_7[var_137_0]["need_item_rarity" .. arg_137_0:getConfig("rarity")]

	assert = var_4

	var_4(var_137_1, "items  can not be nil")

	_ = var_4

	return var_4.map(var_137_1, function(arg_138_0)
		return {
			type = arg_138_0[1],
			id = arg_138_0[2],
			count = arg_138_0[3]
		}
	end)
end

function var_0_1.canUpgradeMaxLevel(arg_139_0)
	local var_139_0 = arg_139_0
	local var_139_1

	if not arg_139_0.isReachNextMaxLevel(var_139_0) then
		var_139_1 = false
		i18n = var_1_10002
		var_1_10002 = var_1_10002("upgrade_to_next_maxlevel_failed")

		return
	else
		getProxy = var_139_1
		PlayerProxy = var_139_0

		local var_139_2 = var_139_1(var_139_0)
		local var_139_3 = var_1.getData(var_139_2)

		getProxy = var_1_10002
		BagProxy = var_1_10004

		local var_139_4 = var_1_10002(var_1_10004)
		local var_139_5 = arg_139_0:getNextMaxLevelConsume()

		pairs = var_1_10004

		for iter_139_0, iter_139_1 in var_1_10004(var_139_5) do
			local var_139_6 = iter_139_1.type

			DROP_TYPE_RESOURCE = var_1_10010

			if var_139_6 == var_1_10010 then
				if var_139_3:getResById(iter_139_1.id) < iter_139_1.count then
					local var_139_7 = false

					i18n = var_1_10010
					var_1_10010 = var_1_10010("common_no_resource")

					return
				end
			else
				local var_139_8 = iter_139_1.type

				DROP_TYPE_ITEM = var_1_10010

				if var_139_8 == var_1_10010 and var_139_4:getItemCountById(iter_139_1.id) < iter_139_1.count then
					local var_139_9 = false

					i18n = var_1_10010
					var_1_10010 = var_1_10010("common_no_item_1")

					return
				end
			end
		end
	end

	return true
end

function var_0_1.CanAccumulateExp(arg_140_0)
	pg = var_1_10001

	return var_1_10001.ship_data_template[arg_140_0.configId].can_get_proficency == 1
end

function var_0_1.getTotalExp(arg_141_0)
	return arg_141_0:getLevelExpConfig().exp_start + arg_141_0.exp
end

function var_0_1.getStartBattleExpend(arg_142_0)
	table = var_1_10001

	local var_142_0 = var_1_10001.contains

	ShipType = var_1_10003

	if var_142_0(var_1_10003.SubShipType, arg_142_0:getShipType()) then
		return 0
	else
		pg = var_1

		return var_1.ship_data_template[arg_142_0.configId].oil_at_start
	end

	return
end

function var_0_1.getEndBattleExpend(arg_143_0)
	pg = var_1_10001

	local var_143_0 = var_1_10001.ship_data_template[arg_143_0.configId]
	local var_143_1 = arg_143_0:getLevelExpConfig()

	math = var_1_10003

	return (var_1_10003.floor(var_143_0.oil_at_end * var_143_1.fight_oil_ratio / 16))
end

function var_0_1.getBattleTotalExpend(arg_144_0)
	return arg_144_0:getStartBattleExpend() + arg_144_0:getEndBattleExpend()
end

function var_0_1.getShipAmmo(arg_145_0)
	local var_145_0 = arg_145_0
	local var_145_1 = arg_145_0.getConfig

	AttributeType = var_1_10004

	local var_145_2 = var_145_1(var_145_0, var_1_10004.Ammo)

	pairs = var_1_10002

	for iter_145_0, iter_145_1 in var_1_10002(arg_145_0:getAllSkills()) do
		tonumber = var_1_10007

		local var_145_3 = iter_145_0

		string = var_1_10010
		var_1_10007 = var_1_10007(var_145_3 .. var_1_10010.format("%.2d", iter_145_1.level))
		pg = var_1_10008

		if var_1_10008.skill_benefit_template[var_1_10007] and arg_145_0:IsBenefitSkillActive(var_1_10008) and (var_1_10008.type == var_0_1.BENEFIT_EQUIP or var_1_10008.type == var_0_1.BENEFIT_SKILL) then
			defaultValue = var_9
			var_145_2 = var_145_2 + var_9(var_1_10008.effect[1], 0)
		end
	end

	local var_145_4 = arg_145_0:getActiveEquipments()

	ipairs = var_3

	for iter_145_2, iter_145_3 in var_3(var_145_4) do
		if iter_145_3 and iter_145_3:getConfig("equip_parameters").ammo then
			var_145_2 = var_145_2 + var_8
		end
	end

	return var_145_2
end

function var_0_1.getHuntingLv(arg_146_0)
	local var_146_0 = arg_146_0:getConfig("huntingrange_level")

	pairs = var_1_10002

	for iter_146_0, iter_146_1 in var_1_10002(arg_146_0:getAllSkills()) do
		tonumber = var_1_10007

		local var_146_1 = iter_146_0

		string = var_1_10010
		var_1_10007 = var_1_10007(var_146_1 .. var_1_10010.format("%.2d", iter_146_1.level))
		pg = var_1_10008

		if var_1_10008.skill_benefit_template[var_1_10007] and arg_146_0:IsBenefitSkillActive(var_1_10008) and (var_1_10008.type == var_0_1.BENEFIT_EQUIP or var_1_10008.type == var_0_1.BENEFIT_SKILL) then
			defaultValue = var_9
			var_146_0 = var_146_0 + var_9(var_1_10008.effect[2], 0)
		end
	end

	local var_146_2 = arg_146_0:getActiveEquipments()

	ipairs = var_3

	for iter_146_2, iter_146_3 in var_3(var_146_2) do
		if iter_146_3 and iter_146_3:getConfig("equip_parameters").hunting_lv then
			var_146_0 = var_146_0 + var_8
		end
	end

	math = var_3

	return (var_3.min(var_146_0, arg_146_0:getMaxHuntingLv()))
end

function var_0_1.getMapAuras(arg_147_0)
	local var_147_0 = {}

	pairs = var_1_10002

	for iter_147_0, iter_147_1 in var_1_10002(arg_147_0:getAllSkills()) do
		tonumber = var_1_10007

		local var_147_1 = iter_147_0

		string = var_1_10010
		var_1_10007 = var_1_10007(var_147_1 .. var_1_10010.format("%.2d", iter_147_1.level))
		pg = var_1_10008

		if var_1_10008.skill_benefit_template[var_1_10007] and arg_147_0:IsBenefitSkillActive(var_1_10008) and var_1_10008.type == var_0_1.BENEFIT_MAP_AURA then
			local var_147_2 = {
				id = var_1_10008.effect[1],
				level = iter_147_1.level
			}

			table = var_1_10010

			var_1_10010.insert(var_147_0, var_147_2)
		end
	end

	return var_147_0
end

function var_0_1.getMapAids(arg_148_0)
	local var_148_0 = {}

	pairs = var_1_10002

	for iter_148_0, iter_148_1 in var_1_10002(arg_148_0:getAllSkills()) do
		tonumber = var_1_10007

		local var_148_1 = iter_148_0

		string = var_1_10010
		var_1_10007 = var_1_10007(var_148_1 .. var_1_10010.format("%.2d", iter_148_1.level))
		pg = var_1_10008

		if var_1_10008.skill_benefit_template[var_1_10007] and arg_148_0:IsBenefitSkillActive(var_1_10008) and var_1_10008.type == var_0_1.BENEFIT_AID then
			local var_148_2 = {
				id = var_1_10008.effect[1],
				level = iter_148_1.level
			}

			table = var_1_10010

			var_1_10010.insert(var_148_0, var_148_2)
		end
	end

	return var_148_0
end

var_0_1.BENEFIT_SKILL = 2
var_0_1.BENEFIT_EQUIP = 3
var_0_1.BENEFIT_MAP_AURA = 4
var_0_1.BENEFIT_AID = 5

function var_0_1.IsBenefitSkillActive(arg_149_0, arg_149_1)
	local var_149_0 = false

	if arg_149_1.type == var_0_1.BENEFIT_SKILL then
		if not arg_149_1.limit[1] or arg_149_1.limit[1] == arg_149_0.triggers.TeamNumbers then
			var_149_0 = true
		end
	elseif arg_149_1.type == var_0_1.BENEFIT_EQUIP then
		local var_149_1 = arg_149_1.limit
		local var_149_2 = arg_149_0:getAllEquipments()

		ipairs = var_1_10005

		for iter_149_0, iter_149_1 in var_1_10005(var_149_2) do
			if iter_149_1 then
				table = var_1_10010

				if var_1_10010.contains(var_149_1, iter_149_1:getConfig("id")) then
					var_149_0 = true

					break
				end
			end
		end
	elseif arg_149_1.type == var_0_1.BENEFIT_MAP_AURA then
		if arg_149_0.hpRant and arg_149_0.hpRant > 0 then
			return true
		end
	elseif arg_149_1.type == var_0_1.BENEFIT_AID and arg_149_0.hpRant and arg_149_0.hpRant > 0 then
		return true
	end

	return var_149_0
end

function var_0_1.getMaxHuntingLv(arg_150_0)
	return #arg_150_0:getConfig("hunting_range")
end

function var_0_1.getHuntingRange(arg_151_0, arg_151_1)
	local var_151_0 = arg_151_0:getConfig("hunting_range")

	Clone = var_1_10003

	local var_151_1 = var_1_10003(var_151_0[1])
	local var_151_2 = arg_151_1 or arg_151_0:getHuntingLv()

	math = var_5

	local var_151_3 = var_5.min(var_151_2, arg_151_0:getMaxHuntingLv())

	for iter_151_0 = 2, var_151_3 do
		_ = var_1_10009

		var_1_10009.each(var_151_0[iter_151_0], function(arg_152_0)
			table = var_2_10001

			var_2_10001.insert(var_151_1, {
				arg_152_0[1],
				arg_152_0[2]
			})

			return
		end)
	end

	return var_151_1
end

function var_0_1.getTriggerSkills(arg_153_0)
	local var_153_0 = {}
	local var_153_1 = arg_153_0:getSkillEffects()

	_ = var_1_10003

	var_1_10003.each(var_153_1, function(arg_154_0)
		if arg_154_0.type == "AddBuff" and arg_154_0.arg_list and arg_154_0.arg_list.buff_id then
			local var_154_0 = arg_154_0.arg_list.buff_id

			var_153_0[var_154_0] = {
				id = var_154_0,
				level = arg_154_0.level
			}
		end

		return
	end)

	return var_153_0
end

function var_0_1.GetEquipmentSkills(arg_155_0)
	local var_155_0 = {}
	local var_155_1 = arg_155_0:getActiveEquipments()

	ipairs = var_1_10003

	for iter_155_0, iter_155_1 in var_1_10003(var_155_1) do
		if iter_155_1 and iter_155_1:getConfig("skill_id")[1] then
			unpack = var_8

			local var_155_2, var_155_3 = var_8(iter_155_1:getConfig("skill_id")[1])

			var_155_0[var_155_2] = {
				id = var_155_2,
				level = var_155_3
			}
		end
	end

	;(function()
		local var_156_0 = arg_155_0
		local var_156_1

		if not var_0.GetSpWeapon(var_156_0) or not var_0:GetEffect() then
			var_156_1 = 0
		end

		if var_156_1 > 0 then
			var_155_0[var_156_1] = {
				level = 1,
				id = var_156_1
			}
		end

		return
	end)()

	return var_155_0
end

function var_0_1.getAllSkills(arg_157_0)
	Clone = var_1_10001

	local var_157_0 = var_1_10001(arg_157_0.skills)

	pairs = var_1_10002

	for iter_157_0, iter_157_1 in var_1_10002(arg_157_0:GetEquipmentSkills()) do
		var_157_0[iter_157_0] = iter_157_1
	end

	pairs = var_2

	for iter_157_2, iter_157_3 in var_2(arg_157_0:getTriggerSkills()) do
		var_157_0[iter_157_2] = iter_157_3
	end

	return var_157_0
end

function var_0_1.isSameKind(arg_158_0, arg_158_1)
	pg = var_1_10002

	local var_158_0 = var_1_10002.ship_data_template[arg_158_0.configId].group_type

	pg = var_3

	return var_158_0 == var_3.ship_data_template[arg_158_1.configId].group_type
end

function var_0_1.GetLockState(arg_159_0)
	return arg_159_0.lockState
end

function var_0_1.IsLocked(arg_160_0)
	return arg_160_0.lockState == var_0_1.LOCK_STATE_LOCK
end

function var_0_1.SetLockState(arg_161_0, arg_161_1)
	arg_161_0.lockState = arg_161_1

	return
end

function var_0_1.GetPreferenceTag(arg_162_0)
	local var_162_0

	if not arg_162_0.preferenceTag then
		var_162_0 = 0
	end

	return var_162_0
end

function var_0_1.IsPreferenceTag(arg_163_0)
	return arg_163_0:GetPreferenceTag() == var_0_1.PREFERENCE_TAG_COMMON
end

function var_0_1.SetPreferenceTag(arg_164_0, arg_164_1)
	arg_164_0.preferenceTag = arg_164_1

	return
end

function var_0_1.calReturnRes(arg_165_0)
	pg = var_1_10001

	local var_165_0 = var_1_10001.ship_data_by_type
	local var_165_1 = arg_165_0
	local var_165_2 = var_165_0[arg_165_0.getShipType(var_165_1)].distory_resource_gold_ratio
	local var_165_3 = var_1.distory_resource_oil_ratio

	pg = var_165_1

	local var_165_4 = var_165_1.ship_data_by_star[arg_165_0:getConfig("rarity")].destory_item

	return var_165_2, 0, var_165_4
end

function var_0_1.getRarity(arg_166_0)
	local var_166_0 = arg_166_0:getConfig("rarity")

	if arg_166_0:isRemoulded() then
		var_166_0 = var_166_0 + 1
	end

	return var_166_0
end

function var_0_1.updateSkill(arg_167_0, arg_167_1)
	local var_167_0

	if not arg_167_1.skill_id then
		var_167_0 = arg_167_1.id
	end

	local var_167_1

	if not arg_167_1.skill_lv and not arg_167_1.lv then
		var_167_1 = arg_167_1.level
	end

	local var_167_2

	if not arg_167_1.skill_exp then
		var_167_2 = arg_167_1.exp
	end

	arg_167_0.skills[var_167_0] = {
		id = var_167_0,
		level = var_167_1,
		exp = var_167_2
	}

	return
end

function var_0_1.canEquipAtPos(arg_168_0, arg_168_1, arg_168_2)
	local var_168_0 = arg_168_0
	local var_168_1, var_168_2 = arg_168_0.isForbiddenAtPos(var_168_0, arg_168_1, arg_168_2)

	if var_168_1 then
		return false, var_168_2
	end

	ipairs = var_168_0

	for iter_168_0, iter_168_1 in var_168_0(arg_168_0.equipments) do
		if iter_168_1 and iter_168_0 ~= arg_168_2 and iter_168_1:getConfig("equip_limit") ~= 0 and arg_168_1:getConfig("equip_limit") == iter_168_1:getConfig("equip_limit") then
			local var_168_3 = false

			i18n = var_11

			local var_168_4 = var_11("ship_equip_same_group_equipment")

			return
		end
	end

	return true
end

function var_0_1.isForbiddenAtPos(arg_169_0, arg_169_1, arg_169_2)
	pg = var_1_10003

	local var_169_0 = var_1_10003.ship_data_template[arg_169_0.configId]

	assert = var_4

	var_4(var_169_0, "can not find ship in ship_data_templtae: " .. arg_169_0.configId)

	local var_169_1 = var_169_0["equip_" .. arg_169_2]

	table = var_5

	local var_169_2, var_169_3

	if not var_5.contains(var_169_1, arg_169_1:getConfig("type")) then
		var_169_2 = true
		i18n = var_169_3
		var_169_3 = var_169_3("common_limit_equip")

		return
	end

	table = var_169_2

	if var_169_2.contains(arg_169_1:getConfig("ship_type_forbidden"), arg_169_0:getShipType()) then
		local var_169_4 = true

		i18n = var_169_3

		local var_169_5 = var_169_3("common_limit_equip")

		return
	end

	return false
end

function var_0_1.canEquipCommander(arg_170_0, arg_170_1)
	if arg_170_1:getShipType() ~= arg_170_0:getShipType() then
		local var_170_0 = false

		i18n = var_3

		local var_170_1 = var_3("commander_type_unmatch")

		return
	end

	return true
end

function var_0_1.upgrade(arg_171_0)
	pg = var_1_10001

	if var_1_10001.ship_data_transform[arg_171_0.configId].trans_id and var_1.trans_id > 0 then
		arg_171_0.configId = var_1.trans_id
		arg_171_0.star = arg_171_0:getConfig("star")
	end

	return
end

function var_0_1.getTeamType(arg_172_0)
	ShipType = var_1_10001

	return var_1_10001.GetTeamFromShipType(arg_172_0:getShipType())
end

function var_0_1.getFleetName(arg_173_0)
	local var_173_0 = arg_173_0:getTeamType()

	return var_0_2[var_173_0]
end

function var_0_1.getMaxConfigId(arg_174_0)
	pg = var_1_10001

	local var_174_0 = var_1_10001.ship_data_template
	local var_174_1

	for iter_174_0 = 4, 1, -1 do
		tonumber = var_1_10007

		if var_174_0[var_1_10007(arg_174_0.groupId .. iter_174_0)] then
			var_174_1 = var_1_10007

			break
		end
	end

	return var_174_1
end

function var_0_1.getFlag(arg_175_0, arg_175_1, arg_175_2)
	pg = var_1_10003

	local var_175_0 = var_1_10003.ShipFlagMgr.GetInstance()

	return var_3.GetShipFlag(var_175_0, arg_175_0.id, arg_175_1, arg_175_2)
end

function var_0_1.hasAnyFlag(arg_176_0, arg_176_1)
	_ = var_1_10002

	return var_1_10002.any(arg_176_1, function(arg_177_0)
		local var_177_0 = arg_176_0

		return var_1.getFlag(var_177_0, arg_177_0)
	end)
end

function var_0_1.isBreakOut(arg_178_0)
	return arg_178_0.configId % 10 > 1
end

function var_0_1.fateSkillChange(arg_179_0, arg_179_1)
	if not arg_179_0.skillChangeList then
		if arg_179_0:isBluePrintShip() then
			local var_179_0 = arg_179_0:getBluePrint()
			local var_179_1

			if not var_179_1.getChangeSkillList(var_179_0) then
				var_179_1 = {}
			end

			arg_179_0.skillChangeList = var_179_1
			ipairs = var_179_1

			for iter_179_0, iter_179_1 in var_179_1(arg_179_0.skillChangeList) do
				if iter_179_1[1] == arg_179_1 and arg_179_0.skills[iter_179_1[2]] then
					return iter_179_1[2]
				end
			end

			return arg_179_1
		end
	end
end

function var_0_1.RemapSkillId(arg_180_0, arg_180_1, arg_180_2)
	if arg_180_0:GetSpWeapon() then
		table = var_1_10004

		local var_180_0 = var_1_10004.contains

		pg = var_1_10006

		if var_180_0(var_1_10006.ship_data_template[arg_180_0.configId].hide_buff_list, arg_180_1) then
			return var_3:RemapHiddenSkillId(arg_180_1)
		elseif arg_180_2 then
			local var_180_1

			if var_3:RemapHiddenSkillId(arg_180_1) == arg_180_1 then
				var_180_1 = var_3:RemapSkillId(arg_180_1)
			end

			return var_180_1
		else
			return var_3:RemapSkillId(arg_180_1)
		end
	end

	return arg_180_1
end

function var_0_1.getSkillList(arg_181_0)
	pg = var_1_10001

	local var_181_0 = var_1_10001.ship_data_template[arg_181_0.configId]

	Clone = var_2

	local var_181_1 = var_2(var_181_0.buff_list_display)

	Clone = var_1_10003

	local var_181_2 = var_1_10003(var_181_0.buff_list)

	pg = var_4

	local var_181_3 = var_4.ship_data_trans[arg_181_0.groupId]
	local var_181_4 = 0

	if var_181_3 and var_181_3.skill_id ~= 0 then
		local var_181_5 = var_181_3.skill_id

		pg = var_1_10007
		var_1_10007 = var_1_10007.transform_data_template[var_181_5]

		if arg_181_0.transforms[var_181_5] and var_1_10007.skill_id ~= 0 then
			table = var_8

			var_8.insert(var_181_2, var_1_10007.skill_id)
		end
	end

	local var_181_6 = {}

	ipairs = var_1_10007

	for iter_181_0, iter_181_1 in var_1_10007(var_181_1) do
		ipairs = var_1_10012

		for iter_181_2, iter_181_3 in var_1_10012(var_181_2) do
			if iter_181_1 == iter_181_3 then
				table = var_1_10017

				var_1_10017.insert(var_181_6, arg_181_0:fateSkillChange(iter_181_1))
			end
		end
	end

	return var_181_6
end

function var_0_1.getModAttrTopLimit(arg_182_0, arg_182_1)
	ShipModAttr = var_1_10002

	local var_182_0 = var_1_10002.ATTR_TO_INDEX[arg_182_1]

	pg = var_1_10003

	local var_182_1 = var_1_10003.ship_data_template[arg_182_0.configId].strengthen_id

	pg = var_4

	local var_182_2 = var_4.ship_data_strengthen[var_182_1].durability[var_182_0]

	calcFloor = var_1_10005
	math = var_1_10007

	return var_1_10005((3 + 7 * (var_1_10007.min(arg_182_0.level, 100) / 100)) * var_182_2 * 0.1)
end

function var_0_1.leftModAdditionPoint(arg_183_0, arg_183_1)
	local var_183_0 = arg_183_0:getModProperties(arg_183_1)
	local var_183_1 = arg_183_0
	local var_183_2 = arg_183_0.getModExpRatio(var_183_1, arg_183_1)
	local var_183_3 = arg_183_0
	local var_183_4 = arg_183_0.getModAttrTopLimit(var_183_3, arg_183_1)

	calcFloor = var_183_1

	local var_183_5 = var_183_1(var_183_0 / var_183_2)

	math = var_183_3

	return var_183_3.max(0, var_183_4 - var_183_5)
end

function var_0_1.getModAttrBaseMax(arg_184_0, arg_184_1)
	table = var_1_10002

	if not var_1_10002.contains(arg_184_0:getConfig("lock"), arg_184_1) then
		local var_184_0 = arg_184_0
		local var_184_1 = arg_184_0.leftModAdditionPoint(var_184_0, arg_184_1)
		local var_184_2 = arg_184_0:getShipProperties()

		calcFloor = var_184_0

		return var_184_0(var_184_2[arg_184_1] + var_184_1)
	else
		return 0
	end

	return
end

function var_0_1.getModExpRatio(arg_185_0, arg_185_1)
	table = var_1_10002

	local var_185_0 = var_1_10002.contains
	local var_185_1 = arg_185_0

	if not var_185_0(arg_185_0.getConfig(var_185_1, "lock"), arg_185_1) then
		pg = var_1_10003

		local var_185_2 = var_1_10003.ship_data_template[arg_185_0.configId].strengthen_id

		assert = var_4
		pg = var_185_1

		var_4(var_185_1.ship_data_strengthen[var_185_2], "ship_data_strengthen>>>>>>" .. var_185_2)

		math = var_4

		local var_185_3 = var_4.max

		pg = var_6

		local var_185_4 = var_6.ship_data_strengthen[var_185_2].level_exp

		ShipModAttr = var_7

		return var_185_3(var_185_4[var_7.ATTR_TO_INDEX[arg_185_1]], 1)
	else
		return 1
	end

	return
end

function var_0_1.inUnlockTip(arg_186_0)
	pg = var_1_10001

	local var_186_0 = var_1_10001.gameset.tip_unlock_shipIds.description[0]

	table = var_1_10002

	return var_1_10002.contains(var_186_0, arg_186_0)
end

function var_0_1.proposeSkinOwned(arg_187_0, arg_187_1)
	local var_187_0

	if arg_187_1 and arg_187_0.propose then
		var_187_0 = arg_187_1.skin_type
		ShipSkin = var_1_10003
		var_187_0 = var_187_0 == var_1_10003.SKIN_TYPE_PROPOSE
	end

	return var_187_0
end

function var_0_1.getProposeSkin(arg_188_0)
	ShipSkin = var_1_10001

	local var_188_0 = var_1_10001.GetSkinByType
	local var_188_1 = arg_188_0.groupId

	ShipSkin = var_1_10004

	return var_188_0(var_188_1, var_1_10004.SKIN_TYPE_PROPOSE)
end

function var_0_1.getDisplaySkillIds(arg_189_0)
	_ = var_1_10001

	local var_189_0 = var_1_10001.map

	pg = var_1_10003

	return var_189_0(var_1_10003.ship_data_template[arg_189_0.configId].buff_list_display, function(arg_190_0)
		local var_190_0 = arg_189_0

		return var_1.fateSkillChange(var_190_0, arg_190_0)
	end)
end

function var_0_1.isFullSkillLevel(arg_191_0)
	pg = var_1_10001

	local var_191_0 = var_1_10001.skill_data_template

	pairs = var_1_10002

	for iter_191_0, iter_191_1 in var_1_10002(arg_191_0.skills) do
		if var_191_0[iter_191_1.id].max_level ~= iter_191_1.level then
			return false
		end
	end

	return true
end

function var_0_1.setEquipmentRecord(arg_192_0, arg_192_1, arg_192_2)
	local var_192_0 = "equipment_record" .. "_" .. arg_192_1 .. "_" .. arg_192_0.id

	PlayerPrefs = var_4

	local var_192_1 = var_4.SetString
	local var_192_2 = var_192_0

	table = var_7

	local var_192_3 = var_7.concat

	_ = var_1_10009

	var_192_1(var_192_2, var_192_3(var_1_10009.flatten(arg_192_2), ":"))

	PlayerPrefs = var_192_1

	var_192_1.Save()

	return
end

function var_0_1.getEquipmentRecord(arg_193_0, arg_193_1)
	if not arg_193_0.equipmentRecords then
		local var_193_0 = "equipment_record" .. "_" .. arg_193_1 .. "_" .. arg_193_0.id

		string = var_3

		local var_193_1 = var_3.split

		PlayerPrefs = var_5

		local var_193_2

		if not var_5.GetString(var_193_0) then
			var_193_2 = ""
		end

		local var_193_3 = var_193_1(var_193_2, ":")
		local var_193_4 = {}

		for iter_193_0 = 1, 3 do
			_ = var_1_10009
			var_1_10009 = var_1_10009.map
			_ = var_1_10011
			var_193_4[iter_193_0] = var_1_10009(var_1_10011.slice(var_193_3, 5 * iter_193_0 - 4, 5), function(arg_194_0)
				tonumber = var_2_10001

				return var_2_10001(arg_194_0)
			end)
		end

		arg_193_0.equipmentRecords = var_193_4
	end

	return arg_193_0.equipmentRecords
end

function var_0_1.SetSpWeaponRecord(arg_195_0, arg_195_1, arg_195_2)
	local var_195_0 = "spweapon_record" .. "_" .. arg_195_1 .. "_" .. arg_195_0.id

	_ = var_4

	local var_195_1 = var_4.map({
		1,
		2,
		3
	}, function(arg_196_0)
		if arg_195_2[arg_196_0] then
			local var_196_0

			if not var_1:GetUID() then
				var_196_0 = 0
			end

			return var_196_0 .. "," .. var_1:GetConfigID()
		else
			return "0,0"
		end

		return
	end)

	PlayerPrefs = var_5

	local var_195_2 = var_5.SetString
	local var_195_3 = var_195_0

	table = var_1_10008

	var_195_2(var_195_3, var_1_10008.concat(var_195_1, ":"))

	PlayerPrefs = var_195_2

	var_195_2.Save()

	return
end

function var_0_1.GetSpWeaponRecord(arg_197_0, arg_197_1)
	local var_197_0 = "spweapon_record" .. "_" .. arg_197_1 .. "_" .. arg_197_0.id

	_ = var_3

	local var_197_1 = var_3.map

	string = var_5

	local var_197_2 = var_5.split

	PlayerPrefs = var_1_10007

	return (var_197_1(var_197_2(var_1_10007.GetString(var_197_0, ""), ":"), function(arg_198_0)
		string = var_2_10001

		local var_198_0 = var_2_10001.split(arg_198_0, ",")

		assert = var_2_10002

		var_2_10002(var_198_0)

		tonumber = var_2_10002

		local var_198_1 = var_2_10002(var_198_0[1])

		tonumber = var_3

		if not var_3(var_198_0[2]) or var_3 == 0 then
			return false
		end

		SpWeapon = var_4

		return (var_4.New({
			id = var_3
		}))
	end))
end

function var_0_1.hasEquipEquipmentSkin(arg_199_0)
	ipairs = var_1_10001

	for iter_199_0, iter_199_1 in var_1_10001(arg_199_0.equipments) do
		if iter_199_1 and iter_199_1:hasSkin() then
			return true
		end
	end

	return false
end

function var_0_1.hasCommander(arg_200_0)
	local var_200_0

	if arg_200_0.commanderId then
		var_200_0 = arg_200_0.commanderId ~= 0
	end

	return var_200_0
end

function var_0_1.getCommander(arg_201_0)
	return arg_201_0.commanderId
end

function var_0_1.setCommander(arg_202_0, arg_202_1)
	arg_202_0.commanderId = arg_202_1

	return
end

function var_0_1.getSkillIndex(arg_203_0, arg_203_1)
	local var_203_0 = arg_203_0:getSkillList()

	ipairs = var_1_10003

	for iter_203_0, iter_203_1 in var_1_10003(var_203_0) do
		if arg_203_1 == iter_203_1 then
			return iter_203_0
		end
	end

	return
end

function var_0_1.getTactics(arg_204_0)
	return 1, "tactics_attack"
end

function var_0_1.IsBgmSkin(arg_205_0)
	local var_205_0 = arg_205_0:GetSkinConfig()

	table = var_1_10002

	local var_205_1 = var_1_10002.contains
	local var_205_2 = var_205_0.tag

	ShipSkin = var_1_10005

	return var_205_1(var_205_2, var_1_10005.WITH_BGM)
end

function var_0_1.GetSkinBgm(arg_206_0)
	if arg_206_0:IsBgmSkin() then
		return arg_206_0:GetSkinConfig().bgm
	end

	return
end

function var_0_1.isIntensifyMax(arg_207_0)
	intProperties = var_1_10001

	local var_207_0 = var_1_10001(arg_207_0:getShipProperties())
	local var_207_1 = arg_207_0

	if arg_207_0.isBluePrintShip(var_207_1) then
		return true
	end

	pairs = var_2
	ShipModAttr = var_207_1

	for iter_207_0, iter_207_1 in var_2(var_207_1.ID_TO_ATTR) do
		if arg_207_0:getModAttrBaseMax(iter_207_1) ~= var_207_0[iter_207_1] then
			return false
		end
	end

	return true
end

function var_0_1.isRemouldable(arg_208_0)
	local var_208_0

	if not arg_208_0:isTestShip() and not arg_208_0:isBluePrintShip() then
		pg = var_1
		var_208_0 = var_1.ship_data_trans[arg_208_0.groupId]
	else
		var_208_0 = false
	end

	if false then
		var_208_0 = true
	end

	return var_208_0
end

function var_0_1.isAllRemouldFinish(arg_209_0)
	pg = var_1_10001

	local var_209_0 = var_1_10001.ship_data_trans[arg_209_0.groupId]

	assert = var_2

	var_2(var_209_0, "this ship group without remould config:" .. arg_209_0.groupId)

	ipairs = var_2

	for iter_209_0, iter_209_1 in var_2(var_209_0.transform_list) do
		ipairs = var_1_10007

		for iter_209_2, iter_209_3 in var_1_10007(iter_209_1) do
			pg = var_1_10012

			if #var_1_10012.transform_data_template[iter_209_3[2]].edit_trans > 0 then
				-- block empty
			elseif not arg_209_0.transforms[iter_209_3[2]] or arg_209_0.transforms[iter_209_3[2]].level < var_1_10012.max_level then
				return false
			end
		end
	end

	return true
end

function var_0_1.isSpecialFilter(arg_210_0)
	pg = var_1_10001

	local var_210_0 = var_1_10001.ship_data_statistics[arg_210_0.configId]

	assert = var_2

	var_2(var_210_0, "this ship without statistics:" .. arg_210_0.configId)

	ipairs = var_2

	for iter_210_0, iter_210_1 in var_2(var_210_0.tag_list) do
		if iter_210_1 == "special" then
			return true
		end
	end

	return false
end

function var_0_1.hasAvailiableSkin(arg_211_0)
	getProxy = var_1_10001
	ShipSkinProxy = var_1_10003

	local var_211_0 = var_1_10001(var_1_10003)
	local var_211_1 = var_1.GetAllSkinForShip(var_211_0, arg_211_0)
	local var_211_2 = var_1
	local var_211_3 = var_1.getRawData(var_211_2)
	local var_211_4 = 0

	ipairs = var_211_2

	for iter_211_0, iter_211_1 in var_211_2(var_211_1) do
		if arg_211_0:proposeSkinOwned(iter_211_1) or var_211_3[iter_211_1.id] or var_1:hasSkin(iter_211_1.id) then
			var_211_4 = var_211_4 + 1
		end
	end

	return var_211_4 > 0
end

function var_0_1.hasProposeSkin(arg_212_0)
	getProxy = var_1_10001
	ShipSkinProxy = var_1_10003

	local var_212_0 = var_1_10001(var_1_10003)
	local var_212_1 = var_1.GetAllSkinForShip(var_212_0, arg_212_0)

	ipairs = var_1_10003

	for iter_212_0, iter_212_1 in var_1_10003(var_212_1) do
		local var_212_2 = iter_212_1.skin_type

		ShipSkin = var_1_10009

		if var_212_2 == var_1_10009.SKIN_TYPE_PROPOSE then
			return true
		end
	end

	local var_212_3 = var_1:GetShareSkinsForShip(arg_212_0)

	ipairs = var_4

	for iter_212_2, iter_212_3 in var_4(var_212_3) do
		local var_212_4 = iter_212_3.skin_type

		ShipSkin = var_1_10010

		if var_212_4 == var_1_10010.SKIN_TYPE_PROPOSE then
			return true
		end
	end

	return false
end

function var_0_1.HasUniqueSpWeapon(arg_213_0)
	tobool = var_1_10001
	pg = var_1_10003

	return var_1_10001(var_1_10003.spweapon_data_statistics.get_id_list_by_unique[arg_213_0:getGroupId()])
end

function var_0_1.getAircraftReloadCD(arg_214_0)
	local var_214_0 = arg_214_0:getConfigTable().base_list
	local var_214_1 = arg_214_0:getConfigTable().default_equip_list
	local var_214_2 = 0
	local var_214_3 = 0

	for iter_214_0 = 1, 3 do
		local var_214_4 = arg_214_0
		local var_214_5

		if not arg_214_0.getEquip(var_214_4, iter_214_0) or not var_9.configId then
			var_214_5 = var_214_1[iter_214_0]
		end

		Equipment = var_214_4

		local var_214_6 = var_214_4.getConfigData(var_214_5).type

		underscore = var_12

		local var_214_7 = var_12.any

		EquipType = var_1_10014

		if var_214_7(var_1_10014.AirEquipTypes, function(arg_215_0)
			return var_214_6 == arg_215_0
		end) then
			Equipment = var_12
			var_214_2 = var_214_2 + var_12.GetEquipReloadStatic(var_214_5) * var_214_0[iter_214_0]
			var_214_3 = var_214_3 + var_214_0[iter_214_0]
		end
	end

	ys = var_5

	local var_214_8 = var_5.Battle.BattleConfig.AIR_ASSIST_RELOAD_RATIO

	pg = var_6

	local var_214_9 = var_214_8 * var_6.bfConsts.PERCENT
	local var_214_10 = {}

	i18n = var_7
	var_214_10.name = var_7("equip_info_31")
	AttributeType = var_7
	var_214_10.type = var_7.CD
	var_214_10.value = var_214_2 / var_214_3 * var_214_9

	return var_214_10
end

function var_0_1.IsTagShip(arg_216_0, arg_216_1)
	local var_216_0 = arg_216_0:getConfig("tag_list")

	table = var_1_10003

	return var_1_10003.contains(var_216_0, arg_216_1)
end

function var_0_1.setReMetaSpecialItemVO(arg_217_0, arg_217_1)
	arg_217_0.reMetaSpecialItemVO = arg_217_1

	return
end

function var_0_1.getReMetaSpecialItemVO(arg_218_0, arg_218_1)
	return arg_218_0.reMetaSpecialItemVO
end

function var_0_1.getProposeType(arg_219_0)
	if arg_219_0:isMetaShip() then
		return "meta"
	elseif arg_219_0:IsXIdol() then
		return "imas"
	else
		return "default"
	end

	return
end

function var_0_1.IsXIdol(arg_220_0)
	local var_220_0 = arg_220_0:getNation()

	Nation = var_1_10002

	return var_220_0 == var_1_10002.IDOL_LINK
end

function var_0_1.getSpecificType(arg_221_0)
	pg = var_1_10001

	return var_1_10001.ship_data_template[arg_221_0.configId].specific_type
end

function var_0_1.GetSpWeapon(arg_222_0)
	return arg_222_0.spWeapon
end

function var_0_1.UpdateSpWeapon(arg_223_0, arg_223_1)
	local var_223_0

	if not arg_223_1 or not arg_223_1:GetUID() then
		var_223_0 = 0
	end

	if arg_223_0.spWeapon then
		local var_223_1 = arg_223_0.spWeapon
		local var_223_2

		if not var_3.GetUID(var_223_1) then
			var_223_2 = 0
		end

		local var_223_3 = var_223_0 == var_223_2

		arg_223_0.spWeapon = arg_223_1

		if arg_223_1 then
			arg_223_1:SetShipId(arg_223_0.id)
		end

		if var_223_3 then
			pg = var_223_2

			local var_223_4 = var_223_2.m02
			local var_223_5 = var_3.sendNotification

			EquipmentProxy = var_1_10006

			var_223_5(var_223_4, var_1_10006.SPWEAPONS_UPDATED)
		end

		return
	end
end

function var_0_1.CanEquipSpWeapon(arg_224_0, arg_224_1)
	local var_224_0, var_224_1 = arg_224_0:IsSpWeaponForbidden(arg_224_1)

	if var_224_0 then
		return false, var_224_1
	end

	return true
end

function var_0_1.IsSpWeaponForbidden(arg_225_0, arg_225_1)
	local var_225_0 = arg_225_1
	local var_225_1 = arg_225_1.GetWearableShipTypes(var_225_0)
	local var_225_2 = arg_225_0
	local var_225_3 = arg_225_0.getShipType(var_225_2)

	table = var_225_0

	if not var_225_0.contains(var_225_1, var_225_3) then
		local var_225_4 = true

		i18n = var_225_2

		local var_225_5 = var_225_2("spweapon_tip_group_error")

		return
	end

	local var_225_6 = arg_225_1:GetUniqueGroup()
	local var_225_7 = arg_225_0
	local var_225_8 = arg_225_0.getGroupId(var_225_7)

	if var_225_6 ~= 0 and var_225_6 ~= var_225_8 then
		local var_225_9 = true

		i18n = var_225_7

		local var_225_10 = var_225_7("spweapon_tip_group_error")

		return
	end

	return false
end

function var_0_1.GetMapStrikeAnim(arg_226_0)
	local var_226_0
	local var_226_1 = arg_226_0:getShipType()

	switch = var_1_10003
	ShipType = var_1_10005

	local var_226_2 = var_1_10005.GetTeamFromShipType(var_226_1)
	local var_226_3 = {}

	TeamType = var_7
	var_226_3[var_7.Main] = function()
		ShipType = var_2_10000

		if var_2_10000.IsTypeQuZhu(var_226_1) then
			var_226_0 = "SubTorpedoUI"
		else
			ShipType = var_0

			local var_227_0 = var_0.ContainInLimitBundle

			ShipType = var_2

			if var_227_0(var_2.BundleAircraftCarrier, var_226_1) then
				var_226_0 = "AirStrikeUI"
			else
				ShipType = var_0

				local var_227_1 = var_0.ContainInLimitBundle

				ShipType = var_2

				if var_227_1(var_2.BundleBattleShip, var_226_1) then
					var_226_0 = "CannonUI"
				else
					var_226_0 = "CannonUI"
				end
			end
		end

		return
	end
	TeamType = var_7
	var_226_3[var_7.Vanguard] = function()
		ShipType = var_2_10000

		if var_2_10000.IsTypeQuZhu(var_226_1) then
			var_226_0 = "SubTorpedoUI"
		end

		return
	end
	TeamType = var_7
	var_226_3[var_7.Submarine] = function()
		local var_229_0 = arg_226_0
		local var_229_1 = var_0.getNation(var_229_0)

		Nation = var_2_10001

		if var_229_1 == var_2_10001.MOT then
			var_226_0 = "CannonUI"
		else
			var_226_0 = "SubTorpedoUI"
		end

		return
	end

	var_1_10003(var_226_2, var_226_3)

	return var_226_0
end

function var_0_1.IsDefaultSkin(arg_230_0)
	return arg_230_0:getSkinId() == 0 or var_1 == arg_230_0:getConfig("skin_id")
end

function var_0_1.IsMatchKey(arg_231_0, arg_231_1)
	if not arg_231_1 or arg_231_1 == "" then
		return true
	end

	string = var_1_10002

	local var_231_0 = var_1_10002.lower

	string = var_1_10004
	arg_231_1 = var_231_0(var_1_10004.gsub(arg_231_1, "%.", "%%."))
	pg = var_2

	local var_231_1 = var_2._ship_data_statistics[arg_231_0.configId].name
	local var_231_2 = arg_231_0:getName()
	local var_231_3 = {
		var_231_1,
		arg_231_0:GetDefaultName(),
		var_231_2
	}

	underscore = var_5

	return var_5.any(var_231_3, function(arg_232_0)
		string = var_2_10001

		local var_232_0 = var_2_10001.find

		string = var_2_10003

		return var_232_0(var_2_10003.lower(arg_232_0), arg_231_1)
	end)
end

function var_0_1.IsOwner(arg_233_0)
	tobool = var_1_10001

	return var_1_10001(arg_233_0.id)
end

function var_0_1.GetUniqueId(arg_234_0)
	return arg_234_0.id
end

function var_0_1.ShowPropose(arg_235_0)
	if not arg_235_0.propose then
		do return false end

		goto label_235_1
	end

	HXSet = var_1

	if var_1.isHxPropose() then
		do
			local var_235_0

			if arg_235_0:IsOwner() then
				var_235_0 = arg_235_0:GetUniqueId()
				getProxy = var_1_10002
				PlayerProxy = var_1_10004

				local var_235_1 = var_1_10002(var_1_10004)
				local var_235_2 = var_2.getRawData(var_235_1)

				if var_235_0 ~= var_2.GetProposeShipId(var_235_2) then
					var_235_0 = false

					goto label_235_0
				end

				var_235_0 = true
			end

			::label_235_0::

			return var_235_0
		end

		::label_235_1::

		return
	end
end

function var_0_1.GetColorName(arg_236_0, arg_236_1)
	arg_236_1 = arg_236_1 or arg_236_0:getName()
	PlayerPrefs = var_1_10002

	local var_236_0 = var_1_10002.GetInt
	local var_236_1 = "SHIP_NAME_COLOR"

	PLATFORM_CODE = var_1_10005
	PLATFORM_CH = var_1_10006

	if var_236_0(var_236_1, var_1_10005 == var_1_10006 and 1 or 0) == 1 and arg_236_0.propose then
		setColorStr = var_2

		return var_2(arg_236_1, "#FFAACEFF")
	else
		return arg_236_1
	end

	return
end

local var_0_24 = {
	effect = {
		"duang_meta_jiehun",
		"duang_6_jiehun_tuzhi",
		"duang_6_jiehun",
		"duang_meta_%s",
		"duang_6"
	},
	frame = {
		"prop4_1",
		"prop%s",
		"prop"
	}
}

function var_0_1.GetFrameAndEffect(arg_237_0, arg_237_1)
	tobool = var_1_10002
	arg_237_1 = var_1_10002(arg_237_1)

	local var_237_0
	local var_237_1

	if arg_237_0.propose then
		if arg_237_0:isMetaShip() then
			string = var_4
			var_237_1 = var_4.format(var_0_24.effect[1])
			string = var_4
			var_237_0 = var_4.format(var_0_24.frame[1])
		elseif arg_237_0:isBluePrintShip() then
			string = var_4
			var_237_1 = var_4.format(var_0_24.effect[2])
			string = var_4
			var_237_0 = var_4.format(var_0_24.frame[2], arg_237_0:rarity2bgPrint())
		else
			string = var_4
			var_237_1 = var_4.format(var_0_24.effect[3])
			string = var_4
			var_237_0 = var_4.format(var_0_24.frame[3])
		end

		if not arg_237_0:ShowPropose() then
			var_237_0 = nil
		end
	elseif arg_237_0:isMetaShip() then
		string = var_4
		var_237_1 = var_4.format(var_0_24.effect[4], arg_237_0:rarity2bgPrint())
	else
		local var_237_2 = arg_237_0:getRarity()

		ShipRarity = var_1_10005

		if var_237_2 == var_1_10005.SSR then
			string = var_237_2
			var_237_1 = var_237_2.format(var_0_24.effect[5])
		end
	end

	if arg_237_1 then
		var_237_1 = var_237_1 and var_237_1 .. "_1"
	end

	return var_237_0, var_237_1
end

function var_0_1.GetRecordPosKey(arg_238_0)
	return arg_238_0:getSkinId()
end

function var_0_1.GetShipPhantomMark(arg_239_0, arg_239_1)
	ShipPhantom = var_1_10002

	return var_1_10002.PackMark(arg_239_0.id, arg_239_1)
end

function var_0_1.GetSelectMark(arg_240_0)
	return arg_240_0.id
end

return var_0_1
