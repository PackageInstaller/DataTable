class = var_0_10000

local var_0_0 = "Commander"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseVO"))

pg = var_0_10001

local var_0_2 = var_0_10001.commander_level

pg = var_0_0

local var_0_3 = var_0_0.commander_attribute_template
local var_0_4 = 0
local var_0_5 = 1

function var_0_1.rarity2Print(arg_1_0)
	if not var_0_1.prints then
		var_0_1.prints = {
			"n",
			"n",
			"r",
			"sr",
			"ssr"
		}
	end

	return var_0_1.prints[arg_1_0]
end

function var_0_1.rarity2Frame(arg_2_0)
	if not var_0_1.frames then
		var_0_1.frames = {
			"2",
			"2",
			"2",
			"3",
			"4"
		}
	end

	return var_0_1.frames[arg_2_0]
end

function var_0_1.Ctor(arg_3_0, arg_3_1)
	arg_3_0.id = arg_3_1.id

	local var_3_0

	if not arg_3_1.template_id then
		var_3_0 = arg_3_0.id
	end

	arg_3_0.configId = var_3_0
	arg_3_0.level = arg_3_1.level
	arg_3_0.exp = arg_3_1.exp
	arg_3_0.isLock = arg_3_1.is_locked
	arg_3_0.pt = arg_3_1.used_pt

	if arg_3_1.name and arg_3_1.name ~= "" then
		arg_3_0.name = arg_3_1.name
	end

	pg = var_2

	local var_3_1 = var_2.gameset.commander_rename_coldtime.key_value
	local var_3_2

	if not arg_3_1.rename_time then
		var_3_2 = 0
	end

	arg_3_0.renameTime = var_3_2 + var_3_1
	arg_3_0.talentOrigins = {}
	ipairs = var_3

	for iter_3_0, iter_3_1 in var_3(arg_3_1.ability_origin) do
		CommanderTalent = var_1_10008

		local var_3_3 = var_1_10008.New({
			id = iter_3_1
		})

		var_1_10008.setOrigin(var_3_3, var_1_10008)

		table = var_1_10009

		var_1_10009.insert(arg_3_0.talentOrigins, var_1_10008)
	end

	arg_3_0.talents = {}
	ipairs = var_3

	for iter_3_2, iter_3_3 in var_3(arg_3_1.ability) do
		CommanderTalent = var_1_10008
		var_1_10008 = var_1_10008.New({
			id = iter_3_3
		})

		arg_3_0:addTalent(var_1_10008)
	end

	arg_3_0.notLearnedList = {}
	arg_3_0.abilityTime = arg_3_1.ability_time
	arg_3_0.skills = {}
	ipairs = var_3

	for iter_3_4, iter_3_5 in var_3(arg_3_1.skill) do
		CommanderSkill = var_1_10008
		var_1_10008 = var_1_10008.New({
			id = iter_3_5.id,
			exp = iter_3_5.exp
		})
		table = var_1_10009

		var_1_10009.insert(arg_3_0.skills, var_1_10008)
	end

	arg_3_0.abilitys = {}

	arg_3_0:updateAbilitys()

	arg_3_0.maxLevel = var_0_2.all[#var_0_2.all]
	arg_3_0.groupId = arg_3_0:getConfig("group_type")

	local var_3_4

	if not arg_3_1.home_clean_time then
		var_3_4 = 0
	end

	arg_3_0.cleanTime = var_3_4

	local var_3_5

	if not arg_3_1.home_play_time then
		var_3_5 = 0
	end

	arg_3_0.playTime = var_3_5

	local var_3_6

	if not arg_3_1.home_feed_time then
		var_3_6 = 0
	end

	arg_3_0.feedTime = var_3_6

	return
end

function var_0_1.IsRegularTalent(arg_4_0)
	return arg_4_0:getConfig("ability_refresh_type") == var_0_5
end

function var_0_1.getRenameTime(arg_5_0)
	return arg_5_0.renameTime
end

function var_0_1.setRenameTime(arg_6_0, arg_6_1)
	arg_6_0.renameTime = arg_6_1

	return
end

function var_0_1.canModifyName(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_7_0) >= arg_7_0.renameTime
end

function var_0_1.getRenameTimeDesc(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.TimeMgr.GetInstance()
	local var_8_1 = var_1.GetServerTime(var_8_0)
	local var_8_2 = arg_8_0.renameTime

	pg = var_8_0

	local var_8_3 = var_8_0.TimeMgr.GetInstance()
	local var_8_4, var_8_5, var_8_6, var_8_7 = var_3.parseTimeFrom(var_8_3, var_8_2 - var_8_1)

	if var_8_4 < 1 then
		if var_8_5 < 1 then
			local var_8_8 = var_8_6

			i18n = var_1_10008

			return var_8_8 .. var_1_10008("word_minute")
		else
			local var_8_9 = var_8_5

			i18n = var_1_10008

			return var_8_9 .. var_1_10008("word_hour")
		end
	else
		local var_8_10 = var_8_4

		i18n = var_1_10008

		return var_8_10 .. var_1_10008("word_date")
	end

	return
end

function var_0_1.setLock(arg_9_0, arg_9_1)
	assert = var_1_10002
	type = var_1_10004

	var_1_10002(var_1_10004(arg_9_1) == "number")

	arg_9_0.isLock = arg_9_1

	return
end

function var_0_1.getLock(arg_10_0)
	return arg_10_0.isLock
end

function var_0_1.isLocked(arg_11_0)
	return arg_11_0.isLock == 1
end

function var_0_1.bindConfigTable(arg_12_0)
	pg = var_1_10001

	return var_1_10001.commander_data_template
end

function var_0_1.getSkill(arg_13_0, arg_13_1)
	_ = var_1_10002

	return var_1_10002.detect(arg_13_0.skills, function(arg_14_0)
		return arg_14_0.id == arg_13_1
	end)
end

function var_0_1.getSkills(arg_15_0)
	return arg_15_0.skills
end

local function var_0_6(arg_16_0, arg_16_1)
	table = var_1_10002

	var_1_10002.sort(arg_16_1, function(arg_17_0, arg_17_1)
		return arg_17_0.configId < arg_17_1.configId
	end)

	ipairs = var_2

	for iter_16_0, iter_16_1 in var_2(arg_16_1) do
		if arg_16_0:IsLearnedTalent(iter_16_1.id) then
			return iter_16_1
		end
	end

	return arg_16_1[1]
end

function var_0_1.GetDisplayTalents(arg_18_0)
	if arg_18_0:IsRegularTalent() then
		local var_18_0 = {}

		ipairs = var_1_10002

		for iter_18_0, iter_18_1 in var_1_10002(arg_18_0:getConfig("ability_show")) do
			CommanderTalent = var_7

			if not var_18_0[var_7.New({
				id = iter_18_1
			}).groupId] then
				var_18_0[var_7.groupId] = {}
			end

			table = var_8

			var_8.insert(var_18_0[var_7.groupId], var_7)
		end

		local var_18_1 = {}
		local var_18_2 = {}

		pairs = var_4

		for iter_18_2, iter_18_3 in var_4(var_18_0) do
			local var_18_3 = var_0_6(arg_18_0, iter_18_3)

			table = var_1_10010

			var_1_10010.insert(var_18_1, var_18_3)

			var_18_2[var_18_3.id] = arg_18_0:IsLearnedTalent(var_18_3.id)
		end

		table = var_4

		var_4.sort(var_18_1, function(arg_19_0, arg_19_1)
			return (var_18_2[arg_19_0.id] and 1 or 0) > (var_18_2[arg_19_1.id] and 1 or 0)
		end)

		do return var_18_1 end
		return
	end

	return arg_18_0:getTalents()
end

function var_0_1.IsLearnedTalent(arg_20_0, arg_20_1)
	ipairs = var_1_10002

	for iter_20_0, iter_20_1 in var_1_10002(arg_20_0.talents) do
		if iter_20_1.id == arg_20_1 then
			return true
		end
	end

	return false
end

function var_0_1.getTalents(arg_21_0)
	return arg_21_0.talents
end

function var_0_1.getTalentOrigins(arg_22_0)
	return arg_22_0.talentOrigins
end

function var_0_1.addTalent(arg_23_0, arg_23_1)
	_ = var_1_10002

	local var_23_0 = var_1_10002.detect(arg_23_0.talentOrigins, function(arg_24_0)
		return arg_24_0.groupId == arg_23_1.groupId
	end)

	arg_23_1:setOrigin(var_23_0)

	table = var_3

	var_3.insert(arg_23_0.talents, arg_23_1)

	return
end

function var_0_1.deleteTablent(arg_25_0, arg_25_1)
	ipairs = var_1_10002

	for iter_25_0, iter_25_1 in var_1_10002(arg_25_0.talents) do
		if iter_25_1.id == arg_25_1 then
			table = var_7

			var_7.remove(arg_25_0.talents, iter_25_0)

			break
		end
	end

	return
end

function var_0_1.getTalent(arg_26_0, arg_26_1)
	pairs = var_1_10002

	for iter_26_0, iter_26_1 in var_1_10002(arg_26_0.talents) do
		if iter_26_1 == arg_26_1 then
			return iter_26_1
		end
	end

	return
end

function var_0_1.resetTalents(arg_27_0)
	Clone = var_1_10001
	arg_27_0.talents = var_1_10001(arg_27_0.talentOrigins)

	return
end

function var_0_1.getNotLearnedList(arg_28_0)
	return arg_28_0.notLearnedList
end

function var_0_1.updateNotLearnedList(arg_29_0, arg_29_1)
	arg_29_0.notLearnedList = arg_29_1

	return
end

function var_0_1.getResetTalentConsume(arg_30_0)
	pg = var_1_10001

	return var_1_10001.gameset.commander_skill_reset_cost.description[1][arg_30_0.pt]
end

function var_0_1.getTotalPoint(arg_31_0)
	math = var_1_10001

	local var_31_0 = var_1_10001.floor
	local var_31_1 = arg_31_0.level

	CommanderConst = var_1_10004

	local var_31_2 = var_31_0(var_31_1 / var_1_10004.TALENT_POINT_LEVEL)

	CommanderConst = var_1_10002

	return var_31_2 * var_1_10002.TALENT_POINT
end

function var_0_1.getTalentPoint(arg_32_0)
	return arg_32_0:getTotalPoint() - arg_32_0.pt
end

function var_0_1.updatePt(arg_33_0, arg_33_1)
	arg_33_0.pt = arg_33_1

	return
end

function var_0_1.getPt(arg_34_0)
	return arg_34_0.pt
end

function var_0_1.fullTalentCnt(arg_35_0)
	local var_35_0 = #arg_35_0.talents

	CommanderConst = var_1_10002

	return var_35_0 >= var_1_10002.MAX_TELENT_COUNT
end

function var_0_1.hasTalent(arg_36_0, arg_36_1)
	return arg_36_0:getSameGroupTalent(arg_36_1.groupId) ~= nil
end

function var_0_1.getSameGroupTalent(arg_37_0, arg_37_1)
	ipairs = var_1_10002

	for iter_37_0, iter_37_1 in var_1_10002(arg_37_0.talents) do
		if iter_37_1.groupId == arg_37_1 then
			return iter_37_1
		end
	end

	return
end

function var_0_1.getTalentsDesc(arg_38_0)
	local var_38_0 = {}
	local var_38_1 = arg_38_0:getTalents()

	ipairs = var_1_10003

	for iter_38_0, iter_38_1 in var_1_10003(var_38_1) do
		pairs = var_1_10008

		for iter_38_2, iter_38_3 in var_1_10008(iter_38_1:getDesc()) do
			if var_38_0[iter_38_2] then
				var_38_0[iter_38_2].value = var_38_0[iter_38_2].value + iter_38_3.value
			else
				var_38_0[iter_38_2] = {
					name = iter_38_2,
					value = iter_38_3.value,
					type = iter_38_3.type
				}
			end
		end
	end

	return var_38_0
end

function var_0_1.getAbilitys(arg_39_0)
	return arg_39_0.abilitys
end

function var_0_1.updateAbilitys(arg_40_0)
	pg = var_1_10001

	local var_40_0 = var_1_10001.gameset.commander_grow_form_a.key_value

	pg = var_1_10002

	local var_40_1 = var_1_10002.gameset.commander_grow_form_b.key_value

	local function var_40_2(arg_41_0)
		local var_41_0 = arg_40_0
		local var_41_1 = var_1.getConfig(var_41_0, arg_41_0 .. "_value")

		math = var_2_10002

		return var_2_10002.floor(var_41_1 + var_41_1 * (arg_40_0.level - 1) * var_40_0 / var_40_1)
	end

	local var_40_3 = {
		"command",
		"tactic",
		"support"
	}
	local var_40_4 = {
		101,
		102,
		103
	}

	ipairs = var_1_10006

	for iter_40_0, iter_40_1 in var_1_10006(var_40_3) do
		local var_40_5 = var_40_2(iter_40_1)

		arg_40_0.abilitys[iter_40_1] = {
			value = var_40_5,
			id = var_40_4[iter_40_0]
		}
	end

	return
end

function var_0_1.getAbilitysAddition(arg_42_0)
	pg = var_1_10001

	local var_42_0 = var_1_10001.gameset.commander_form_a.key_value

	pg = var_1_10002

	local var_42_1 = var_1_10002.gameset.commander_form_b.key_value

	pg = var_1_10003

	local var_42_2 = var_1_10003.gameset.commander_form_c.key_value

	pg = var_1_10004

	local var_42_3 = var_1_10004.gameset.commander_form_n.key_value

	local function var_42_4(arg_43_0)
		local var_43_0 = 0

		pairs = var_2_10002

		for iter_43_0, iter_43_1 in var_2_10002(arg_42_0.abilitys) do
			if var_0_3[iter_43_1.id]["rate_" .. arg_43_0] and var_7["rate_" .. arg_43_0] / 16 > 0 then
				var_43_0 = var_43_0 + iter_43_1.value * var_8
			end
		end

		tonumber = var_2
		string = var_4

		return var_2(var_4.format("%0.3f", (var_42_0 - var_42_1 / (var_43_0 + var_42_2)) * var_42_3))
	end

	local var_42_5 = {}

	ipairs = var_1_10007
	CommanderConst = var_1_10009

	for iter_42_0, iter_42_1 in var_1_10007(var_1_10009.PROPERTIES) do
		var_42_5[iter_42_1] = var_42_4(iter_42_1)
	end

	return var_42_5
end

function var_0_1.getTalentsAddition(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4)
	local var_44_0 = 0
	local var_44_1 = arg_44_0:getTalents()

	pairs = var_1_10007

	for iter_44_0, iter_44_1 in var_1_10007(var_44_1) do
		local var_44_2, var_44_3 = iter_44_1:getAttrsAddition()
		local var_44_4

		CommanderConst = var_1_10015

		if arg_44_1 == var_1_10015.TALENT_ADDITION_NUMBER then
			var_44_4 = var_44_2
		else
			CommanderConst = var_1_10015

			if arg_44_1 == var_1_10015.TALENT_ADDITION_RATIO then
				var_44_4 = var_44_3
			end
		end

		var_1_10015 = var_44_4[arg_44_2]

		local var_44_5 = true

		if var_1_10015 then
			if #var_1_10015.nation > 0 then
				table = var_17

				if not var_17.contains(var_1_10015.nation, arg_44_3) then
					var_44_5 = false
				end
			end

			if #var_1_10015.shiptype > 0 then
				table = var_17

				if not var_17.contains(var_1_10015.shiptype, arg_44_4) then
					var_44_5 = false
				end
			end
		else
			var_44_5 = false
		end

		if var_44_5 then
			var_44_0 = var_44_0 + var_1_10015.value
		end
	end

	return var_44_0
end

function var_0_1.getAttrRatioAddition(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	table = var_1_10004

	local var_45_0 = var_1_10004.contains

	CommanderConst = var_1_10006

	if var_45_0(var_1_10006.PROPERTIES, arg_45_1) then
		local var_45_1 = arg_45_0:getAbilitysAddition()[arg_45_1]
		local var_45_2 = arg_45_0
		local var_45_3 = arg_45_0.getTalentsAddition

		CommanderConst = var_1_10009

		return var_45_1 + var_45_3(var_45_2, var_1_10009.TALENT_ADDITION_RATIO, arg_45_1, arg_45_2, arg_45_3) / 100
	else
		return 0
	end

	return
end

function var_0_1.getAttrValueAddition(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	table = var_1_10004

	local var_46_0 = var_1_10004.contains

	CommanderConst = var_1_10006

	if var_46_0(var_1_10006.PROPERTIES, arg_46_1) then
		local var_46_1 = arg_46_0
		local var_46_2 = arg_46_0.getTalentsAddition

		CommanderConst = var_7

		return (var_46_2(var_46_1, var_7.TALENT_ADDITION_NUMBER, arg_46_1, arg_46_2, arg_46_3))
	else
		return 0
	end

	return
end

function var_0_1.addExp(arg_47_0, arg_47_1)
	if arg_47_0:isMaxLevel() then
		return
	end

	arg_47_0.exp = arg_47_0.exp + arg_47_1

	while not arg_47_0:isMaxLevel() and arg_47_0:canLevelUp() do
		arg_47_0.exp = arg_47_0.exp - arg_47_0:getNextLevelExp()

		arg_47_0:updateLevel()
	end

	return
end

function var_0_1.ReduceExp(arg_48_0, arg_48_1)
	arg_48_0.exp = arg_48_0.exp - arg_48_1

	while arg_48_0.exp < 0 do
		arg_48_0.level = arg_48_0.level - 1
		arg_48_0.exp = arg_48_0:getNextLevelExp() + arg_48_0.exp
	end

	return
end

function var_0_1.canLevelUp(arg_49_0)
	return arg_49_0.exp >= arg_49_0:getNextLevelExp()
end

function var_0_1.isMaxLevel(arg_50_0)
	return arg_50_0:getMaxLevel() <= arg_50_0.level
end

function var_0_1.getMaxLevel(arg_51_0)
	return arg_51_0.maxLevel
end

function var_0_1.updateLevel(arg_52_0)
	arg_52_0.level = arg_52_0.level + 1

	arg_52_0:updateAbilitys()

	local var_52_0 = arg_52_0.level

	CommanderConst = var_1_10002

	if var_52_0 % var_1_10002.TALENT_POINT_LEVEL == 0 then
		arg_52_0.notLearnedList = {}
	end

	return
end

function var_0_1.getConfigExp(arg_53_0, arg_53_1)
	math = var_1_10002
	arg_53_1 = var_1_10002.max(arg_53_1, 1)

	local var_53_0

	if not var_0_2[arg_53_1]["exp_" .. arg_53_0:getRarity()] then
		var_53_0 = var_2.exp
	end

	return var_53_0
end

function var_0_1.getNextLevelExp(arg_54_0)
	return arg_54_0:getConfigExp(arg_54_0.level)
end

function var_0_1.UpdateLevelAndExp(arg_55_0, arg_55_1, arg_55_2)
	arg_55_0.exp = arg_55_2
	arg_55_0.level = arg_55_1

	return
end

function var_0_1.getName(arg_56_0, arg_56_1)
	if arg_56_1 then
		return arg_56_0:getConfig("name")
	else
		local var_56_0

		if not arg_56_0.name then
			var_56_0 = arg_56_0:getConfig("name")
		end

		return var_56_0
	end

	return
end

function var_0_1.setName(arg_57_0, arg_57_1)
	arg_57_0.name = arg_57_1

	return
end

function var_0_1.getRarity(arg_58_0)
	return arg_58_0:getConfig("rarity")
end

function var_0_1.isSSR(arg_59_0)
	return arg_59_0:getRarity() == 5
end

function var_0_1.isSR(arg_60_0)
	return arg_60_0:getRarity() == 4
end

function var_0_1.isR(arg_61_0)
	return arg_61_0:getRarity() == 3
end

function var_0_1.getPainting(arg_62_0)
	return arg_62_0:getConfig("painting")
end

function var_0_1.getLevel(arg_63_0)
	return arg_63_0.level
end

function var_0_1.getDestoryedExp(arg_64_0, arg_64_1)
	local var_64_0 = 0

	for iter_64_0 = 1, arg_64_0.level - 1 do
		var_64_0 = var_64_0 + arg_64_0:getConfigExp(iter_64_0)
	end

	local var_64_1 = var_64_0 + arg_64_0.exp

	local function var_64_2()
		local var_65_0 = 0
		local var_65_1 = 0
		local var_65_2 = arg_64_0
		local var_65_3 = var_2.getTalents(var_65_2)

		ipairs = var_2_10003

		for iter_65_0, iter_65_1 in var_2_10003(var_65_3) do
			var_65_0 = var_65_0 + iter_65_1:getDestoryExpValue()
			var_65_1 = var_65_1 + iter_65_1:getDestoryExpRetio()
		end

		return var_65_0, var_65_1 / 16
	end

	pg = var_4

	local var_64_3 = var_4.gameset.commander_exp_a.key_value / 16

	pg = var_5

	local var_64_4 = var_5.gameset.commander_exp_same_rate.key_value / 16
	local var_64_5 = arg_64_1 == arg_64_0.groupId and var_64_4 or 1
	local var_64_6, var_64_7 = var_64_2()

	return (arg_64_0:getConfig("exp") + var_64_1 * var_64_3) * var_64_5 * (1 + var_64_7) + var_64_6
end

function var_0_1.getDestoryedSkillExp(arg_66_0, arg_66_1)
	if arg_66_1 == arg_66_0.groupId then
		pg = var_2

		return var_2.gameset.commander_skill_exp.key_value
	end

	return 0
end

function var_0_1.updateAbilityTime(arg_67_0, arg_67_1)
	arg_67_0.abilityTime = arg_67_1

	return
end

function var_0_1.GetNextResetAbilityTime(arg_68_0)
	pg = var_1_10001

	if var_1_10001.gameset.commander_ability_reset_time.key_value == 1 then
		pg = var_1

		local var_68_0 = var_1.TimeMgr.GetInstance()

		return var_1.GetNextTimeByTimeStamp(var_68_0, arg_68_0.abilityTime) + 0
	else
		local var_68_1 = arg_68_0.abilityTime

		pg = var_1_10002

		return var_68_1 + var_1_10002.gameset.commander_ability_reset_coldtime.key_value
	end

	return
end

function var_0_1.isLevelUp(arg_69_0, arg_69_1)
	return arg_69_0.level > 1 and arg_69_0.exp - arg_69_1 < 0
end

function var_0_1.isSameGroup(arg_70_0, arg_70_1)
	return arg_70_1 == arg_70_0.groupId
end

function var_0_1.getUpgradeConsume(arg_71_0)
	return var_1 + arg_71_0:getConfig("exp_cost") * (arg_71_0.level - 1) * (0.85 + 0.15 * arg_71_0.level)
end

function var_0_1.canEquipToEliteChapter(arg_72_0, arg_72_1, arg_72_2, arg_72_3)
	getProxy = var_1_10004
	ChapterProxy = var_1_10006

	local var_72_0 = var_1_10004(var_1_10006)
	local var_72_1 = var_4.getChapterById(var_72_0, arg_72_0)
	local var_72_2

	if not var_5.getEliteFleetCommanders(var_72_1) then
		var_72_2 = {}
	end

	return var_0_1.canEquipToFleetList(var_72_2, arg_72_1, arg_72_2, arg_72_3)
end

function var_0_1.canEquipToFleetList(arg_73_0, arg_73_1, arg_73_2, arg_73_3)
	getProxy = var_1_10004
	CommanderProxy = var_1_10006

	local var_73_0 = var_1_10004(var_1_10006)

	if not var_4.getCommanderById(var_73_0, arg_73_3) then
		var_1_10006 = false
		i18n = var_73_0

		local var_73_1 = var_73_0("commander_not_found")

		return
	end

	pairs = var_1_10006

	for iter_73_0, iter_73_1 in var_1_10006(arg_73_0) do
		if iter_73_0 == arg_73_1 then
			pairs = var_1_10011

			for iter_73_2, iter_73_3 in var_1_10011(iter_73_1) do
				if var_4:getCommanderById(iter_73_3) and var_16.groupId == var_5.groupId and iter_73_2 ~= arg_73_2 then
					var_1_10017 = false
					i18n = var_18

					local var_73_2 = var_18("commander_can_not_select_same_group")

					return
				end
			end
		else
			pairs = var_1_10011

			for iter_73_4, iter_73_5 in var_1_10011(iter_73_1) do
				if arg_73_3 == iter_73_5 then
					local var_73_3 = false

					i18n = var_1_10017
					var_1_10017 = var_1_10017("commander_is_in_fleet_already")

					return
				end
			end
		end
	end

	return true
end

function var_0_1.ExistCleanFlag(arg_74_0)
	pg = var_1_10001

	local var_74_0 = var_1_10001.TimeMgr.GetInstance()
	local var_74_1 = var_1.GetServerTime(var_74_0)

	pg = var_1_10002

	local var_74_2 = var_1_10002.TimeMgr.GetInstance()

	return not var_2.IsSameDay(var_74_2, arg_74_0.cleanTime, var_74_1)
end

function var_0_1.ExitFeedFlag(arg_75_0)
	pg = var_1_10001

	local var_75_0 = var_1_10001.TimeMgr.GetInstance()
	local var_75_1 = var_1.GetServerTime(var_75_0)

	pg = var_1_10002

	local var_75_2 = var_1_10002.TimeMgr.GetInstance()

	return not var_2.IsSameDay(var_75_2, arg_75_0.feedTime, var_75_1)
end

function var_0_1.ExitPlayFlag(arg_76_0)
	pg = var_1_10001

	local var_76_0 = var_1_10001.TimeMgr.GetInstance()
	local var_76_1 = var_1.GetServerTime(var_76_0)

	pg = var_1_10002

	local var_76_2 = var_1_10002.TimeMgr.GetInstance()

	return not var_2.IsSameDay(var_76_2, arg_76_0.playTime, var_76_1)
end

function var_0_1.UpdateHomeOpTime(arg_77_0, arg_77_1, arg_77_2)
	if arg_77_1 == 1 then
		arg_77_0.cleanTime = arg_77_2
	elseif arg_77_1 == 2 then
		arg_77_0.feedTime = arg_77_2
	elseif arg_77_1 == 3 then
		arg_77_0.playTime = arg_77_2
	end

	return
end

function var_0_1.IsSameTalent(arg_78_0)
	local var_78_0 = arg_78_0:getTalentOrigins()
	local var_78_1 = arg_78_0:getTalents()

	if #var_78_0 == #var_78_1 then
		_ = var_3

		if var_3.all(var_78_0, function(arg_79_0)
			_ = var_2_10001

			return var_2_10001.any(var_78_1, function(arg_80_0)
				return arg_80_0.id == arg_79_0.id
			end)
		end) then
			return true
		end
	end

	return false
end

function var_0_1.CanReset(arg_81_0)
	local var_81_0 = arg_81_0:GetNextResetAbilityTime()

	pg = var_1_10002

	local var_81_1 = var_1_10002.TimeMgr.GetInstance()

	return var_81_0 <= var_2.GetServerTime(var_81_1)
end

function var_0_1.ShouldTipLock(arg_82_0)
	local var_82_0

	if arg_82_0:isSSR() then
		var_82_0 = not arg_82_0:isLocked()
	end

	return var_82_0
end

return var_0_1
