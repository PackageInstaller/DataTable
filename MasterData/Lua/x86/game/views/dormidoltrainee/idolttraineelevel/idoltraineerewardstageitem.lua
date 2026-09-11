local IdolTraineeRewardStageItem = class("IdolTraineeRewardStageItem", ReduxView)

function IdolTraineeRewardStageItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function IdolTraineeRewardStageItem:InitUI()
	self:BindCfgUI()
end

function IdolTraineeRewardStageItem:SetData(arg_3_1)
	self.stageID = arg_3_1

	if self.stageID then
		self.nameText_.text = IdolTraineePveBattleCfg[self.stageID].name

		self:InitRewardList()
	end
end

function IdolTraineeRewardStageItem:InitRewardList()
	if not self.awardList then
		self.awardList = {}

		if IdolTraineePveBattleCfg[self.stageID].taskIDList and IdolTraineePveBattleCfg[self.stageID].taskIDList ~= "" then
			for iter_4_0, iter_4_1 in ipairs(IdolTraineePveBattleCfg[self.stageID].taskIDList) do
				self.awardList[iter_4_1] = IdolTraineeRewardListItem.New((Object.Instantiate(self.levelitemGo_, self.contentTrs_)))

				self.awardList[iter_4_1]:SetData(iter_4_1)
			end
		end

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
	end
end

function IdolTraineeRewardStageItem:RefreshUI()
	if self.awardList then
		for iter_5_0, iter_5_1 in pairs(self.awardList) do
			iter_5_1:SetData(iter_5_0)
		end
	end
end

function IdolTraineeRewardStageItem:GetCanReciveAwardList()
	local var_6_0 = {}

	if self.awardList then
		for iter_6_0, iter_6_1 in pairs(self.awardList) do
			if iter_6_1.stateController_:GetSelectedState() == "complete" then
				table.insert(var_6_0, iter_6_0)
			end
		end
	end

	return var_6_0
end

function IdolTraineeRewardStageItem:Dispose()
	if self.awardList then
		for iter_7_0, iter_7_1 in pairs(self.awardList) do
			iter_7_1:Dispose()
		end

		self.awardList = nil
	end

	Object.DestroyImmediate(self.gameObject_)
	IdolTraineeRewardStageItem.super.Dispose(self)
end

return IdolTraineeRewardStageItem
