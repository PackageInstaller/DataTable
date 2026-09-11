HodurChapterTemplate = class("HodurChapterTemplate")

function HodurChapterTemplate:Ctor(arg_1_1)
	self.chapter_id = arg_1_1.normal_stage_id
	self.option_list = arg_1_1.normal_option_info
	self.hero_list = {}
	self.complete_stage_list = {}
	self.cur_complete_stage_list = {}

	if arg_1_1.normal_hero_stage_info then
		for iter_1_0, iter_1_1 in ipairs(arg_1_1.normal_hero_stage_info) do
			table.insert(self.hero_list, {
				heroID = iter_1_1.hero_id,
				hp = iter_1_1.hero_blood,
				maxHP = iter_1_1.hero_max_blood
			})
		end
	end

	if arg_1_1.normal_boss_id_list then
		for iter_1_2, iter_1_3 in ipairs(arg_1_1.normal_boss_id_list) do
			table.insert(self.complete_stage_list, iter_1_3.boss_id)

			if iter_1_3.result == 1 then
				table.insert(self.cur_complete_stage_list, iter_1_3.boss_id)
			end
		end
	end
end

function HodurChapterTemplate:GetChapterID()
	return self.chapter_id
end

function HodurChapterTemplate.ResetData(arg_3_0)
	arg_3_0.option_list = {}
	arg_3_0.hero_list = {}
	arg_3_0.cur_complete_stage_list = {}
end

function HodurChapterTemplate:GetAffixList()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(self.option_list) do
		table.insert(var_4_0, tonumber(ActivityHodurEventOptionCfg[iter_4_1].buff_id))
	end

	return var_4_0
end

function HodurChapterTemplate:GetPassNum()
	return #self.complete_stage_list, #self.cur_complete_stage_list
end

function HodurChapterTemplate:GetHeroHP(arg_6_1)
	if self.hero_list == nil or #self.hero_list == 0 then
		return -1, -1
	end

	for iter_6_0, iter_6_1 in ipairs(self.hero_list) do
		if iter_6_1.heroID == arg_6_1 then
			return iter_6_1.hp, iter_6_1.maxHP
		end
	end

	return -1, -1
end

HodurChallengeTemplate = class("HodurChallengeTemplate")

function HodurChallengeTemplate:Ctor(arg_7_1)
	self.chapter_id = arg_7_1.challenge_stage_id
	self.buff_list = arg_7_1.challenge_buff_info
	self.max_score = arg_7_1.challenge_max_score
	self.hero_list = {}
	self.cache_hero_list = {}
	self.complete_stage_list = {}
	self.cur_score_list = {}
	self.boss_max_score = {}
	self.detail_score_list = {}

	if arg_7_1.challenge_hero_stage_info then
		for iter_7_0, iter_7_1 in ipairs(arg_7_1.challenge_hero_stage_info) do
			table.insert(self.hero_list, {
				heroID = iter_7_1.hero_id,
				hp = iter_7_1.hero_blood,
				maxHP = iter_7_1.hero_max_blood
			})
		end
	end

	if arg_7_1.last_status then
		for iter_7_2, iter_7_3 in ipairs(arg_7_1.last_status) do
			table.insert(self.cache_hero_list, {
				heroID = iter_7_3.hero_id,
				hp = iter_7_3.hero_blood,
				maxHP = iter_7_3.hero_max_blood
			})
		end
	end

	if arg_7_1.challenge_boss_list then
		for iter_7_4, iter_7_5 in ipairs(arg_7_1.challenge_boss_list) do
			if iter_7_5.score > 0 then
				table.insert(self.complete_stage_list, iter_7_5.boss_id)
				table.insert(self.cur_score_list, iter_7_5.score)
			end

			table.insert(self.boss_max_score, iter_7_5.max_score)
		end
	end

	if arg_7_1.score_list then
		for iter_7_6, iter_7_7 in ipairs(arg_7_1.score_list) do
			self.detail_score_list[iter_7_6] = iter_7_7
		end
	end
end

function HodurChallengeTemplate:ResetData()
	self.buff_list = {}
	self.hero_list = {}
	self.cache_hero_list = {}
	self.complete_stage_list = {}

	local var_8_0 = 0

	for iter_8_0, iter_8_1 in pairs(self.cur_score_list) do
		var_8_0 = var_8_0 + iter_8_1
	end

	self.cur_score_list = {}
	self.max_score = math.max(self.max_score, var_8_0)
end

function HodurChallengeTemplate:GetMaxScore()
	return self.max_score
end

function HodurChallengeTemplate:GetHeroList()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(self.hero_list) do
		table.insert(var_10_0, iter_10_1.heroID)
	end

	return var_10_0
end

function HodurChallengeTemplate:GetHeroBattleList(arg_11_1)
	if arg_11_1 and self.cache_hero_list then
		return self.cache_hero_list
	end

	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(self.hero_list) do
		if iter_11_1.hp > 0 then
			table.insert(var_11_0, iter_11_1.heroID)
		end
	end

	return var_11_0
end

function HodurChallengeTemplate:GetHeroHP(arg_12_1, arg_12_2)
	for iter_12_0, iter_12_1 in ipairs((arg_12_2 or nil) and (self.cache_hero_list or self.hero_list)) do
		if iter_12_1.heroID == arg_12_1 then
			return iter_12_1.hp, iter_12_1.maxHP == 0 and 1 or iter_12_1.maxHP
		end
	end

	return -1, -1
end

function HodurChallengeTemplate:GetCurTotalScore()
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in ipairs(self.cur_score_list) do
		var_13_0 = var_13_0 + iter_13_1
	end

	return var_13_0
end

function HodurChallengeTemplate:GetStageMaxScore(arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(self.complete_stage_list) do
		if iter_14_1 == arg_14_1 then
			return self.boss_max_score[iter_14_0]
		end
	end

	return 0
end

function HodurChallengeTemplate:GetScoreList()
	return self.detail_score_list
end
