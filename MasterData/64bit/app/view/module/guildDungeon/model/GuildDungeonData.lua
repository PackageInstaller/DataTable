local GuildDungeonData = class("GuildDungeonData")
local var_0_1 = g.core.const.ConstMgr.GuildDungeonConst
local GuildDunChapStruct = require("app.view.module.guildDungeon.model.GuildDunChapStruct")
local var_0_3 = g.core.config.guild_dungeon_chapter_info
local var_0_4 = g.core.config.guild_dungeon_skill_info
local var_0_5 = g.core.config.talent_skill_info
local var_0_6 = g.core.config.attribute_info
local var_0_7 = g.core.config.guild_dungeon_week_info
local var_0_8 = g.core.config.guild_dungeon_award_info

function GuildDungeonData:ctor()
	self:initData()
end

function GuildDungeonData:initData()
	self._curChapterId = 0
	self._clearAward = {}
	self._rebirth = 1
	self._chapterMap = {}
	self._allSkillMap = {}
	self._skillMap = {}
	self._skillList = {}
	self._clearAwardState = {}
	self._isResponse = false
	self._responseChap = {}
	self._finishStage = {}
	self._awardStage = {}
	self._awardChapter = {}
	self._curWeekInfo = {}
	self._displayVersion = 1
	self._awardInfoMap = {}
	self._awardInfoNumMap = {}

	self:_initAwardInfo()

	self._allChapterCfgList = {}

	self:_initChapterInfo()
	self:updateDungeonInfo()
	self:_initDungeonSkill()
end

function GuildDungeonData:_initAwardInfo()
	for iter_3_0 = 1, var_0_8.getLength() do
		local var_3_0 = var_0_8.indexOf(iter_3_0).toObject()

		self._awardInfoMap[var_3_0.award_type] = self._awardInfoMap[var_3_0.award_type] or {}

		table.insert(self._awardInfoMap[var_3_0.award_type], var_3_0)

		self._awardInfoNumMap[var_3_0.award_type] = self._awardInfoNumMap[var_3_0.award_type] or 0
		self._awardInfoNumMap[var_3_0.award_type] = self._awardInfoNumMap[var_3_0.award_type] + var_3_0.num
	end
end

function GuildDungeonData:getAwardInfoByType(arg_4_1)
	return self._awardInfoMap[arg_4_1] or {}, self._awardInfoNumMap[arg_4_1] or 0
end

function GuildDungeonData:_initChapterInfo()
	for iter_5_0 = 1, var_0_3.getLength() do
		local var_5_0 = var_0_3.indexOf(iter_5_0)
		local var_5_1 = GuildDunChapStruct.new(var_5_0.id)

		var_5_1:setCfg(var_5_0, self._awardInfoMap, self._awardInfoNumMap)

		self._allChapterCfgList[var_5_0.week] = self._allChapterCfgList[var_5_0.week] or {}
		self._allChapterCfgList[var_5_0.week][var_5_0.id] = var_5_1
	end
end

function GuildDungeonData:updateDungeonInfo()
	self._chapterMap = {}
	self._clearAwardState = {}

	for iter_6_0, iter_6_1 in pairs(self._allChapterCfgList[self._rebirth] or {}) do
		self._chapterMap[iter_6_0] = iter_6_1

		local var_6_0 = iter_6_1:getCfg()

		if var_6_0.if_show == 1 then
			table.insert(self._clearAwardState, {
				state = 0,
				id = var_6_0.id
			})
		end
	end
end

function GuildDungeonData:_initDungeonSkill()
	self._allSkillMap = {}

	for iter_7_0 = 1, var_0_4.getLength() do
		local var_7_0 = var_0_4.indexOf(iter_7_0)

		if not self._allSkillMap[var_7_0.type] then
			self._allSkillMap[var_7_0.type] = {}
			self._allSkillMap[var_7_0.type][var_7_0.level] = var_7_0
		else
			self._allSkillMap[var_7_0.type][var_7_0.level] = var_7_0
		end
	end
end

function GuildDungeonData:getChapterAwardCanShow(arg_8_1)
	return self:getStageAwardNotShowNum((self:getChapterById(arg_8_1):getStageList())) ~= g.core.const.ConstMgr.GuildDungeonConst.STAGE_NUM
end

function GuildDungeonData:getStageAwardNotShowNum(arg_9_1)
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if iter_9_1:getCfg().if_show == 0 then
			var_9_0 = var_9_0 + 1
		end
	end

	return var_9_0
end

