local MatrixStageSettingView = class("MatrixStageSettingView", ReduxView)

function MatrixStageSettingView:SetActive(arg_1_1)
	if self.gameObject_ then
		SetActive(self.gameObject_, arg_1_1)
	end
end

function MatrixStageSettingView:Ctor(arg_2_1, arg_2_2, arg_2_3)
	self.hander_ = arg_2_1
	self.transform_ = arg_2_2.transform
	self.gameObject_ = arg_2_2
	self.params_ = arg_2_3
	self.activityId = self.params_.stageData:GetActivityID()

	self:Init()
end

function MatrixStageSettingView:OnEnter()
	self:InitUI()
	self:AddUIListener()

	local var_3_0 = {}

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == self.params_.stageType then
		var_3_0 = MatrixData:GetAffixList()
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX == self.params_.stageType then
		var_3_0 = ActivityMatrixData:GetAffixList(self.activityId)
	elseif BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX == self.params_.stageType then
		var_3_0 = StrategyMatrixData:GetAffixList(self.activityId)
	end

	self.affixItemList_ = {}

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		table.insert(self.affixItemList_, MatrixStageAffixItemView.New(self.item_, self.itemParent_, iter_3_1))
	end

	self:RefreshUI()
end

function MatrixStageSettingView:InitUI()
	self:BindCfgUI()
end

function MatrixStageSettingView:AddUIListener()
	return
end

function MatrixStageSettingView:RefreshUI()
	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX == self.params_.stageType then
		local var_6_0 = MatrixTierCfg[MatrixData:GetTierID()]

		self.levelText_.text = string.format("%s-%s", GetI18NText(var_6_0.tier), var_6_0.level)
		self.nameText_.text = GetI18NText(BattleMatrixStageCfg[MatrixData:GetMatrixPhaseData():GetData()].name)
		self.difficultText_.text = GetTips(BattleConst.HARD_LANGUAGE[MatrixData:GetDifficulty()])
	elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_MATRIX == self.params_.stageType then
		local var_6_1 = ActivityMatrixTierTemplateCfg[ActivityMatrixData:GetTierID(self.activityId)]

		self.levelText_.text = string.format("%s-%s", GetI18NText(var_6_1.tier), var_6_1.level)
		self.nameText_.text = GetI18NText(BattleActivityMatrixCfg[ActivityMatrixData:GetMatrixPhaseData(self.activityId):GetData()].name)
		self.difficultText_.text = ""
	elseif BattleConst.STAGE_TYPE_NEW.STRATEGY_MATRIX == self.params_.stageType then
		local var_6_2 = StrategyMatrixTierTemplateCfg[StrategyMatrixData:GetTierID(self.activityId)]

		self.levelText_.text = string.format("%s-%s", GetI18NText(var_6_2.tier), var_6_2.level)
		self.nameText_.text = GetI18NText(BattleStrategyMatrixCfg[StrategyMatrixData:GetMatrixPhaseData(self.activityId):GetData()].name)
		self.difficultText_.text = ""
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.itemParent_.transform)
end

function MatrixStageSettingView:Dispose()
	for iter_7_0, iter_7_1 in ipairs(self.affixItemList_) do
		iter_7_1:Dispose()
	end

	self.affixItemList_ = nil

	MatrixStageSettingView.super.Dispose(self)

	self.transform_ = nil
	self.gameObject_ = nil
end

return MatrixStageSettingView
