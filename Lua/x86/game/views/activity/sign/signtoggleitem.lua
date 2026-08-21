local var_0_0 = class("SignToggleItem", ReduxView)

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

	arg_3_0.selectController = arg_3_0.m_ControllerEx_:GetController("select")
	arg_3_0.lockController = ControllerUtil.GetController(arg_3_0.transform_, "lock")
	arg_3_0.iconControllerUnselect = arg_3_0.m_iconControllerEx1_:GetController("icon")
	arg_3_0.iconControllerSelect = arg_3_0.m_iconControllerEx2_:GetController("icon")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.m_btn, nil, function()
		if arg_4_0.callback_ then
			arg_4_0.callback_(arg_4_0.index)
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	manager.redPoint:unbindUIandKey(arg_6_0.transform_)

	arg_6_0.index = arg_6_1

	if arg_6_2:RedPointKey() then
		manager.redPoint:bindUIandKey(arg_6_0.transform_, arg_6_2:RedPointKey())
	end

	arg_6_0.m_title.text = GetI18NText(arg_6_2:Title())
	arg_6_0.m_selectTitle.text = GetI18NText(arg_6_2:Title())

	local var_6_0 = arg_6_2:Image()

	if var_6_0 then
		arg_6_0.iconControllerUnselect:SetSelectedState(var_6_0)
		arg_6_0.iconControllerSelect:SetSelectedState(var_6_0)
	end

	if PlayerData:GetPlayerInfo().userLevel < arg_6_2:GetLimitLevel() then
		arg_6_0.lockController:SetSelectedIndex(1)
	else
		arg_6_0.lockController:SetSelectedIndex(0)
	end
end

function var_0_0.SetSelect(arg_7_0, arg_7_1)
	if arg_7_0.index == arg_7_1 then
		arg_7_0.selectController:SetSelectedIndex(1)
	else
		arg_7_0.selectController:SetSelectedIndex(0)
	end
end

function var_0_0.RegistCallBack(arg_8_0, arg_8_1)
	arg_8_0.callback_ = arg_8_1
end

function var_0_0.Dispose(arg_9_0)
	manager.redPoint:unbindUIandKey(arg_9_0.transform_)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
