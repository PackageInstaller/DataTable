local var_0_0 = class("CustomCenterHeroItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.selectController_ = arg_1_0.controllerEx_:GetController("selected")
	arg_1_0.useController_ = arg_1_0.controllerEx_:GetController("use")
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		if arg_3_0.heroID_ == arg_3_0.selectID_ then
			return
		end

		manager.notify:Invoke(CUSTOM_CENTER_SELECT_HERO, arg_3_0.heroID_)
	end)
end

function var_0_0.SetHeroData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.heroID_ = arg_5_1

	arg_5_0:RefreshUI()
	arg_5_0:SetSelected(arg_5_2)
end

function var_0_0.RefreshUI(arg_6_0)
	arg_6_0.nameText_.text = HeroTools.GetHeroFullName(arg_6_0.heroID_)

	local var_6_0 = PlayerData:GetCacheHeroSkinID(arg_6_0.heroID_)

	arg_6_0.headIcon_.sprite = HeroTools.GetHeadSprite(var_6_0)

	arg_6_0:RefreshSelectedState()
	arg_6_0:RefreshSkinCnt()
end

function var_0_0.SetSelected(arg_7_0, arg_7_1)
	arg_7_0.selectID_ = arg_7_1

	arg_7_0:RefreshSelectedState()
end

function var_0_0.RefreshSelectedState(arg_8_0)
	arg_8_0.selectController_:SetSelectedState(tostring(arg_8_0.selectID_ == arg_8_0.heroID_))
end

function var_0_0.RefreshSkinCnt(arg_9_0)
	local var_9_0 = CustomCenterTools.GetHeroUseSkinCnt(arg_9_0.heroID_)

	if var_9_0 > 0 then
		arg_9_0.useController_:SetSelectedState("true")

		arg_9_0.skinCntText_.text = var_9_0

		return
	end

	arg_9_0.useController_:SetSelectedState("false")
end

return var_0_0
