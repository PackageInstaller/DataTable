local var_0_0 = import("game.views.newHero.NewHeroHead")
local var_0_1 = class("HeroTeamHeadItem", var_0_0)

function var_0_1.InitUI(arg_1_0)
	var_0_1.super.InitUI(arg_1_0)

	if arg_1_0.heroLock1_ then
		arg_1_0.lockTypeController_ = ControllerUtil.GetController(arg_1_0.heroLock1_.transform, "lockType")
	end

	arg_1_0.trialController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "trial")
	arg_1_0.bgStyleController_ = ControllerUtil.GetController(arg_1_0.teamMark_.transform, "bgStyle")
	arg_1_0.energyController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "energy")
	arg_1_0.lockingController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "locking")
	arg_1_0.showAttackTypeController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "showAttackType")
end

function var_0_1.SetEnergy(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.energyController_:SetSelectedState(arg_2_1 and "on" or "off")

	arg_2_0.energyLabel_.text = arg_2_2
end

function var_0_1.SetTeamMarkBg(arg_3_0, arg_3_1)
	arg_3_0.bgStyleController_:SetSelectedState(arg_3_1)
end

function var_0_1.SetTeamMark(arg_4_0, arg_4_1, arg_4_2)
	SetActive(arg_4_0.teamMark_, arg_4_1)

	if arg_4_1 then
		arg_4_0.teamMarkText_.text = GetI18NText(arg_4_2)
	end
end

function var_0_1.SetInTeamFlag(arg_5_0, arg_5_1, arg_5_2)
	SetActive(arg_5_0.teamMark_, arg_5_1)

	if arg_5_1 then
		if arg_5_2 then
			arg_5_0.teamMarkText_.text = GetTips("IS_CAPTAIN")
		else
			arg_5_0.teamMarkText_.text = GetTips("IN_TEAM")
		end
	end
end

function var_0_1.SetInShowFlag(arg_6_0, arg_6_1)
	SetActive(arg_6_0.teamMark_, arg_6_1)

	arg_6_0.teamMarkText_.text = GetTips("DISPLAY")
end

function var_0_1.SetHeroLock(arg_7_0, arg_7_1)
	SetActive(arg_7_0.heroLock_, arg_7_1)
	SetActive(arg_7_0.heroLock1_, arg_7_1)
end

function var_0_1.SetHeroLockType(arg_8_0, arg_8_1)
	arg_8_0.lockTypeController_:SetSelectedState(arg_8_1)
end

function var_0_1.SetHeroLockText(arg_9_0, arg_9_1)
	arg_9_0.heroLockLabel_.text = GetI18NText(arg_9_1)
end

function var_0_1.SetChallengeFlag(arg_10_0, arg_10_1)
	SetActive(arg_10_0.challenge_, arg_10_1)
end

function var_0_1.SetHp(arg_11_0, arg_11_1)
	arg_11_0.hpController_:SetSelectedState(arg_11_1 and "show" or "no")
end

function var_0_1.RefreshHpValue(arg_12_0, arg_12_1)
	arg_12_0.bloodImg_.fillAmount = arg_12_1 / 100
	arg_12_0.hptextText_.text = arg_12_1 .. "%"
end

function var_0_1.SetLocking(arg_13_0, arg_13_1)
	arg_13_0.lockingController_:SetSelectedState(arg_13_1 and "on" or "off")
end

function var_0_1.SetTrial(arg_14_0, arg_14_1)
	arg_14_0.trialController_:SetSelectedState(tostring(arg_14_1))
end

function var_0_1.Dispose(arg_15_0)
	arg_15_0.teamMark_ = nil
	arg_15_0.teamMarkText_ = nil
	arg_15_0.heroLock_ = nil
	arg_15_0.challenge_ = nil

	var_0_1.super.Dispose(arg_15_0)
end

function var_0_1.SetSoloChallengeIndex(arg_16_0, arg_16_1)
	if arg_16_1 ~= -1 then
		SetActive(arg_16_0.teamMark_, false)
		SetActive(arg_16_0.teamOrder_, true)

		arg_16_0.teamOrderText_.text = GetTips(string.format("TEAM_%d", arg_16_1))
	else
		SetActive(arg_16_0.teamOrder_, false)
	end
end

function var_0_1.SetLove(arg_17_0, arg_17_1)
	arg_17_0.loveCon_:SetSelectedState(arg_17_1 and "off" or "on")
end

function var_0_1.SetShowAttackType(arg_18_0, arg_18_1)
	if not arg_18_0.showAttackTypeController_ then
		return
	end

	local var_18_0 = HeroCfg[arg_18_0.heroId_]

	if arg_18_1 and var_18_0 then
		for iter_18_0, iter_18_1 in ipairs(GameDisplayCfg.hero_atack_type_tag.value) do
			if iter_18_1[1] == var_18_0.ATK_attribute[1] then
				local var_18_1 = iter_18_1[2]

				arg_18_0.m_attributeIcon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/HeroIconUI/AttributeIcon/" .. var_18_1)

				break
			end
		end

		arg_18_0.showAttackTypeController_:SetSelectedIndex(1)
	else
		arg_18_0.showAttackTypeController_:SetSelectedIndex(0)
	end
end

return var_0_1
