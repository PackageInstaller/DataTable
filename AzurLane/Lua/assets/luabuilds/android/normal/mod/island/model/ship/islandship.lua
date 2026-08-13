class = var_0_10000

local var_0_0 = "IslandShip"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

var_0_1.STATE_NORMAL = 0
var_0_1.STATE_DELEGATION = 1
var_0_1.STATE_TECHNOLOGY = 2
var_0_1.STATE_RESTAURANT = 3

function var_0_1.Ctor(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1.id then
		var_1_0 = 0
	end

	arg_1_0.id = var_1_0
	arg_1_0.configId = arg_1_0.id

	local var_1_1

	if not arg_1_1.exp then
		var_1_1 = 0
	end

	arg_1_0.exp = var_1_1

	local var_1_2

	if not arg_1_1.lv then
		var_1_2 = 1
	end

	arg_1_0.level = var_1_2

	local var_1_3

	if not arg_1_1.break_lv then
		var_1_3 = 0
	end

	arg_1_0.breakLevel = var_1_3

	local var_1_4

	if not arg_1_1.power then
		var_1_4 = 0
	end

	arg_1_0.energy = var_1_4

	local var_1_5

	if not arg_1_1.recover_time then
		var_1_5 = 0
	end

	arg_1_0.recorverTime = var_1_5

	local var_1_6

	if not arg_1_1.up_limit_state then
		var_1_6 = 0
	end

	arg_1_0.unlockExtraAttLimit = var_1_6 == 1
	arg_1_0.extraAttrs = {}
	ipairs = var_2

	local var_1_7

	if not arg_1_1.extra_attr_list then
		var_1_7 = {}
	end

	for iter_1_0, iter_1_1 in var_2(var_1_7) do
		IslandShipAttr = var_1_10007
		var_1_10007 = var_1_10007.GetAtrrName(iter_1_1.id)
		arg_1_0.extraAttrs[var_1_10007] = iter_1_1.value
	end

	IslandShipSkill = var_2

	local var_1_8 = var_2.New
	local var_1_9 = {
		id = arg_1_0:getConfig("skill_id")
	}
	local var_1_10

	if not arg_1_1.skill_lv then
		var_1_10 = 0
	end

	var_1_9.level = var_1_10

	local var_1_11

	if not arg_1_1.skill_use_state then
		var_1_11 = 0
	end

	var_1_9.isUseToday = var_1_11 == 1
	arg_1_0.skill = var_1_8(var_1_9)
	arg_1_0.maxEnerey = arg_1_0:getConfig("power")

	arg_1_0:InitMaxEnergy()

	arg_1_0.maxLevel = 1

	arg_1_0:InitMaxLevel()

	arg_1_0.attrs = {}

	arg_1_0:InitAttrs()

	arg_1_0.maxExtraAttrs = {}

	arg_1_0:InitMaxExtraAttrs()
	arg_1_0:InitSkill()

	arg_1_0.status = {}
	ipairs = var_2

	local var_1_12

	if not arg_1_1.buff_list then
		var_1_12 = {}
	end

	for iter_1_2, iter_1_3 in var_2(var_1_12) do
		IslandShipStatus = var_1_10007
		var_1_10007 = var_1_10007.New(iter_1_3)
		table = var_8

		var_8.insert(arg_1_0.status, var_1_10007)
	end

	arg_1_0:InitEnergyRecoverTime()

	local var_1_13

	if not arg_1_1.work_place then
		var_1_13 = {}
	end

	local var_1_14

	if not var_1_13.type then
		var_1_14 = 0
	end

	arg_1_0.state = var_1_14

	local var_1_15

	if not var_1_13.place then
		var_1_15 = 0
	end

	arg_1_0.stateId = var_1_15
	arg_1_0.cur_skin_id = arg_1_1.cur_skin_id

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.island_chara_template
end

function var_0_1.GetCantFollowTaskIdList(arg_3_0)
	return arg_3_0:getConfig("in_task")
end

function var_0_1.GetLevel(arg_4_0)
	local var_4_0

	if not arg_4_0.level then
		var_4_0 = 1
	end

	return var_4_0
end

function var_0_1.GetExp(arg_5_0)
	local var_5_0

	if not arg_5_0.exp then
		var_5_0 = 0
	end

	return var_5_0
end

function var_0_1.AddExp(arg_6_0, arg_6_1)
	if arg_6_0:IsMaxLevel() then
		return
	end

	arg_6_0.exp = arg_6_0.exp + arg_6_1

	while arg_6_0:CanUpgrade() do
		arg_6_0.exp = arg_6_0.exp - arg_6_0:GetTargetExp()
		arg_6_0.level = arg_6_0.level + 1

		arg_6_0:InitAttrs()
	end

	if arg_6_0:IsMaxLevel() then
		arg_6_0.exp = 0
	end

	return
end

function var_0_1.CanUpgrade(arg_7_0)
	return not arg_7_0:IsMaxLevel() and arg_7_0.exp >= arg_7_0:GetTargetExp()
end

function var_0_1.GetTargetExp(arg_8_0)
	if arg_8_0:IsMaxLevel() then
		return 0
	end

	pg = var_1

	return var_1.island_chara_level[arg_8_0.level].level_up_exp
end

function var_0_1.IsMaxLevel(arg_9_0)
	return arg_9_0.level >= arg_9_0.maxLevel
end

function var_0_1.InitMaxLevel(arg_10_0)
	arg_10_0.maxLevel = arg_10_0:GetBreakLevel() * arg_10_0:GetBreakPhaseValue()

	return
end

function var_0_1.GetMaxLevel(arg_11_0)
	return arg_11_0.maxLevel
end

function var_0_1.GetEnergy(arg_12_0)
	return arg_12_0.energy
end

function var_0_1.AddEnergy(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.energy + arg_13_1

	if arg_13_0:GetMaxEnergy() < var_13_0 then
		arg_13_0.energy = var_3
	else
		arg_13_0.energy = var_13_0
	end

	return
end

function var_0_1.UpdateEnergy(arg_14_0, arg_14_1)
	arg_14_0.energy = arg_14_1

	return
end

function var_0_1.UpdateEnergyBeginRecoverTime(arg_15_0, arg_15_1)
	arg_15_0.recorverTime = arg_15_1

	return
end

function var_0_1.GetMaxEnergy(arg_16_0)
	return arg_16_0.maxEnerey
end

function var_0_1.InitMaxEnergy(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.maxEnerey
	local var_17_1, var_17_2 = arg_17_0:GetBreakLevel(), arg_17_0:getConfig("upgrade_power")
	local var_17_3 = arg_17_0:getConfig("power")
	local var_17_4 = 0

	for iter_17_0 = 1, var_17_1 do
		local var_17_5

		if not var_17_2[iter_17_0] then
			var_17_5 = 0
		end

		var_17_4 = var_17_4 + var_17_5
	end

	arg_17_0.maxEnerey = var_17_3 + var_17_4

	if not arg_17_1 then
		return
	end

	if arg_17_0.maxEnerey - var_17_0 > 0 then
		local var_17_6 = var_17_0 - arg_17_0.energy

		arg_17_0.energy = arg_17_0.maxEnerey - var_17_6
	end

	return
end

function var_0_1.InitEnergyRecoverTime(arg_18_0)
	arg_18_0.recoverSpeed = arg_18_0:getConfig("power_recover")

	return
end

function var_0_1.GetSkillAddRecoverSpeed(arg_19_0)
	local var_19_0 = 0

	if arg_19_0.skill then
		local var_19_1 = arg_19_0.skill
		local var_19_2 = var_2.GetUnlockShipEffectIds(var_19_1)

		ipairs = var_19_1

		for iter_19_0, iter_19_1 in var_19_1(var_19_2) do
			pg = var_1_10008

			local var_19_3 = var_1_10008.island_buff_template[iter_19_1].buff_type

			IslandBuffType = var_1_10010

			if var_19_3 == var_1_10010.SHIP_POWER_RECOVER then
				var_19_0 = var_19_0 + var_1_10008.type_use[1]
			end
		end
	end

	return var_19_0
end

function var_0_1.GetCurrentEnergy(arg_20_0)
	if arg_20_0:GetState() ~= var_0_1.STATE_NORMAL then
		math = var_1

		return var_1.min(arg_20_0.maxEnerey, arg_20_0.energy)
	end

	pg = var_1

	local var_20_0 = var_1.TimeMgr.GetInstance()
	local var_20_1 = var_1.GetServerTime(var_20_0)

	math = var_20_0

	local var_20_2 = var_20_0.floor(arg_20_0.energy + (var_20_1 - arg_20_0.recorverTime) / arg_20_0.recoverSpeed)
	local var_20_3 = arg_20_0:GetSkillAddRecoverSpeed()

	if 0 < var_20_3 then
		math = var_4

		local var_20_4 = var_4.floor((var_20_1 - arg_20_0.recorverTime) / arg_20_0.recoverSpeed)

		math = var_5
		var_20_2 = var_20_2 + var_5.floor(var_20_4 * var_20_3 * 0.01)
	end

	local var_20_5 = arg_20_0
	local var_20_6 = arg_20_0.GetVaildStatusByType

	IslandBuffType = var_1_10006

	if #var_20_6(var_20_5, var_1_10006.SHIP_POWER_RECOVER) == 0 then
		math = var_5

		return var_5.min(arg_20_0.maxEnerey, var_20_2)
	end

	local function var_20_7(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
		math = var_2_10004

		local var_21_0 = var_2_10004.max(arg_21_0, arg_21_2)

		math = var_5

		if var_21_0 < var_5.min(arg_21_1, arg_21_3) then
			return var_5 - var_21_0
		else
			return 0
		end

		return
	end

	local var_20_8 = var_4:GetBuffEffect()[1] * 0.01
	local var_20_9 = var_20_7(arg_20_0.recorverTime, var_20_1, var_4:GetStartTime(), var_4:GetEndTime())

	math = var_8

	local var_20_10 = var_20_2 + var_8.floor(var_20_9 / arg_20_0.recoverSpeed * var_20_8)

	math = var_9

	return var_9.min(arg_20_0.maxEnerey, var_20_10)
end

function var_0_1.GetCurrentEnergyDecimal(arg_22_0)
	pg = var_1_10001

	local var_22_0 = var_1_10001.TimeMgr.GetInstance()
	local var_22_1 = var_1.GetServerTime(var_22_0)
	local var_22_2 = arg_22_0.energy + (var_22_1 - arg_22_0.recorverTime) / arg_22_0.recoverSpeed
	local var_22_3 = arg_22_0
	local var_22_4 = arg_22_0.GetVaildStatusByType

	IslandBuffType = var_1_10005

	local var_22_5 = var_22_4(var_22_3, var_1_10005.SHIP_POWER_RECOVER)

	if arg_22_0:GetSkillAddRecoverSpeed() > 0 then
		var_22_2 = var_22_2 + (var_22_1 - arg_22_0.recorverTime) / arg_22_0.recoverSpeed * var_4 * 0.01
	end

	if #var_22_5 == 0 then
		math = var_5

		return var_5.min(arg_22_0.maxEnerey, var_22_2)
	end

	local function var_22_6(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
		math = var_2_10004

		local var_23_0 = var_2_10004.max(arg_23_0, arg_23_2)

		math = var_5

		if var_23_0 < var_5.min(arg_23_1, arg_23_3) then
			return var_5 - var_23_0
		else
			return 0
		end

		return
	end

	local var_22_7 = var_22_5:GetBuffEffect()[1] * 0.01
	local var_22_8 = var_22_2 + var_22_6(arg_22_0.recorverTime, var_22_1, var_22_5:GetStartTime(), var_22_5:GetEndTime()) / arg_22_0.recoverSpeed * var_22_7

	math = var_9

	return var_9.min(arg_22_0.maxEnerey, var_22_8)
end

function var_0_1.GetEnergyMaxTime(arg_24_0)
	pg = var_1_10001

	local var_24_0 = var_1_10001.TimeMgr.GetInstance()
	local var_24_1 = var_1.GetServerTime(var_24_0)
	local var_24_2 = arg_24_0.maxEnerey - arg_24_0:GetCurrentEnergyDecimal()
	local var_24_3 = arg_24_0
	local var_24_4 = arg_24_0.GetVaildStatusByType

	IslandBuffType = var_1_10005

	local var_24_5 = var_24_4(var_24_3, var_1_10005.SHIP_POWER_RECOVER)
	local var_24_6 = arg_24_0:GetSkillAddRecoverSpeed()
	local var_24_7 = arg_24_0.recoverSpeed / (1 + var_24_6 * 0.01)

	if #var_24_5 == 0 then
		math = var_6

		return var_24_1 + var_6.floor(var_24_2 * var_24_7)
	end

	local var_24_8

	if var_24_1 <= var_24_5:GetEndTime() then
		var_24_8 = var_24_5:GetEndTime() - var_24_1

		if var_24_2 <= var_24_7 / (1 + var_24_5:GetBuffEffect()[1] * 0.01) * var_24_8 then
			math = var_1_10010

			return var_24_1 + var_1_10010.floor(var_24_2 / var_8)
		end

		local var_24_9 = var_24_2 - var_9

		math = var_1_10011

		local var_24_10 = var_24_1 + var_1_10011.floor(var_24_9 / var_24_7)

		math = var_1_10013

		return var_24_10 + var_1_10013.floor(var_24_2 / var_8)
	end

	math = var_24_8

	return var_24_1 + var_24_8.floor(var_24_2 * var_24_7)
end

function var_0_1.AnySkillCanUpgrade(arg_25_0)
	return arg_25_0:CanUpgradeSkill()
end

function var_0_1.HasStatus(arg_26_0)
	table = var_1_10001

	return var_1_10001.getCount(arg_26_0:GetVaildStatus()) > 0
end

function var_0_1.GetPower(arg_27_0)
	local var_27_0 = arg_27_0:GetLevel() * 1000000
	local var_27_1 = 0

	pairs = var_1_10003

	for iter_27_0, iter_27_1 in var_1_10003(arg_27_0:GetAttrs()) do
		var_27_1 = var_27_1 + iter_27_1
	end

	return var_27_0 + var_27_1
end

function var_0_1.GetName(arg_28_0)
	return arg_28_0:getConfig("name")
end

function var_0_1.GetEnName(arg_29_0)
	local var_29_0 = arg_29_0
	local var_29_1 = arg_29_0.GetModelUnit(var_29_0)

	pg = var_29_0

	return var_29_0.island_unit_character[var_29_1].english_name
end

function var_0_1.StaticGetName(arg_30_0)
	pg = var_1_10001

	return var_1_10001.island_chara_template[arg_30_0].name
end

function var_0_1.GetPrefab(arg_31_0)
	return var_0_1.StaticGetPrefab(arg_31_0.configId)
end

function var_0_1.GetModelUnit(arg_32_0)
	local var_32_0 = arg_32_0:getConfig("unit_id")

	if arg_32_0.cur_skin_id and arg_32_0.cur_skin_id ~= 0 then
		pg = var_2
		var_32_0 = var_2.island_skin_template[arg_32_0.cur_skin_id].model
		getProxy = var_2
		IslandProxy = var_3

		local var_32_1 = var_2(var_3)
		local var_32_2 = var_2.GetIsland(var_32_1)
		local var_32_3 = var_2.GetCharacterAgency(var_32_2)

		if var_3.GetCurrentSkinColorByShipId(var_32_3, arg_32_0.id, arg_32_0.cur_skin_id) ~= 0 then
			pg = var_32_3
			var_32_0 = var_32_3.island_skin_colordiff_template[var_4].model
		end
	end

	return var_32_0
end

function var_0_1.GetCurrentSkinId(arg_33_0)
	local var_33_0

	if not arg_33_0.cur_skin_id then
		var_33_0 = 0
	end

	return var_33_0
end

function var_0_1.GetModel(arg_34_0)
	local var_34_0 = arg_34_0
	local var_34_1 = arg_34_0.GetModelUnit(var_34_0)

	pg = var_34_0

	local var_34_2 = var_34_0.island_unit_character[var_34_1].personal_ani

	return {
		model = var_2.model,
		animator = var_2.animator,
		personal_ani = var_34_2
	}
end

function var_0_1.GetModelBySkinAndColorId(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_0
	local var_35_1 = arg_35_0.getConfig(var_35_0, "unit_id")

	if arg_35_1 and arg_35_1 ~= 0 then
		pg = var_35_0
		var_35_1 = var_35_0.island_skin_template[arg_35_1].model

		if arg_35_2 ~= 0 then
			pg = var_4
			var_35_1 = var_4.island_skin_colordiff_template[arg_35_2].model
		end
	end

	return var_35_1
end

function var_0_1.ChangeSkinId(arg_36_0, arg_36_1)
	if arg_36_0.cur_skin_id ~= arg_36_1 then
		arg_36_0.cur_skin_id = arg_36_1
	end

	return
end

function var_0_1.GetCurSkinId(arg_37_0)
	local var_37_0

	if not arg_37_0.cur_skin_id then
		var_37_0 = 0
	end

	return var_37_0
end

function var_0_1.GetNewShipWord(arg_38_0)
	return ""
end

function var_0_1.GetShipGroup(arg_39_0)
	return arg_39_0.configId
end

function var_0_1.StaticGetPrefab(arg_40_0)
	pg = var_1_10001

	local var_40_0 = var_1_10001.island_chara_template[arg_40_0].unit_id

	pg = var_1_10003

	return var_1_10003.island_unit_character[var_40_0].IslandShipIcon
end

function var_0_1.UpdateState(arg_41_0, arg_41_1, arg_41_2)
	arg_41_0.state = arg_41_1
	arg_41_0.stateId = arg_41_2

	return
end

function var_0_1.GetState(arg_42_0)
	pg = var_1_10001

	local var_42_0 = var_1_10001.TimeMgr.GetInstance()

	if var_1.GetServerTime(var_42_0) >= arg_42_0.recorverTime then
		return var_0_1.STATE_NORMAL
	end

	return arg_42_0.state
end

function var_0_1.GetStateId(arg_43_0)
	return arg_43_0.stateId
end

function var_0_1.GetStatePlaceName(arg_44_0)
	switch = var_1_10001

	return var_1_10001(arg_44_0.state, {
		[var_0_1.STATE_DELEGATION] = function()
			pg = var_2_10000

			return var_2_10000.island_production_place[arg_44_0.stateId].name
		end,
		[var_0_1.STATE_TECHNOLOGY] = function()
			pg = var_2_10000

			return var_2_10000.island_production_place[arg_44_0.stateId].name
		end,
		[var_0_1.STATE_RESTAURANT] = function()
			pg = var_2_10000

			return var_2_10000.island_manage_restaurant[arg_44_0.stateId].name
		end
	}, function()
		return ""
	end)
end

function var_0_1.IsDelegable(arg_49_0)
	local var_49_3

	if arg_49_0:GetState() == var_0_1.STATE_NORMAL then
		getProxy = var_1
		IslandProxy = var_2

		local var_49_0 = var_1(var_2)
		local var_49_1 = var_1.GetIsland(var_49_0)
		local var_49_2 = var_1.GetFollowerAgency(var_49_1)

		var_49_3 = not var_1.Following(var_49_2, arg_49_0.id)
	else
		var_49_3 = false
	end

	if false then
		var_49_3 = true
	end

	return var_49_3
end

function var_0_1.GetBreakLevel(arg_50_0)
	return arg_50_0.breakLevel
end

function var_0_1.GetBreakMaxLevel(arg_51_0)
	return arg_51_0:getConfig("upgrade_level")[2] + 1
end

function var_0_1.GetBreakPhaseValue(arg_52_0)
	return arg_52_0:getConfig("upgrade_level")[1]
end

function var_0_1.IsMaxBreakLevel(arg_53_0)
	return arg_53_0:GetBreakMaxLevel() <= arg_53_0:GetBreakLevel()
end

function var_0_1.CanBreakOut(arg_54_0)
	if arg_54_0:IsMaxBreakLevel() then
		return false
	end

	local var_54_0 = arg_54_0:GetBreakPhaseValue()

	return arg_54_0.level % var_54_0 == 0
end

function var_0_1.UpgradeBreakOut(arg_55_0)
	arg_55_0.breakLevel = arg_55_0.breakLevel + 1

	arg_55_0:InitMaxLevel()

	local var_55_0 = arg_55_0:GetMaxEnergy() - arg_55_0:GetEnergy()

	arg_55_0:InitMaxEnergy(true)

	if var_1 < arg_55_0:GetMaxEnergy() then
		arg_55_0.energy = var_4 - var_55_0
	end

	arg_55_0:InitSkill()

	return
end

function var_0_1.GetBreakoutMatrials(arg_56_0)
	local var_56_0 = arg_56_0:getConfig("upgrade_material")
	local var_56_1 = {}
	local var_56_2

	if not var_56_0[arg_56_0:GetBreakLevel()] then
		var_56_2 = {}
	end

	ipairs = var_1_10005

	for iter_56_0, iter_56_1 in var_1_10005(var_56_2) do
		table = var_1_10010
		var_1_10010 = var_1_10010.insert

		local var_56_3 = var_56_1
		local var_56_4 = {}

		DROP_TYPE_ISLAND_ITEM = var_1_10013
		var_56_4.type = var_1_10013
		var_56_4.id = iter_56_1[1]
		var_56_4.count = iter_56_1[2]

		var_1_10010(var_56_3, var_56_4)
	end

	return var_56_1
end

function var_0_1.InitAttrs(arg_57_0)
	local var_57_0 = arg_57_0
	local var_57_1 = arg_57_0.GetBreakPhaseValue(var_57_0)

	math = var_57_0

	local var_57_2 = var_57_0.floor(arg_57_0.level / var_57_1)
	local var_57_3 = arg_57_0.level % var_57_1
	local var_57_4 = arg_57_0
	local var_57_5 = arg_57_0.getConfig(var_57_4, "base_att")

	ipairs = var_57_4

	for iter_57_0, iter_57_1 in var_57_4(var_57_5) do
		local var_57_6 = iter_57_1[1]
		local var_57_7 = iter_57_1[2]

		IslandShipAttr = var_1_10012
		var_1_10012 = var_1_10012.GetAtrrName(var_57_6)
		var_1_10013 = arg_57_0.attrs
		var_1_10013[var_1_10012] = var_57_7
	end

	local var_57_8 = arg_57_0
	local var_57_9 = arg_57_0.getConfig(var_57_8, "growth_att")

	ipairs = var_57_8

	for iter_57_2, iter_57_3 in var_57_8(var_57_9) do
		local var_57_10 = iter_57_3[1]

		var_1_10012 = iter_57_3[2]
		IslandShipAttr = var_1_10013
		var_1_10013 = var_1_10013.GetAtrrName(var_57_10)

		local var_57_11 = 0

		for iter_57_4 = 1, var_57_2 do
			var_57_11 = var_57_11 + var_1_10012[iter_57_4] * var_57_1
		end

		if var_57_2 < #var_1_10012 then
			var_57_11 = var_57_11 + var_1_10012[var_57_2 + 1] * var_57_3
		end

		arg_57_0.attrs[var_1_10013] = arg_57_0.attrs[var_1_10013] + var_57_11
	end

	pairs = var_6

	for iter_57_5, iter_57_6 in var_6(arg_57_0.extraAttrs) do
		arg_57_0.attrs[iter_57_5] = arg_57_0.attrs[iter_57_5] + iter_57_6
	end

	pairs = var_6

	for iter_57_7, iter_57_8 in var_6(arg_57_0.attrs) do
		local var_57_12 = arg_57_0.attrs

		math = var_1_10012
		var_57_12[iter_57_7] = var_1_10012.floor(iter_57_8)
	end

	return
end

function var_0_1.GetGrowthAtt(arg_58_0)
	local var_58_0 = {}
	local var_58_1 = arg_58_0
	local var_58_2 = arg_58_0.getConfig(var_58_1, "growth_att")

	ipairs = var_58_1

	for iter_58_0, iter_58_1 in var_58_1(var_58_2) do
		local var_58_3 = iter_58_1[1]
		local var_58_4 = iter_58_1[2]

		IslandShipAttr = var_1_10010
		var_1_10010 = var_1_10010.GetAtrrName(var_58_3)

		local var_58_5

		if not var_58_4[arg_58_0:GetBreakLevel()] then
			var_58_5 = 0
		end

		var_58_0[var_1_10010] = var_58_5
	end

	return var_58_0
end

function var_0_1.GetAttrs(arg_59_0)
	return arg_59_0.attrs
end

function var_0_1.GetAttr(arg_60_0, arg_60_1)
	local var_60_0

	if not arg_60_0.attrs[arg_60_1] then
		var_60_0 = 0
	end

	return var_60_0
end

function var_0_1.GetAttrGradeCnt(arg_61_0, arg_61_1)
	local var_61_0 = 0

	pairs = var_1_10003

	for iter_61_0, iter_61_1 in var_1_10003(arg_61_0.attrs) do
		if arg_61_1 >= arg_61_0:GetAttrGrade(iter_61_0) then
			var_61_0 = var_61_0 + 1
		end
	end

	return var_61_0
end

function var_0_1.GetAttrGradeByValue(arg_62_0, arg_62_1)
	pg = var_1_10002

	local var_62_0 = var_1_10002.island_chara_att.all

	pg = var_1_10003

	local var_62_1 = var_62_0[#var_1_10003.island_chara_att.all]

	ipairs = var_3
	pg = var_1_10004

	for iter_62_0, iter_62_1 in var_3(var_1_10004.island_chara_att.all) do
		pg = var_1_10008

		local var_62_2 = var_1_10008.island_chara_att[iter_62_1].range[1]
		local var_62_3 = var_1_10008.range[2]

		if var_62_2 <= arg_62_1 and arg_62_1 <= var_62_3 then
			var_62_1 = iter_62_1

			break
		end
	end

	return var_62_1
end

function var_0_1.GetAttrGrade(arg_63_0, arg_63_1)
	local var_63_0 = arg_63_0:GetAttr(arg_63_1)

	return arg_63_0:GetAttrGradeByValue(var_63_0)
end

function var_0_1.GetAttrGradeName(arg_64_0, arg_64_1)
	local var_64_0 = arg_64_0
	local var_64_1 = arg_64_0.GetAttrGrade(var_64_0, arg_64_1)

	pg = var_64_0

	return var_64_0.island_chara_att[var_64_1].name
end

function var_0_1.GetAttrGradeEffect(arg_65_0, arg_65_1)
	local var_65_0 = arg_65_0
	local var_65_1 = arg_65_0.GetAttrGrade(var_65_0, arg_65_1)

	pg = var_65_0

	return var_65_0.island_chara_att[var_65_1].effect
end

function var_0_1.SetUnlockExtraAttLimit(arg_66_0)
	arg_66_0.unlockExtraAttLimit = true

	arg_66_0:InitMaxExtraAttrs()

	return
end

function var_0_1.IsUnlockExtraAttLimit(arg_67_0)
	return arg_67_0.unlockExtraAttLimit
end

function var_0_1.InitMaxExtraAttrs(arg_68_0)
	ipairs = var_1_10001

	for iter_68_0, iter_68_1 in var_1_10001(arg_68_0:getConfig("extra_max")) do
		local var_68_0 = iter_68_1[1]
		local var_68_1 = iter_68_1[2][1]
		local var_68_2 = iter_68_1[2][2]
		local var_68_3 = arg_68_0.unlockExtraAttLimit and var_68_2 or var_68_1

		IslandShipAttr = var_1_10010
		var_1_10010 = var_1_10010.GetAtrrName(var_68_0)
		arg_68_0.maxExtraAttrs[var_1_10010] = var_68_3
	end

	return
end

function var_0_1.GetExtraAttrLimit(arg_69_0, arg_69_1)
	local var_69_0

	if not arg_69_0.maxExtraAttrs[arg_69_1] then
		var_69_0 = 0
	end

	return var_69_0
end

function var_0_1.GetExtraAttrValue(arg_70_0, arg_70_1)
	local var_70_0

	if not arg_70_0.extraAttrs[arg_70_1] then
		var_70_0 = 0
	end

	return var_70_0
end

function var_0_1.ExistPotency(arg_71_0)
	pairs = var_1_10001
	IslandShipAttr = var_1_10002

	for iter_71_0, iter_71_1 in var_1_10001(var_1_10002.ATTRS) do
		if arg_71_0:GetExtraAttrLimit(iter_71_1) > arg_71_0:GetExtraAttrValue(iter_71_1) then
			return true
		end
	end

	return false
end

function var_0_1.AddExtraAttr(arg_72_0, arg_72_1, arg_72_2)
	local var_72_0 = arg_72_0:GetExtraAttrLimit(arg_72_1)
	local var_72_1 = arg_72_0:GetExtraAttrValue(arg_72_1) + arg_72_2
	local var_72_2 = arg_72_0.extraAttrs

	math = var_6
	var_72_2[arg_72_1] = var_6.min(var_72_1, var_72_0)

	arg_72_0:InitAttrs()

	return
end

function var_0_1.GetUpgradeExtraAttrConsume(arg_73_0, arg_73_1)
	table = var_1_10002

	local var_73_0 = var_1_10002.indexof

	IslandShipAttr = var_1_10003

	if var_73_0(var_1_10003.ATTRS, arg_73_1) <= 0 then
		return {}
	end

	local var_73_1 = arg_73_0:getConfig("att_item")
	local var_73_2 = {}

	ipairs = var_5

	local var_73_3

	if not var_73_1[var_2] then
		var_73_3 = {}
	end

	for iter_73_0, iter_73_1 in var_5(var_73_3) do
		table = var_1_10010
		var_1_10010 = var_1_10010.insert

		local var_73_4 = var_73_2
		local var_73_5 = {
			count = 1
		}

		DROP_TYPE_ISLAND_ITEM = var_1_10013
		var_73_5.type = var_1_10013
		var_73_5.id = iter_73_1

		var_1_10010(var_73_4, var_73_5)
	end

	return var_73_2
end

function var_0_1.GetExtraAttrLimitUnlockConsume(arg_74_0)
	local var_74_0 = {}
	local var_74_1 = {
		id = 100000,
		count = 1
	}

	DROP_TYPE_ISLAND_ITEM = var_1_10003
	var_74_1.type = var_1_10003
	var_74_0[1] = var_74_1

	return var_74_0
end

function var_0_1.InitSkill(arg_75_0)
	if arg_75_0:getConfig("skill_unlock") <= arg_75_0:GetBreakLevel() then
		local var_75_0 = arg_75_0.skill

		var_3.Unlock(var_75_0)
	end

	return
end

function var_0_1.GetSkillUnlockLevel(arg_76_0)
	return arg_76_0:getConfig("skill_unlock")
end

function var_0_1.GetSkill(arg_77_0)
	return arg_77_0.skill
end

function var_0_1.CanUpgradeSkill(arg_78_0)
	local var_78_0 = arg_78_0.skill

	if not var_1.IsUnlock(var_78_0) then
		return false
	end

	local var_78_1 = arg_78_0.skill

	if var_1.IsMaxLevel(var_78_1) then
		return false
	end

	local var_78_2 = arg_78_0.skill
	local var_78_3 = var_1.GetUpgradeMaterial(var_78_2)

	getProxy = var_78_2
	IslandProxy = var_1_10003

	local var_78_4 = var_78_2(var_1_10003)
	local var_78_5 = var_2.GetIsland(var_78_4)
	local var_78_6 = var_2.GetInventoryAgency(var_78_5)

	_ = var_78_5

	return var_78_5.all(var_78_3, function(arg_79_0)
		local var_79_0 = var_78_6

		return var_1.GetOwnCount(var_79_0, arg_79_0.id) >= arg_79_0.count
	end)
end

function var_0_1.HasGreetingSkill(arg_80_0)
	local var_80_0

	if arg_80_0:GetSkill() and var_1:IsUnlock() then
		var_80_0 = var_1:IsGreetingType()
	end

	return var_80_0
end

function var_0_1.ApplySkill(arg_81_0, arg_81_1)
	local var_81_0 = arg_81_0:GetSkill()

	var_2.Apply(var_81_0, arg_81_0, arg_81_1)

	return
end

function var_0_1.GetVaildStatusByGroup(arg_82_0, arg_82_1)
	_ = var_1_10002

	return var_1_10002.select(arg_82_0.status, function(arg_83_0)
		return not arg_83_0:IsExpiration() and arg_83_0:GetGroup() == arg_82_1
	end)
end

function var_0_1.GetVaildStatus(arg_84_0)
	_ = var_1_10001

	return var_1_10001.select(arg_84_0.status, function(arg_85_0)
		return not arg_85_0:IsExpiration()
	end)
end

function var_0_1.GetVaildStatusByType(arg_86_0, arg_86_1)
	_ = var_1_10002

	return var_1_10002.select(arg_86_0.status, function(arg_87_0)
		return not arg_87_0:IsExpiration() and arg_87_0:GetBuffType() == arg_86_1
	end)
end

function var_0_1.GetDisplayStatus(arg_88_0)
	_ = var_1_10001

	return var_1_10001.select(arg_88_0.status, function(arg_89_0)
		return not arg_89_0:IsExpiration() and arg_89_0:CanDisplay()
	end)
end

function var_0_1.GetFavoriteGift(arg_90_0)
	return arg_90_0:getConfig("gift_id")
end

function var_0_1.IsFavoriteGift(arg_91_0, arg_91_1)
	local var_91_0 = arg_91_0
	local var_91_1 = arg_91_0.GetFavoriteGift(var_91_0)

	_ = var_91_0

	return var_91_0.any(var_91_1, function(arg_92_0)
		return arg_92_0 == arg_91_1
	end)
end

function var_0_1.AddStatus(arg_93_0, arg_93_1)
	_ = var_1_10002

	if var_1_10002.detect(arg_93_0.status, function(arg_94_0)
		return arg_94_0.id == arg_93_1.id
	end) then
		table = var_3

		var_3.removebyvalue(arg_93_0.status, var_2)
	end

	local var_93_0 = arg_93_0:GetVaildStatus()
	local var_93_1 = arg_93_1
	local var_93_2 = arg_93_1.GetDuelTypeList(var_93_1)

	_ = var_93_1

	if var_93_1.detect(var_93_0, function(arg_95_0)
		table = var_2_10001

		return var_2_10001.contains(var_93_2, arg_95_0:GetGroup())
	end) then
		table = var_6

		var_6.removebyvalue(arg_93_0.status, var_5)
	end

	local var_93_3 = arg_93_1
	local var_93_4 = arg_93_1.GetDuelIdList(var_93_3)

	_ = var_93_3

	if var_93_3.detect(var_93_0, function(arg_96_0)
		table = var_2_10001

		return var_2_10001.contains(var_93_4, arg_96_0.id)
	end) then
		table = var_8

		var_8.removebyvalue(arg_93_0.status, var_7)
	end

	pg = var_8

	local var_93_5 = var_8.GameTrackerMgr.GetInstance()
	local var_93_6 = var_8.Record

	GameTrackerBuilder = var_1_10010

	var_93_6(var_93_5, var_1_10010.BuildIslandShipAddBuff(arg_93_0.id, arg_93_1.id))

	table = var_93_6

	var_93_6.insert(arg_93_0.status, arg_93_1)

	return
end

return var_0_1
