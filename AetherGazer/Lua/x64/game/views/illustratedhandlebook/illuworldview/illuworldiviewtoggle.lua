local var_0_0 = class("IlluWorldIViewToggle", ReduxView)

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

function var_0_0.RefreshUI(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.index_ = arg_4_1
	arg_4_0.info_ = arg_4_2
	arg_4_0.nameText_.text = GetI18NText(arg_4_2.name)

	arg_4_0:ShowSelect(arg_4_2.select)
end

function var_0_0.ShowSelect(arg_5_0, arg_5_1)
	arg_5_0.info_.select = arg_5_1

	if arg_5_1 then
		arg_5_0.controller_:SetSelectedState("sel")
	else
		arg_5_0.controller_:SetSelectedState("notSel")
	end
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.toggleitemBtn_, nil, function()
		if arg_6_0.func_ then
			arg_6_0.func_(arg_6_0.index_)
		end
	end)
end

function var_0_0.RegisterBtnListener(arg_8_0, arg_8_1)
	arg_8_0.func_ = arg_8_1
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
