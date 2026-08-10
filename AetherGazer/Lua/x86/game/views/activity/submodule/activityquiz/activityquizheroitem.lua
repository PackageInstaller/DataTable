local var_0_0 = class("ActivityQuizHeroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.selectCon_ = ControllerUtil.GetController(arg_3_0.transform_, "select")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		ActivityQuizAction.ChangeHero(arg_4_0.heroID_)
	end)
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	arg_6_0.heroID_ = arg_6_1
	arg_6_0.icon_.sprite = getSpriteViaConfig("DormHeroHeadIcon", arg_6_0.heroID_)
end

function var_0_0.RefreshSelect(arg_7_0, arg_7_1)
	arg_7_0.selectCon_:SetSelectedState(arg_7_1 and "on" or "off")
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:RemoveAllListeners()
	arg_9_0.super.Dispose(arg_9_0)
end

return var_0_0
