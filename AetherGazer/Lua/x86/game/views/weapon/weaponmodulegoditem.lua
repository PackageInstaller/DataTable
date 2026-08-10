local var_0_0 = class("WeaponModuleGodItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.statucontroller_ = ControllerUtil.GetController(arg_3_0.transform_, "type")
	arg_3_0.selectcontroller_ = ControllerUtil.GetController(arg_3_0.transform_, "select")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.selectCallBack_ then
			arg_4_0.selectCallBack_(arg_4_0.index_)
		end
	end)
end

function var_0_0.SetSelectCallBack(arg_6_0, arg_6_1)
	arg_6_0.selectCallBack_ = arg_6_1
end

function var_0_0.SetData(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.index_ = arg_7_1

	if arg_7_0.index_ == arg_7_2 then
		arg_7_0.selectcontroller_:SetSelectedState("true")
	else
		arg_7_0.selectcontroller_:SetSelectedState("false")
	end

	local var_7_0 = HeroAstrolabeCfg[arg_7_3]

	arg_7_0.nameText_.text = GetI18NText(var_7_0.suit_name) .. "·" .. GetI18NText(var_7_0.name)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)

	arg_8_0.selectCallBack_ = nil
end

return var_0_0
