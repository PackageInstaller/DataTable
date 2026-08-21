local var_0_0 = import("game.views.newHero.HeroLongHead")
local var_0_1 = class("SectionHeroTeamHeadItem", var_0_0)

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	local var_1_0 = arg_1_1

	arg_1_0:InitProxy()

	arg_1_0.gameObject_ = arg_1_0.realGo_
	arg_1_0.transform_ = arg_1_0.realGo_.transform

	arg_1_0:Init()

	arg_1_0.gameObject_ = var_1_0
	arg_1_0.transform_ = var_1_0.transform
end

function var_0_1.InitProxy(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:InitController()
end

function var_0_1.InitController(arg_3_0)
	arg_3_0.sectionLockTypeController_ = arg_3_0.sectionController_:GetController("sectionLockType")
	arg_3_0.sectionTeamMarkBgStyleController_ = arg_3_0.sectionController_:GetController("sectionTeamMarkBgStyle")
	arg_3_0.sectionEnergyController_ = arg_3_0.sectionController_:GetController("sectionEnergy")
	arg_3_0.sectionLockingController_ = arg_3_0.sectionController_:GetController("sectionLocking")
	arg_3_0.sectionHPController_ = arg_3_0.sectionController_:GetController("sectionHP")
	arg_3_0.sectionMultiPosController_ = arg_3_0.sectionController_:GetController("sectionMultiPos")
end

function var_0_1.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_1.SetStageID(arg_5_0, arg_5_1)
	arg_5_0.stageID_ = arg_5_1
end

function var_0_1.SetSectionHeroData(arg_6_0, arg_6_1)
	arg_6_0.sectionHeroData_ = arg_6_1
	arg_6_0.isBattlePanel_ = true

	local var_6_0 = arg_6_0.sectionHeroData_.id
	local var_6_1 = arg_6_0.sectionHeroData_.trialID
	local var_6_2 = arg_6_0.sectionHeroData_.type
	local var_6_3 = arg_6_0.sectionHeroData_.heroViewProxy

	arg_6_0.gameObject_.name = tostring(var_6_0)

	arg_6_0:SetProxy(var_6_3)
	arg_6_0:SetHeroId(var_6_0, var_6_2, var_6_3.tempHeroList)
	arg_6_0:SetRedPointEnable(false)
	arg_6_0:RefreshSectionUI()
end

function var_0_1.RefreshSectionUI(arg_7_0)
	local var_7_0 = arg_7_0.sectionHeroData_.type

	if var_7_0 == HeroConst.HERO_DATA_TYPE.DEFAULT then
		arg_7_0:SetTrial(false)
	elseif var_7_0 == HeroConst.HERO_DATA_TYPE.TRIAL then
		arg_7_0:SetTrial(true)
	elseif var_7_0 == HeroConst.HERO_DATA_TYPE.CUSTOM then
		arg_7_0:SetTrial(true)
	elseif var_7_0 == HeroConst.HERO_DATA_TYPE.ADVANCETEST then
		arg_7_0:SetTrial(false)
	end
end

function var_0_1.SetEnergy(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.sectionEnergyController_:SetSelectedState(arg_8_1 and "on" or "off")

	arg_8_0.sectionEnergyLabel_.text = arg_8_2
end

function var_0_1.SetTeamMarkBg(arg_9_0, arg_9_1)
	arg_9_0.sectionTeamMarkBgStyleController_:SetSelectedState(arg_9_1)
end

function var_0_1.SetTeamMark(arg_10_0, arg_10_1, arg_10_2)
	SetActive(arg_10_0.sectionTeamMarkGo_, arg_10_1)

	if arg_10_1 then
		arg_10_0.sectionTeamMarkText_.text = GetI18NText(arg_10_2)

		LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.sectionTeamMarkTransform_)
	end
end

function var_0_1.SetInTeamFlag(arg_11_0, arg_11_1, arg_11_2)
	SetActive(arg_11_0.sectionTeamMarkGo_, arg_11_1)

	if arg_11_1 then
		if arg_11_2 then
			arg_11_0.sectionTeamMarkText_.text = GetTips("IS_CAPTAIN")
		else
			arg_11_0.sectionTeamMarkText_.text = GetTips("IN_TEAM")
		end
	end
end

function var_0_1.SetInShowFlag(arg_12_0, arg_12_1)
	SetActive(arg_12_0.sectionTeamMarkGo_, arg_12_1)

	arg_12_0.sectionTeamMarkText_.text = GetTips("DISPLAY")
end

function var_0_1.SetHeroLock(arg_13_0, arg_13_1)
	arg_13_0:SetLocking(arg_13_1)
end

function var_0_1.SetHeroLockType(arg_14_0, arg_14_1)
	arg_14_0.sectionLockTypeController_:SetSelectedState(arg_14_1)
end

function var_0_1.SetHeroLockText(arg_15_0, arg_15_1)
	arg_15_0.sectionLockLabelText_.text = GetI18NText(arg_15_1)
end

function var_0_1.SetChallengeFlag(arg_16_0, arg_16_1)
	SetActive(arg_16_0.sectionBossChallengeGo_, arg_16_1)
end

function var_0_1.SetHp(arg_17_0, arg_17_1)
	arg_17_0.sectionHPController_:SetSelectedState(arg_17_1 and "on" or "off")
end

function var_0_1.RefreshHpValue(arg_18_0, arg_18_1)
	arg_18_0.sectionHPImg_.fillAmount = arg_18_1 / 100
	arg_18_0.sectionHPText_.text = arg_18_1 .. "%"
end

function var_0_1.SetLocking(arg_19_0, arg_19_1)
	arg_19_0.sectionLockingController_:SetSelectedState(arg_19_1 and "on" or "off")
end

function var_0_1.SetTrial(arg_20_0, arg_20_1)
	arg_20_0.trialController_:SetSelectedState(tostring(arg_20_1))
end

function var_0_1.SetSoloChallengeIndex(arg_21_0, arg_21_1)
	if arg_21_1 ~= -1 then
		SetActive(arg_21_0.sectionTeamMarkGo_, false)
		SetActive(arg_21_0.sectionTeamOrderGo_, true)

		arg_21_0.sectionTeamOrderText_.text = GetTips(string.format("TEAM_%d", arg_21_1))
	else
		SetActive(arg_21_0.teamOrder_, false)
	end
end

function var_0_1.SetChallengeRogueTeamModify(arg_22_0)
	if arg_22_0.heroInfo_.modifyLevel or arg_22_0.heroInfo_.tempID then
		arg_22_0.levelText_.text = "<color=#3596ED>" .. arg_22_0.heroInfo_.level .. "</color>"
	else
		arg_22_0.levelText_.text = arg_22_0.heroInfo_.level
	end

	if arg_22_0.heroInfo_.modifyStar or arg_22_0.heroInfo_.tempID then
		SetActive(arg_22_0.starBgGo_, true)
	else
		SetActive(arg_22_0.starBgGo_, false)
	end
end

function var_0_1.SetMultiPos(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	arg_23_0.sectionMultiPosController_:SetSelectedState(arg_23_1 and "on" or "off")

	if arg_23_1 then
		arg_23_0.sectionMultiPosText_.text = arg_23_3
	end
end

return var_0_1
