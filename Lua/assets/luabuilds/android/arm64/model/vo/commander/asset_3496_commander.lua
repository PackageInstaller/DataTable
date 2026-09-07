local Commander = class("Commander", import("..BaseVO"))
local var_0_1 = pg.commander_level
local var_0_2 = pg.commander_attribute_template
local var_0_4 = 1

function Commander:rarity2Print()
	Commander.prints = Commander.prints or {
		"n",
		"n",
		"r",
		"sr",
		"ssr"
	}

	return Commander.prints[self]
end

function Commander:rarity2Frame()
	Commander.frames = Commander.frames or {
		"2",
		"2",
		"2",
		"3",
		"4"
	}

	return Commander.frames[self]
end

function Commander:Ctor(arg_3_1)
	self.id = arg_3_1.id
	self.configId = arg_3_1.template_id or self.id
	self.level = arg_3_1.level
	self.exp = arg_3_1.exp
	self.isLock = arg_3_1.is_locked
	self.pt = arg_3_1.used_pt

	if arg_3_1.name and arg_3_1.name ~= "" then
		self.name = arg_3_1.name
	end

	self.renameTime = (arg_3_1.rename_time or 0) + pg.gameset.commander_rename_coldtime.key_value
	self.talentOrigins = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.ability_origin) do
		local var_3_0 = CommanderTalent.New({
			id = iter_3_1
		})

		var_3_0.setOrigin(var_3_0, var_3_0)
		table.insert(self.talentOrigins, var_3_0)
	end

	self.talents = {}

	for iter_3_2, iter_3_3 in ipairs(arg_3_1.ability) do
		self:addTalent((CommanderTalent.New({
			id = iter_3_3
		})))
	end

	self.notLearnedList = {}
	self.abilityTime = arg_3_1.ability_time
	self.skills = {}

	for iter_3_4, iter_3_5 in ipairs(arg_3_1.skill) do
		table.insert(self.skills, (CommanderSkill.New({
			id = iter_3_5.id,
			exp = iter_3_5.exp
		})))
	end

	self.abilitys = {}

	self:updateAbilitys()

	self.maxLevel = var_0_1.all[#var_0_1.all]
	self.groupId = self:getConfig("group_type")
	self.cleanTime = arg_3_1.home_clean_time or 0
	self.playTime = arg_3_1.home_play_time or 0
	self.feedTime = arg_3_1.home_feed_time or 0

	return
end

function Commander:IsRegularTalent()
	return self:getConfig("ability_refresh_type") == var_0_4
end

function Commander:getRenameTime()
	return self.renameTime
end

function Commander:setRenameTime(arg_6_1)
	self.renameTime = arg_6_1

	return
end

function Commander:canModifyName()
	return pg.TimeMgr.GetInstance():GetServerTime() >= self.renameTime
end

function Commander:getRenameTimeDesc()
	local var_8_0, var_8_1, var_8_2, var_8_3 = pg.TimeMgr.GetInstance():parseTimeFrom(self.renameTime - pg.TimeMgr.GetInstance():GetServerTime())

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

function Commander:setLock(arg_9_1)
	assert(type(arg_9_1) == "number")

	self.isLock = arg_9_1

	return
end

function Commander:getLock()
	return self.isLock
end

function Commander:isLocked()
	return self.isLock == 1
end

function Commander:bindConfigTable()
	return pg.commander_data_template
end

function Commander:getSkill(arg_13_1)
	return _.detect(self.skills, function(arg_14_0)
		return arg_14_0.id == arg_13_1
	end)
end

function Commander:getSkills()
	return self.skills
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

function Commander:GetDisplayTalents()
	if self:IsRegularTalent() then
		local var_18_0 = {}

		for iter_18_0, iter_18_1 in ipairs(self:getConfig("ability_show")) do
			local var_18_1 = CommanderTalent.New({
				id = iter_18_1
			})

			var_18_0[var_18_1.groupId] = var_18_0[var_18_1.groupId] or {}

			table.insert(var_18_0[var_18_1.groupId], var_18_1)
		end

		local var_18_2 = {}
		local var_18_3 = {}

		for iter_18_2, iter_18_3 in pairs(var_18_0) do
			local var_18_4 = var_0_5(self, iter_18_3)

			table.insert(var_18_2, var_18_4)

			var_18_3[var_18_4.id] = self:IsLearnedTalent(var_18_4.id)
		end

		table.sort(var_18_2, function(arg_19_0, arg_19_1)
			return (var_18_3[arg_19_0.id] and 1 or 0) > (var_18_3[arg_19_1.id] and 1 or 0)
		end)

		do return var_18_2 end
		return
	end

	return self:getTalents()
end

function Commander:IsLearnedTalent(arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(self.talents) do
		if iter_20_1.id == arg_20_1 then
			return true
		end
	end

	return false
end

function Commander:getTalents()
	return self.talents
end

function Commander:getTalentOrigins()
	return self.talentOrigins
end

function Commander:addTalent(arg_23_1)
	arg_23_1:setOrigin((_.detect(self.talentOrigins, function(arg_24_0)
		return arg_24_0.groupId == arg_23_1.groupId
	end)))
	table.insert(self.talents, arg_23_1)

	return
end

function Commander:deleteTablent(arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(self.talents) do
		if iter_25_1.id == arg_25_1 then
			table.remove(self.talents, iter_25_0)

			break
		end
	end

	return
end

function Commander:getTalent(arg_26_1)
	for iter_26_0, iter_26_1 in pairs(self.talents) do
		if iter_26_1 == arg_26_1 then
			return iter_26_1
		end
	end

	return
end

function Commander:resetTalents()
	self.talents = Clone(self.talentOrigins)

	return
end

function Commander:getNotLearnedList()
	return self.notLearnedList
end

function Commander:updateNotLearnedList(arg_29_1)
	self.notLearnedList = arg_29_1

	return
end

function Commander:getResetTalentConsume()
	return pg.gameset.commander_skill_reset_cost.description[1][self.pt]
end

function Commander:getTotalPoint()
	return math.floor(self.level / CommanderConst.TALENT_POINT_LEVEL) * CommanderConst.TALENT_POINT
end

function Commander:getTalentPoint()
	return self:getTotalPoint() - self.pt
end

function Commander:updatePt(arg_33_1)
	self.pt = arg_33_1

	return
end

function Commander:getPt()
	return self.pt
end

function Commander:fullTalentCnt()
	return #self.talents >= CommanderConst.MAX_TELENT_COUNT
end

function Commander:hasTalent(arg_36_1)
	return self:getSameGroupTalent(arg_36_1.groupId) ~= nil
end

function Commander:getSameGroupTalent(arg_37_1)
	for iter_37_0, iter_37_1 in ipairs(self.talents) do
		if iter_37_1.groupId == arg_37_1 then
			return iter_37_1
		end
	end

	return
end

function Commander:getTalentsDesc()
	local var_38_0 = {}

	for iter_38_0, iter_38_1 in ipairs((self:getTalents())) do
		for iter_38_2, iter_38_3 in pairs(iter_38_1:getDesc()) do
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

function Commander:getAbilitys()
	return self.abilitys
end

function Commander:updateAbilitys()
	local var_40_0 = pg.gameset.commander_grow_form_a.key_value
	local var_40_1 = pg.gameset.commander_grow_form_b.key_value

	local function var_40_2(arg_41_0)
		local var_41_0 = self:getConfig(arg_41_0 .. "_value")

		return math.floor(var_41_0 + var_41_0 * (self.level - 1) * var_40_0 / var_40_1)
	end

	local var_40_3 = {
		101,
		102,
		103
	}

	for iter_40_0, iter_40_1 in ipairs({
		"command",
		"tactic",
		"support"
	}) do
		self.abilitys[iter_40_1] = {
			value = var_40_2(iter_40_1),
			id = var_40_3[iter_40_0]
		}
	end

	return
end

function Commander:getAbilitysAddition()
	local var_42_0 = pg.gameset.commander_form_a.key_value
	local var_42_1 = pg.gameset.commander_form_b.key_value
	local var_42_2 = pg.gameset.commander_form_c.key_value
	local var_42_3 = pg.gameset.commander_form_n.key_value

	local function var_42_4(arg_43_0)
		local var_43_0 = 0

		for iter_43_0, iter_43_1 in pairs(self.abilitys) do
			if var_0_2[iter_43_1.id]["rate_" .. arg_43_0] then
				if var_0_2[iter_43_1.id]["rate_" .. arg_43_0] / 16 > 0 then
					var_43_0 = var_43_0 + iter_43_1.value * (var_0_2[iter_43_1.id]["rate_" .. arg_43_0] / 16)
				end
			end
		end

		return tonumber(string.format("%0.3f", (var_42_0 - var_42_1 / (var_43_0 + var_42_2)) * var_42_3))
	end

	local var_42_5 = {}

	for iter_42_0, iter_42_1 in ipairs(CommanderConst.PROPERTIES) do
		var_42_5[iter_42_1] = var_42_4(iter_42_1)
	end

	return var_42_5
end

function Commander:getTalentsAddition(arg_44_1, arg_44_2, arg_44_3, arg_44_4)
	local var_44_0 = 0

	for iter_44_0, iter_44_1 in pairs((self:getTalents())) do
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

function Commander:getAttrRatioAddition(arg_45_1, arg_45_2, arg_45_3)
	if table.contains(CommanderConst.PROPERTIES, arg_45_1) then
		return self:getAbilitysAddition()[arg_45_1] + self:getTalentsAddition(CommanderConst.TALENT_ADDITION_RATIO, arg_45_1, arg_45_2, arg_45_3) / 100
	else
		return 0
	end

	return
end

function Commander:getAttrValueAddition(arg_46_1, arg_46_2, arg_46_3)
	if table.contains(CommanderConst.PROPERTIES, arg_46_1) then
		return (self:getTalentsAddition(CommanderConst.TALENT_ADDITION_NUMBER, arg_46_1, arg_46_2, arg_46_3))
	else
		return 0
	end

	return
end

function Commander:addExp(arg_47_1)
	if self:isMaxLevel() then
		return
	end

	self.exp = self.exp + arg_47_1

	while not self:isMaxLevel() and self:canLevelUp() do
		self.exp = self.exp - self:getNextLevelExp()

		self:updateLevel()
	end

	return
end

function Commander:ReduceExp(arg_48_1)
	self.exp = self.exp - arg_48_1

	while self.exp < 0 do
		self.level = self.level - 1
		self.exp = self:getNextLevelExp() + self.exp
	end

	return
end

function Commander:canLevelUp()
	return self.exp >= self:getNextLevelExp()
end

function Commander:isMaxLevel()
	return self:getMaxLevel() <= self.level
end

function Commander:getMaxLevel()
	return self.maxLevel
end

function Commander:updateLevel()
	self.level = self.level + 1

	self:updateAbilitys()

	if self.level % CommanderConst.TALENT_POINT_LEVEL == 0 then
		self.notLearnedList = {}
	end

	return
end

function Commander:getConfigExp(arg_53_1)
	arg_53_1 = math.max(arg_53_1, 1)

	return var_0_1[arg_53_1]["exp_" .. self:getRarity()] or var_0_1[arg_53_1].exp
end

function Commander:getNextLevelExp()
	return self:getConfigExp(self.level)
end

function Commander:UpdateLevelAndExp(arg_55_1, arg_55_2)
	self.exp = arg_55_2
	self.level = arg_55_1

	return
end

function Commander:getName(arg_56_1)
	if arg_56_1 then
		return self:getConfig("name")
	else
		return self.name or self:getConfig("name")
	end

	return
end

function Commander:setName(arg_57_1)
	self.name = arg_57_1

	return
end

function Commander:getRarity()
	return self:getConfig("rarity")
end

function Commander:isSSR()
	return self:getRarity() == 5
end

function Commander:isSR()
	return self:getRarity() == 4
end

function Commander:isR()
	return self:getRarity() == 3
end

function Commander:getPainting()
	return self:getConfig("painting")
end

function Commander:getLevel()
	return self.level
end

function Commander:getDestoryedExp(arg_64_1)
	local var_64_0 = 0

	for iter_64_0 = 1, self.level - 1 do
		var_64_0 = var_64_0 + self:getConfigExp(iter_64_0)
	end

	local var_64_1 = var_64_0 + self.exp
	local var_64_2 = pg.gameset.commander_exp_a.key_value / 16
	local var_64_3 = arg_64_1 == self.groupId and pg.gameset.commander_exp_same_rate.key_value / 16 or 1
	local var_64_4, var_64_5 = (function()
		local var_65_0 = 0
		local var_65_1 = 0

		for iter_65_0, iter_65_1 in ipairs((self:getTalents())) do
			var_65_0 = var_65_0 + iter_65_1:getDestoryExpValue()
			var_65_1 = var_65_1 + iter_65_1:getDestoryExpRetio()
		end

		return var_65_0, var_65_1 / 16
	end)()

	return (self:getConfig("exp") + var_64_1 * var_64_2) * var_64_3 * (1 + var_64_5) + var_64_4
end

function Commander:getDestoryedSkillExp(arg_66_1)
	if arg_66_1 == self.groupId then
		return pg.gameset.commander_skill_exp.key_value
	end

	return 0
end

function Commander:updateAbilityTime(arg_67_1)
	self.abilityTime = arg_67_1

	return
end

function Commander:GetNextResetAbilityTime()
	if pg.gameset.commander_ability_reset_time.key_value == 1 then
		return pg.TimeMgr.GetInstance():GetNextTimeByTimeStamp(self.abilityTime) + 0
	else
		return self.abilityTime + pg.gameset.commander_ability_reset_coldtime.key_value
	end

	return
end

function Commander:isLevelUp(arg_69_1)
	return self.level > 1 and self.exp - arg_69_1 < 0
end

function Commander:isSameGroup(arg_70_1)
	return arg_70_1 == self.groupId
end

function Commander:getUpgradeConsume()
	local var_71_0 = self:getConfig("exp_cost")

	return var_71_0 + var_71_0 * (self.level - 1) * (0.85 + 0.15 * self.level)
end

function Commander:canEquipToEliteChapter(arg_72_1, arg_72_2, arg_72_3)
	return Commander.canEquipToFleetList(getProxy(ChapterProxy):getChapterById(self):getEliteFleetCommanders() or {}, arg_72_1, arg_72_2, arg_72_3)
end

function Commander:canEquipToFleetList(arg_73_1, arg_73_2, arg_73_3)
	local var_73_0 = getProxy(CommanderProxy)
	local var_73_1 = var_73_0:getCommanderById(arg_73_3)

	if not var_73_1 then
		local var_73_3 = i18n("commander_not_found")

		return
	end

	for iter_73_0, iter_73_1 in pairs(self) do
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

function Commander:ExistCleanFlag()
	return not pg.TimeMgr.GetInstance():IsSameDay(self.cleanTime, (pg.TimeMgr.GetInstance():GetServerTime()))
end

function Commander:ExitFeedFlag()
	return not pg.TimeMgr.GetInstance():IsSameDay(self.feedTime, (pg.TimeMgr.GetInstance():GetServerTime()))
end

function Commander:ExitPlayFlag()
	return not pg.TimeMgr.GetInstance():IsSameDay(self.playTime, (pg.TimeMgr.GetInstance():GetServerTime()))
end

function Commander:UpdateHomeOpTime(arg_77_1, arg_77_2)
	if arg_77_1 == 1 then
		self.cleanTime = arg_77_2
	elseif arg_77_1 == 2 then
		self.feedTime = arg_77_2
	elseif arg_77_1 == 3 then
		self.playTime = arg_77_2
	end

	return
end

function Commander:IsSameTalent()
	local var_78_0 = self:getTalentOrigins()
	local var_78_1 = self:getTalents()

	if #var_78_0 == #var_78_1 and _.all(var_78_0, function(arg_79_0)
		return _.any(var_78_1, function(arg_80_0)
			return arg_80_0.id == arg_79_0.id
		end)
	end) then
		return true
	end

	return false
end

function Commander:CanReset()
	return self:GetNextResetAbilityTime() <= pg.TimeMgr.GetInstance():GetServerTime()
end

function Commander:ShouldTipLock()
	return self:isSSR() and not self:isLocked()
end

return Commander
