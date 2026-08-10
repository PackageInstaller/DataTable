local var_0_0 = class("MimirChipManagerInfoView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.ctrl = arg_1_2

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.btnState = arg_2_0.btnControllerexcollection_:GetController("btn")
	arg_2_0.tabControl = arg_2_0.tabControllerexcollection_:GetController("select")
	arg_2_0.chipManagerLockView_ = ChipManagerLockView.New(arg_2_0.lockPanel_)
end

function var_0_0.OnEnter(arg_3_0)
	return
end

function var_0_0.OnExit(arg_4_0)
	manager.redPoint:unbindUIandKey(arg_4_0.btn_unlock2Btn_.transform)
end

function var_0_0.SetTemplateData(arg_5_0, arg_5_1)
	arg_5_0.chipManagerDataTemplate_ = arg_5_1
end

function var_0_0.RefreshData(arg_6_0, arg_6_1)
	arg_6_0.chipManagerID = arg_6_1

	local var_6_0 = ChipCfg[arg_6_0.chipManagerID]

	arg_6_0.chipManagerName_.text = GetI18NText(var_6_0.suit_name)
	arg_6_0.skillText_.text = GetI18NText(var_6_0.desc)

	local var_6_1, var_6_2, var_6_3 = IsConditionAchieved(var_6_0.new_condition)
	local var_6_4 = arg_6_0.chipManagerDataTemplate_:GetChipManagerIsUnLock(arg_6_0.chipManagerID)

	arg_6_0.isUnlock_ = var_6_1

	arg_6_0.chipManagerLockView_:SetChipManagerID(arg_6_0.chipManagerID)
	arg_6_0.chipManagerLockView_:SetActive(not var_6_4)

	if var_6_4 == false then
		if arg_6_0.isUnlock_ then
			arg_6_0.btnState:SetSelectedState("unLock2")
		else
			arg_6_0.btnState:SetSelectedState("unLock1")
		end
	else
		arg_6_0.btnState:SetSelectedState("unlocked")
	end

	if arg_6_0.lastIndex then
		arg_6_0:SelectTab(arg_6_0.lastIndex)
	end

	manager.redPoint:bindUIandKey(arg_6_0.btn_unlock2Btn_.transform, string.format("%s_%s", RedPointConst.CHIP_MANAGER, arg_6_0.chipManagerID))
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.btn_unlock2Btn_, nil, function()
		if arg_7_0.isUnlock_ then
			ChipAction.UnlockChipManager(arg_7_0.chipManagerID)
		else
			ShowTips("CHIP_MANAGER_UNLOCK_FAILED")
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.btn_unlock1Btn_, nil, function()
		ShowTips("CHIP_MANAGER_UNLOCK_FAILED")
	end)

	for iter_7_0 = 1, 2 do
		arg_7_0:AddBtnListener(arg_7_0[string.format("btnTab%s_", iter_7_0)], nil, function()
			arg_7_0:SelectTab(iter_7_0)
		end)
	end
end

function var_0_0.SelectTab(arg_11_0, arg_11_1)
	local var_11_0 = ChipCfg[arg_11_0.chipManagerID]

	if arg_11_1 == 1 then
		OperationRecorder.Record("chipManager", "pageDetail")

		arg_11_0.skillText_.text = GetI18NText(var_11_0.desc)
		arg_11_0.lastIndex = arg_11_1
	elseif arg_11_1 == 2 then
		OperationRecorder.Record("chipManager", "pageStory")

		arg_11_0.skillText_.text = GetI18NText(var_11_0.story)
		arg_11_0.lastIndex = arg_11_1
	end

	arg_11_0.tabControl:SetSelectedState(string.format("select%s", arg_11_1))
end

function var_0_0.RemoveListeners(arg_12_0)
	return
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
	arg_13_0:RemoveListeners()

	if arg_13_0.chipManagerLockView_ then
		arg_13_0.chipManagerLockView_:Dispose()

		arg_13_0.chipManagerLockView_ = nil
	end

	if arg_13_0.chipManagerUnlockView_ then
		arg_13_0.chipManagerUnlockView_:Dispose()

		arg_13_0.chipManagerUnlockView_ = nil
	end

	arg_13_0.ctrl = nil
end

return var_0_0
