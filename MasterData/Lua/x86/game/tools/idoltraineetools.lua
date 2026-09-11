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

		for iter_5_0, iter_5_1 in pairs(BackHomeHeroCfg[arg_5_1].idol_base_attribute) do
			table.insert(var_5_0, iter_5_1[2])
		end

		return var_5_0
	end,
	GetChapterProgress = function(arg_6_0, arg_6_1)
		local var_6_0 = IdolTraineeData:GetPveChapterData()[arg_6_1]
		local var_6_1 = 0

		if var_6_0 then
			for iter_6_0, iter_6_1 in pairs(var_6_0) do
				if iter_6_1.pass then
					var_6_1 = var_6_1 + 1
				end
			end
		end

		return var_6_1, #IdolTraineeChapterCfg[arg_6_1].section_id_list
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
			for iter_9_0, iter_9_1 in pairs((IdolTraineeData:GetHistoryBattleData())) do
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
	if not IdolTraineeSkillEffectCfg[arg_10_0] or IdolTraineeSkillEffectCfg[arg_10_0].valid_probability == 100 then
		return nil
	end

	local var_10_0 = IdolTraineeSkillDescCfg.DEFAULT_ROUND_PROBABILITY

	if not IdolTraineeSkillDescCfg.DEFAULT_ROUND_PROBABILITY then
		return nil
	end

	return string.format(GetI18NText(var_10_0.pattern), IdolTraineeSkillEffectCfg[arg_10_0].valid_probability)
end

local function var_0_2(arg_11_0)
	local var_11_0 = IdolTraineeSkillEffectCfg[arg_11_0]

	if not IdolTraineeSkillEffectCfg[arg_11_0] or var_11_0.condition == 0 then
		return nil
	end

	local var_11_1 = "DEFAULT_CONDITION_" .. var_11_0.condition
	local var_11_2 = {}

	table.insert(var_11_2, (GetTips(var_11_0.object == 1 and "IDOL_SKILL_DESC_OBJ_0" or "IDOL_SKILL_DESC_OBJ_1")))

	if var_11_0.condition == 1 then
		table.insert(var_11_2, (IdolStageSceneCfg[var_11_0.con_param[1]] or nil) and (IdolStageSceneCfg[var_11_0.con_param[1]].scene_show_name or ""))
	elseif var_11_0.condition ~= 2 then
		if var_11_0.condition == 4 then
			table.insert(var_11_2, var_11_0.con_param[1] .. "")
		elseif var_11_0.condition == 5 then
			table.insert(var_11_2, (GetTips(IdolTraineeConst.style[var_11_0.con_param[1]])))
		end
	end

	local var_11_3 = IdolTraineeSkillDescCfg[var_11_1]

	if not IdolTraineeSkillDescCfg[var_11_1] then
		return nil
	end

	return string.format(GetI18NText(var_11_3.pattern), unpack(var_11_2))
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
	local var_13_1 = {
		args = {},
		buffID = arg_13_0,
		effect = IdolTraineeSkillEffectCfg[arg_13_0].effect_type,
		target = IdolTraineeSkillEffectCfg[arg_13_0].object
	}

	if not arg_13_2 and var_13_0.trigger_time ~= 0 then
		var_13_1.delay = var_13_0.trigger_time
	end

	if not arg_13_3 and var_13_0.round ~= -1 then
		var_13_1.round = var_13_0.round
	end

	if not (arg_13_1 or var_13_0.probability >= 100) then
		var_13_1.chance = var_13_0.probability
	end

	if IdolTraineeSkillEffectCfg[arg_13_0].effect_type == 1 then
		var_13_1.args[1] = GetTips("IDOL_SKILL_ATTRIBUTE_" .. var_13_0.unique[1])
		var_13_1.positive = var_13_0.unique[2] >= 0
		var_13_1.buffValue = var_13_0.unique[2]
	elseif IdolTraineeSkillEffectCfg[arg_13_0].effect_type == 2 then
		var_13_1.args[1] = GetTips(IdolTraineeConst.style[var_13_0.unique[1]])
		var_13_1.positive = var_13_0.unique[2] >= 0
		var_13_1.buffValue = var_13_0.unique[2]
	elseif IdolTraineeSkillEffectCfg[arg_13_0].effect_type == 3 or IdolTraineeSkillEffectCfg[arg_13_0].effect_type == 4 or IdolTraineeSkillEffectCfg[arg_13_0].effect_type == 5 or IdolTraineeSkillEffectCfg[arg_13_0].effect_type == 6 or IdolTraineeSkillEffectCfg[arg_13_0].effect_type == 7 then
		var_13_1.positive = var_13_0.unique[1] >= 0
		var_13_1.buffValue = var_13_0.unique[1]
	elseif IdolTraineeSkillEffectCfg[arg_13_0].effect_type == 8 then
		var_13_1.args[1] = GetTips("IDOL_SKILL_ATTRIBUTE_" .. var_13_0.unique[1])
		var_13_1.positive = var_13_0.unique[2] >= 0
		var_13_1.buffValue = var_13_0.unique[2]
	else
		Debug.LogError("idol_trainee_skill_desc表中有类型程序未指定拼接描述规则" .. var_13_0.id)

		var_13_1.invalid = true
	end

	if var_13_1.buffValue then
		var_13_1.absBuffValue = math.abs(var_13_1.buffValue)
	end

	return var_13_1
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
	local var_15_0 = "_" .. arg_15_0.effect
	local var_15_1 = {}

	var_15_1[1] = "BUFF_EFFECT"

	local var_15_2 = "_DELAY"
	local var_15_3 = "_ROUND"
	local var_15_4 = "_RNG"

	if arg_15_0.delay then
		var_0_5(var_15_1, function(arg_16_0)
			return arg_16_0 .. var_15_2
		end)
	end

	if arg_15_0.round then
		var_0_5(var_15_1, function(arg_17_0)
			return arg_17_0 .. var_15_3
		end)
	end

	if arg_15_0.chance then
		var_0_5(var_15_1, function(arg_18_0)
			return arg_18_0 .. var_15_4
		end)
	end

	if arg_15_0.delay and arg_15_0.round and arg_15_0.chance then
		table.insert(var_15_1, "BUFF_EFFECT" .. "_FULL")
	end

	local var_15_5 = arg_15_0.positive and "_POS" or "_NEG"

	for iter_15_0 = #var_15_1, 1, -1 do
		local var_15_6 = IdolTraineeSkillDescCfg[var_15_1[iter_15_0] .. var_15_5 .. var_15_0] or IdolTraineeSkillDescCfg[var_15_1[iter_15_0] .. var_15_0]

		if var_15_6 then
			local var_15_7 = GetI18NText(var_15_6.pattern)

			if not var_15_6.is_full_info and (arg_15_0.chance or arg_15_0.round) then
				var_15_7 = var_0_3((arg_15_0.chance or nil) and GetI18NText(IdolTraineeSkillDescCfg.DEFAULT_PREFIX.pattern), var_15_7, (arg_15_0.round or nil) and GetI18NText(IdolTraineeSkillDescCfg.DEFAULT_SUFFIX.pattern))
			end

			return var_15_7
		end
	end

	return ""
