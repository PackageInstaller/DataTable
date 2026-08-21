local var_0_0 = class("SectionSmallHeroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.emptyController_ = arg_3_0.controllerExCollection_:GetController("empty")
	arg_3_0.lockController_ = arg_3_0.controllerExCollection_:GetController("lock")
	arg_3_0.validController_ = arg_3_0.controllerExCollection_:GetController("valid")
end

function var_0_0.SetData(arg_4_0, arg_4_1)
	arg_4_0:Show(true)

	arg_4_0.heroID_ = arg_4_1

	arg_4_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_5_0)
	if arg_5_0.heroID_ and arg_5_0.heroID_ ~= 0 then
		arg_5_0.heroIcon_.sprite = getSpriteViaConfig("HeroItemshead", arg_5_0.heroID_)

		arg_5_0.emptyController_:SetSelectedState("false")
	else
		arg_5_0.emptyController_:SetSelectedState("true")
	end
end

function var_0_0.RefreshLock(arg_6_0, arg_6_1)
	arg_6_0.lockController_:SetSelectedState(tostring(arg_6_1))
end

function var_0_0.RefreshValid(arg_7_0, arg_7_1)
	arg_7_0.validController_:SetSelectedState(tostring(arg_7_1))
end

function var_0_0.Show(arg_8_0, arg_8_1)
	SetActive(arg_8_0.gameObject_, arg_8_1)
end

return var_0_0
