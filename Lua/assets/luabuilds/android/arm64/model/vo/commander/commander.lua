local var_0_0 = class("Commander", import("..BaseVO"))
local var_0_1 = pg.commander_level
local var_0_2 = pg.commander_attribute_template
local var_0_4 = 1

function var_0_0.rarity2Print(arg_1_0)
	var_0_0.prints = var_0_0.prints or {
		"n",
		"n",
		"r",
		"sr",
		"ssr"
	}

	return var_0_0.prints[arg_1_0]
end

function var_0_0.rarity2Frame(arg_2_0)
	var_0_0.frames = var_0_0.frames or {
		"2",
		"2",
		"2",
		"3",
		"4"
	}

	return var_0_0.frames[arg_2_0]
end

function var_0_0.Ctor(arg_3_0, arg_3_1)
	arg_3_0.id = arg_3_1.id
	arg_3_0.configId = arg_3_1.template_id or arg_3_0.id
	arg_3_0.level = arg_3_1.level
	arg_3_0.exp = arg_3_1.exp
	arg_3_0.isLock = arg_3_1.is_locked
	arg_3_0.pt = arg_3_1.used_pt

	if arg_3_1.name and arg_3_1.name ~= "" then
		arg_3_0.name = arg_3_1.name
	end

	local var_3_0 = pg.gameset.commander_rename_coldtime.key_value
	local var_3_1 = arg_3_1.rename_time or 0

	arg_3_0.renameTime = var_3_1 + var_3_0
	arg_3_0.talentOrigins = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.ability_origin) do
		local var_3_2 = CommanderTalent.New({
			id = iter_3_1
		})

		var_3_2.setOrigin(var_3_2, var_3_2)
		table.insert(arg_3_0.talentOrigins, var_3_2)
	end

	arg_3_0.talents = {}

	for iter_3_2, iter_3_3 in ipairs(arg_3_1.ability) do
		arg_3_0:addTalent((CommanderTalent.New({
			id = iter_3_3
		})))
	end

	arg_3_0.notLearnedList = {}
	arg_3_0.abilityTime = arg_3_1.ability_time
	arg_3_0.skills = {}

	for iter_3_4, iter_3_5 in ipairs(arg_3_1.skill) do
		table.insert(arg_3_0.skills, (CommanderSkill.New({
			id = iter_3_5.id,
			exp = iter_3_5.exp
		})))
	end

	arg_3_0.abilitys = {}

	arg_3_0:updateAbilitys()

	arg_3_0.maxLevel = var_0_1.all[#var_0_1.all]
	arg_3_0.groupId = arg_3_0:getConfig("group_type")
	arg_3_0.cleanTime = arg_3_1.home_clean_time or 0
	arg_3_0.playTime = arg_3_1.home_play_time or 0
	arg_3_0.feedTime = arg_3_1.home_feed_time or 0

	return
end

function var_0_0.IsRegularTalent(arg_4_0)
	return arg_4_0:getConfig("ability_refresh_type") == var_0_4
end

function var_0_0.getRenameTime(arg_5_0)
	return arg_5_0.renameTime
end

function var_0_0.setRenameTime(arg_6_0, arg_6_1)
	arg_6_0.renameTime = arg_6_1

	return
end

function var_0_0.canModifyName(arg_7_0)
	local var_7_0 = pg.TimeMgr.GetInstance()

	return var_7_0:GetServerTime() >= arg_7_0.renameTime
end

function var_0_0.getRenameTimeDesc(arg_8_0)
	local var_8_9000
	local var_8_0, var_8_1, var_8_2, var_8_3 = pg.TimeMgr.GetInstance():parseTimeFrom(arg_8_0.renameTime - pg.TimeMgr.GetInstance().GetServerTime(var_8_9000))

	if var_8_0 < 1 then
		if var_8_1 < 1 then
			return var_8_2 .. i18n("word_minute")
		else
			return var_8_1 .. i18n("word_hour")
		end
	else
		return var_8_0 .. i18n("word_date")
	end

	return
end

function var_0_0.setLock(arg_9_0, arg_9_1)
	assert(type(arg_9_1) == "number")

	arg_9_0.isLock = arg_9_1

	return
end

function var_0_0.getLock(arg_10_0)
	return arg_10_0.isLock
end

function var_0_0.isLocked(arg_11_0)
	return arg_11_0.isLock == 1
end

function var_0_0.bindConfigTable(arg_12_0)
	return pg.commander_data_template
end

function var_0_0.getSkill(arg_13_0, arg_13_1)
	return _.detect(arg_13_0.skills, function(arg_14_0)
		return arg_14_0.id == arg_13_1
	end)
end

function var_0_0.getSkills(arg_15_0)
	return arg_15_0.skills
end

local function var_0_5(arg_16_0, arg_16_1)
	table.sort(arg_16_1, function(arg_17_0, arg_17_1)
		return arg_17_0.configId < arg_17_1.configId
	end)

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		if arg_16_0:IsLearnedTalent(iter_16_1.id) then
			return iter_16_1
		end
	end

	return arg_16_1[1]
end

function var_0_0.GetDisplayTalents(arg_18_0)
	if arg_18_0:IsRegularTalent() then
		for iter_18_0, iter_18_1 in ipairs(arg_18_0:getConfig("ability_show")) do
			local var_18_0 = CommanderTalent.New({
				id = iter_18_1
			})

			if not ({})[var_18_0.groupId] then
				({})[var_18_0.groupId] = {}
			end

			table.insert(({})[var_18_0.groupId], var_18_0)
		end

		local var_18_1 = {}

		for iter_18_2, iter_18_3 in pairs({}) do
			local var_18_2 = var_0_5(arg_18_0, iter_18_3)

			table.insert({}, var_18_2)

			;({})[var_18_2.id] = arg_18_0:IsLearnedTalent(var_18_2.id)
		end

		table.sort({}, function(arg_19_0, arg_19_1)
			return (var_18_1[arg_19_0.id] and 1 or 0) > (var_18_1[arg_19_1.id] and 1 or 0)
		end)

		do return {} end
		return
	end

	return arg_18_0:getTalents()
end

function var_0_0.IsLearnedTalent(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0.talents) do
		if iter_20_1.id == arg_20_1 then
			return true
		end
	end

	return false
end

function var_0_0.getTalents(arg_21_0)
	return arg_21_0.talents
end

function var_0_0.getTalentOrigins(arg_22_0)
	return arg_22_0.talentOrigins
end

function var_0_0.addTalent(arg_23_0, arg_23_1)
	arg_23_1:setOrigin((_.detect(arg_23_0.talentOrigins, function(arg_24_0)
		return arg_24_0.groupId == arg_23_1.groupId
	end)))
	table.insert(arg_23_0.talents, arg_23_1)

	return
end

function var_0_0.deleteTablent(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(arg_25_0.talents) do
		if iter_25_1.id == arg_25_1 then
			table.remove(arg_25_0.talents, iter_25_0)

			break
		end
	end

	return
end

function var_0_0.getTalent(arg_26_0, arg_26_1)
	for iter_26_0, iter_26_1 in pairs(arg_26_0.talents) do
		if iter_26_1 == arg_26_1 then
			return iter_26_1
		end
	end

	return
end

function var_0_0.resetTalents(arg_27_0)
	arg_27_0.talents = Clone(arg_27_0.talentOrigins)

	return
end

function var_0_0.getNotLearnedList(arg_28_0)
	return arg_28_0.notLearnedList
end

function var_0_0.updateNotLearnedList(arg_29_0, arg_29_1)
	arg_29_0.notLearnedList = arg_29_1

	return
end

function var_0_0.getResetTalentConsume(arg_30_0)
	return pg.gameset.commander_skill_reset_cost.description[1][arg_30_0.pt]
end

function var_0_0.getTotalPoint(arg_31_0)
	return math.floor(arg_31_0.level / CommanderConst.TALENT_POINT_LEVEL) * CommanderConst.TALENT_POINT
end

function var_0_0.getTalentPoint(arg_32_0)
	return arg_32_0:getTotalPoint() - arg_32_0.pt
end

function var_0_0.updatePt(arg_33_0, arg_33_1)
	arg_33_0.pt = arg_33_1

	return
end

function var_0_0.getPt(arg_34_0)
	return arg_34_0.pt
end

function var_0_0.fullTalentCnt(arg_35_0)
	return #arg_35_0.talents >= CommanderConst.MAX_TELENT_COUNT
end

function var_0_0.hasTalent(arg_36_0, arg_36_1)
	return arg_36_0:getSameGroupTalent(arg_36_1.groupId) ~= nil
end

function var_0_0.getSameGroupTalent(arg_37_0, arg_37_1)
	for iter_37_0, iter_37_1 in ipairs(arg_37_0.talents) do
		if iter_37_1.groupId == arg_37_1 then
			return iter_37_1
		end
	end

	return
end

function var_0_0.getTalentsDesc(arg_38_0)
	for iter_38_0, iter_38_1 in ipairs((arg_38_0:getTalents())) do
		for iter_38_2, iter_38_3 in pairs(iter_38_1:getDesc()) do
			if ({})[iter_38_2] then
				({})[iter_38_2].value = ({})[iter_38_2].value + iter_38_3.value
			else
				({})[iter_38_2] = {
					name = iter_38_2,
					value = iter_38_3.value,
					type = iter_38_3.type
				}
			end
		end
	end

	return {}
end

function var_0_0.getAbilitys(arg_39_0)
	return arg_39_0.abilitys
end

function var_0_0.updateAbilitys(arg_40_0)
	local var_40_0 = pg.gameset.commander_grow_form_a.key_value
	local var_40_1 = pg.gameset.commander_grow_form_b.key_value

	for iter_40_0, iter_40_1 in ipairs({
		"command",
		"tactic",
		"support"
	}) do
		arg_40_0.abilitys[iter_40_1] = {
			value = (function(arg_41_0)
				local var_41_0 = arg_40_0:getConfig(arg_41_0 .. "_value")

				return math.floor(var_41_0 + var_41_0 * (arg_40_0.level - 1) * var_40_0 / var_40_1)
			end)(iter_40_1),
			id = ({
				101,
				102,
				103
			})[iter_40_0]
		}
	end

	return
end

function var_0_0.getAbilitysAddition(arg_42_0)
	local var_42_0 = pg.gameset.commander_form_a.key_value
	local var_42_1 = pg.gameset.commander_form_b.key_value
	local var_42_2 = pg.gameset.commander_form_c.key_value
	local var_42_3 = pg.gameset.commander_form_n.key_value

	for iter_42_0, iter_42_1 in ipairs(CommanderConst.PROPERTIES) do
		({})[iter_42_1] = (function(arg_43_0)
			local var_43_0 = 0

			for iter_43_0, iter_43_1 in pairs(arg_42_0.abilitys) do
				if var_0_2[iter_43_1.id]["rate_" .. arg_43_0] then
					if var_0_2[iter_43_1.id]["rate_" .. arg_43_0] / 16 > 0 then
						var_43_0 = var_43_0 + iter_43_1.value * (var_0_2[iter_43_1.id]["rate_" .. arg_43_0] / 16)
					end
				end
			end

			return tonumber(string.format("%0.3f", (var_42_0 - var_42_1 / (var_43_0 + var_42_2)) * var_42_3))
		end)(iter_42_1)
	end

	return {}
end

function var_0_0.getTalentsAddition(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4)
	local var_44_0 = 0

	for iter_44_0, iter_44_1 in pairs((arg_44_0:getTalents())) do
		local var_44_1, var_44_2 = iter_44_1:getAttrsAddition()
		local var_44_3

		if arg_44_1 == CommanderConst.TALENT_ADDITION_NUMBER then
			var_44_3 = var_44_1
		elseif arg_44_1 == CommanderConst.TALENT_ADDITION_RATIO then
			var_44_3 = var_44_2
		end

		local var_44_4 = var_44_3[arg_44_2]
		local var_44_5 = true

		if var_44_3[arg_44_2] then
			if #var_44_4.nation > 0 and not table.contains(var_44_4.nation, arg_44_3) then
				var_44_5 = false
			end

			if #var_44_4.shiptype > 0 and not table.contains(var_44_4.shiptype, arg_44_4) then
				var_44_5 = false
			end
		else
			var_44_5 = false
		end

		if var_44_5 then
			var_44_0 = var_44_0 + var_44_4.value
		end
	end

	return var_44_0
end

function var_0_0.getAttrRatioAddition(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	if table.contains(CommanderConst.PROPERTIES, arg_45_1) then
		return arg_45_0:getAbilitysAddition()[arg_45_1] + arg_45_0:getTalentsAddition(CommanderConst.TALENT_ADDITION_RATIO, arg_45_1, arg_45_2, arg_45_3) / 100
	else
		return 0
	end

	return
end

function var_0_0.getAttrValueAddition(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	if table.contains(CommanderConst.PROPERTIES, arg_46_1) then
		return (arg_46_0:getTalentsAddition(CommanderConst.TALENT_ADDITION_NUMBER, arg_46_1, arg_46_2, arg_46_3))
	else
		return 0
	end

	return
end

function var_0_0.addExp(arg_47_0, arg_47_1)
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

function var_0_0.ReduceExp(arg_48_0, arg_48_1)
	arg_48_0.exp = arg_48_0.exp - arg_48_1

	while arg_48_0.exp < 0 do
		arg_48_0.level = arg_48_0.level - 1
		arg_48_0.exp = arg_48_0:getNextLevelExp() + arg_48_0.exp
	end

	return
end

function var_0_0.canLevelUp(arg_49_0)
	return arg_49_0.exp >= arg_49_0:getNextLevelExp()
end

function var_0_0.isMaxLevel(arg_50_0)
	return arg_50_0:getMaxLevel() <= arg_50_0.level
end

function var_0_0.getMaxLevel(arg_51_0)
	return arg_51_0.maxLevel
end

function var_0_0.updateLevel(arg_52_0)
	arg_52_0.level = arg_52_0.level + 1

	arg_52_0:updateAbilitys()

	if arg_52_0.level % CommanderConst.TALENT_POINT_LEVEL == 0 then
		arg_52_0.notLearnedList = {}
	end

	return
end

function var_0_0.getConfigExp(arg_53_0, arg_53_1)
	arg_53_1 = math.max(arg_53_1, 1)

	return var_0_1[arg_53_1]["exp_" .. arg_53_0:getRarity()] or var_0_1[arg_53_1].exp
end

function var_0_0.getNextLevelExp(arg_54_0)
	return arg_54_0:getConfigExp(arg_54_0.level)
end

function var_0_0.UpdateLevelAndExp(arg_55_0, arg_55_1, arg_55_2)
	arg_55_0.exp = arg_55_2
	arg_55_0.level = arg_55_1

	return
end

function var_0_0.getName(arg_56_0, arg_56_1)
	if arg_56_1 then
		return arg_56_0:getConfig("name")
	else
		return arg_56_0.name or arg_56_0:getConfig("name")
	end

	return
end

function var_0_0.setName(arg_57_0, arg_57_1)
	arg_57_0.name = arg_57_1

	return
end

function var_0_0.getRarity(arg_58_0)
	return arg_58_0:getConfig("rarity")
end

function var_0_0.isSSR(arg_59_0)
	return arg_59_0:getRarity() == 5
end

function var_0_0.isSR(arg_60_0)
	return arg_60_0:getRarity() == 4
end

function var_0_0.isR(arg_61_0)
	return arg_61_0:getRarity() == 3
end

function var_0_0.getPainting(arg_62_0)
	return arg_62_0:getConfig("painting")
end

function var_0_0.getLevel(arg_63_0)
	return arg_63_0.level
end

function var_0_0.getDestoryedExp(arg_64_0, arg_64_1)
	local var_64_0 = 0

	for iter_64_0 = 1, arg_64_0.level - 1 do
		var_64_0 = var_64_0 + arg_64_0:getConfigExp(iter_64_0)
	end

	local var_64_1 = var_64_0 + arg_64_0.exp
	local var_64_2 = pg.gameset.commander_exp_a.key_value / 16
	local var_64_3 = arg_64_1 == arg_64_0.groupId and pg.gameset.commander_exp_same_rate.key_value / 16 or 1
	local var_64_4, var_64_5 = (function()
		local var_65_0 = 0
		local var_65_1 = 0

		for iter_65_0, iter_65_1 in ipairs((arg_64_0:getTalents())) do
			var_65_0 = var_65_0 + iter_65_1:getDestoryExpValue()
			var_65_1 = var_65_1 + iter_65_1:getDestoryExpRetio()
		end

		return var_65_0, var_65_1 / 16
	end)()

	return (arg_64_0:getConfig("exp") + var_64_1 * var_64_2) * var_64_3 * (1 + var_64_5) + var_64_4
end

function var_0_0.getDestoryedSkillExp(arg_66_0, arg_66_1)
	if arg_66_1 == arg_66_0.groupId then
		return pg.gameset.commander_skill_exp.key_value
	end

	return 0
end

function var_0_0.updateAbilityTime(arg_67_0, arg_67_1)
	arg_67_0.abilityTime = arg_67_1

	return
end

function var_0_0.GetNextResetAbilityTime(arg_68_0)
	if pg.gameset.commander_ability_reset_time.key_value == 1 then
		return pg.TimeMgr.GetInstance():GetNextTimeByTimeStamp(arg_68_0.abilityTime) + 0
	else
		return arg_68_0.abilityTime + pg.gameset.commander_ability_reset_coldtime.key_value
	end

	return
end

function var_0_0.isLevelUp(arg_69_0, arg_69_1)
	return arg_69_0.level > 1 and arg_69_0.exp - arg_69_1 < 0
end

function var_0_0.isSameGroup(arg_70_0, arg_70_1)
	return arg_70_1 == arg_70_0.groupId
end

function var_0_0.getUpgradeConsume(arg_71_0)
	local var_71_0 = arg_71_0:getConfig("exp_cost")

	return var_71_0 + var_71_0 * (arg_71_0.level - 1) * (0.85 + 0.15 * arg_71_0.level)
end

function var_0_0.canEquipToEliteChapter(arg_72_0, arg_72_1, arg_72_2, arg_72_3)
	local var_72_0 = getProxy(ChapterProxy):getChapterById(arg_72_0):getEliteFleetCommanders() or {}

	return var_0_0.canEquipToFleetList(var_72_0, arg_72_1, arg_72_2, arg_72_3)
end

function var_0_0.canEquipToFleetList(arg_73_0, arg_73_1, arg_73_2, arg_73_3)
	local var_73_0 = getProxy(CommanderProxy)
	local var_73_1 = var_73_0:getCommanderById(arg_73_3)

	if not var_73_1 then
		local var_73_3 = i18n("commander_not_found")

		return
	end

	for iter_73_0, iter_73_1 in pairs(arg_73_0) do
		if iter_73_0 == arg_73_1 then
			for iter_73_2, iter_73_3 in pairs(iter_73_1) do
				local var_73_4 = var_73_0:getCommanderById(iter_73_3)

				if var_73_4 and var_73_4.groupId == var_73_1.groupId and iter_73_2 ~= arg_73_2 then
					local var_73_6 = i18n("commander_can_not_select_same_group")

					return
				end
			end
		else
			for iter_73_4, iter_73_5 in pairs(iter_73_1) do
				if arg_73_3 == iter_73_5 then
					local var_73_8 = i18n("commander_is_in_fleet_already")

					return
				end
			end
		end
	end

	return true
end

function var_0_0.ExistCleanFlag(arg_74_0)
	return not pg.TimeMgr.GetInstance():IsSameDay(arg_74_0.cleanTime, (pg.TimeMgr.GetInstance():GetServerTime()))
end

function var_0_0.ExitFeedFlag(arg_75_0)
	return not pg.TimeMgr.GetInstance():IsSameDay(arg_75_0.feedTime, (pg.TimeMgr.GetInstance():GetServerTime()))
end

function var_0_0.ExitPlayFlag(arg_76_0)
	return not pg.TimeMgr.GetInstance():IsSameDay(arg_76_0.playTime, (pg.TimeMgr.GetInstance():GetServerTime()))
end

function var_0_0.UpdateHomeOpTime(arg_77_0, arg_77_1, arg_77_2)
	if arg_77_1 == 1 then
		arg_77_0.cleanTime = arg_77_2
	elseif arg_77_1 == 2 then
		arg_77_0.feedTime = arg_77_2
	elseif arg_77_1 == 3 then
		arg_77_0.playTime = arg_77_2
	end

	return
end

function var_0_0.IsSameTalent(arg_78_0)
	local var_78_0 = arg_78_0:getTalentOrigins()

	if #var_78_0 == #arg_78_0:getTalents() and _.all(var_78_0, function(arg_79_0)
		return _.any(var_0, function(arg_80_0)
			return arg_80_0.id == arg_79_0.id
		end)
	end) then
		return true
	end

	return false
end

function var_0_0.CanReset(arg_81_0)
	local var_81_0 = pg.TimeMgr.GetInstance()

	return arg_81_0:GetNextResetAbilityTime() <= var_81_0:GetServerTime()
end

function var_0_0.ShouldTipLock(arg_82_0)
	return arg_82_0:isSSR() and not arg_82_0:isLocked()
end

return var_0_0
