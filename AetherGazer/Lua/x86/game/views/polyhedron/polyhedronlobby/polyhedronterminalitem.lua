local var_0_0 = class("PolyhedronTerminalItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.id = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.frameController = ControllerUtil.GetController(arg_3_0.transform_, "frame")
	arg_3_0.selectController = ControllerUtil.GetController(arg_3_0.transform_, "select")
	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")

	local var_3_0 = PolyhedronTerminalCfg[arg_3_0.id]
	local var_3_1 = (var_3_0.classify or 1) - 1

	if var_3_0.hinge == 0 then
		arg_3_0.frameController:SetSelectedIndex(var_3_1)
	else
		arg_3_0.frameController:SetSelectedIndex(var_3_1 + 3)
	end

	arg_3_0.m_icon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.TERMINAL_ICON_PATH .. var_3_0.icon)
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_btn, nil, function()
		if arg_4_0.clickFunc then
			arg_4_0.clickFunc(arg_4_0.id, arg_4_0)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.stateController:SetSelectedIndex(arg_6_2)
end

function var_0_0.SetChoice(arg_7_0, arg_7_1)
	arg_7_0.selectController:SetSelectedIndex(arg_7_1 and 1 or 0)
end

function var_0_0.GetId(arg_8_0)
	return arg_8_0.id
end

function var_0_0.RegistCallBack(arg_9_0, arg_9_1)
	arg_9_0.clickFunc = arg_9_1
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
