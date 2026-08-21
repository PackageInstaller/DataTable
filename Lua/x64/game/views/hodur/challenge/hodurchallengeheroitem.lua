local var_0_0 = class("HodurChallengeHeroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.haveController_ = arg_2_0.mainControllerEx_:GetController("default0")
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = HeroStandardSystemCfg[arg_3_1]

	if var_3_0 then
		arg_3_0.heroID_ = var_3_0.hero_id
	else
		arg_3_0.heroID_ = arg_3_1
	end

	arg_3_0.curHP_ = arg_3_2
	arg_3_0.maxHP_ = arg_3_3

	arg_3_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_4_0)
	if arg_4_0.heroID_ == nil then
		arg_4_0.haveController_:SetSelectedState("none")

		return
	end

	arg_4_0.haveController_:SetSelectedState("state1")

	arg_4_0.headImg_.sprite = HeroTools.GetHeadSprite(arg_4_0.heroID_)
	arg_4_0.hpBarImg_.fillAmount = arg_4_0.curHP_ / arg_4_0.maxHP_

	if arg_4_0.curHP_ == 0 then
		arg_4_0.hpText_.text = string.format("%d%%", 0)
	else
		arg_4_0.hpText_.text = string.format("%d%%", math.max(1, math.floor(arg_4_0.curHP_ / arg_4_0.maxHP_ * 100)))
	end
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
