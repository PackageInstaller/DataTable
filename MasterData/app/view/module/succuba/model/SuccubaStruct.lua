local var_0_0 = g.core.config.succuba_advance_info
local SuccubaStruct = class("SuccubaStruct")

function SuccubaStruct:ctor(arg_1_1)
	self._svrIndexMap = {}
	self._svrInterIndexMap = {}
	self._cfgList = {}

	self:_createSimpleMember("star", 0)

	self._advanceId = 0

	self:_createSimpleMember("level", 0)

	self._quality = 0

	self:_createSimpleMember("charm", 0)
	self:_createSimpleMember("position", 0)
	self:_createSimpleMember("roomId", 0)
	self:_createSimpleMember("eventId", 0, "event_id", self._svrInterIndexMap)
	self:_createSimpleMember("progress", 0, self._svrInterIndexMap)
	self:_createSimpleMember("activeEvents", {}, "active_events", self._svrInterIndexMap)
	self:_createSimpleMember("roomId", 0)
	self:_createSimpleMember("node", 0)
	self:_createSimpleMember("stage", 0)

	self._serverInfo = {}
	self._interactionInfo = {}
	self._curCfg = self:getCfg(arg_1_1.advanceId, arg_1_1.id)
	self._advanceId = self._curCfg.advance_id
	self._showCfg = self:getShowCfg()
	self._levelCfgList = self:getLevelCfgList(self._curCfg.level_group)
	self._interactionLvCfgList = self:getInteractionCfgList(self._curCfg.interation_group)
	self._interactionCfgList = g.core.config.succuba_interaction_info.match(function(arg_2_0)
		return arg_2_0.interaction_group == self._advanceId
	end)
	self._advanceStageInfo = nil
end

