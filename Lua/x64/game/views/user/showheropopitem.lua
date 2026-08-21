local var_0_0 = class("ShowHeroPopItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()

	arg_1_0.ownHeroDataProxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	arg_1_0.foreignHeroDataProxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.FOREIGN)
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.headIcon_.immediate = true
	arg_3_0.heroCampCon_ = ControllerUtil.GetController(arg_3_0.transform_, "camp")
	arg_3_0.heroStarCon_ = ControllerUtil.GetController(arg_3_0.transform_, "grade")
	arg_3_0.heroStateCon_ = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.isHeroOathController = arg_3_0.controllers_:GetController("isOath")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.selfBtn_, nil, function()
		if arg_4_0.clickFunc_ then
			arg_4_0.clickFunc_()
		end
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.RefreshData(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.data_ = arg_7_1
	arg_7_0.isForeign_ = arg_7_2

	if arg_7_0.data_.hero_id == 0 then
		if not arg_7_0.isForeign_ then
			arg_7_0.heroStateCon_:SetSelectedState(1)
		else
			arg_7_0.heroStateCon_:SetSelectedState(2)
		end
	else
		arg_7_0.heroStateCon_:SetSelectedState(0)
		arg_7_0:RefreshUI()
	end
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = arg_8_0.data_.oath

	if var_8_0 == nil then
		var_8_0 = (arg_8_0.isForeign_ and arg_8_0.foreignHeroDataProxy or arg_8_0.ownHeroDataProxy):IsHeroOath(arg_8_0.data_.hero_id)
	end

	arg_8_0.isHeroOathController:SetSelectedState(var_8_0 and "true" or "false")

	arg_8_0.headIcon_.spriteSync = getSpritePathViaConfig("HeroIcon", arg_8_0.data_.using_skin == 0 and arg_8_0.data_.hero_id or arg_8_0.data_.using_skin)

	local var_8_1 = HeroStarCfg[arg_8_0.data_.star]
	local var_8_2 = var_8_1 ~= nil and var_8_1.star or 1

	arg_8_0.heroStarCon_:SetSelectedState(var_8_2)

	local var_8_3 = HeroCfg[arg_8_0.data_.hero_id].race

	arg_8_0.campIcon_.sprite = HeroTools.GetHeroRaceIcon(arg_8_0.data_.hero_id)
	arg_8_0.levelText_.text = arg_8_0.data_.level

	SetActive(arg_8_0.lvGo_, not arg_8_0.isForeign_)
end

function var_0_0.RegistClickFunction(arg_9_0, arg_9_1)
	arg_9_0.clickFunc_ = arg_9_1
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllEventListener()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
