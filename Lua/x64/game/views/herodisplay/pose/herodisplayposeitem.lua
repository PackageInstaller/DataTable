local var_0_0 = class("HeroDisplayPoseItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "select")
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.clickBtn_, nil, function()
		manager.notify:Invoke(HERO_POSE_SELECT, arg_2_0.index_)
	end)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.transform_ = nil
	arg_4_0.gameObject_ = nil
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:Show(true)

	arg_5_0.index_ = arg_5_2

	local var_5_0 = HeroDisplayData:GetHeroPoseList(arg_5_1)[arg_5_2]
	local var_5_1 = HeroDisplayPoseCfg[var_5_0.id].name

	arg_5_0.tagTxt_.text = GetI18NText(var_5_1)
end

function var_0_0.SetSelect(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.controller_:SetSelectedState("on")
	else
		arg_6_0.controller_:SetSelectedState("off")
	end
end

function var_0_0.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

return var_0_0
