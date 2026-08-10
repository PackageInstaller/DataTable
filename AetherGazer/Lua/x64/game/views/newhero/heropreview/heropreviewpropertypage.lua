local var_0_0 = class("HeroPreviewPropertyPage", HeroPageBase)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.campController_ = ControllerUtil.GetController(arg_3_0.infoViewGo_.transform, "camp")
	arg_3_0.attackTypeController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "attackType")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.campBgBtn_, nil, function()
		JumpTools.OpenPageByJump("sectionSelectRaceDescription")
	end)
end

function var_0_0.SetHeroInfo(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.heroInfo_

	arg_6_0.heroInfo_ = HeroData:GetHeroData(arg_6_1.id)

	arg_6_0:UpdateView()
end

function var_0_0.UpdateView(arg_7_0)
	arg_7_0.heroCfg_ = HeroCfg[arg_7_0.heroInfo_.id]
	arg_7_0.nameText_.text = GetI18NText(arg_7_0.heroCfg_.name)
	arg_7_0.subNameText_.text = GetI18NText(arg_7_0.heroCfg_.suffix)
	arg_7_0.friendlyDescText_.text = GetI18NText(arg_7_0.heroCfg_.hero_desc)

	local var_7_0 = HeroStarCfg[arg_7_0.heroCfg_.unlock_star]

	arg_7_0.starImg_.sprite = getSprite("Atlas/Common", "star_" .. var_7_0.star)
	arg_7_0.rangeTypeText_.text = CharactorParamCfg[arg_7_0.heroInfo_.id].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")

	local var_7_1 = arg_7_0.heroCfg_.mechanism_type[1]

	arg_7_0.compatTypeText_.text = HeroTools.GetChargeTextByType(arg_7_0.heroCfg_.mechanism_type[1])

	if #arg_7_0.heroCfg_.ATK_attribute > 1 then
		arg_7_0.attackTypeController_:SetSelectedState(-1)
	else
		local var_7_2 = arg_7_0.heroCfg_.ATK_attribute[1]

		arg_7_0.attackTypeController_:SetSelectedState(var_7_2)
	end

	arg_7_0.campController_:SetSelectedState(tostring(arg_7_0.heroCfg_.race))
end

function var_0_0.PlayEnterAni(arg_8_0)
	arg_8_0.playableDirector_ = arg_8_0.playableDirector_ or arg_8_0:FindCom(typeof(PlayableDirector), "panel")

	if arg_8_0.playableDirector_ then
		arg_8_0.playableDirector_.time = 0

		arg_8_0.playableDirector_:Play()
	end
end

function var_0_0.OnEnter(arg_9_0)
	return
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.OnHeroModify(arg_11_0, arg_11_1)
	if arg_11_1 == arg_11_0.heroInfo_.id then
		arg_11_0:UpdateView()
	end
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()

	if arg_12_0.heroInfoView_ then
		arg_12_0.heroInfoView_:Dispose()

		arg_12_0.heroInfoView_ = nil
	end

	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
