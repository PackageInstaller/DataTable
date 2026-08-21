local var_0_0 = import("game.views.chip.manager.MimirChipManagerInfoView")
local var_0_1 = class("BattleChipManagerInfoView", var_0_0)

function var_0_1.InitUI(arg_1_0)
	var_0_1.super.InitUI(arg_1_0)

	arg_1_0.chipManagerUnlockView_ = ChipManagerUnlockView.New(arg_1_0.chipGo_)
end

function var_0_1.RefreshData(arg_2_0, arg_2_1)
	arg_2_0.chipManagerID = arg_2_1

	local var_2_0 = ChipCfg[arg_2_0.chipManagerID]

	arg_2_0.chipManagerName_.text = GetI18NText(var_2_0.suit_name)
	arg_2_0.skillText_.text = GetI18NText(var_2_0.desc)

	local var_2_1, var_2_2, var_2_3 = IsConditionAchieved(var_2_0.new_condition)
	local var_2_4 = arg_2_0.chipManagerDataTemplate_:GetChipManagerIsUnLock(arg_2_0.chipManagerID)

	arg_2_0.isUnlock_ = var_2_1

	arg_2_0.chipManagerLockView_:SetActive(not var_2_4)
	arg_2_0.chipManagerUnlockView_:SetActive(var_2_4)

	if var_2_4 == false then
		if arg_2_0.isUnlock_ then
			arg_2_0.btnState:SetSelectedState("unLock2")
		else
			arg_2_0.btnState:SetSelectedState("unLock1")
		end

		arg_2_0.chipManagerLockView_:SetChipManagerID(arg_2_0.chipManagerID)
	else
		if arg_2_0.chipManagerDataTemplate_:GetISUseChipmanager(arg_2_0.chipManagerID) then
			arg_2_0.btnState:SetSelectedState("unUse")
		else
			arg_2_0.btnState:SetSelectedState("use")
		end

		arg_2_0.chipManagerUnlockView_:SetDataTemplate(arg_2_0.chipManagerDataTemplate_)
		arg_2_0.chipManagerUnlockView_:SetChipManagerID(arg_2_0.chipManagerID)
	end

	if arg_2_0.lastIndex then
		arg_2_0:SelectTab(arg_2_0.lastIndex)
	end

	manager.redPoint:bindUIandKey(arg_2_0.btn_unlock2Btn_.transform, string.format("%s_%s", RedPointConst.CHIP_MANAGER, arg_2_0.chipManagerID))
end

function var_0_1.AddListeners(arg_3_0)
	arg_3_0.super.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_unuseBtn_, nil, function()
		arg_3_0.chipManagerDataTemplate_:SetUseChipmanagerId(0)

		if arg_3_0.enableIDFunc_ then
			arg_3_0.enableIDFunc_(0)
		end

		ShowTips("CHIP_MANAGER_UNLOAD_SUCCESS")
	end)
	arg_3_0:AddBtnListener(arg_3_0.btn_useBtn_, nil, function()
		arg_3_0.chipManagerDataTemplate_:SetUseChipmanagerId(arg_3_0.chipManagerID)

		if arg_3_0.enableIDFunc_ then
			arg_3_0.enableIDFunc_(arg_3_0.chipManagerID)
		end

		ShowTips("CHIP_MANAGER_USE_SUCCESS")
	end)
end

function var_0_1.RegistEnableIDFunc(arg_6_0, arg_6_1)
	arg_6_0.enableIDFunc_ = arg_6_1
end

function var_0_1.Dispose(arg_7_0)
	var_0_1.super.Dispose(arg_7_0)

	if arg_7_0.chipManagerUnlockView_ then
		arg_7_0.chipManagerUnlockView_:Dispose()

		arg_7_0.chipManagerUnlockView_ = nil
	end
end

return var_0_1
