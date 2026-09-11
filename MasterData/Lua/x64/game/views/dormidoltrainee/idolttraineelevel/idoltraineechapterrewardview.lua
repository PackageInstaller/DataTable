local IdolTraineeChapterRewardView = class("IdolTraineeChapterRewardView", ReduxView)

function IdolTraineeChapterRewardView:UIName()
	return "Widget/BackHouseUI/IdolTrainee/IdolChapterRewardPopup"
end

function IdolTraineeChapterRewardView:UIParent()
	return manager.ui.uiMain.transform
end

function IdolTraineeChapterRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function IdolTraineeChapterRewardView:InitUI()
	self:BindCfgUI()
end

function IdolTraineeChapterRewardView:AddUIListener()
	self:AddBtnListener(self.backBtn, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.reciveBtn, nil, function()
		local var_7_0 = self:GetCurCanReciveTaskIdList()

		if #var_7_0 > 0 then
			TaskAction:SubmitTaskList(var_7_0, nil, handler(self, self.RefreshRewardList))
		end
	end)
end

function IdolTraineeChapterRewardView:OnEnter()
	self.chapterID = self.params_.chapterID

	self:InitChapterList()
	self:RefreshRewardList()
	self:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, handler(self, self.RefreshRewardList))
end

function IdolTraineeChapterRewardView:InitChapterList()
	if self.chapterID ~= self.chapterOldID then
		self:DestoryItemList()

		self.stageList = {}

		for iter_9_0, iter_9_1 in ipairs(IdolTraineeChapterCfg[self.chapterID].section_id_list) do
			self.stageList[iter_9_1] = IdolTraineeRewardStageItem.New((Object.Instantiate(self.leveltitleGo_, self.contentTrs_)))

			self.stageList[iter_9_1]:SetData(iter_9_1)
		end

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
	end
end

function IdolTraineeChapterRewardView:RefreshRewardList()
	local var_10_1
	local var_10_0

	if self.stageList then
		for iter_10_0, iter_10_1 in pairs(self.stageList) do
			iter_10_1:RefreshUI()
		end

		var_10_0 = SetActive
		var_10_1 = self.allReciveGo_
	end

	var_10_0(var_10_1, #self:GetCurCanReciveTaskIdList() > 0)
end

function IdolTraineeChapterRewardView:DestoryItemList()
	if self.stageList then
		for iter_11_0, iter_11_1 in pairs(self.stageList) do
			iter_11_1:Dispose()
		end

		self.stageList = nil
	end
end

function IdolTraineeChapterRewardView:GetCurCanReciveTaskIdList()
	local var_12_0 = {}

	if self.stageList then
		for iter_12_0, iter_12_1 in pairs(self.stageList) do
			for iter_12_2, iter_12_3 in ipairs((iter_12_1:GetCanReciveAwardList())) do
				table.insert(var_12_0, iter_12_3)
			end
		end
	end

	return var_12_0
end

function IdolTraineeChapterRewardView:OnExit()
	self:RemoveAllEventListener()
end

function IdolTraineeChapterRewardView:Dispose()
	if self.stageList then
		for iter_14_0, iter_14_1 in pairs(self.stageList) do
			iter_14_1:Dispose()
		end

		self.stageList = nil
	end

	IdolTraineeChapterRewardView.super.Dispose(self)
end

return IdolTraineeChapterRewardView
