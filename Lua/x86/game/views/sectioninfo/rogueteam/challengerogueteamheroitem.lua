local var_0_0 = import("game.views.newHero.HeroLongHead")
local var_0_1 = class("ChallengeRogueTeamHeroItem", ReduxView)

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitProxy()
	arg_1_0:Init()
end

function var_0_1.InitProxy(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_1.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_1.InitUI(arg_4_0)
	arg_4_0.selectedController_ = arg_4_0.controller_:GetController("select")
	arg_4_0.recruitController_ = arg_4_0.controller_:GetController("recruit")
	arg_4_0.trialController_ = arg_4_0.controller_:GetController("trial")
end

function var_0_1.SetSectionHeroData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.index_ = arg_5_1
	arg_5_0.sectionHeroData_ = arg_5_2

	local var_5_0 = arg_5_0.sectionHeroData_.id
	local var_5_1 = arg_5_0.sectionHeroData_.trialID
	local var_5_2 = arg_5_0.sectionHeroData_.type
	local var_5_3 = arg_5_0.sectionHeroData_.heroViewProxy

	arg_5_0.gameObject_.name = tostring(var_5_0)

	arg_5_0:SetProxy(var_5_3)
	arg_5_0:SetHeroId(var_5_0, var_5_2, var_5_3.tempHeroList)
	arg_5_0:RefreshSectionUI()
end

function var_0_1.SetProxy(arg_6_0, arg_6_1)
	arg_6_0.heroViewProxy_ = arg_6_1 or HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.CHALLENGEROUGETEAM)
end

function var_0_1.SetHeroId(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.heroDataType = arg_7_2

	if arg_7_2 == HeroConst.HERO_DATA_TYPE.TRIAL or heroDataType == HeroConst.HERO_DATA_TYPE.CUSTOM then
		arg_7_1 = TempHeroData:GetHeroData(arg_7_1, arg_7_3).tempID
	end

	arg_7_0:SetHeroData(arg_7_1, arg_7_2)
end

function var_0_1.SetHeroData(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2 == HeroConst.HERO_DATA_TYPE.TRIAL or arg_8_2 == HeroConst.HERO_DATA_TYPE.CUSTOM then
		arg_8_0.trialID_ = arg_8_1
		arg_8_0.heroId_ = HeroStandardSystemCfg[arg_8_1].hero_id
		arg_8_1 = arg_8_0.heroId_
	else
		arg_8_0.heroId_ = arg_8_1
		arg_8_0.trialID_ = 0
	end

	arg_8_0.heroDataType_ = arg_8_2
	arg_8_0.heroCfg_ = HeroCfg[arg_8_1]
	arg_8_0.heroInfo_ = arg_8_0.heroViewProxy_:GetHeroData(arg_8_1)

	arg_8_0:UpdateView()
end

function var_0_1.UpdateView(arg_9_0)
	local var_9_0 = HeroCfg[arg_9_0.heroId_]
	local var_9_1 = arg_9_0.heroViewProxy_:GetHeroBattleUsingSkinInfo(arg_9_0.heroId_).id

	arg_9_0.heroImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. var_9_1)

	arg_9_0.heroImg_:SetNativeSize()

	arg_9_0.campLogo_.sprite = HeroTools.GetRaceIcon(var_9_0.race)
	arg_9_0.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_9_0.heroId_)

	if arg_9_0.heroInfo_.modifyLevel or arg_9_0.heroInfo_.tempID then
		arg_9_0.level_.text = "<color=#3596ED>" .. arg_9_0.heroInfo_.level .. "</color>"
	else
		arg_9_0.level_.text = arg_9_0.heroInfo_.level or 1
	end

	if arg_9_0.heroInfo_.modifyStar or arg_9_0.heroInfo_.tempID then
		SetActive(arg_9_0.starBgGo_, true)
	else
		SetActive(arg_9_0.starBgGo_, false)
	end

	arg_9_0:SetRareIcon()
end

function var_0_1.SetRareIcon(arg_10_0, arg_10_1)
	if arg_10_1 then
		arg_10_0.rareImg_.sprite = HeroTools.GetRareSprite(arg_10_1)
	else
		arg_10_0.rareImg_.sprite = HeroTools.GetRareSprite(math.floor(arg_10_0.heroInfo_.star / 100))
	end
end

function var_0_1.RefreshSectionUI(arg_11_0)
	local var_11_0 = arg_11_0.sectionHeroData_.type

	if var_11_0 == HeroConst.HERO_DATA_TYPE.DEFAULT then
		arg_11_0:SetTrial(false)
	elseif var_11_0 == HeroConst.HERO_DATA_TYPE.TRIAL then
		arg_11_0:SetTrial(true)
	elseif var_11_0 == HeroConst.HERO_DATA_TYPE.CUSTOM then
		arg_11_0:SetTrial(true)
	elseif var_11_0 == HeroConst.HERO_DATA_TYPE.ADVANCETEST then
		arg_11_0:SetTrial(false)
	elseif var_11_0 == HeroConst.HERO_DATA_TYPE.CHALLENGEROUGETEAM then
		arg_11_0:SetTrial(false)
	end
end

function var_0_1.SetTrial(arg_12_0, arg_12_1)
	arg_12_0.trialController_:SetSelectedState(tostring(arg_12_1))
end

function var_0_1.SetSelected(arg_13_0, arg_13_1)
	arg_13_0.selectedController_:SetSelectedState(tostring(arg_13_1))
end

function var_0_1.SetRecruited(arg_14_0, arg_14_1)
	arg_14_0.recruitController_:SetSelectedState(tostring(arg_14_1 and true))

	arg_14_0.recruitNum_.text = arg_14_1 or 0
end

function var_0_1.RegisterClickListener(arg_15_0, arg_15_1)
	arg_15_0.clickListener_ = arg_15_1
end

function var_0_1.RegisterLookListener(arg_16_0, arg_16_1)
	arg_16_0.lookListner_ = arg_16_1
end

function var_0_1.AddUIListener(arg_17_0)
	arg_17_0:AddBtnListener(arg_17_0.selfBtn_, nil, function()
		if arg_17_0.clickListener_ ~= nil and arg_17_0.heroCfg_ then
			arg_17_0.clickListener_(arg_17_0.index_)
		end
	end)
	arg_17_0:AddBtnListener(arg_17_0.lookBtn_, nil, function()
		if arg_17_0.lookListner_ ~= nil and arg_17_0.heroCfg_ then
			arg_17_0.lookListner_(arg_17_0.heroInfo_, arg_17_0.heroViewProxy_:GetViewDataType())
		end
	end)
end

return var_0_1
