local var_0_0 = class("HeroFileArchiveTabItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.itemIndex = arg_1_2
	arg_1_0.lock = false

	function arg_1_0.clickHandler()
		if arg_1_0.onClick then
			arg_1_0:onClick(arg_1_0.itemIndex)
		end
	end

	arg_1_0:Init()
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.lockController = arg_4_0.linktabitemControllerEx_:GetController("lock")
	arg_4_0.selectController = arg_4_0.linktabitemControllerEx_:GetController("select")
	arg_4_0.bgController = arg_4_0.linktabitemControllerEx_:GetController("bg")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.selectBtn_, nil, arg_5_0.clickHandler)
end

function var_0_0.SetTitle(arg_6_0, arg_6_1)
	arg_6_0.titleText_.text = arg_6_1
end

function var_0_0.SetOnClick(arg_7_0, arg_7_1)
	arg_7_0.onClick = arg_7_1
end

function var_0_0.SetLockState(arg_8_0, arg_8_1)
	arg_8_0.lock = arg_8_1

	arg_8_0.lockController:SetSelectedState(arg_8_1 and "lock" or "unlock")
end

function var_0_0.SetSelectState(arg_9_0, arg_9_1)
	arg_9_0.selectController:SetSelectedState(arg_9_1 and "select" or "cancel")
end

function var_0_0.SetBgState(arg_10_0, arg_10_1)
	arg_10_0.bgController:SetSelectedState(arg_10_1)
end

function var_0_0.SetIsShow(arg_11_0, arg_11_1)
	SetActive(arg_11_0.gameObject_, arg_11_1)
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