function GuildDungeonData:updateGuildDungeonInfo(arg_10_1)
	local var_10_0 = arg_10_1.rebirth or 1

	if self._rebirth ~= var_10_0 or not self._isResponse then
		self._isResponse = true
		self._rebirth = var_10_0

		self:updateDungeonInfo()
	end

	local var_10_1 = arg_10_1.current_chapter_id or 1

	self._curChapterId = var_10_1
	self._curChapter = self._chapterMap[var_10_1]

	self._curChapter:setServerData(arg_10_1)

	self._clearAward = arg_10_1.first_finish_chapter or {}
	self._curWeekInfo = var_0_7.get(self._rebirth)

	self:_updateClearAwardState()
end

function GuildDungeonData:updateCurChapterInfo(arg_11_1)
	local var_11_0 = false

	for iter_11_0 = 1, #self._responseChap do
		if self._responseChap[iter_11_0] == arg_11_1.chapter_id then
			var_11_0 = true

			break
		end
	end

	if not var_11_0 then
		table.insert(self._responseChap, arg_11_1.chapter_id)
	end

	local var_11_1 = self._chapterMap[arg_11_1.chapter_id]
	local var_11_2 = self._chapterMap[arg_11_1.chapter_id]:getStageList()

	for iter_11_1 = 1, #arg_11_1.stages do
		var_11_2[iter_11_1]:setServerData(arg_11_1.stages[iter_11_1])
	end

	var_11_1:updateCurHp()

	local var_11_3 = arg_11_1.awarded_stage or {}

	for iter_11_2 = 1, #var_11_3 do
		local var_11_4 = self:getStageById(var_11_3[iter_11_2])

		if var_11_4 then
			var_11_4:setReceiveState(true)
		end
	end
end

function GuildDungeonData:getClearAwardChapterList()
	local var_12_0 = {}

	if self._isResponse then
		for iter_12_0, iter_12_1 in ipairs(self._clearAwardState) do
			if iter_12_1.id <= self._curChapterId and math.uint64_equal(self:getChapterById(iter_12_1.id):getCurrentHp(), 0) and iter_12_1.state ~= 2 then
				table.insert(var_12_0, iter_12_1.id)
			end
		end
	else
		local var_12_1 = {}

		for iter_12_2, iter_12_3 in pairs(self._awardChapter) do
			var_12_1[iter_12_3] = true
		end

		for iter_12_4, iter_12_5 in ipairs(self._clearAwardState) do
			if iter_12_5.id < self._curChapterId and var_12_1[iter_12_5.id] ~= true then
				table.insert(var_12_0, iter_12_5.id)
			end
		end
	end

	return var_12_0
end

function GuildDungeonData:canGetClearAward()
	if self._isResponse then
		return #self:getClearAwardChapterList() > 0
	else
		return self._curChapterId > #self._awardChapter + 1
	end
end

function GuildDungeonData:updateClearAwardList(arg_14_1)
	for iter_14_0 = 1, #arg_14_1.chapter_id do
		self:updateClearAward({
			chapter_id = arg_14_1.chapter_id[iter_14_0]
		}, true)
	end

	self._awardChapter = arg_14_1.chapter_id

	self:_updateClearAwardState()
end

function GuildDungeonData:updateClearAward(arg_15_1, arg_15_2)
	local var_15_0 = false

	for iter_15_0, iter_15_1 in ipairs(self._clearAward) do
		if iter_15_1 == arg_15_1.chapter_id then
			var_15_0 = true
		end
	end

	if not var_15_0 then
		table.insert(self._clearAward, arg_15_1.chapter_id)
	end

	if not arg_15_2 then
		self:_updateClearAwardState()
	end
end

function GuildDungeonData:updateStageHp(arg_16_1)
	local var_16_0 = self:getStageById(arg_16_1.stage_id)

	if not var_16_0 then
		return
	end

	var_16_0:updateDamage(arg_16_1.damage)

	if var_16_0:isStageFinish() then
		local var_16_1 = var_16_0:getStageId()

		self._finishStage[var_16_1] = var_16_1
	end

	self:getChapterById((self:getChapterIdByStageId(arg_16_1.stage_id))):updateCurHp()
end

function GuildDungeonData:_updateClearAwardState()
	for iter_17_0, iter_17_1 in ipairs(self._clearAward) do
		for iter_17_2, iter_17_3 in ipairs(self._clearAwardState) do
			if iter_17_3.id == iter_17_1 then
				iter_17_3.state = 2

				break
			end
		end
	end

	table.sort(self._clearAwardState, function(arg_18_0, arg_18_1)
		if arg_18_0.state ~= arg_18_1.state then
			return arg_18_0.state ~= 2
		end

		if arg_18_0.id ~= arg_18_1.id then
			return arg_18_0.id < arg_18_1.id
		end
	end)
