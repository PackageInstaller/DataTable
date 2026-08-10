local var_0_0 = class("BulletinBtnItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.clickHandler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectedController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "selected")
	arg_3_0.newController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "new")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener("", nil, function()
		if arg_4_0.clickHandler_ then
			arg_4_0.clickHandler_(arg_4_0.data_)
			arg_4_0:UpdateView()
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.data_ = arg_6_1

	arg_6_0:UpdateView()
end

function var_0_0.UpdateView(arg_7_0)
	local var_7_0 = manager.time:GetServerTime()
	local var_7_1 = SettingData:GetCurrentLanguage()
	local var_7_2 = arg_7_0.data_.i18n_info_name[var_7_1] or arg_7_0.data_.name

	arg_7_0.content_.text = GetI18NText(var_7_2)
	arg_7_0.content1_.text = GetI18NText(var_7_2)

	if not getData("bulletin", "bulletin_" .. arg_7_0.data_.id) and var_7_0 < arg_7_0.data_.endTime then
		arg_7_0.newController_:SetSelectedState("true")
	else
		arg_7_0.newController_:SetSelectedState("false")
	end
end

function var_0_0.SetSelected(arg_8_0, arg_8_1)
	arg_8_0.selectedController_:SetSelectedState(arg_8_1 and "true" or "false")
	arg_8_0:UpdateView()
end

function var_0_0.OnEnter(arg_9_0)
	return
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()
	arg_11_0.transform_:SetParent(nil)
	Object.Destroy(arg_11_0.gameObject_)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
