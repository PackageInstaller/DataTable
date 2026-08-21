local var_0_0 = class("MatrixProcessSelectHeroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
	arg_1_0:AddUIListener()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.selectController_ = ControllerUtil.GetController(arg_2_0.transform_, "select")
	arg_2_0.stateController_ = ControllerUtil.GetController(arg_2_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.m_clickBtn, nil, function()
		if arg_3_0.clickFunc then
			arg_3_0.clickFunc(arg_3_0.heroId)
		end
	end)
end

function var_0_0.GetHeroId(arg_5_0)
	return arg_5_0.heroId
end

function var_0_0.Refresh(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.heroId = arg_6_1

	local var_6_0 = arg_6_0:GetHeroSkin(arg_6_1)

	arg_6_0.m_icon.sprite = getSpriteViaConfig("HeroLittleIcon", var_6_0)

	arg_6_0.stateController_:SetSelectedIndex(arg_6_2 and 0 or 1)
end

function var_0_0.SetSelected(arg_7_0, arg_7_1)
	arg_7_0.selectController_:SetSelectedIndex(arg_7_1 and 1 or 0)
end

function var_0_0.RegistCallBack(arg_8_0, arg_8_1)
	arg_8_0.clickFunc = arg_8_1
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

function var_0_0.GetHeroSkin(arg_10_0, arg_10_1)
	return MatrixData:GetHeroSkin(arg_10_1)
end

return var_0_0