end

function GuildDungeonData:getChapterNum()
	return (var_0_3.getLength())
end

function GuildDungeonData:getAttrValByTalentId(arg_20_1)
	local var_20_0 = var_0_5.get(arg_20_1)
	local var_20_1 = var_20_0.affect_value_1

	if var_0_6.get(var_20_0.affect_type_1).value_format == 2 then
		var_20_1 = tostring(var_20_1 / 10) .. "%"
	end

	return var_20_1, var_20_0.affect_value_1
end

function GuildDungeonData:updateSkillInfo(arg_21_1)
	self._skillMap = {}
	self._skillList = {}

	for iter_21_0 = 1, #arg_21_1 do
		self._skillMap[arg_21_1[iter_21_0].id] = {}
		self._skillMap[arg_21_1[iter_21_0].id].info = var_0_4.get(arg_21_1[iter_21_0].id)
		self._skillMap[arg_21_1[iter_21_0].id].curExp = arg_21_1[iter_21_0].num

		table.insert(self._skillList, self._skillMap[arg_21_1[iter_21_0].id])
	end

	table.sort(self._skillList, function(arg_22_0, arg_22_1)
		if arg_22_0.info.id ~= arg_22_1.info.id then
			return arg_22_0.info.id < arg_22_1.info.id
		end
	end)
end

function GuildDungeonData:getSkillMaxAcquireExp(arg_23_1)
	local var_23_0 = 0

	for iter_23_0 = 1, var_0_4.getLength() do
		local var_23_1 = var_0_4.indexOf(iter_23_0)

		if arg_23_1.info.type == var_23_1.type and var_23_1.level >= arg_23_1.info.level then
			var_23_0 = var_23_0 + var_23_1.exp
		end
	end

	return var_23_0 - arg_23_1.curExp
end

function GuildDungeonData:getCanLevelupCount(arg_24_1)
	local var_24_0 = arg_24_1.score

	if arg_24_1.score <= 0 then
		return 0
	end

	local var_24_1 = 0

	for iter_24_0 = 1, var_0_4.getLength() do
		local var_24_2 = var_0_4.indexOf(iter_24_0)

		if arg_24_1.skillData.info.type == var_24_2.type and var_24_2.exp > 0 then
			if var_24_2.level == arg_24_1.preLevel and arg_24_1.skillData.curExp + var_24_0 >= var_24_2.exp then
				var_24_1 = 1
				var_24_0 = var_24_0 - (var_24_2.exp - arg_24_1.skillData.curExp)
			end

			if arg_24_1.preLevel < var_24_2.level and var_24_0 >= var_24_2.exp then
				var_24_1 = var_24_1 + 1
				var_24_0 = var_24_0 - var_24_2.exp
			end
		end
	end

	return var_24_1
end

function GuildDungeonData:isSkillCalLvUp()
	if g.core.model.User.resourceData:getGuildDungeonScore() <= 0 then
		return false
	end

	for iter_25_0 = 1, #self._skillList do
		if self:getSkillMaxAcquireExp(self._skillList[iter_25_0]) > 0 then
			return true
		end
	end

	return false
end

function GuildDungeonData:updateStageTreasure(arg_26_1)
	self:getStageById(arg_26_1.stage_id):updateStageTreasure(arg_26_1)

	self._awardStage[arg_26_1.stage_id] = arg_26_1.stage_id
end

function GuildDungeonData:updateMvpAwardState(arg_27_1)
	self:getStageById(arg_27_1.stage_id):updateMvpAwardState()
end

function GuildDungeonData:getStageById(arg_28_1)
	for iter_28_0, iter_28_1 in pairs(self._chapterMap) do
		local var_28_0 = iter_28_1:getCfg()

		for iter_28_2 = 1, 4 do
			if var_28_0["dungeon_" .. iter_28_2] == arg_28_1 then
				return (iter_28_1:getStageById(arg_28_1))
			end
		end
	end
end

function GuildDungeonData:getChapterIdByStageId(arg_29_1)
	for iter_29_0, iter_29_1 in pairs(self._chapterMap) do
		local var_29_0 = iter_29_1:getCfg()

		for iter_29_2 = 1, 4 do
			if arg_29_1 == var_29_0["dungeon_" .. iter_29_2] then
				return var_29_0.id
			end
		end
	end
