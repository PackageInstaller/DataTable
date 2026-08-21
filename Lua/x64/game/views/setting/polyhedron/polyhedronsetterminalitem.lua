local var_0_0 = class("PolyhedronSetTerminalItem", ReduxView)

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

	arg_3_0.frameController = ControllerUtil.GetController(arg_3_0.transform_, "frame")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_btn, nil, function()
		if arg_4_0.clickFunc then
			local var_5_0 = PolyhedronTerminalCfg[arg_4_0.id]
			local var_5_1 = arg_4_0.transform_.position

			arg_4_0.clickFunc(var_5_0.name, var_5_0.desc, var_5_1)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.id = arg_6_1

	local var_6_0 = PolyhedronTerminalCfg[arg_6_1]
	local var_6_1 = (var_6_0.classify or 1) - 1

	if var_6_0.hinge == 0 then
		arg_6_0.frameController:SetSelectedIndex(var_6_1)
	else
		arg_6_0.frameController:SetSelectedIndex(var_6_1 + 3)
	end

	arg_6_0.m_icon.sprite = pureGetSpriteWithoutAtlas(PolyhedronConst.TERMINAL_ICON_PATH .. var_6_0.icon)
	arg_6_0.m_name.text = GetI18NText(var_6_0.name)
end

function var_0_0.SetActive(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.RegistCallBack(arg_9_0, arg_9_1)
	arg_9_0.clickFunc = arg_9_1
end

return var_0_0
