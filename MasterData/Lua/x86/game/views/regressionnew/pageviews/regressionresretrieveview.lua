local RegressionResRetrieveView = class("RegressionResRetrieveView", ReduxView)

function RegressionResRetrieveView:OnCtor(arg_1_1)
	local var_1_0 = Object.Instantiate(Asset.Load("Widget/System/ReturnThree/RT3rd_ResRetrieveUI"), arg_1_1)

	self.gameObject_ = var_1_0
	self.transform_ = var_1_0.transform

	self:Init()
end

function RegressionResRetrieveView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RegressionResRetrieveView:InitUI()
	self:BindCfgUI()

	self.taskState1Controller_ = self.controller_:GetController("taskState")
	self.btnState1Controller_ = self.controller_:GetController("btnState")
end

function RegressionResRetrieveView:GetRetrieveData(arg_4_1)
	local var_4_0 = RegressionDataNew:GetLastOfflineTime()
	local var_4_1 = RegressionDataNew:GetRegressReturnLevel()
	local var_4_2 = ReturnRetrieveCfg.all[1]

	for iter_4_0, iter_4_1 in pairs(ReturnRetrieveCfg.all) do
		if iter_4_1 <= var_4_1 then
			var_4_2 = iter_4_1
		else
			break
		end
	end

	local var_4_3 = ReturnRetrieveCfg[var_4_2]
	local var_4_5 = {}

	for iter_4_2, iter_4_3 in ipairs(arg_4_1 and var_4_3.challenge_supply or var_4_3.dundun_supply) do
		table.insert(var_4_5, {
			iter_4_3[1],
			iter_4_3[2]
		})
	end

	return var_4_5
end

function RegressionResRetrieveView:AddUIListener()
	self:AddBtnListener(self.dayCheckBtn_, nil, function()
		JumpTools.OpenPageByJump("rewardPreview", {
			rewardList = self:GetRetrieveData()
		}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
	end)
	self:AddBtnListener(self.weekCheckBtn_, nil, function()
		JumpTools.OpenPageByJump("rewardPreview", {
			rewardList = self:GetRetrieveData(true)
		}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
	end)
	self:AddBtnListener(self.findBtn_, nil, function()
		self:OnFindBtn()
	end)
end

function RegressionResRetrieveView:OnFindBtn()
	local var_9_0 = RegressionDataNew:GetRegressFindTime()

	if RegressionDataNew:IsCanFinishFindResTask() then
		var_9_0 = var_9_0 + 1
	end

	if var_9_0 > 0 then
		if RegressionDataNew:GetRegressFindTime() == 0 then
			TaskAction:SubmitTask(RegressionDataNew:GetReturnCfgData().return_retrieve_task[1])

			self.willFindRes = true
		else
			RegressionActionNew.FindRes()
		end
	else
		ShowTips("NEW_REGRESSION_NO_FIND_TIPS")
	end
end

function RegressionResRetrieveView:OnTaskSubmitResponse()
	if not self.willFindRes then
		return
	end

	RegressionActionNew.FindRes()

	self.willFindRes = false
end

function RegressionResRetrieveView:SetData()
	self.descTxt_.text = GetTips("NEW_REGRESSION_FIND_RES_DESC")

	self:UpdateFindTimesShow()

	local var_11_0 = RegressionDataNew:GetReturnCfgData().return_retrieve_task[1]

	self.taskText_.text = GetI18NText(AssignmentCfg[var_11_0].desc)

	local var_11_1 = TaskData2:GetTask(var_11_0)

	self.taskState1Controller_:SetSelectedState(RegressionDataNew:IsFinishFindResTask() and "finish" or "unFinish")

	self.currentpointTxt_.text = string.format(GetTips("NEW_REGRESSION_SCORE"), var_11_1.progress)

	manager.redPoint:bindUIandKey(self.findBtn_.transform, RedPointConst.NEW_REGRESSION_RES_FIND)
end

function RegressionResRetrieveView:UpdateFindTimesShow()
	local var_12_0 = RegressionDataNew:GetRegressFindTime()

	if RegressionDataNew:IsCanFinishFindResTask() then
		var_12_0 = var_12_0 + 1
	end

	self.findCountTxt_.text = string.format(GetTips("NEW_REGRESSION_FIND_TIME_DESC"), var_12_0)

	if var_12_0 > 0 then
		self.btnState1Controller_:SetSelectedState("normal")
	elseif TaskData2:GetTask(RegressionDataNew:GetReturnCfgData().return_retrieve_task[1]).complete_flag == 1 then
		self.btnState1Controller_:SetSelectedState("found")
	else
		self.btnState1Controller_:SetSelectedState("grey")
	end
end

function RegressionResRetrieveView:OnRegressionFindRes()
	self:UpdateFindTimesShow()
end

function RegressionResRetrieveView:SetActive(arg_14_1)
	SetActive(self.gameObject_, arg_14_1)
end

function RegressionResRetrieveView:Dispose()
	manager.redPoint:unbindUIandKey(self.findBtn_.transform, RedPointConst.NEW_REGRESSION_RES_FIND)
	RegressionResRetrieveView.super.Dispose(self)
end

return RegressionResRetrieveView
