local var_0_0 = class("SettingToggleItem", ReduxView)

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

	arg_3_0.selectController = ControllerUtil.GetController(arg_3_0.transform_, "select")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_btn01, nil, function()
		if arg_4_0.callback_ then
			arg_4_0.callback_(arg_4_0.index)
		end
	end)
	arg_4_0:AddBtnListener(arg_4_0.m_btn02, nil, function()
		if arg_4_0.callback_ then
			arg_4_0.callback_(arg_4_0.index)
		end
	end)
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2)
	manager.redPoint:unbindUIandKey(arg_7_0.transform_)

	arg_7_0.index = arg_7_1

	local var_7_0 = arg_7_2:Image()

	arg_7_0.icon_01.sprite = var_7_0
	arg_7_0.icon_02.sprite = var_7_0
	arg_7_0.data = arg_7_2

	if arg_7_2 and arg_7_2.RedPointKey and arg_7_2:RedPointKey() ~= nil then
		for iter_7_0, iter_7_1 in ipairs(arg_7_2:RedPointKey()) do
			manager.redPoint:bindUIandKey(arg_7_0.transform_, iter_7_1)
		end
	end
end

function var_0_0.SetSelect(arg_8_0, arg_8_1)
	if arg_8_0.index == arg_8_1 then
		arg_8_0.selectController:SetSelectedIndex(0)
	else
		arg_8_0.selectController:SetSelectedIndex(1)
	end
end

function var_0_0.RegistCallBack(arg_9_0, arg_9_1)
	arg_9_0.callback_ = arg_9_1
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.data and arg_10_0.data.RedPointKey and arg_10_0.data:RedPointKey() ~= nil then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0.data:RedPointKey()) do
			manager.redPoint:unbindUIandKey(arg_10_0.transform_, iter_10_1)
		end
	end

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
