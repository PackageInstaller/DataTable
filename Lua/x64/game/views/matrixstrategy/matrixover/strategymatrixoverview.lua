local var_0_0 = import("game.views.matrixOver.MatrixOverView")
local var_0_1 = class("StrategyMatrixOverView", var_0_0)

function var_0_1.UIBackCount(arg_1_0)
	return 2
end

function var_0_1.UIName(arg_2_0)
	return "Widget/System/MatrixlUI/StrategyBattleMatrixOverUI"
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.heroItemList_ = {}

	for iter_3_0 = 1, 3 do
		local var_3_0 = arg_3_0[string.format("heroItem%s_", iter_3_0)]

		arg_3_0.heroItemList_[iter_3_0] = StrategyMatrixOverHeroItem.New(var_3_0)
	end

	arg_3_0.affixList_ = LuaList.New(handler(arg_3_0, arg_3_0.AffixIndexItem), arg_3_0.m_affixList, MatrixOverAffixItem)
	arg_3_0.treasureList_ = LuaList.New(handler(arg_3_0, arg_3_0.ArtifactIndexItem), arg_3_0.m_treasureList, MatrixOverArtifactItem)
	arg_3_0.beaconList_ = LuaList.New(handler(arg_3_0, arg_3_0.BeaconIndexItem), arg_3_0.m_beaconList, MatrixOverBeaconItem)
	arg_3_0.resultController_ = ControllerUtil.GetController(arg_3_0.transform_, "result")
	arg_3_0.difficultyController_ = ControllerUtil.GetController(arg_3_0.transform_, "difficulty")
end

function var_0_1.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.closeBtn_, nil, function()
		if arg_4_0:GetGameState() == MatrixConst.STATE_TYPE.NOTSTARTED then
			StrategyMatrixAction.GotoStrategyMatrixPrepare(arg_4_0.matrix_activity_id)
		else
			StrategyMatrixAction.QueryMatrixOver(arg_4_0.matrix_activity_id)
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.statisticsBtn_, nil, function()
		JumpTools.OpenPageByJump("battleStatisticsStrategyMatrixOver", {
			matrix_activity_id = arg_4_0.matrix_activity_id
		})
	end)
end

function var_0_1.OnEnter(arg_7_0)
	arg_7_0.matrix_activity_id = arg_7_0.params_.matrix_activity_id

	for iter_7_0 = 1, 3 do
		arg_7_0.heroItemList_[iter_7_0]:SetMatrixActivityId(arg_7_0.matrix_activity_id)
	end

	arg_7_0:Refresh()
end

function var_0_1.Refresh(arg_8_0)
	var_0_1.super.Refresh(arg_8_0)
end

function var_0_1.OnMatrixUserUpdate(arg_9_0)
	local var_9_0 = MatrixData:GetGameState()

	if MatrixConst.STATE_TYPE.NOTSTARTED == var_9_0 then
		-- block empty
	elseif MatrixConst.STATE_TYPE.SUCCESS ~= var_9_0 and MatrixConst.STATE_TYPE.FAIL == var_9_0 then
		-- block empty
	end
end

function var_0_1.GetGameState(arg_10_0)
	return StrategyMatrixData:GetGameState(arg_10_0.matrix_activity_id)
end

function var_0_1.GetCurrentClearTime(arg_11_0)
	return StrategyMatrixData:GetCurrentClearTime(arg_11_0.matrix_activity_id)
end

function var_0_1.GetMinClearTime(arg_12_0)
	return StrategyMatrixData:GetMinClearTime(arg_12_0.matrix_activity_id)
end

function var_0_1.GetEvaluateList(arg_13_0)
	return {}
end

function var_0_1.GetTierDes(arg_14_0)
	local var_14_0 = StrategyMatrixData:GetTierID(arg_14_0.matrix_activity_id)
	local var_14_1 = StrategyMatrixTierTemplateCfg[var_14_0]

	return string.format("%s-%s", var_14_1.tier, var_14_1.level)
end

function var_0_1.GetAffixList(arg_15_0)
	return StrategyMatrixData:GetAffixList(arg_15_0.matrix_activity_id)
end

function var_0_1.GetArtifactList(arg_16_0)
	return StrategyMatrixData:GetArtifactList(arg_16_0.matrix_activity_id)
end

function var_0_1.GetUseBeaconList(arg_17_0)
	return {}
end

function var_0_1.GetMatrixCurrencyList(arg_18_0)
	return StrategyMatrixData:GetMatrixCurrencyList(arg_18_0.matrix_activity_id)
end

function var_0_1.GetMatrixHeroTeam(arg_19_0)
	return StrategyMatrixData:GetMatrixHeroTeam(arg_19_0.matrix_activity_id)
end

function var_0_1.GetMatrixOverScore(arg_20_0)
	return StrategyMatrixData:GetMatrixOverPoint(arg_20_0.matrix_activity_id)
end

function var_0_1.GetDifficulty(arg_21_0)
	local var_21_0 = StrategyMatrixCfg[arg_21_0.matrix_activity_id]

	return var_21_0 and var_21_0.activity_difficulty or 1
end

function var_0_1.GetRegularAffix(arg_22_0)
	return {}
end

function var_0_1.GetCustomAffix(arg_23_0)
	return StrategyMatrixData:GetCustomAffix(arg_23_0.matrix_activity_id)
end

return var_0_1
