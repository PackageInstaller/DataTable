local var_0_0 = {
	CheckHeroIsAttack = function(arg_1_0, arg_1_1)
		return IdolTraineeData:GetCurAttackHero()[arg_1_1]
	end,
	CheckHeroIsDefine = function(arg_2_0, arg_2_1)
		return IdolTraineeData:GetCurDefendHero()[arg_2_1]
	end,
	CheckHeroRaceBuff = function(arg_3_0, arg_3_1)
		return IdolTraineeData:GetCurBuffCamp()[HeroCfg[arg_3_1].race]
	end,
	GetBackHomeHeadSprite = function(arg_4_0)
		if IdolPveNpcCfg[arg_4_0] then
			arg_4_0 = IdolPveNpcCfg[arg_4_0].icon
		end

		if arg_4_0 then
			return getSpriteViaConfig("DormHeroHeadIcon", arg_4_0)
		end
	end,
	GetHeroIdolMaxProperty = function(arg_5_0, arg_5_1)
		local var_5_0 = {}
		local var_5_1 = BackHomeHeroCfg[arg_5_1]

		for iter_5_0, iter_5_1 in pairs(var_5_1.idol_base_attribute) do
			table.insert(var_5_0, iter_5_1[2])
		end

		return var_5_0
	end,
	GetChapterProgress = function(arg_6_0, arg_6_1)
		local var_6_0 = #IdolTraineeChapterCfg[arg_6_1].section_id_list
		local var_6_1 = IdolTraineeData:GetPveChapterData()[arg_6_1]
		local var_6_2 = 0

		if var_6_1 then
			for iter_6_0, iter_6_1 in pairs(var_6_1) do
				if iter_6_1.pass then
					var_6_2 = var_6_2 + 1
				end
			end
		end

		return var_6_2, var_6_0
	end,
	GetChapterScoreList = function(arg_7_0, arg_7_1)
		return IdolTraineeData:GetPveChapterData()[arg_7_1]
	end,
	GetOpponentData = function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		if arg_8_2 == IdolTraineeConst.friendType.friend then
			return IdolTraineeData:GetCacheFriendList()[arg_8_1]
		elseif arg_8_2 == IdolTraineeConst.friendType.stranger then
			return IdolTraineeData:GetCacheOpponentList()[arg_8_1]
		end

		return {}
	end,
	GetEnemyUserData = function(arg_9_0, arg_9_1)
		local var_9_0 = IdolTraineeData:GetCacheFriendList()[arg_9_1] or IdolTraineeData:GetCacheOpponentList()[arg_9_1]

		if not var_9_0 then
			local var_9_1 = IdolTraineeData:GetHistoryBattleData()

			for iter_9_0, iter_9_1 in pairs(var_9_1) do
				if iter_9_1.userID == arg_9_1 then
					var_9_0 = iter_9_1

					break
				end
			end
		end

		return var_9_0
	end
}

local function var_0_1(arg_10_0)
	local var_10_0 = IdolTraineeSkillEffectCfg[arg_10_0]

	if not var_10_0 or var_10_0.valid_probability == 100 then
		return nil
	end

	local var_10_1 = IdolTraineeSkillDescCfg.DEFAULT_ROUND_PROBABILITY

	if not var_10_1 then
		return nil
	end

	return string.format(GetI18NText(var_10_1.pattern), var_10_0.valid_probability)
end

local function var_0_2(arg_11_0)
	local var_11_0 = IdolTraineeSkillEffectCfg[arg_11_0]

	if not var_11_0 or var_11_0.condition == 0 then
		return nil
	end

	local var_11_1 = "DEFAULT_CONDITION_" .. var_11_0.condition
	local var_11_2 = {}
	local var_11_3 = GetTips(var_11_0.object == 1 and "IDOL_SKILL_DESC_OBJ_0" or "IDOL_SKILL_DESC_OBJ_1")

	table.insert(var_11_2, var_11_3)

	if var_11_0.condition == 1 then
		local var_11_4 = IdolStageSceneCfg[var_11_0.con_param[1]] and IdolStageSceneCfg[var_11_0.con_param[1]].scene_show_name or ""

		table.insert(var_11_2, var_11_4)
	elseif var_11_0.condition == 2 or var_11_0.condition == 4 then
		local var_11_5 = var_11_0.con_param[1] .. ""

		table.insert(var_11_2, var_11_5)
	elseif var_11_0.condition == 5 then
		local var_11_6 = GetTips(IdolTraineeConst.style[var_11_0.con_param[1]])

		table.insert(var_11_2, var_11_6)
	end

	local var_11_7 = IdolTraineeSkillDescCfg[var_11_1]

	if not var_11_7 then
		return nil
	end

	return string.format(GetI18NText(var_11_7.pattern), unpack(var_11_2))