end

local function var_0_7(arg_19_0)
	local var_19_0 = arg_19_0

	if not arg_19_0.invalid then
		local var_19_1 = var_0_6(arg_19_0)
		local var_19_2 = {
			GetTips(arg_19_0.target == 1 and "IDOL_SKILL_DESC_OBJ_0" or "IDOL_SKILL_DESC_OBJ_1"),
			arg_19_0.buffValue,
			arg_19_0.absBuffValue
		}

		var_19_2[4] = arg_19_0.chance or ""
		var_19_2[5] = arg_19_0.delay or ""
		var_19_2[6] = var_19_0.round or ""
		var_19_2[7] = unpack(var_19_0.args)

		return var_0_3(var_0_2(arg_19_0.buffID), LuaExchangeHelper.GetDescription(var_19_1, var_19_2), (var_0_1(arg_19_0.buffID)))
	end

	return ""
end

function var_0_0.GetBuffDescString(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4)
	return (var_0_7((var_0_4(arg_20_1, arg_20_2, arg_20_3, arg_20_4))))
end

function var_0_0:GetSkillDescString(arg_21_1)
	local var_21_0 = ""

	for iter_21_0, iter_21_1 in ipairs(IdolTraineeSkillCfg[arg_21_1].skill_effect) do
		var_21_0 = var_21_0 .. self:GetBuffDescString(iter_21_1) .. ((iter_21_0 ~= #IdolTraineeSkillCfg[arg_21_1].skill_effect or nil) and "\n")
	end

	return var_21_0
end

function var_0_0.GetSkillEffect(arg_22_0, arg_22_1)
	if IdolTraineeSkillEffectCfg[arg_22_1].effect_type == 1 then
		return IdolTraineeSkillEffectCfg[arg_22_1].unique[1], IdolTraineeSkillEffectCfg[arg_22_1].unique[2]
	end

	return nil
end

function var_0_0.GetCurQuestRankInfo(arg_23_0)
	local var_23_0 = IdolTraineeData:GetQuestRankInfo()

	return var_23_0, ItemTools.getItemNum(IdolTraineeRewardRankCfg[var_23_0].item_id[1]), IdolTraineeRewardRankCfg[var_23_0].item_id[2], (IdolTraineeData:GetQuestWeeklyData())
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
		local var_26_3 = arg_26_3 == IdolTraineeConst.friendType.friend and IdolTraineeData:GetCacheFriendList()[arg_26_2] or IdolTraineeData:GetCacheOpponentList()[arg_26_2]

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
	if not IdolTraineeSkillEffectCfg[arg_28_1].effect_icon then
		return nil
	end

	return getSpriteWithoutAtlas(SpritePathCfg.IdolDanceBuffIcon.path .. IdolTraineeSkillEffectCfg[arg_28_1].effect_icon)
end

function var_0_0.GetSkillIcon(arg_29_0, arg_29_1)
	if not IdolTraineeSkillCfg[arg_29_1].icon then
		return nil
	end

	return getSpriteWithoutAtlas(SpritePathCfg.IdolDanceSkillIcon.path .. IdolTraineeSkillCfg[arg_29_1].icon)
end

function var_0_0.CheckDanceTaskComplete(arg_30_0)
	for iter_30_0, iter_30_1 in pairs((TaskTools:GetIdolTraineeTaskSortList())) do
		if TaskData2:GetTaskProgress(iter_30_1) >= AssignmentCfg[iter_30_1].need and not TaskData2:GetTaskComplete(iter_30_1) then
			return true
		end
	end
end

function var_0_0.GetPveStageChapter(arg_31_0, arg_31_1)
	for iter_31_0, iter_31_1 in ipairs(IdolTraineeChapterCfg.all) do
		if table.keyof(IdolTraineeChapterCfg[iter_31_1].section_id_list, arg_31_1) ~= nil then
			return iter_31_1
		end
	end

	return nil
end

local var_0_8 = 2

function var_0_0.GetMusicDuration(arg_32_0)
	if IdolStageMusicCfg[arg_32_0] then
		if IdolStageMusicCfg[arg_32_0].music_duration then
			do return IdolStageMusicCfg[arg_32_0].music_duration end

			local var_32_0 = require("cjson").decode
		end

		local var_32_1 = require("cjson").decode((AssetEx.LoadText(IdolStageMusicCfg[arg_32_0].music_json)))
		local var_32_2 = 0

		for iter_32_0 = 1, var_0_8 do
			for iter_32_1, iter_32_2 in pairs(var_32_1["track" .. iter_32_0]) do
				local var_32_3 = math.max(unpack(iter_32_2))

				if var_32_2 < var_32_3 then
					var_32_2 = var_32_3
				end
			end
		end

		return var_32_2 / 1000
	end

	return nil
end

function var_0_0.GetDanceDIYActionUnlockDesc(arg_33_0)
	if IdolDanceDIYActionCfg[arg_33_0].unlock_condition == 0 then
		return nil
	end

	local var_33_0 = nullable(ConditionCfg, IdolDanceDIYActionCfg[arg_33_0].unlock_condition, "desc")

	if var_33_0 then
		return GetTipsF(var_33_0, IdolDanceDIYActionCfg[arg_33_0].need)
	else
		return ""
	end
end

function var_0_0:GetDIYDataFromLoadInfo()
	if self == nil then
		return nil
	elseif self.source == IdolTraineeConst.DataSource.MyData then
		return IdolTraineeData:GetDanceDIYSequence(self.id)
	elseif self.source == IdolTraineeConst.DataSource.MySharedData then
		return self.data or IdolTraineeData:GetSharedDanceDIYSequence(self.id)
	else
		return self.data
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
	if not var_0_9(Filter_Root_Define.IDOL_DANCE_ACTION_Filter_List, Filter_Group_Define.IDOL_DANCE_ACTION_STYLE, Filter_Group_Define.IDOL_DANCE_ACTION_STYLE.tags[IdolDanceDIYActionCfg[arg_39_0].type]) then
		return false
	end

	if not var_0_9(Filter_Root_Define.IDOL_DANCE_ACTION_Filter_List, Filter_Group_Define.IDOL_DANCE_ACTION_BEAT, Filter_Tags_Define["IdolDanceBeat" .. IdolDanceDIYActionCfg[arg_39_0].beat]) then
		return false
	end

	return true
end

function var_0_0:ViewSharedDIY()
	IdolTraineeAction.GetSharedDanceDIYSequenceDetail(self.id, function(arg_41_0)
		IdolTraineeData.ParseDanceDIYSequence(arg_41_0.base_sequence, self.data)
		IdolTraineeData.UpdateDIYStatistics(self.data, arg_41_0)

		self.data.myTodayLiked = arg_41_0.own_today_liked_num

		DIYBridge.EnterDIY(self)
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
