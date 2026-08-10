local var_0_0 = class("IlluEnemyFileDetailItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "conName")
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, true)

	arg_4_0.titleText_.text = GetI18NText(arg_4_1.name)

	if arg_4_1.isLock then
		arg_4_0.controller_:SetSelectedState("lock")

		arg_4_0.requireText_.text = GetI18NText(arg_4_1.info)
	else
		arg_4_0.controller_:SetSelectedState("unlock")

		arg_4_0.descText_.text = GetI18NText(arg_4_1.info)
	end
end

function var_0_0.Hide(arg_5_0)
	SetActive(arg_5_0.gameObject_, false)
end

function var_0_0.AddUIListener(arg_6_0)
	return
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
