local var_0_0 = class("MatrixStageSettingView", ReduxView)

function var_0_0.SetActive(arg_1_0, arg_1_1)
	if arg_1_0.gameObject_ then
		SetActive(arg_1_0.gameObject_, arg_1_1)
	end
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.hander_ = arg_2_1
	arg_2_0.transform_ = arg_2_2.transform
	arg_2_0.gameObject_ = arg_2_2
	arg_2_0.params_ = arg_2_3
	arg_2_0.activityId = arg_2_0.params_.stageData:GetActivityID()

	arg_2_0:Init()
end

function var_0_0.OnEnter(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	local var_3_0 = {}

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == arg_3_0.params_.stageType then
		var_3_0 = MatrixData:GetAffixList()
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX == arg_3_0.params_.stageType then
		var_3_0 = ActivityMatrixData:GetAffixList(arg_3_0.activityId)
	elseif BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX == arg_3_0.params_.stageType then
		var_3_0 = StrategyMatrixData:GetAffixList(arg_3_0.activityId)
	end

	arg_3_0.affixItemList_ = {}

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		table.insert(arg_3_0.affixItemList_, MatrixStageAffixItemView.New(arg_3_0.item_, arg_3_0.itemParent_, iter_3_1))
	end

	arg_3_0:RefreshUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.RefreshUI(arg_6_0)
	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == arg_6_0.params_.stageType then
		local var_6_0 = MatrixData:GetTierID()
		local var_6_1 = MatrixTierCfg[var_6_0]

		arg_6_0.levelText_.text = string.format("%s-%s", GetI18NText(var_6_1.tier), var_6_1.level)

		local var_6_2 = MatrixData:GetMatrixPhaseData():GetData()
		local var_6_3 = BattleMatrixStageCfg[var_6_2]

		arg_6_0.nameText_.text = GetI18NText(var_6_3.name)

		local var_6_4 = MatrixData:GetDifficulty()

		arg_6_0.difficultText_.text = GetTips(BattleConst.HARD_LANGUAGE[var_6_4])
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX == arg_6_0.params_.stageType then
		local var_6_5 = ActivityMatrixData:GetTierID(arg_6_0.activityId)
		local var_6_6 = ActivityMatrixTierTemplateCfg[var_6_5]

		arg_6_0.levelText_.text = string.format("%s-%s", GetI18NText(var_6_6.tier), var_6_6.level)

		local var_6_7 = ActivityMatrixData:GetMatrixPhaseData(arg_6_0.activityId):GetData()
		local var_6_8 = BattleActivityMatrixCfg[var_6_7]

		arg_6_0.nameText_.text = GetI18NText(var_6_8.name)
		arg_6_0.difficultText_.text = ""
	elseif BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX == arg_6_0.params_.stageType then
		local var_6_9 = StrategyMatrixData:GetTierID(arg_6_0.activityId)
		local var_6_10 = StrategyMatrixTierTemplateCfg[var_6_9]

		arg_6_0.levelText_.text = string.format("%s-%s", GetI18NText(var_6_10.tier), var_6_10.level)

		local var_6_11 = StrategyMatrixData:GetMatrixPhaseData(arg_6_0.activityId):GetData()
		local var_6_12 = BattleStrategyMatrixCfg[var_6_11]

		arg_6_0.nameText_.text = GetI18NText(var_6_12.name)
		arg_6_0.difficultText_.text = ""
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.itemParent_.transform)
end

function var_0_0.Dispose(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.affixItemList_) do
		iter_7_1:Dispose()
	end

	arg_7_0.affixItemList_ = nil

	var_0_0.super.Dispose(arg_7_0)

	arg_7_0.transform_ = nil
	arg_7_0.gameObject_ = nil
end

return var_0_0