end

local function var_0_3(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0

	if arg_12_0 and arg_12_2 then
		var_12_0 = GetI18NText(IdolTraineeSkillDescCfg.DEFAULT_JOIN.pattern)
	elseif arg_12_0 then
		var_12_0 = GetI18NText(IdolTraineeSkillDescCfg.DEFAULT_JOIN_NO_SUFFIX.pattern)
	elseif arg_12_2 then
		var_12_0 = GetI18NText(IdolTraineeSkillDescCfg.DEFAULT_JOIN_NO_PREFIX.pattern)
	else
		return arg_12_1
	end

	return LuaExchangeHelper.GetDescription(var_12_0, {
		arg_12_0,
		arg_12_1,
		arg_12_2
	})
end

local function var_0_4(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = IdolTraineeSkillEffectCfg[arg_13_0]
	local var_13_1 = var_13_0.effect_type
	local var_13_2 = arg_13_1 or var_13_0.probability >= 100
	local var_13_3 = {
		args = {},
		buffID = arg_13_0,
		effect = var_13_1,
		target = var_13_0.object
	}

	if not arg_13_2 and var_13_0.trigger_time ~= 0 then
		var_13_3.delay = var_13_0.trigger_time
	end

	if not arg_13_3 and var_13_0.round ~= -1 then
		var_13_3.round = var_13_0.round
	end

	if not var_13_2 then
		var_13_3.chance = var_13_0.probability
	end

	if var_13_1 == 1 then
		var_13_3.args[1] = GetTips("IDOL_SKILL_ATTRIBUTE_" .. var_13_0.unique[1])
		var_13_3.positive = var_13_0.unique[2] >= 0
		var_13_3.buffValue = var_13_0.unique[2]
	elseif var_13_1 == 2 then
		var_13_3.args[1] = GetTips(IdolTraineeConst.style[var_13_0.unique[1]])
		var_13_3.positive = var_13_0.unique[2] >= 0
		var_13_3.buffValue = var_13_0.unique[2]
	elseif var_13_1 == 3 or var_13_1 == 4 or var_13_1 == 5 or var_13_1 == 6 or var_13_1 == 7 then
		var_13_3.positive = var_13_0.unique[1] >= 0
		var_13_3.buffValue = var_13_0.unique[1]
	elseif var_13_1 == 8 then
		var_13_3.args[1] = GetTips("IDOL_SKILL_ATTRIBUTE_" .. var_13_0.unique[1])
		var_13_3.positive = var_13_0.unique[2] >= 0
		var_13_3.buffValue = var_13_0.unique[2]
	else
		Debug.LogError("idol_trainee_skill_desc表中有类型程序未指定拼接描述规则" .. var_13_0.id)

		var_13_3.invalid = true
	end

	if var_13_3.buffValue then
		var_13_3.absBuffValue = math.abs(var_13_3.buffValue)
	end

	return var_13_3
end

local function var_0_5(arg_14_0, arg_14_1)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_0) do
		table.insert(var_14_0, arg_14_1(iter_14_1))
	end

	for iter_14_2, iter_14_3 in ipairs(var_14_0) do
		table.insert(arg_14_0, iter_14_3)
	end
end

local function var_0_6(arg_15_0)
	local var_15_0 = "BUFF_EFFECT"
	local var_15_1 = "_" .. arg_15_0.effect
	local var_15_2 = {
		var_15_0
	}
	local var_15_3 = "_DELAY"
	local var_15_4 = "_ROUND"
	local var_15_5 = "_RNG"
	local var_15_6 = "_POS"
	local var_15_7 = "_NEG"
	local var_15_8 = "_FULL"

	if arg_15_0.delay then
		var_0_5(var_15_2, function(arg_16_0)
			return arg_16_0 .. var_15_3
		end)
	end

	if arg_15_0.round then
		var_0_5(var_15_2, function(arg_17_0)
			return arg_17_0 .. var_15_4
		end)
	end

	if arg_15_0.chance then
		var_0_5(var_15_2, function(arg_18_0)
			return arg_18_0 .. var_15_5
		end)
	end

	if arg_15_0.delay and arg_15_0.round and arg_15_0.chance then
		table.insert(var_15_2, var_15_0 .. var_15_8)
	end

	local var_15_9 = arg_15_0.positive and var_15_6 or var_15_7

	for iter_15_0 = #var_15_2, 1, -1 do
		local var_15_10 = var_15_2[iter_15_0]
		local var_15_11 = IdolTraineeSkillDescCfg[var_15_10 .. var_15_9 .. var_15_1] or IdolTraineeSkillDescCfg[var_15_10 .. var_15_1]

		if var_15_11 then
			local var_15_12 = GetI18NText(var_15_11.pattern)

			if not var_15_11.is_full_info and (arg_15_0.chance or arg_15_0.round) then
				local var_15_13
				local var_15_14

				if arg_15_0.chance then
					var_15_13 = GetI18NText(IdolTraineeSkillDescCfg.DEFAULT_PREFIX.pattern)
				end

				if arg_15_0.round then
					var_15_14 = GetI18NText(IdolTraineeSkillDescCfg.DEFAULT_SUFFIX.pattern)
				end

				var_15_12 = var_0_3(var_15_13, var_15_12, var_15_14)
			end

			return var_15_12
		end
	end

	return ""
end

local function var_0_7(arg_19_0)
	local var_19_0 = arg_19_0

	if not var_19_0.invalid then
		local var_19_1 = var_0_6(var_19_0)
		local var_19_2 = GetTips(var_19_0.target == 1 and "IDOL_SKILL_DESC_OBJ_0" or "IDOL_SKILL_DESC_OBJ_1")
		local var_19_3 = {
			var_19_2,
			var_19_0.buffValue,
			var_19_0.absBuffValue,
			var_19_0.chance or "",
			var_19_0.delay or "",
			var_19_0.round or "",
			unpack(var_19_0.args)
		}
		local var_19_4 = LuaExchangeHelper.GetDescription(var_19_1, var_19_3)
		local var_19_5 = arg_19_0.buffID
		local var_19_6 = var_0_2(var_19_5)
		local var_19_7 = var_0_1(var_19_5)

		return var_0_3(var_19_6, var_19_4, var_19_7)
	end

	return ""
end

function var_0_0.GetBuffDescString(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	local var_20_0 = var_0_4(arg_20_1, arg_20_2, arg_20_3, arg_20_4)

	return (var_0_7(var_20_0))
end

function var_0_0.GetSkillDescString(arg_21_0, arg_21_1)
	local var_21_0 = IdolTraineeSkillCfg[arg_21_1]
	local var_21_1 = ""

	for iter_21_0, iter_21_1 in ipairs(var_21_0.skill_effect) do
		local var_21_2 = ""

		if iter_21_0 ~= #var_21_0.skill_effect then
			var_21_2 = "\n"
		end

		local var_21_3 = arg_21_0:GetBuffDescString(iter_21_1) .. var_21_2

		var_21_1 = var_21_1 .. var_21_3
	end

	return var_21_1
end

function var_0_0.GetSkillEffect(arg_22_0, arg_22_1)
	local var_22_0 = IdolTraineeSkillEffectCfg[arg_22_1]

	if var_22_0.effect_type == 1 then
		local var_22_1 = var_22_0.unique[1]
		local var_22_2 = var_22_0.unique[2]

		return var_22_1, var_22_2
	end

	return nil
end

function var_0_0.GetCurQuestRankInfo(arg_23_0)
	local var_23_0 = IdolTraineeData:GetQuestRankInfo()
	local var_23_1 = IdolTraineeRewardRankCfg[var_23_0]
	local var_23_2 = ItemTools.getItemNum(var_23_1.item_id[1])
	local var_23_3 = var_23_1.item_id[2]
	local var_23_4 = IdolTraineeData:GetQuestWeeklyData()

	return var_23_0, var_23_2, var_23_3, var_23_4
end

function var_0_0.GetCurTrainMaxTimes(arg_24_0)
	local var_24_0 = DormRoomTools:GetUnlockRoomNum()
	local var_24_1 = 0

	for iter_24_0, iter_24_1 in pairs(GameSetting.dorm_idol_hero_exercise_times_limit.value) do
		if var_24_0 >= iter_24_1[1] then
			var_24_1 = iter_24_1[2]
		end
	end

	return var_24_1
end

function var_0_0.GetOpponentList(arg_25_0, arg_25_1)
	local var_25_0 = {}
	local var_25_1 = {}

	if arg_25_1 == IdolTraineeConst.friendType.friend then
		var_25_1 = IdolTraineeData:GetCacheFriendList()
	elseif arg_25_1 == IdolTraineeConst.friendType.stranger then
		var_25_1 = IdolTraineeData:GetCacheOpponentList()
	end

	for iter_25_0, iter_25_1 in pairs(var_25_1) do
		table.insert(var_25_0, iter_25_0)
	end

	return var_25_0
end

function var_0_0.GetHeroBattleInfoTemplate(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	local var_26_0 = {
		heroIcon = "",
		heroID = 0,
		propertyData = {},
		propertyMax = {},
		skill = {}
	}

	if IdolTraineeConst.friendType.npc == arg_26_3 then
		local var_26_1, var_26_2 = IdolTraineeData:GetNpcPropertyByStageID(arg_26_4)

		var_26_0.heroID = var_26_2
		var_26_0.skinID = var_26_2
		var_26_0.heroIcon = DormHeroTools.GetBackHomeHeadSprite(var_26_2)
		var_26_0.propertyData = var_26_1
		var_26_0.propertyMax = var_26_1
		var_26_0.skill = IdolTraineeData:GetIdolHeroSkillList(var_26_2)
	elseif arg_26_2 then
		local var_26_3

		if arg_26_3 == IdolTraineeConst.friendType.friend then
			var_26_3 = IdolTraineeData:GetCacheFriendList()[arg_26_2]
		else
			var_26_3 = IdolTraineeData:GetCacheOpponentList()[arg_26_2]
		end

		var_26_0.heroID = var_26_3.hero_id
		var_26_0.skinID = var_26_3.skin_id
		var_26_0.heroIcon = IdolTraineeTools.GetBackHomeHeadSprite(var_26_3.skin_id)
		var_26_0.propertyData = var_26_3.property
		var_26_0.propertyMax = IdolTraineeTools:GetHeroIdolMaxProperty(var_26_3.hero_id)
		var_26_0.skill = IdolTraineeData:GetIdolHeroSkillList(var_26_3.hero_id)
	else
		var_26_0.heroID = arg_26_1
		var_26_0.skinID = DormHeroTools:GetCurSkinID(arg_26_1)
		var_26_0.heroIcon = IdolTraineeTools.GetBackHomeHeadSprite(var_26_0.skinID)
		var_26_0.propertyData = IdolTraineeData:GetIdolHeroData(arg_26_1)
		var_26_0.propertyMax = IdolTraineeTools:GetHeroIdolMaxProperty(arg_26_1)
		var_26_0.skill = IdolTraineeData:GetIdolHeroSkillList(arg_26_1)
	end

	return var_26_0
end

function var_0_0.GetAbilityIcon(arg_27_0, arg_27_1)
	return
end

function var_0_0.GetBuffIcon(arg_28_0, arg_28_1)
	local var_28_0 = IdolTraineeSkillEffectCfg[arg_28_1]

	if not var_28_0.effect_icon then
		return nil
	end

	return getSpriteWithoutAtlas(SpritePathCfg.IdolDanceBuffIcon.path .. var_28_0.effect_icon)
end

function var_0_0.GetSkillIcon(arg_29_0, arg_29_1)
	local var_29_0 = IdolTraineeSkillCfg[arg_29_1]

	if not var_29_0.icon then
		return nil
	end

	return getSpriteWithoutAtlas(SpritePathCfg.IdolDanceSkillIcon.path .. var_29_0.icon)
end

function var_0_0.CheckDanceTaskComplete(arg_30_0)
	local var_30_0 = TaskTools:GetIdolTraineeTaskSortList()

	for iter_30_0, iter_30_1 in pairs(var_30_0) do
		local var_30_1 = TaskData2:GetTaskComplete(iter_30_1)

		if TaskData2:GetTaskProgress(iter_30_1) >= AssignmentCfg[iter_30_1].need and not var_30_1 then
			return true
		end
	end
end

function var_0_0.GetPveStageChapter(arg_31_0, arg_31_1)
	for iter_31_0, iter_31_1 in ipairs(IdolTraineeChapterCfg.all) do
		local var_31_0 = IdolTraineeChapterCfg[iter_31_1]

		if table.keyof(var_31_0.section_id_list, arg_31_1) ~= nil then
			return iter_31_1
		end
	end

	return nil
end

local var_0_8 = 2

function var_0_0.GetMusicDuration(arg_32_0)
	local var_32_0 = IdolStageMusicCfg[arg_32_0]

	if var_32_0 then
		local var_32_1 = var_32_0.music_duration

		if var_32_1 then
			return var_32_1
		end

		local var_32_2 = var_32_0.music_json
		local var_32_3 = AssetEx.LoadText(var_32_2)
		local var_32_4 = require("cjson").decode(var_32_3)
		local var_32_5 = 0

		for iter_32_0 = 1, var_0_8 do
			local var_32_6 = var_32_4["track" .. iter_32_0]

			for iter_32_1, iter_32_2 in pairs(var_32_6) do
				local var_32_7 = math.max(unpack(iter_32_2))

				if var_32_5 < var_32_7 then
					var_32_5 = var_32_7
				end
			end
		end

		return var_32_5 / 1000
	end

	return nil
end

function var_0_0.GetDanceDIYActionUnlockDesc(arg_33_0)
	local var_33_0 = IdolDanceDIYActionCfg[arg_33_0].unlock_condition

	if var_33_0 == 0 then
		return nil
	end

	local var_33_1 = nullable(ConditionCfg, var_33_0, "desc")

	if var_33_1 then
		return GetTipsF(var_33_1, IdolDanceDIYActionCfg[arg_33_0].need)
	else
		return ""
	end
end

function var_0_0.GetDIYDataFromLoadInfo(arg_34_0)
	if arg_34_0 == nil then
		return nil
	elseif arg_34_0.source == IdolTraineeConst.DataSource.MyData then
		return IdolTraineeData:GetDanceDIYSequence(arg_34_0.id)
	elseif arg_34_0.source == IdolTraineeConst.DataSource.MySharedData then
		return arg_34_0.data or IdolTraineeData:GetSharedDanceDIYSequence(arg_34_0.id)
	else
		return arg_34_0.data
	end
end

function var_0_0.GetDIYDanceDataName(arg_35_0)
	return GetTipsF("IDOL_DANCE_EDIT_SEQ_NAME", arg_35_0)
end

function var_0_0.GetSharedDIYDanceDataName(arg_36_0)
	return GetTipsF("IDOL_DANCE_EDIT_SHOW_SHARED_AUTHOR_NAME", arg_36_0 or "--")
end

function var_0_0.CalculateActionCount(arg_37_0)
	local var_37_0 = 0

	if arg_37_0 then
		for iter_37_0, iter_37_1 in ipairs(arg_37_0) do
			if iter_37_1 and iter_37_1 ~= 0 then
				var_37_0 = var_37_0 + 1
			end
		end
	end

	return var_37_0
end

local function var_0_9(arg_38_0, arg_38_1, arg_38_2)
	if CommonFilterData:AtLeastOneChooseGroup(arg_38_0.filter_id, arg_38_1.groupID) and not CommonFilterData:HasIndexFlag(arg_38_0.filter_id, arg_38_1.groupID, arg_38_2) then
		return false
	end

	return true
end

function var_0_0.FilterDIYDanceAction(arg_39_0)
	local var_39_0 = IdolDanceDIYActionCfg[arg_39_0]
	local var_39_1 = Filter_Root_Define.IDOL_DANCE_ACTION_Filter_List
	local var_39_2 = Filter_Group_Define.IDOL_DANCE_ACTION_STYLE
	local var_39_3 = Filter_Group_Define.IDOL_DANCE_ACTION_BEAT

	if not var_0_9(var_39_1, var_39_2, var_39_2.tags[var_39_0.type]) then
		return false
	end

	if not var_0_9(var_39_1, var_39_3, Filter_Tags_Define["IdolDanceBeat" .. var_39_0.beat]) then
		return false
	end

	return true
end

function var_0_0.ViewSharedDIY(arg_40_0)
	IdolTraineeAction.GetSharedDanceDIYSequenceDetail(arg_40_0.id, function(arg_41_0)
		IdolTraineeData.ParseDanceDIYSequence(arg_41_0.base_sequence, arg_40_0.data)
		IdolTraineeData.UpdateDIYStatistics(arg_40_0.data, arg_41_0)

		arg_40_0.data.myTodayLiked = arg_41_0.own_today_liked_num

		DIYBridge.EnterDIY(arg_40_0)
	end)
end

function var_0_0.FetchSharedDIY(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = IdolTraineeData:BriefListCacheAvailable(arg_42_1)

	if arg_42_0 or not var_42_0 then
		IdolTraineeAction.GetSharedDanceDIYBriefList(arg_42_1, function(arg_43_0)
			IdolTraineeData.cachedAuthorInfo = IdolTraineeAction.ProcessAuthorInfo(arg_43_0, IdolTraineeData.cachedAuthorInfo)

			local var_43_0 = IdolTraineeAction.ProcessBriefList(arg_43_0, IdolTraineeData.cachedAuthorInfo)

			table.sort(var_43_0, function(arg_44_0, arg_44_1)
				return arg_44_0.recommend > arg_44_1.recommend
			end)
			IdolTraineeData:CacheBriefList(arg_42_1, var_43_0)

			if arg_42_2 then
				arg_42_2(var_43_0)
			end
		end, function()
			if arg_42_2 then
				arg_42_2(var_42_0 or {})
			end
		end)
	elseif arg_42_2 then
		arg_42_2(var_42_0)
	end
end

return var_0_0
