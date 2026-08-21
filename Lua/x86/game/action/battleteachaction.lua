local var_0_0 = {}

manager.net:Bind(47001, function(arg_1_0)
	BattleTeachData:ModifyBaseTeach(arg_1_0)
	var_0_0.UpdateBaseTeachRedPoint()
end)
manager.net:Bind(47003, function(arg_2_0)
	BattleTeachData:ModifyHeroTeach(arg_2_0)
end)
manager.notify:RegistListener(HERO_DATA_INIT, function()
	var_0_0.UpdateHeroTeachRedPoint()
end)
manager.notify:RegistListener(HERO_UNLOCK_SUCCESS, function()
	var_0_0.UpdateHeroTeachRedPoint()
end)

function var_0_0.UpdateBaseTeachRedPoint()
	if PlayerData:GetPlayerInfo().userLevel < ChapterClientCfg[402].level then
		return
	end

	local var_5_0 = false

	for iter_5_0, iter_5_1 in ipairs(GameSetting.new_player_study_stage_unlock.value) do
		local var_5_1 = iter_5_1[1]

		if RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + var_5_1) == nil then
			var_5_0 = true
		end

		local var_5_2 = RedPointConst.TEACH_BASE_TEACHING .. "_" .. var_5_1
		local var_5_3 = getData("redPoint", "BattleBaseTeachStageViewed_" .. var_5_1) or false
		local var_5_4 = BattleTeachData:GetBaseTeachList()[iter_5_1[1]] and BattleTeachData:GetBaseTeachList()[iter_5_1[1]] > 0 or false

		if not var_5_3 and not var_5_4 then
			manager.redPoint:setTip(var_5_2, 1)
		else
			manager.redPoint:setTip(var_5_2, 0)
		end
	end

	manager.redPoint:setTip(RedPointConst.TEACH_BASE, var_5_0 and 1 or 0)
end

function var_0_0.CancelBaseTeachRedPoint()
	for iter_6_0, iter_6_1 in ipairs(GameSetting.new_player_study_stage_unlock.value) do
		local var_6_0 = iter_6_1[1]

		if RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + var_6_0) == nil then
			RedPointAction.HandleRedPoint(RedPointConst.CHAPTER_CHANLLAGE_RANGE + var_6_0)
		end
	end

	manager.redPoint:setTip(RedPointConst.TEACH_BASE, 0)
end

function var_0_0.UpdateHeroTeachRedPoint()
	if PlayerData:GetPlayerInfo().userLevel < ChapterClientCfg[402].level then
		return
	end

	local var_7_0 = HeroData.GetUnlockHeros()
	local var_7_1 = false

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		if RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + iter_7_1) == nil then
			var_7_1 = true

			break
		end
	end

	manager.redPoint:setTip(RedPointConst.TEACH_CHARACTER, var_7_1 and 1 or 0)
end

function var_0_0.CancelHeroTeachRedPoint()
	local var_8_0 = HeroData.GetUnlockHeros()

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		if RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + iter_8_1) == nil then
			RedPointAction.HandleRedPoint(RedPointConst.CHAPTER_CHANLLAGE_RANGE + iter_8_1)
		end
	end

	manager.redPoint:setTip(RedPointConst.TEACH_CHARACTER, 0)
end

return var_0_0