end

function GuildDungeonData:canReceiveTreasure()
	if self._isResponse then
		for iter_30_0, iter_30_1 in pairs(self._chapterMap) do
			if self:canRecTreasureById((iter_30_1:getChapterId())) then
				return true
			end
		end
	else
		return table.nums(self._finishStage) > table.nums(self._awardStage)
	end

	return false
end

function GuildDungeonData:isThereCanRcvBoxWithCustomData(arg_31_1)
	if arg_31_1.stageId then
		return self:canRecStageTreasure(arg_31_1.stageId)
	elseif arg_31_1.chapterId then
		return self:canRecTreasureById(arg_31_1.chapterId)
	else
		return self:canReceiveTreasure()
	end
end

function GuildDungeonData:canRecTreasureById(arg_32_1)
	if arg_32_1 > self:getCurChapterId() then
		return false
	end

	for iter_32_0, iter_32_1 in ipairs((self._chapterMap[arg_32_1]:getStageList())) do
		if self:canRecStageTreasure((iter_32_1:getStageId())) then
			return true
		end
	end

	return false
end

function GuildDungeonData:canRecStageTreasure(arg_33_1)
	local var_33_0 = self._awardStage[arg_33_1]

	if not self._awardStage[arg_33_1] then
		local var_33_1 = self:getSameChapterStageList(arg_33_1)

		for iter_33_0 = 1, #var_33_1 do
			if self._awardStage[var_33_1[iter_33_0]] then
				var_33_0 = true

				break
			end
		end
	end

	return self._finishStage[arg_33_1] and not var_33_0
end

function GuildDungeonData:getSameChapterStageList(arg_34_1)
	local var_34_0 = g.core.config.guild_dungeon_stage_info.get(arg_34_1).chapter_id
	local var_34_1 = 1

	for iter_34_0, iter_34_1 in g.core.config.guild_dungeon_chapter_info.ipairs() do
		for iter_34_2 = 1, 4 do
			if iter_34_1["dungeon_" .. iter_34_2] == arg_34_1 then
				var_34_1 = iter_34_2

				break
			end
		end
	end

	local var_34_2 = {}

	for iter_34_3, iter_34_4 in g.core.config.guild_dungeon_chapter_info.ipairs() do
		if iter_34_4.id == var_34_0 and iter_34_4["dungeon_" .. var_34_1] ~= arg_34_1 then
			table.insert(var_34_2, iter_34_4["dungeon_" .. var_34_1])
		end
	end

	return var_34_2
end

function GuildDungeonData:canRecMvpAward()
	for iter_35_0, iter_35_1 in pairs(self._chapterMap) do
		if iter_35_1:getChapterId() > self:getCurChapterId() then
			return false
		end

		local var_35_0 = iter_35_1:getStageList()

		for iter_35_2 = 1, #var_35_0 do
			if var_35_0[iter_35_2]:getMvpId() == g.core.model.User:getId() and not var_35_0[iter_35_2]:isRecMvpAward() then
				return true
			end
		end
	end

	return false
end

function GuildDungeonData:getChapterProgById(arg_36_1)
	return (self._chapterMap[arg_36_1]:getChapterProgress())
end

function GuildDungeonData:resetReceiveState()
	self._isResponse = false

	for iter_37_0, iter_37_1 in pairs(self._chapterMap) do
		for iter_37_2, iter_37_3 in pairs((iter_37_1:getStageMap())) do
			iter_37_3:setReceiveState(false)
		end
	end
end

function GuildDungeonData:updateStageTreasureArr(arg_38_1)
	if arg_38_1 == nil then
		return
	end

	if arg_38_1.stageAwards and #arg_38_1.stageAwards > 0 then
		for iter_38_0, iter_38_1 in ipairs(arg_38_1.stageAwards) do
			self:updateStageTreasure(iter_38_1)
		end
	end

	self._finishStage = {}

	for iter_38_2, iter_38_3 in pairs(arg_38_1.stageFinished or {}) do
		self._finishStage[iter_38_3] = iter_38_3
	end

	for iter_38_4, iter_38_5 in pairs(arg_38_1.stageAwarded or {}) do
		self._awardStage[iter_38_5] = iter_38_5
	end
end

