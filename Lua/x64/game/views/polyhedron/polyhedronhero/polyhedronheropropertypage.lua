local var_0_0 = class("PolyhedronHeroPropertyPage", HeroPropertyPage)

function var_0_0.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.lockController_ = arg_1_0.controller_:GetController("lock")
	arg_1_0.favoriteController_ = arg_1_0.favorBtnController_:GetController("follow")
	arg_1_0.favoriteShowController_ = arg_1_0.favorBtnController_:GetController("favor")
	arg_1_0.detailController_ = arg_1_0.heroInfoController_:GetController("detail")
	arg_1_0.heroInfoView_ = PolyhedronHeroInfoView.New(arg_1_0, arg_1_0.infoViewGo_)
end

function var_0_0.CheckLocked(arg_2_0)
	arg_2_0.lockController_:SetSelectedState("true")
end

return var_0_0
