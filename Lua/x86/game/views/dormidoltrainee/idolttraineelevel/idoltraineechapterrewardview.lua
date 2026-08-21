local var_0_0 = class("IdolTraineeChapterRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/IdolTrainee/IdolChapterRewardPopup"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backBtn, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.reciveBtn, nil, function()
		local var_7_0 = arg_5_0:GetCurCanReciveTaskIdList()

		if #var_7_0 > 0 then
			TaskAction:SubmitTaskList(var_7_0, nil, handler(arg_5_0, arg_5_0.RefreshRewardList))
		end
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.chapterID = arg_8_0.params_.chapterID

	arg_8_0:InitChapterList()
	arg_8_0:RefreshRewardList()
	arg_8_0:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, handler(arg_8_0, arg_8_0.RefreshRewardList))
end

function var_0_0.InitChapterList(arg_9_0)
	if arg_9_0.chapterID ~= arg_9_0.chapterOldID then
		arg_9_0:DestoryItemList()

		arg_9_0.stageList = {}

		local var_9_0 = IdolTraineeChapterCfg[arg_9_0.chapterID].section_id_list

		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			local var_9_1 = Object.Instantiate(arg_9_0.leveltitleGo_, arg_9_0.contentTrs_)

			arg_9_0.stageList[iter_9_1] = IdolTraineeRewardStageItem.New(var_9_1)

			arg_9_0.stageList[iter_9_1]:SetData(iter_9_1)
		end

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_0.contentTrs_)
	end
end

function var_0_0.RefreshRewardList(arg_10_0)
	if arg_10_0.stageList then
		for iter_10_0, iter_10_1 in pairs(arg_10_0.stageList) do
			iter_10_1:RefreshUI()
		end
	end

	local var_10_0 = arg_10_0:GetCurCanReciveTaskIdList()

	SetActive(arg_10_0.allReciveGo_, #var_10_0 > 0)
end

function var_0_0.DestoryItemList(arg_11_0)
	if arg_11_0.stageList then
		for iter_11_0, iter_11_1 in pairs(arg_11_0.stageList) do
			iter_11_1:Dispose()
		end

		arg_11_0.stageList = nil
	end
end

function var_0_0.GetCurCanReciveTaskIdList(arg_12_0)
	local var_12_0 = {}

	if arg_12_0.stageList then
		for iter_12_0, iter_12_1 in pairs(arg_12_0.stageList) do
			local var_12_1 = iter_12_1:GetCanReciveAwardList()

			for iter_12_2, iter_12_3 in ipairs(var_12_1) do
				table.insert(var_12_0, iter_12_3)
			end
		end
	end

	return var_12_0
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_14_0)
	if arg_14_0.stageList then
		for iter_14_0, iter_14_1 in pairs(arg_14_0.stageList) do
			iter_14_1:Dispose()
		end

		arg_14_0.stageList = nil
	end

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