function GuildDungeonData:setStageAwardTreasureRedData(arg_39_1)
	if not arg_39_1.guild_hint then
		return
	end

	local var_39_0 = arg_39_1.guild_hint.dungeon_hint or {}
	local var_39_1 = var_39_0.stage_awarded or {}
	local var_39_2 = var_39_0.chapter_awarded or {}

	self._finishStage = {}

	for iter_39_0, iter_39_1 in pairs(var_39_0.stage_finished or {}) do
		self._finishStage[iter_39_1] = iter_39_1
	end

	self._awardStage = {}

	for iter_39_2, iter_39_3 in pairs(var_39_1) do
		self._awardStage[iter_39_3] = iter_39_3
	end

	self._curChapterId = var_39_0.current_chapter or 1
	self._awardChapter = var_39_2
end

function GuildDungeonData:getStageAwardTreasureRedData()
	return {
		finished = self._finishStage,
		awarded = self._awardStage
	}
end

function GuildDungeonData:getOneKeyAwardList(arg_41_1)
	local var_41_0 = {}

	if arg_41_1 and arg_41_1.stageAwards and #arg_41_1.stageAwards > 0 then
		local var_41_1 = clone(arg_41_1.stageAwards)

		table.sort(var_41_1, function(arg_42_0, arg_42_1)
			return (arg_42_0.award_id[1] or 0) < (arg_42_1.award_id[1] or 0)
		end)

		for iter_41_0, iter_41_1 in ipairs(var_41_1) do
			local var_41_2 = false

			if iter_41_1.award_id then
				local var_41_3 = g.core.config.guild_dungeon_award_info.get(iter_41_1.award_id[1])

				if var_41_3 then
					var_41_2 = var_41_3.rare == 1
				end
			end

			if iter_41_1.awards and #iter_41_1.awards > 0 then
				for iter_41_2, iter_41_3 in ipairs(iter_41_1.awards) do
					local var_41_4 = clone(iter_41_3)

					var_41_4.isRare = var_41_2

					table.insert(var_41_0, var_41_4)
				end
			end
		end
	end

	return var_41_0
end

function GuildDungeonData:updateAttackFinish(arg_43_1)
	if not arg_43_1 then
		return
	end

	local var_43_0 = arg_43_1.current_chapter_id or self._curChapterId

	if arg_43_1.current_chapter_id ~= self._curChapterId then
		self._curChapterId = var_43_0
		self._curChapter = self._chapterMap[var_43_0]

		self._curChapter:updateCurHp()
	end
end

function GuildDungeonData:updateAllBoxAwards(arg_44_1)
	if not arg_44_1 then
		return
	end

	for iter_44_0, iter_44_1 in pairs(arg_44_1.stage_awarded or {}) do
		self._awardStage[iter_44_1] = iter_44_1
	end
end

function GuildDungeonData:getCurChapter()
	return self._curChapter
end

function GuildDungeonData:getCurChapterId()
	return self._curChapterId
end

function GuildDungeonData:getClearAward()
	return self._clearAward
end

function GuildDungeonData:getClearAwardState()
	return self._clearAwardState
end

function GuildDungeonData:getRebirth()
	return self._rebirth == 0 and 1 or self._rebirth
end

function GuildDungeonData:getSkillByTypeAndLv(arg_50_1, arg_50_2)
	return self._allSkillMap[arg_50_1][arg_50_2]
end

function GuildDungeonData:getSkillInfoById(arg_51_1)
	return self._skillMap[arg_51_1]
end

function GuildDungeonData:getSkillList()
	return self._skillList
end

function GuildDungeonData:getChapterMap()
	return self._chapterMap
end

function GuildDungeonData:getChapterById(arg_54_1)
	return self._chapterMap[arg_54_1]
end

function GuildDungeonData:isResponse()
	return self._isResponse
end

function GuildDungeonData:getResponseChapter()
	return self._responseChap
end

function GuildDungeonData:getCurWeekInfo()
	return self._curWeekInfo
end

function GuildDungeonData:getDunCntEnough()
	local var_58_0 = g.core.model.User.resourceData:getRecoverCfg(g.core.common.Goods.RESOURCE.TYPE_GUILD_DUN_TIME).time_limit

	return g.core.model.User.resourceData:getGuildDungeonTimes() > 5
end

function GuildDungeonData:isFirstChapter(arg_59_1)
	return arg_59_1 == 1
end

function GuildDungeonData:isLastChapter(arg_60_1)
	return arg_60_1 >= var_0_1.MAX_CHAPTER_NUM
end

function GuildDungeonData:setDisplayVersion(arg_61_1)
	self._displayVersion = arg_61_1
end

function GuildDungeonData:getDisplayVersion()
	return self._displayVersion
end

return GuildDungeonData
