local var_0_0 = import("game.views.matrixOver.MatrixOverView")
local var_0_1 = class("ActivityMatrixOriginView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "UI/VolumeIIIUI/SoloRoguelike/AactivityBattleMatrixOverUI"
end

function var_0_1.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.heroItemList_ = {}

	for iter_2_0 = 1, 3 do
		local var_2_0 = arg_2_0[string.format("heroItem%s_", iter_2_0)]

		arg_2_0.heroItemList_[iter_2_0] = ActivityMatrixOverHeroItem.New(var_2_0)
	end

	arg_2_0.affixList_ = LuaList.New(handler(arg_2_0, arg_2_0.AffixIndexItem), arg_2_0.m_affixList, MatrixOverAffixItem)
	arg_2_0.treasureList_ = LuaList.New(handler(arg_2_0, arg_2_0.ArtifactIndexItem), arg_2_0.m_treasureList, MatrixOverArtifactItem)
	arg_2_0.beaconList_ = LuaList.New(handler(arg_2_0, arg_2_0.BeaconIndexItem), arg_2_0.m_beaconList, MatrixOverBeaconItem)
	arg_2_0.resultController_ = ControllerUtil.GetController(arg_2_0.transform_, "result")
	arg_2_0.difficultyController_ = ControllerUtil.GetController(arg_2_0.transform_, "difficulty")
end

function var_0_1.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.closeBtn_, nil, function()
		if arg_3_0:GetGameState() == MatrixConst.STATE_TYPE.NOTSTARTED then
			local var_4_0 = ActivityMatrixData:GetMainActivityId(arg_3_0.matrix_activity_id)

			JumpTools.GoToSystem("/matrixBlank/activityMatrix", {
				main_matrix_activity_id = var_4_0,
				matrix_activity_id = arg_3_0.matrix_activity_id
			})
		else
			ActivityMatrixAction.QueryMatrixOver(arg_3_0.matrix_activity_id)
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.statisticsBtn_, nil, function()
		JumpTools.OpenPageByJump("battleStatisticsActivityMatrixOver", {
			matrix_activity_id = arg_3_0.matrix_activity_id
		})
	end)
end

function var_0_1.OnEnter(arg_6_0)
	arg_6_0.matrix_activity_id = arg_6_0.params_.matrix_activity_id

	for iter_6_0 = 1, 3 do
		arg_6_0.heroItemList_[iter_6_0]:SetMatrixActivityId(arg_6_0.matrix_activity_id)
	end

	arg_6_0:Refresh()

	if arg_6_0:GetGameState() == MatrixConst.STATE_TYPE.SUCCESS then
		local var_6_0 = ActivityMatrixCfg[arg_6_0.matrix_activity_id]
		local var_6_1 = var_6_0 and var_6_0.after_story_id or {}
		local var_6_2 = false

		for iter_6_1, iter_6_2 in ipairs(var_6_1) do
			if iter_6_2 and not manager.story:IsStoryPlayed(iter_6_2) then
				var_6_2 = true

				break
			end
		end

		if var_6_2 then
			arg_6_0.storyList = clone(var_6_1)

			manager.story:StartStoryById(arg_6_0.storyList[1], function(arg_7_0)
				arg_6_0:CheckStoryPlay()
			end)
		end
	end
end

function var_0_1.CheckStoryPlay(arg_8_0)
	PlayerAction.ChangeStoryList(arg_8_0.storyList[1])
	table.remove(arg_8_0.storyList, 1)

	if #arg_8_0.storyList > 0 then
		manager.story:StartStoryById(arg_8_0.storyList[1], function(arg_9_0)
			arg_8_0:CheckStoryPlay()
		end)
	end
end

function var_0_1.Refresh(arg_10_0)
	var_0_1.super.Refresh(arg_10_0)

	if ActivityMatrixData:GetMatrixIsFirstClear(arg_10_0.matrix_activity_id) then
		local var_10_0 = ActivityMatrixData:GetMainActivityId(arg_10_0.matrix_activity_id)
		local var_10_1 = ActivityMatrixData:GetMatrixClueCount(var_10_0, arg_10_0.matrix_activity_id)

		arg_10_0.m_clueText.text = string.format(GetTips("ACTIVITY_VOLUME_MATRIX_CLUE"), var_10_1)
	else
		arg_10_0.m_clueText.text = ""
	end
end

function var_0_1.OnMatrixUserUpdate(arg_11_0)
	local var_11_0 = MatrixData:GetGameState()

	if MatrixConst.STATE_TYPE.NOTSTARTED == var_11_0 then
		-- block empty
	elseif MatrixConst.STATE_TYPE.SUCCESS ~= var_11_0 and MatrixConst.STATE_TYPE.FAIL == var_11_0 then
		-- block empty
	end
end

function var_0_1.GetGameState(arg_12_0)
	return ActivityMatrixData:GetGameState(arg_12_0.matrix_activity_id)
end

function var_0_1.GetCurrentClearTime(arg_13_0)
	return ActivityMatrixData:GetCurrentClearTime(arg_13_0.matrix_activity_id)
end

function var_0_1.GetMinClearTime(arg_14_0)
	return ActivityMatrixData:GetMinClearTime(arg_14_0.matrix_activity_id)
end

function var_0_1.GetEvaluateList(arg_15_0)
	return {}
end

function var_0_1.GetTierDes(arg_16_0)
	local var_16_0 = ActivityMatrixData:GetTierID(arg_16_0.matrix_activity_id)
	local var_16_1 = ActivityMatrixTierTemplateCfg[var_16_0]

	return string.format("%s-%s", var_16_1.tier, var_16_1.level)
end

function var_0_1.GetAffixList(arg_17_0)
	return {}
end

function var_0_1.GetArtifactList(arg_18_0)
	return ActivityMatrixData:GetArtifactList(arg_18_0.matrix_activity_id)
end

function var_0_1.GetUseBeaconList(arg_19_0)
	return {}
end

function var_0_1.GetMatrixCurrencyList(arg_20_0)
	return ActivityMatrixData:GetMatrixCurrencyList(arg_20_0.matrix_activity_id)
end

function var_0_1.GetMatrixHeroTeam(arg_21_0)
	return ActivityMatrixData:GetMatrixHeroTeam(arg_21_0.matrix_activity_id)
end

function var_0_1.GetMatrixOverScore(arg_22_0)
	return ActivityMatrixData:GetMatrixOverPoint(arg_22_0.matrix_activity_id)
end

function var_0_1.GetDifficulty(arg_23_0)
	return 1
end

function var_0_1.GetRegularAffix(arg_24_0)
	return {}
end

function var_0_1.GetCustomAffix(arg_25_0)
	return {}
end

return var_0_1
