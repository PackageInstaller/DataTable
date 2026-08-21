local var_0_0 = class("SummerRaceUnlockPopItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.isCarController_ = arg_2_0.controllerEx_:GetController("isCar")
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	arg_3_0.itemData_ = arg_3_1

	arg_3_0:RefreshView()
end

function var_0_0.RefreshView(arg_4_0)
	local var_4_0 = arg_4_0.itemData_

	arg_4_0.nameText_.text = tostring(var_4_0.itemName or "")

	arg_4_0.isCarController_:SetSelectedState(var_4_0.isCar and "true" or "false")

	if var_4_0.isCar then
		arg_4_0.carIcon_.spriteSync = var_4_0.iconPath ~= "" and var_4_0.iconPath or nil
	else
		arg_4_0.normalIcon_.spriteSync = var_4_0.iconPath ~= "" and var_4_0.iconPath or nil
	end
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.itemData_ = nil

	var_0_0.super.Dispose(arg_5_0)
end

local var_0_1 = class("SummerRaceUnlockPopView", ReduxView)

function var_0_1.UIName(arg_6_0)
	return "Widget/System/Activity_SummerRace/Activity_SummerRace_MainUI/Activity_SummerRace_EquipUnlockPopUI"
end

function var_0_1.UIParent(arg_7_0)
	return manager.ui.uiPop.transform
end

function var_0_1.Init(arg_8_0)
	arg_8_0:BindCfgUI()

	arg_8_0.unlockItemList_ = LuaList.New(handler(arg_8_0, arg_8_0.IndexUnlockItem), arg_8_0.listGo_, var_0_0)
	arg_8_0.unlockItemDataList_ = {}
	arg_8_0.followupUnlockTimer_ = nil

	arg_8_0:AddUIListener()
end

function var_0_1.OnEnter(arg_9_0)
	arg_9_0:RefreshView()
end

function var_0_1.OnExit(arg_10_0)
	arg_10_0:StopFollowupUnlockTimer()
end

function var_0_1.AddUIListener(arg_11_0)
	arg_11_0:AddBtnListener(arg_11_0.sureBtn_, nil, function()
		JumpTools.Back()
		arg_11_0:ScheduleFollowupUnlock()
	end)
	arg_11_0:AddBtnListener(arg_11_0.goModifyBtn_, nil, function()
		JumpTools.Back()
		SummerRaceAction.OpenModifyView("all")
	end)
end

function var_0_1.IndexUnlockItem(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2:SetData(arg_14_0.unlockItemDataList_[arg_14_1])
end

function var_0_1.RefreshView(arg_15_0)
	arg_15_0.unlockItemDataList_ = SummerRaceData:GetUnlockPopViewModel().unlockItemList

	arg_15_0.unlockItemList_:StartScroll(#arg_15_0.unlockItemDataList_)
end

function var_0_1.ScheduleFollowupUnlock(arg_16_0)
	arg_16_0:StopFollowupUnlockTimer()

	arg_16_0.followupUnlockTimer_ = Timer.New(function()
		arg_16_0:StopFollowupUnlockTimer()
		SummerRaceAction.TryContinuePendingUnlockFlow()
	end, 0.05, 1)

	arg_16_0.followupUnlockTimer_:Start()
end

function var_0_1.StopFollowupUnlockTimer(arg_18_0)
	if arg_18_0.followupUnlockTimer_ ~= nil then
		arg_18_0.followupUnlockTimer_:Stop()

		arg_18_0.followupUnlockTimer_ = nil
	end
end

function var_0_1.Dispose(arg_19_0)
	arg_19_0:StopFollowupUnlockTimer()

	if arg_19_0.unlockItemList_ ~= nil then
		arg_19_0.unlockItemList_:Dispose()

		arg_19_0.unlockItemList_ = nil
	end

	arg_19_0.unlockItemDataList_ = nil

	var_0_1.super.Dispose(arg_19_0)
end

return var_0_1
