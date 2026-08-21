local var_0_0 = class("HeroTrialSelectItem_Resident", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
	arg_1_0:SetActivityHeroID(arg_1_4, arg_1_3)
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.heroHeadIcon_.immediate = true
	arg_3_0.selectController_ = arg_3_0.controllerEx_:GetController("select")
	arg_3_0.completeController_ = arg_3_0.controllerEx_:GetController("complete")
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)

	local var_4_0 = ActivityHeroTrialCfg[arg_4_0.acitvityTrialID_]
	local var_4_1 = string.format("%s_%s", RedPointConst.HERO_TRIAL, var_4_0.id)

	manager.redPoint:unbindUIandKey(arg_4_0.transform_, var_4_1)
	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.transform_ = nil
	arg_4_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		HeroTrialData:SetSelectActivityHeroID(arg_5_0.activityID_, arg_5_0.acitvityTrialID_)
		manager.notify:Invoke(HERO_TRIAL_CLICK, arg_5_0.acitvityTrialID_)
	end)
end

function var_0_0.SetActivityHeroID(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.acitvityTrialID_ == nil then
		local var_7_0 = ActivityHeroTrialCfg[arg_7_2]
		local var_7_1 = string.format("%s_%s", RedPointConst.HERO_TRIAL, var_7_0.id)

		manager.redPoint:bindUIandKey(arg_7_0.transform_, var_7_1)
	elseif arg_7_0.acitvityTrialID_ ~= arg_7_2 then
		local var_7_2 = ActivityHeroTrialCfg[arg_7_0.acitvityTrialID_]
		local var_7_3 = string.format("%s_%s", RedPointConst.HERO_TRIAL, var_7_2.id)

		manager.redPoint:unbindUIandKey(arg_7_0.transform_, var_7_3)

		local var_7_4 = ActivityHeroTrialCfg[arg_7_2]
		local var_7_5 = string.format("%s_%s", RedPointConst.HERO_TRIAL, var_7_4.id)

		manager.redPoint:bindUIandKey(arg_7_0.transform_, var_7_5)
	end

	arg_7_0.acitvityTrialID_ = arg_7_2
	arg_7_0.activityID_ = arg_7_1

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	local var_8_0 = HeroTrialTools.GetHeroStandardID(arg_8_0.acitvityTrialID_)
	local var_8_1 = SkinCfg[HeroStandardSystemCfg[var_8_0].skin_id].picture_id

	arg_8_0.heroHeadIcon_.spriteSync = SpritePathCfg.HeroLittleIcon.path .. var_8_1

	local var_8_2 = HeroCfg[HeroStandardSystemCfg[var_8_0].hero_id].race

	arg_8_0.raceImg_.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[var_8_2].icon)

	arg_8_0:RefreshComplete()
end

function var_0_0.OnSelect(arg_9_0, arg_9_1)
	arg_9_0.selectController_:SetSelectedState(tostring(arg_9_0.acitvityTrialID_ == arg_9_1))
end

function var_0_0.RefreshComplete(arg_10_0)
	if arg_10_0.completeController_ then
		local var_10_0 = HeroTrialData:GetHeroTrialStateList()[arg_10_0.acitvityTrialID_] ~= 0

		arg_10_0.completeController_:SetSelectedState(tostring(var_10_0))
	end
end

return var_0_0