function SuccubaStruct:_createSimpleMember(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_3 = arg_3_3 or arg_3_1
	arg_3_4 = arg_3_4 or self._svrIndexMap

	local var_3_0 = table.concat({
		"_",
		arg_3_1
	})

	self[var_3_0] = arg_3_2

	local var_3_1 = table.concat({
		string.upper(arg_3_1:sub(1, 1)),
		arg_3_1:sub(2, #arg_3_1)
	})
	local var_3_2 = table.concat({
		"get",
		var_3_1
	})
	local var_3_3 = table.concat({
		"set",
		var_3_1
	})

	self[var_3_2] = self[var_3_2] or function(arg_4_0)
		return arg_4_0[var_3_0]
	end
	self[var_3_3] = self[var_3_3] or function(arg_5_0, arg_5_1)
		arg_5_0[var_3_0] = arg_5_1 == nil and arg_3_2 ~= nil and arg_3_2 or arg_5_1
	end
	arg_3_4[arg_3_3] = self[var_3_3]
end

function SuccubaStruct:updateSvrInfo(arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		self._serverInfo[iter_6_0] = iter_6_1

		if self._svrIndexMap[iter_6_0] then
			self._svrIndexMap[iter_6_0](self, iter_6_1)
		end

		if iter_6_0 == "base_id" and iter_6_1 ~= self._curCfg.id then
			self._curCfg = self:getCfg(nil, iter_6_1)
		end
	end
end

function SuccubaStruct:updateInteractionInfo(arg_7_1)
	for iter_7_0, iter_7_1 in pairs(arg_7_1) do
		self._interactionInfo[iter_7_0] = iter_7_1

		if self._svrInterIndexMap[iter_7_0] then
			self._svrInterIndexMap[iter_7_0](self, iter_7_1)
		end
	end
end

function SuccubaStruct:getCfg(arg_8_1, arg_8_2)
	local var_8_0

	if arg_8_2 then
		var_8_0 = g.core.config.succuba_info.get(arg_8_2)
	elseif arg_8_1 then
		var_8_0 = g.core.config.succuba_info.match(function(arg_9_0)
			return arg_9_0.advance_id == arg_8_1
		end)[1]
	end

	return var_8_0
end

function SuccubaStruct:getShowCfg(arg_10_1)
	arg_10_1 = arg_10_1 or self._curCfg

	return (g.core.config.succuba_show_info.get(arg_10_1.advance_id))
end

function SuccubaStruct:getLevelCfgList(arg_11_1)
	return (g.core.config.succuba_level_info.match(function(arg_12_0)
		return arg_12_0.group == arg_11_1
	end))
end

function SuccubaStruct:getCurLevelCfg()
	for iter_13_0, iter_13_1 in ipairs(self._levelCfgList) do
		if iter_13_1.level == self._level then
			return iter_13_1
		end
	end

	return nil
end

function SuccubaStruct:getNextLevelCfg()
	local var_14_0 = self:getCurLevelCfg()

	if not var_14_0 then
		return nil
	end

	if var_14_0.next_id <= 0 then
		return nil
	end

	return (g.core.config.succuba_level_info.get(var_14_0.next_id))
end

function SuccubaStruct:isMaxLevel()
	return not self:getNextLevelCfg()
end

function SuccubaStruct:getLvTalentSkillList()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(self._levelCfgList) do
		if iter_16_1.talent > 0 then
			table.insert(var_16_0, {
				skillId = iter_16_1.talent,
				lv = iter_16_1.level
			})
		end
	end

	table.sort(var_16_0, function(arg_17_0, arg_17_1)
		if arg_17_0.lv ~= arg_17_1.lv then
			return arg_17_0.lv < arg_17_1.lv
		end

		return false
	end)

	return var_16_0
end

function SuccubaStruct:getCurLvTalentSkill()
	local var_18_0 = 0
	local var_18_1 = 0

	for iter_18_0, iter_18_1 in ipairs((self:getLvTalentSkillList())) do
		if iter_18_1.lv <= self._level then
			var_18_0 = iter_18_1.skillId
		elseif var_18_1 == 0 then
			var_18_1 = iter_18_1.skillId
		end
	end

	if var_18_1 == 0 then
		var_18_1 = var_18_0
	end

	return var_18_0, var_18_1
end

function SuccubaStruct:getCurStarCfg()
	return self._curCfg
end

function SuccubaStruct:getName()
	return self._curCfg.name
end

function SuccubaStruct:getMaxStarLevel()
	return 7
end

function SuccubaStruct:getNextStarCfg()
	if self._curCfg.next_star_id <= 0 then
		return nil
	end

	return (g.core.config.succuba_info.get(self._curCfg.next_star_id))
end

function SuccubaStruct:isMaxStar()
	return not self:getNextStarCfg()
end

function SuccubaStruct:getStarTalentSkillList()
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs((g.core.config.succuba_info.match(function(arg_25_0)
		return arg_25_0.advance_id == self._advanceId
	end))) do
		if iter_24_1.star > 0 then
			if iter_24_1["star_talent_" .. iter_24_1.star] and iter_24_1["star_talent_" .. iter_24_1.star] > 0 then
				table.insert(var_24_0, {
					skillId = iter_24_1["star_talent_" .. iter_24_1.star],
					star = iter_24_1.star
				})
			end
		end
	end

	table.sort(var_24_0, function(arg_26_0, arg_26_1)
		if arg_26_0.star ~= arg_26_1.star then
			return arg_26_0.star < arg_26_1.star
		end

		return false
	end)

	return var_24_0
end

function SuccubaStruct:getCurStarTalentSkill()
	local var_27_0 = 0
	local var_27_1 = 0

	for iter_27_0, iter_27_1 in ipairs((self:getStarTalentSkillList())) do
		if iter_27_1.star <= self._star then
			var_27_0 = iter_27_1.skillId
		elseif var_27_1 == 0 then
			var_27_1 = iter_27_1.skillId
		end
	end

	if var_27_1 == 0 then
		var_27_1 = var_27_0
	end

	return var_27_0, var_27_1
end

function SuccubaStruct:getStarMainSkillList()
	local var_28_0 = {}
	local var_28_1 = {}

	for iter_28_0, iter_28_1 in ipairs((g.core.config.succuba_info.match(function(arg_29_0)
		return arg_29_0.advance_id == self._advanceId
	end))) do
		if iter_28_1.skill_id and iter_28_1.skill_id > 0 then
			table.insert(var_28_0, {
				skillId = iter_28_1.skill_id,
				star = iter_28_1.star
			})
		end

		local var_28_2 = iter_28_1.passive_skill_1

		if iter_28_1.passive_skill_1 and var_28_2 > 0 then
			table.insert(var_28_1, {
				skillId = var_28_2,
				star = iter_28_1.star
			})
		end
	end

	table.sort(var_28_0, function(arg_30_0, arg_30_1)
		if arg_30_0.star ~= arg_30_1.star then
			return arg_30_0.star < arg_30_1.star
		end

		return false
	end)
	table.sort(var_28_1, function(arg_31_0, arg_31_1)
		if arg_31_0.star ~= arg_31_1.star then
			return arg_31_0.star < arg_31_1.star
		end

		return false
	end)

	return var_28_0, var_28_1
end

function SuccubaStruct:getTotalCharm(arg_32_1, arg_32_2)
	local var_32_0, var_32_1 = self:getStarCharm(arg_32_1, true)

	return var_32_0 + self:getLevelCharm(arg_32_2, var_32_1)
end

function SuccubaStruct:getStarCharm(arg_33_1, arg_33_2)
	local var_33_0 = 0
	local var_33_1 = self._curCfg

	if not arg_33_1 then
		var_33_0 = self._curCfg.charm
	else
		local var_33_2 = g.core.config.succuba_info.match(function(arg_34_0)
			return arg_34_0.advance_id == self._advanceId
		end)

		for iter_33_0, iter_33_1 in ipairs(var_33_2) do
			if iter_33_1.star == arg_33_1 then
				var_33_1 = var_33_2[iter_33_0]
				var_33_0 = var_33_2[iter_33_0].charm
			end
		end
	end

	if arg_33_2 then
		return var_33_0, var_33_1
	else
		return var_33_0
	end
end

function SuccubaStruct:getLevelCharm(arg_35_1, arg_35_2)
	arg_35_2 = arg_35_2 or self._curCfg
	arg_35_1 = arg_35_1 or self._level

	return arg_35_2.charm_develop * arg_35_1
end

function SuccubaStruct:getLevelUpSound()
	local var_36_0 = self:getShowCfg()

	return ({
		[30] = var_36_0.sound_level_1,
		[60] = var_36_0.sound_level_2,
		[80] = var_36_0.sound_level_3,
		[100] = var_36_0.sound_level_4,
		[120] = var_36_0.sound_level_5
	})[self._level] or ""
end

function SuccubaStruct:getStarUpSound()
	return self:getShowCfg().sound_star
end

function SuccubaStruct:getInteractionHandbookCfgList()
	return self._interactionCfgList
end

function SuccubaStruct:getInteractionCfgList(arg_39_1)
	return (g.core.config.succuba_interaction_level_info.match(function(arg_40_0)
		return arg_40_0.group == arg_39_1
	end))
end

function SuccubaStruct:getCurInteractionCfg()
	return self._interactionLvCfgList[self:getInteractionLevel() + 1]
end

function SuccubaStruct:getCurCfg()
	return self._curCfg
end

function SuccubaStruct:getMineLevelCfgList()
	return self._levelCfgList
end

function SuccubaStruct:getMineInteractionCfgList()
	return self._interactionLvCfgList
end

function SuccubaStruct:getMineShowCfg()
	return self._showCfg
end

function SuccubaStruct:getAdvanceId()
	return self._advanceId
end

function SuccubaStruct:getQuality()
	return self._curCfg.quality
end

function SuccubaStruct:getCharm()
	if self._charm == 0 then
		return self:getTotalCharm()
	end

	return self._charm
end

function SuccubaStruct:getSid()
	return (self._serverInfo and self._serverInfo.id or nil) and self._serverInfo.id
end

function SuccubaStruct:getType()
	return (self._serverInfo and self._serverInfo.id or nil) and self._serverInfo.id
end

function SuccubaStruct:getSvrInfo()
	return self._serverInfo
end

function SuccubaStruct:getInteractionInfo()
	return self._interactionInfo
end

function SuccubaStruct:getInteractionExp()
	return (self._interactionInfo and self._interactionInfo.exp or nil) and self._interactionInfo.exp
end

function SuccubaStruct:getInteractionLevel()
	if self._interactionInfo then
		return self._interactionInfo.level or 0
	end

	return 0
end

function SuccubaStruct:getInteractionAIExpTimes()
	if self._interactionInfo then
		return self._interactionInfo.exp_times or 0
	end

	return 0
end

function SuccubaStruct:getLastAIExpTimes()
	return self._lastAIExpTimes or 0
end

function SuccubaStruct:onActiveEvent(arg_57_1)
	self._activeEvents[#self._activeEvents + 1] = arg_57_1
end

function SuccubaStruct:isActiveEvent(arg_58_1)
	for iter_58_0, iter_58_1 in ipairs(self._activeEvents) do
		if iter_58_1 == arg_58_1 then
			return true
		end
	end

	return false
end

function SuccubaStruct:costAIExpTimes()
	if self._interactionInfo.exp_times then
		self._lastAIExpTimes = self._interactionInfo.exp_times
		self._interactionInfo.exp_times = self._interactionInfo.exp_times + 1
	else
		self._lastAIExpTimes = 0

		if self._interactionInfo then
			self._interactionInfo.exp_times = 1
		end
	end
end

function SuccubaStruct:getTempAIChatContent()
	local var_60_0 = self:getShowCfg()
	local var_60_1 = {}

	for iter_60_0 = 1, 99 do
		local var_60_2 = table.concat({
			"start_chats_",
			iter_60_0
		})

		if g.core.config.succuba_show_info.hasKey(var_60_2) then
			var_60_1[#var_60_1 + 1] = var_60_0[var_60_2]
		end
	end

	return var_60_1[math.random(1, #var_60_1)]
end

function SuccubaStruct:getRandomDailyTalk()
	local var_61_0 = self:getMineShowCfg()
	local var_61_1 = {}

	for iter_61_0 = 1, 99 do
		local var_61_2 = table.concat({
			"daily_chats_",
			iter_61_0
		})

		if g.core.config.succuba_show_info.hasKey(var_61_2) then
			var_61_1[#var_61_1 + 1] = var_61_0[var_61_2]
		else
			break
		end
	end

	return var_61_1[math.random(1, #var_61_1)]
end

function SuccubaStruct:isOwn()
	return self:getSid() ~= 0
end

function SuccubaStruct:isCanCompose()
	if not self:isOwn() then
		local var_63_0 = self:getCurStarCfg()

		return var_63_0.next_star_num <= math.min(g.core.model.User.fragmentsData:getFragmentNumById(var_63_0.fragment), var_63_0.next_star_num)
	end

	return false
end

function SuccubaStruct:refreshAdvanceStageInfo()
	local var_64_0 = self:getStage()
	local var_64_1 = self:getNode()

	for iter_64_0, iter_64_1 in var_0_0.ipairs() do
		if iter_64_1.advance_id == self._advanceId and iter_64_1.stage == var_64_0 and iter_64_1.node == var_64_1 then
			self._advanceStageInfo = iter_64_1
		end
	end
end

function SuccubaStruct:getAdvanceStageInfo()
	if not self._advanceStageInfo then
		self:refreshAdvanceStageInfo()
	end

	return self._advanceStageInfo
end

function SuccubaStruct:isPut()
	return not g.core.model.User.homeData:checkItemIsInUnputList("succuba_info", self._curCfg.advance_id)
end

function SuccubaStruct:isLvUpAvailable()
	if self:isMaxLevel() then
		return false
	end

	if self._level >= self._curCfg.level_max then
		return false
	end

	local var_67_0 = self:getCurLevelCfg()

	for iter_67_0 = 1, 2 do
		if var_67_0["size_" .. iter_67_0] > 0 and var_67_0["size_" .. iter_67_0] > g.core.model.User.bagData:getOwnNum(var_67_0["type_" .. iter_67_0], var_67_0["value_" .. iter_67_0]) then
			return false
		end
	end

	return true
end

function SuccubaStruct:isStarUpAvailable()
	if self:isMaxStar() then
		return false
	end

	if g.core.model.User.fragmentsData:getFragmentNumById(self._curCfg.fragment) < self._curCfg.next_star_num then
		return false
	end

	return true
end

function SuccubaStruct:isAdvUpAvailable()
	if not self._advanceStageInfo then
		self:refreshAdvanceStageInfo()
	end

	if not self._advanceStageInfo or self._advanceStageInfo.id_num <= 0 then
		return false
	end

	self._costList = {}

	while var_0_0.hasKey("cost_type_" .. 1) do
		if self._advanceStageInfo["cost_num_" .. 1] > 0 and self._advanceStageInfo["cost_num_" .. 1] > g.core.model.User.bagData:getOwnNum(self._advanceStageInfo["cost_type_" .. 1], self._advanceStageInfo["cost_value_" .. 1]) then
			return false
		end
	end

	return true
end

return SuccubaStruct
