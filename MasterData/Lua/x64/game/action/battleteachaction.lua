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
		if RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + iter_5_1[1]) == nil then
			var_5_0 = true
		end

		local var_5_1 = RedPointConst.TEACH_BASE_TEACHING .. "_" .. iter_5_1[1]

		if not (getData("redPoint", "BattleBaseTeachStageViewed_" .. iter_5_1[1]) or false) and not (BattleTeachData:GetBaseTeachList()[iter_5_1[1]] and BattleTeachData:GetBaseTeachList()[iter_5_1[1]] > 0 or false) then
			manager.redPoint:setTip(var_5_1, 1)
		else
			manager.redPoint:setTip(var_5_1, 0)
		end
	end

	manager.redPoint:setTip(RedPointConst.TEACH_BASE, var_5_0 and 1 or 0)
end

function var_0_0.CancelBaseTeachRedPoint()
	for iter_6_0, iter_6_1 in ipairs(GameSetting.new_player_study_stage_unlock.value) do
		if RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + iter_6_1[1]) == nil then
			RedPointAction.HandleRedPoint(RedPointConst.CHAPTER_CHANLLAGE_RANGE + iter_6_1[1])
		end
	end

	manager.redPoint:setTip(RedPointConst.TEACH_BASE, 0)
end

function var_0_0.UpdateHeroTeachRedPoint()
	local var_7_0

	if PlayerData:GetPlayerInfo().userLevel < ChapterClientCfg[402].level then
		do return end

		var_7_0 = false
	end

	for iter_7_0, iter_7_1 in pairs((HeroData.GetUnlockHeros())) do
		if RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + iter_7_1) == nil then
			var_7_0 = true

			break
		end
	end

	manager.redPoint:setTip(RedPointConst.TEACH_CHARACTER, var_7_0 and 1 or 0)
end

function var_0_0.CancelHeroTeachRedPoint()
	for iter_8_0, iter_8_1 in pairs((HeroData.GetUnlockHeros())) do
		if RedPointData:GetIsRedPointOpen(RedPointConst.CHAPTER_CHANLLAGE_RANGE + iter_8_1) == nil then
			RedPointAction.HandleRedPoint(RedPointConst.CHAPTER_CHANLLAGE_RANGE + iter_8_1)
		end
	end

	manager.redPoint:setTip(RedPointConst.TEACH_CHARACTER, 0)
end

return var_0_0
