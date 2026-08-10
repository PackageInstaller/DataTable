HodurChapterTemplate = class("HodurChapterTemplate")

function HodurChapterTemplate.Ctor(arg_1_0, arg_1_1)
	arg_1_0.chapter_id = arg_1_1.normal_stage_id
	arg_1_0.option_list = arg_1_1.normal_option_info
	arg_1_0.hero_list = {}
	arg_1_0.complete_stage_list = {}
	arg_1_0.cur_complete_stage_list = {}

	if arg_1_1.normal_hero_stage_info then
		for iter_1_0, iter_1_1 in ipairs(arg_1_1.normal_hero_stage_info) do
			table.insert(arg_1_0.hero_list, {
				heroID = iter_1_1.hero_id,
				hp = iter_1_1.hero_blood,
				maxHP = iter_1_1.hero_max_blood
			})
		end
	end

	if arg_1_1.normal_boss_id_list then
		for iter_1_2, iter_1_3 in ipairs(arg_1_1.normal_boss_id_list) do
			table.insert(arg_1_0.complete_stage_list, iter_1_3.boss_id)

			if iter_1_3.result == 1 then
				table.insert(arg_1_0.cur_complete_stage_list, iter_1_3.boss_id)
			end
		end
	end
end

function HodurChapterTemplate.GetChapterID(arg_2_0)
	return arg_2_0.chapter_id
end

function HodurChapterTemplate.ResetData(arg_3_0)
	arg_3_0.option_list = {}
	arg_3_0.hero_list = {}
	arg_3_0.cur_complete_stage_list = {}
end

function HodurChapterTemplate.GetAffixList(arg_4_0)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.option_list) do
		local var_4_1 = ActivityHodurEventOptionCfg[iter_4_1]

		table.insert(var_4_0, tonumber(var_4_1.buff_id))
	end

	return var_4_0
end

function HodurChapterTemplate.GetPassNum(arg_5_0)
	return #arg_5_0.complete_stage_list, #arg_5_0.cur_complete_stage_list
end

function HodurChapterTemplate.GetHeroHP(arg_6_0, arg_6_1)
	if arg_6_0.hero_list == nil or #arg_6_0.hero_list == 0 then
		return -1, -1
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.hero_list) do
		if iter_6_1.heroID == arg_6_1 then
			return iter_6_1.hp, iter_6_1.maxHP
		end
	end

	return -1, -1
end

HodurChallengeTemplate = class("HodurChallengeTemplate")

function HodurChallengeTemplate.Ctor(arg_7_0, arg_7_1)
	arg_7_0.chapter_id = arg_7_1.challenge_stage_id
	arg_7_0.buff_list = arg_7_1.challenge_buff_info
	arg_7_0.max_score = arg_7_1.challenge_max_score
	arg_7_0.hero_list = {}
	arg_7_0.cache_hero_list = {}
	arg_7_0.complete_stage_list = {}
	arg_7_0.cur_score_list = {}
	arg_7_0.boss_max_score = {}
	arg_7_0.detail_score_list = {}

	if arg_7_1.challenge_hero_stage_info then
		for iter_7_0, iter_7_1 in ipairs(arg_7_1.challenge_hero_stage_info) do
			table.insert(arg_7_0.hero_list, {
				heroID = iter_7_1.hero_id,
				hp = iter_7_1.hero_blood,
				maxHP = iter_7_1.hero_max_blood
			})
		end
	end

	if arg_7_1.last_status then
		for iter_7_2, iter_7_3 in ipairs(arg_7_1.last_status) do
			table.insert(arg_7_0.cache_hero_list, {
				heroID = iter_7_3.hero_id,
				hp = iter_7_3.hero_blood,
				maxHP = iter_7_3.hero_max_blood
			})
		end
	end

	if arg_7_1.challenge_boss_list then
		for iter_7_4, iter_7_5 in ipairs(arg_7_1.challenge_boss_list) do
			if iter_7_5.score > 0 then
				table.insert(arg_7_0.complete_stage_list, iter_7_5.boss_id)
				table.insert(arg_7_0.cur_score_list, iter_7_5.score)
			end

			table.insert(arg_7_0.boss_max_score, iter_7_5.max_score)
		end
	end

	if arg_7_1.score_list then
		for iter_7_6, iter_7_7 in ipairs(arg_7_1.score_list) do
			arg_7_0.detail_score_list[iter_7_6] = iter_7_7
		end
	end
end

function HodurChallengeTemplate.ResetData(arg_8_0)
	arg_8_0.buff_list = {}
	arg_8_0.hero_list = {}
	arg_8_0.cache_hero_list = {}
	arg_8_0.complete_stage_list = {}

	local var_8_0 = 0

	for iter_8_0, iter_8_1 in pairs(arg_8_0.cur_score_list) do
		var_8_0 = var_8_0 + iter_8_1
	end

	arg_8_0.cur_score_list = {}
	arg_8_0.max_score = math.max(arg_8_0.max_score, var_8_0)
end

function HodurChallengeTemplate.GetMaxScore(arg_9_0)
	return arg_9_0.max_score
end

function HodurChallengeTemplate.GetHeroList(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.hero_list) do
		table.insert(var_10_0, iter_10_1.heroID)
	end

	return var_10_0
end

function HodurChallengeTemplate.GetHeroBattleList(arg_11_0, arg_11_1)
	if arg_11_1 and arg_11_0.cache_hero_list then
		return arg_11_0.cache_hero_list
	end

	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.hero_list) do
		if iter_11_1.hp > 0 then
			table.insert(var_11_0, iter_11_1.heroID)
		end
	end

	return var_11_0
end

function HodurChallengeTemplate.GetHeroHP(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_2 and arg_12_0.cache_hero_list or arg_12_0.hero_list

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if iter_12_1.heroID == arg_12_1 then
			return iter_12_1.hp, iter_12_1.maxHP == 0 and 1 or iter_12_1.maxHP
		end
	end

	return -1, -1
end

function HodurChallengeTemplate.GetCurTotalScore(arg_13_0)
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.cur_score_list) do
		var_13_0 = var_13_0 + iter_13_1
	end

	return var_13_0
end

function HodurChallengeTemplate.GetStageMaxScore(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.complete_stage_list) do
		if iter_14_1 == arg_14_1 then
			return arg_14_0.boss_max_score[iter_14_0]
		end
	end

	return 0
end

function HodurChallengeTemplate.GetScoreList(arg_15_0)
	return arg_15_0.detail_score_list
end
