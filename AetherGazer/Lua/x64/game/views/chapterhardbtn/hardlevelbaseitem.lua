local var_0_0 = class("HardLevelBaseItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.hardLevel_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.lockController_ = arg_2_0.controllerEx_:GetController("lock")
end

function var_0_0.OnEnter(arg_3_0)
	arg_3_0:IsLock()
	arg_3_0:RefreshItem()
end

function var_0_0.OnExit(arg_4_0)
	return
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.btn_, nil, function()
		if arg_6_0.isLock_ then
			arg_6_0:LockTips()

			return
		end

		arg_6_0:ClickBtn()
	end)
end

function var_0_0.LockTips(arg_8_0)
	ShowTips("ERROR_FUNCTION_NOT_OPEN")
end

function var_0_0.ClickBtn(arg_9_0)
	return
end

function var_0_0.RefreshItem(arg_10_0)
	arg_10_0.lockController_:SetSelectedState(tostring(arg_10_0.isLock_))

	arg_10_0.hardText_.text = GetTips(BattleConst.HARD_LANGUAGE[arg_10_0.hardLevel_])
end

function var_0_0.SetSiblingIndex(arg_11_0, arg_11_1)
	arg_11_0.transform_:SetSiblingIndex(arg_11_1)
end

function var_0_0.IsLock(arg_12_0)
	arg_12_0.isLock_ = false
end

return var_0_0
