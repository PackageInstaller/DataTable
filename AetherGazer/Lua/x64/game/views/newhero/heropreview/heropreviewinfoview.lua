local var_0_0 = class("HeroPreviewInfoView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("raceCollectReward", {})
	end)
end

function var_0_0.SetHeroInfo(arg_6_0, arg_6_1)
	manager.redPoint:bindUIandKey(arg_6_0.rewardTrs_, RedPointConst.HERO_RACE_COLLECT_REWARD)

	arg_6_0.heroInfo_ = arg_6_1
	arg_6_0.heroCfg_ = HeroCfg[arg_6_1.id]
	arg_6_0.curHeroId_ = arg_6_1.id

	arg_6_0:UpdateView()
end

function var_0_0.UpdateView(arg_7_0)
	arg_7_0.nameText_.text = GetI18NText(arg_7_0.heroCfg_.name)
	arg_7_0.subNameText_.text = GetI18NText(arg_7_0.heroCfg_.suffix)
	arg_7_0.campLogo_.sprite = HeroTools.GetRaceIcon(arg_7_0.heroCfg_.race)
	arg_7_0.starImg_.sprite = getSprite("Atlas/Common", "star_" .. arg_7_0.heroCfg_.rare)
	arg_7_0.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_7_0.heroCfg_.id)
	arg_7_0.rangeTypeText_.text = CharactorParamCfg[arg_7_0.heroInfo_.id].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
	arg_7_0.infoText_.text = arg_7_0.heroCfg_.hero_desc

	arg_7_0:RefreshChargeType()

	local var_7_0 = ObtainHeroMovieCfg[arg_7_0.curHeroId_]

	SetActive(arg_7_0.playBtnGo_, var_7_0 ~= nil and arg_7_0.heroInfo_.unlock == 1)
end

function var_0_0.RefreshChargeType(arg_8_0)
	arg_8_0.chargeType_.text = HeroTools.GetChargeTextByType(arg_8_0.heroCfg_.mechanism_type[1])
end

function var_0_0.OnExit(arg_9_0)
	manager.redPoint:unbindUIandKey(arg_9_0.rewardTrs_, RedPointConst.HERO_RACE_COLLECT_REWARD)
end

return var_0_0
