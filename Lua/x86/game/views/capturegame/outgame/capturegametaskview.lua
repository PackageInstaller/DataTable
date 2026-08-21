local var_0_0 = class("CaptureActivityMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/SummerUI_3_4/SummerUI_3_4_CaptureUI/Main/Summer2024_CaptureTaskUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
end

function var_0_0.BuildContext(arg_4_0)
	return
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
	arg_5_0:BuildContext()
	arg_5_0:AddListener()

	arg_5_0.scrollHelper = LuaList.New(handler(arg_5_0, arg_5_0.RenderItem), arg_5_0.taskList_, CaptureGameMainTaskModule)
	arg_5_0.taskUpdateHandler = handler(arg_5_0, arg_5_0.OnTaskUpdate)
	arg_5_0.onceController = arg_5_0.controller_:GetController("oneclick")
end

function var_0_0.AddListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.backBtn_, nil, function()
		arg_6_0:OnBackClick()
	end)
	arg_6_0:AddBtnListener(arg_6_0.onceBtn_, nil, function()
		arg_6_0:OnOnceClick()
	end)
end

function var_0_0.OnBackClick(arg_9_0)
	arg_9_0:Back()
end

function var_0_0.OnOnceClick(arg_10_0)
	local var_10_0 = arg_10_0:CheckTaskCanReceive()

	CaptureGameAction.ReceiveTaskReward(var_10_0)
end

function var_0_0.RenderItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.taskList[arg_11_1]

	arg_11_2:RenderView(var_11_0)
end

function var_0_0.OnEnter(arg_12_0)
	manager.notify:RegistListener(CAPTURE_GAME_OUTGAME_TASK_UPDATE, arg_12_0.taskUpdateHandler)

	local var_12_0 = {
		CaptureGameConst.ModeMainActivity.Single,
		CaptureGameConst.ModeMainActivity.Multi,
		CaptureGameConst.ModeMainActivity.Common
	}
	local var_12_1 = {}

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_2 = ActivityPointRewardCfg.get_id_list_by_activity_id[iter_12_1]

		for iter_12_2, iter_12_3 in ipairs(var_12_2) do
			table.insert(var_12_1, iter_12_3)
		end
	end

	arg_12_0.taskList = var_12_1

	arg_12_0:OnTaskUpdate()
	arg_12_0:RefreshOnce()
end

function var_0_0.OnTaskUpdate(arg_13_0)
	arg_13_0:UpdateCounter()

	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.taskList

	table.sort(var_13_1, function(arg_14_0, arg_14_1)
		local var_14_0 = var_13_0:CheckSingleTaskCanReceive(arg_14_0)
		local var_14_1 = var_13_0:CheckSingleTaskCanReceive(arg_14_1)

		if var_14_0 ~= var_14_1 then
			if var_14_0 == 1 then
				return true
			end

			if var_14_1 == 1 then
				return false
			end

			if var_14_0 == 2 then
				return false
			end

			if var_14_1 == 2 then
				return true
			end

			return arg_14_0 < arg_14_1
		else
			return arg_14_0 < arg_14_1
		end
	end)
	arg_13_0.scrollHelper:StartScroll(#arg_13_0.taskList)
	arg_13_0:RefreshOnce()
end

function var_0_0.RefreshOnce(arg_15_0)
	arg_15_0.onceController:SetSelectedState(#arg_15_0:CheckTaskCanReceive() > 0 and "state1" or "state0")
end

function var_0_0.CheckSingleTaskCanReceive(arg_16_0, arg_16_1)
	local var_16_0 = CaptureGameData:CheckTaskIsComplete(arg_16_1)

	if var_16_0 then
		return 2
	end

	local var_16_1 = ActivityPointRewardCfg[arg_16_1]
	local var_16_2 = var_16_1.activity_id

	if var_16_1.need <= (arg_16_0.mainCountMap[var_16_2] or 0) and not var_16_0 then
		return 1
	end

	return 0
end

function var_0_0.CheckTaskCanReceive(arg_17_0)
	arg_17_0:UpdateCounter()

	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.taskList) do
		if arg_17_0:CheckSingleTaskCanReceive(iter_17_1) == 1 then
			table.insert(var_17_0, iter_17_1)
		end
	end

	return var_17_0
end

function var_0_0.UpdateCounter(arg_18_0)
	arg_18_0.mainCountMap = {
		[CaptureGameConst.ModeMainActivity.Single] = CaptureGameData:GetCaptureCountByMode(CaptureGameConst.ServerNeedGameMode.Single),
		[CaptureGameConst.ModeMainActivity.Multi] = CaptureGameData:GetCaptureCountByMode(CaptureGameConst.ServerNeedGameMode.Multiple),
		[CaptureGameConst.ModeMainActivity.Common] = CaptureGameData:GetCaptureCountFull()
	}
end

function var_0_0.OnExit(arg_19_0)
	manager.notify:RemoveListener(CAPTURE_GAME_OUTGAME_TASK_UPDATE, arg_19_0.taskUpdateHandler)
end

function var_0_0.Dispose(arg_20_0)
	arg_20_0.scrollHelper:Dispose()
	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0
