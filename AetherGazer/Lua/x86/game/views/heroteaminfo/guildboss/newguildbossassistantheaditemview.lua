local var_0_0 = import("game.views.heroTeamInfo.SectionHeroTeamHeadItem")
local var_0_1 = class("NewGuildBossAssistantHeadItemView", var_0_0)

function var_0_1.InitProxy(arg_1_0)
	var_0_1.super.InitProxy(arg_1_0)

	arg_1_0.positionController_ = ControllerUtil.GetController(arg_1_0.transform_, "position")
end

function var_0_1.InitUI(arg_2_0)
	var_0_1.super.InitUI(arg_2_0)

	arg_2_0.headItemIsOathController = arg_2_0.controller_:GetController("isOath")
end

function var_0_1.SetSectionHeroData(arg_3_0, arg_3_1)
	arg_3_0.assistantData_ = arg_3_1

	local var_3_0 = arg_3_0.assistantData_.assist_hero_id

	arg_3_0.gameObject_.name = tostring(var_3_0)

	arg_3_0:SetHeroData(var_3_0)
	arg_3_0:SetRedPointEnable(false)
end

function var_0_1.SetHeroId(arg_4_0, arg_4_1)
	arg_4_0:SetHeroData(arg_4_1)
end

function var_0_1.SetHeroData(arg_5_0, arg_5_1)
	arg_5_0.heroId_ = arg_5_1
	arg_5_0.trialID_ = 0
	arg_5_0.heroCfg_ = HeroCfg[arg_5_1]

	arg_5_0:UpdateView()
end

function var_0_1.UpdateView(arg_6_0)
	local var_6_0 = HeroCfg[arg_6_0.heroId_]
	local var_6_1

	if arg_6_0.assistantData_.assist_hero_skin ~= 0 then
		var_6_1 = arg_6_0.assistantData_.assist_hero_skin
	else
		var_6_1 = arg_6_0.heroId_
	end

	local var_6_2 = nullable(arg_6_0.assistantData_, "hero_oath_display", "oath")

	arg_6_0.headItemIsOathController:SetSelectedState(var_6_2 and "true" or "false")

	arg_6_0.headIcon_.sprite = HeroTools.GetHeadSprite(var_6_1)

	arg_6_0.headIcon_:SetNativeSize()

	arg_6_0.campLogo_.sprite = HeroTools.GetRaceIcon(var_6_0.race)
	arg_6_0.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_6_0.heroId_)
	arg_6_0.rareImg_.sprite = HeroTools.GetRareSprite(math.floor(arg_6_0.assistantData_.hero_rare / 100))

	arg_6_0:SetLevel(arg_6_0.assistantData_.hero_level or 1)

	arg_6_0.nickLabel_.text = GetI18NText(arg_6_0.assistantData_.nick)
	arg_6_0.fightPowerLabel_.text = arg_6_0.assistantData_.fight_capacity

	arg_6_0.positionController_:SetSelectedState(tostring(arg_6_0.assistantData_.member_post))

	if tostring(arg_6_0.assistantData_.member_post) == "1" then
		arg_6_0.clubMemberLabel_.text = GetTips("CLUB_CHAIR_MAN")
	elseif tostring(arg_6_0.assistantData_.member_post) == "2" then
		arg_6_0.clubMemberLabel_.text = GetTips("CLUB_VICE_CHAIR_MAN")
	elseif tostring(arg_6_0.assistantData_.member_post) == "3" then
		arg_6_0.clubMemberLabel_.text = GetTips("CLUB_MEMBER")
	elseif tostring(arg_6_0.assistantData_.member_post) == "4" then
		arg_6_0.clubMemberLabel_.text = GetTips("CLUB_NOVICIATE")
	end
end

function var_0_1.GetHeroId(arg_7_0)
	return arg_7_0.assistantData_.assist_hero_id
end

function var_0_1.GetOwnerId(arg_8_0)
	return arg_8_0.assistantData_.member_id
end

function var_0_1.SetSelected(arg_9_0, arg_9_1)
	SetActive(arg_9_0.sectionSelectGo_, arg_9_1 == true)
end

return var_0_1
