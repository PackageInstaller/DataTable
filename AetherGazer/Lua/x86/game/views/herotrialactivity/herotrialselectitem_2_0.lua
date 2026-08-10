local var_0_0 = class("HeroTrialSelectItem_2_0", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()

	arg_1_0.imageSelect_.immediate = true
	arg_1_0.imageIcon_.immediate = true

	arg_1_0:AddListeners()

	arg_1_0.selectController_ = ControllerUtil.GetController(arg_1_0.transform_, "name")
	arg_1_0.completeController_ = ControllerUtil.GetController(arg_1_0.transform_, "complete")

	arg_1_0:SetActivityHeroID(arg_1_4, arg_1_3)
	SetActive(arg_1_0.gameObject_, true)
end

function var_0_0.Dispose(arg_2_0)
	var_0_0.super.Dispose(arg_2_0)

	local var_2_0 = ActivityHeroTrialCfg[arg_2_0.acitvityTrialID_]
	local var_2_1 = string.format("%s_%s", RedPointConst.HERO_TRIAL, var_2_0.id)

	manager.redPoint:unbindUIandKey(arg_2_0.transformBtn1_, var_2_1)
	manager.redPoint:unbindUIandKey(arg_2_0.transformBtn2_, var_2_1)
	Object.Destroy(arg_2_0.gameObject_)

	arg_2_0.transform_ = nil
	arg_2_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		HeroTrialData:SetSelectActivityHeroID(arg_3_0.activityID_, arg_3_0.acitvityTrialID_)
		manager.notify:Invoke(HERO_TRIAL_CLICK, arg_3_0.acitvityTrialID_)
	end)
end

function var_0_0.SetActivityHeroID(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.acitvityTrialID_ == nil then
		local var_5_0 = ActivityHeroTrialCfg[arg_5_2]
		local var_5_1 = string.format("%s_%s", RedPointConst.HERO_TRIAL, var_5_0.id)

		manager.redPoint:bindUIandKey(arg_5_0.transformBtn1_, var_5_1)
		manager.redPoint:bindUIandKey(arg_5_0.transformBtn2_, var_5_1)
	elseif arg_5_0.acitvityTrialID_ ~= arg_5_2 then
		local var_5_2 = ActivityHeroTrialCfg[arg_5_0.acitvityTrialID_]
		local var_5_3 = string.format("%s_%s", RedPointConst.HERO_TRIAL, var_5_2.id)

		manager.redPoint:unbindUIandKey(arg_5_0.transformBtn1_, var_5_3)
		manager.redPoint:unbindUIandKey(arg_5_0.transformBtn2_, var_5_3)

		local var_5_4 = ActivityHeroTrialCfg[arg_5_2]
		local var_5_5 = string.format("%s_%s", RedPointConst.HERO_TRIAL, var_5_4.id)

		manager.redPoint:bindUIandKey(arg_5_0.transformBtn1_, var_5_5)
		manager.redPoint:bindUIandKey(arg_5_0.transformBtn2_, var_5_5)
	end

	arg_5_0.acitvityTrialID_ = arg_5_2
	arg_5_0.activityID_ = arg_5_1

	arg_5_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_6_0)
	local var_6_0 = HeroTrialTools.GetHeroStandardID(arg_6_0.acitvityTrialID_)
	local var_6_1 = SkinCfg[HeroStandardSystemCfg[var_6_0].skin_id].picture_id
	local var_6_2 = getSpritePathViaConfig("HeroIcon", var_6_1)

	arg_6_0.imageSelect_.spriteSync = var_6_2
	arg_6_0.imageIcon_.spriteSync = var_6_2

	local var_6_3 = HeroCfg[HeroStandardSystemCfg[var_6_0].hero_id].race

	arg_6_0.imageRace_.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[var_6_3].icon)
	arg_6_0.imageRaceSelect_.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[var_6_3].icon)

	arg_6_0:RefreshComplete()
end

function var_0_0.OnSelect(arg_7_0, arg_7_1)
	if arg_7_0.acitvityTrialID_ == arg_7_1 then
		arg_7_0.selectController_:SetSelectedState("Select")
	else
		arg_7_0.selectController_:SetSelectedState("no")
	end
end

function var_0_0.RefreshComplete(arg_8_0)
	if arg_8_0.completeController_ then
		local var_8_0 = HeroTrialData:GetHeroTrialStateList()[arg_8_0.acitvityTrialID_] ~= 0

		arg_8_0.completeController_:SetSelectedState(tostring(var_8_0))
	end
end

return var_0_0
