local var_0_0 = class("RegressionResRetrieveView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("Widget/System/ReturnThree/RT3rd_ResRetrieveUI")
	local var_1_1 = Object.Instantiate(var_1_0, arg_1_1)

	arg_1_0.gameObject_ = var_1_1
	arg_1_0.transform_ = var_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.taskState1Controller_ = arg_3_0.controller_:GetController("taskState")
	arg_3_0.btnState1Controller_ = arg_3_0.controller_:GetController("btnState")
end

function var_0_0.GetRetrieveData(arg_4_0, arg_4_1)
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
	local var_4_4

	if arg_4_1 then
		var_4_4 = var_4_3.challenge_supply
	else
		var_4_4 = var_4_3.dundun_supply
	end

	local var_4_5 = {}

	for iter_4_2, iter_4_3 in ipairs(var_4_4) do
		table.insert(var_4_5, {
			iter_4_3[1],
			iter_4_3[2]
		})
	end

	return var_4_5
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.dayCheckBtn_, nil, function()
		JumpTools.OpenPageByJump("rewardPreview", {
			rewardList = arg_5_0:GetRetrieveData()
		}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
	end)
	arg_5_0:AddBtnListener(arg_5_0.weekCheckBtn_, nil, function()
		JumpTools.OpenPageByJump("rewardPreview", {
			rewardList = arg_5_0:GetRetrieveData(true)
		}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
	end)
	arg_5_0:AddBtnListener(arg_5_0.findBtn_, nil, function()
		arg_5_0:OnFindBtn()
	end)
end

function var_0_0.OnFindBtn(arg_9_0)
	local var_9_0 = RegressionDataNew:GetRegressFindTime()

	if RegressionDataNew:IsCanFinishFindResTask() then
		var_9_0 = var_9_0 + 1
	end

	if var_9_0 > 0 then
		if RegressionDataNew:GetRegressFindTime() == 0 then
			local var_9_1 = RegressionDataNew:GetReturnCfgData().return_retrieve_task[1]

			TaskAction:SubmitTask(var_9_1)

			arg_9_0.willFindRes = true
		else
			RegressionActionNew.FindRes()
		end
	else
		ShowTips("NEW_REGRESSION_NO_FIND_TIPS")
	end
end

function var_0_0.OnTaskSubmitResponse(arg_10_0)
	if not arg_10_0.willFindRes then
		return
	end

	RegressionActionNew.FindRes()

	arg_10_0.willFindRes = false
end

function var_0_0.SetData(arg_11_0)
	arg_11_0.descTxt_.text = GetTips("NEW_REGRESSION_FIND_RES_DESC")

	arg_11_0:UpdateFindTimesShow()

	local var_11_0 = RegressionDataNew:GetReturnCfgData().return_retrieve_task[1]

	arg_11_0.taskText_.text = GetI18NText(AssignmentCfg[var_11_0].desc)

	local var_11_1 = TaskData2:GetTask(var_11_0)
	local var_11_2 = RegressionDataNew:IsFinishFindResTask()

	arg_11_0.taskState1Controller_:SetSelectedState(var_11_2 and "finish" or "unFinish")

	arg_11_0.currentpointTxt_.text = string.format(GetTips("NEW_REGRESSION_SCORE"), var_11_1.progress)

	manager.redPoint:bindUIandKey(arg_11_0.findBtn_.transform, RedPointConst.NEW_REGRESSION_RES_FIND)
end

function var_0_0.UpdateFindTimesShow(arg_12_0)
	local var_12_0 = RegressionDataNew:GetRegressFindTime()

	if RegressionDataNew:IsCanFinishFindResTask() then
		var_12_0 = var_12_0 + 1
	end

	arg_12_0.findCountTxt_.text = string.format(GetTips("NEW_REGRESSION_FIND_TIME_DESC"), var_12_0)

	if var_12_0 > 0 then
		arg_12_0.btnState1Controller_:SetSelectedState("normal")
	else
		local var_12_1 = RegressionDataNew:GetReturnCfgData().return_retrieve_task[1]

		if TaskData2:GetTask(var_12_1).complete_flag == 1 then
			arg_12_0.btnState1Controller_:SetSelectedState("found")
		else
			arg_12_0.btnState1Controller_:SetSelectedState("grey")
		end
	end
end

function var_0_0.OnRegressionFindRes(arg_13_0)
	arg_13_0:UpdateFindTimesShow()
end

function var_0_0.SetActive(arg_14_0, arg_14_1)
	SetActive(arg_14_0.gameObject_, arg_14_1)
end

function var_0_0.Dispose(arg_15_0)
	manager.redPoint:unbindUIandKey(arg_15_0.findBtn_.transform, RedPointConst.NEW_REGRESSION_RES_FIND)
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
