local var_0_0 = class("RankHeroItemBase", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.selectController_ = ControllerUtil.GetController(arg_2_0.transform_, "select")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btn_, nil, function()
		if arg_3_0.clickHandler_ then
			arg_3_0.clickHandler_(arg_3_0.heroID_)
		end
	end)
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.heroID_ = arg_5_1

	local var_5_0 = RankData:GetActivityRank(arg_5_2, arg_5_4)
	local var_5_1 = var_5_0 and var_5_0.curRank

	arg_5_0.scoreText_.text = var_5_1 and var_5_1.score or 0

	local var_5_2 = HeroCfg[arg_5_0.heroID_]

	arg_5_0.nameText_.text = var_5_2.name
	arg_5_0.portraitImg_.sprite = getSpriteViaConfig("HeroLittleIcon", arg_5_3)
end

function var_0_0.SetSelect(arg_6_0, arg_6_1)
	if arg_6_1 == arg_6_0.heroID_ then
		arg_6_0.selectController_:SetSelectedState("true")
	else
		arg_6_0.selectController_:SetSelectedState("false")
	end
end

function var_0_0.SetClickHandler(arg_7_0, arg_7_1)
	arg_7_0.clickHandler_ = arg_7_1
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
