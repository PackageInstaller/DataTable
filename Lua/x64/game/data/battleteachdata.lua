local var_0_0 = singletonClass("BattleTeachData")

function var_0_0.Ctor(arg_1_0)
	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0.switchType_ = getData("BattleTeach", "switchType_new") or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING
	arg_2_0.stageList_ = {}
	arg_2_0.baseStageList_ = {}
	arg_2_0.heroStageList_ = {}
	arg_2_0.cacheSelectHeroID_ = nil
	arg_2_0.baseScrollViewHorizontal_ = getData("BattleTeach", "base_scroll_horizontal") or 0
	arg_2_0.heroScrollViewHorizontal_ = getData("BattleTeach", "hero_scroll_horizontal") or 0
end

function var_0_0.ModifyBaseTeach(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1.base_stage_list) do
		arg_3_0.baseStageList_[iter_3_1.id] = iter_3_1.clear_times
		arg_3_0.stageList_[iter_3_1.id] = iter_3_1.clear_times
	end
end

function var_0_0.ModifyHeroTeach(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1.hero_teaching_list) do
		local var_4_0 = iter_4_1.hero_id

		arg_4_0.heroStageList_[var_4_0] = arg_4_0.heroStageList_[var_4_0] or {}

		for iter_4_2, iter_4_3 in ipairs(iter_4_1.stage_list) do
			arg_4_0.heroStageList_[var_4_0][iter_4_3.id] = iter_4_3.clear_times
			arg_4_0.stageList_[iter_4_3.id] = iter_4_3.clear_times
		end
	end
end

function var_0_0.SetSwitchType(arg_5_0, arg_5_1)
	arg_5_0.switchType_ = arg_5_1

	saveData("BattleTeach", "switchType_new", arg_5_1)
end

function var_0_0.GetSwitchType(arg_6_0)
	return arg_6_0.switchType_
end

function var_0_0.GetStageData(arg_7_0)
	return arg_7_0.stageList_
end

function var_0_0.GetBaseTeachList(arg_8_0)
	return arg_8_0.baseStageList_
end

function var_0_0.GetHeroTeachInfo(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0.heroStageList_[arg_9_1] then
		return 0
	end

	return arg_9_0.heroStageList_[arg_9_1][arg_9_2]
end

function var_0_0.SetCacheTeachHeroID(arg_10_0, arg_10_1)
	arg_10_0.cacheSelectHeroID_ = arg_10_1
end

function var_0_0.GetCacheTeachHeroID(arg_11_0)
	return arg_11_0.cacheSelectHeroID_
end

function var_0_0.SetBaseScrollViewHorizontal(arg_12_0, arg_12_1)
	arg_12_0.baseScrollViewHorizontal_ = arg_12_1

	saveData("BattleTeach", "base_scroll_horizontal", arg_12_1)
end

function var_0_0.GetBaseScrollViewHorizontal(arg_13_0)
	return arg_13_0.baseScrollViewHorizontal_
end

function var_0_0.SetHeroScrollViewHorizontal(arg_14_0, arg_14_1)
	arg_14_0.heroScrollViewHorizontal_ = arg_14_1

	saveData("BattleTeach", "hero_scroll_horizontal", arg_14_1)
end

function var_0_0.GetHeroScrollViewHorizontal(arg_15_0)
	return arg_15_0.heroScrollViewHorizontal_
end

return var_0_0
