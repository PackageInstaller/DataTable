local HeroTeamHeadItem = class("HeroTeamHeadItem", (import("game.views.newHero.NewHeroHead")))

function HeroTeamHeadItem:InitUI()
	HeroTeamHeadItem.super.InitUI(self)

	if self.heroLock1_ then
		self.lockTypeController_ = ControllerUtil.GetController(self.heroLock1_.transform, "lockType")
	end

	self.trialController_ = ControllerUtil.GetController(self.gameObject_.transform, "trial")
	self.bgStyleController_ = ControllerUtil.GetController(self.teamMark_.transform, "bgStyle")
	self.energyController_ = ControllerUtil.GetController(self.gameObject_.transform, "energy")
	self.lockingController_ = ControllerUtil.GetController(self.gameObject_.transform, "locking")
	self.showAttackTypeController_ = ControllerUtil.GetController(self.gameObject_.transform, "showAttackType")
end

function HeroTeamHeadItem:SetEnergy(arg_2_1, arg_2_2)
	self.energyController_:SetSelectedState(arg_2_1 and "on" or "off")

	self.energyLabel_.text = arg_2_2
end

function HeroTeamHeadItem:SetTeamMarkBg(arg_3_1)
	self.bgStyleController_:SetSelectedState(arg_3_1)
end

function HeroTeamHeadItem:SetTeamMark(arg_4_1, arg_4_2)
	SetActive(self.teamMark_, arg_4_1)

	if arg_4_1 then
		self.teamMarkText_.text = GetI18NText(arg_4_2)
	end
end

function HeroTeamHeadItem:SetInTeamFlag(arg_5_1, arg_5_2)
	SetActive(self.teamMark_, arg_5_1)

	if arg_5_1 then
		self.teamMarkText_.text = arg_5_2 and GetTips("IS_CAPTAIN") or GetTips("IN_TEAM")
	end
end

function HeroTeamHeadItem:SetInShowFlag(arg_6_1)
	SetActive(self.teamMark_, arg_6_1)

	self.teamMarkText_.text = GetTips("DISPLAY")
end

function HeroTeamHeadItem:SetHeroLock(arg_7_1)
	SetActive(self.heroLock_, arg_7_1)
	SetActive(self.heroLock1_, arg_7_1)
end

function HeroTeamHeadItem:SetHeroLockType(arg_8_1)
	self.lockTypeController_:SetSelectedState(arg_8_1)
end

function HeroTeamHeadItem:SetHeroLockText(arg_9_1)
	self.heroLockLabel_.text = GetI18NText(arg_9_1)
end

function HeroTeamHeadItem:SetChallengeFlag(arg_10_1)
	SetActive(self.challenge_, arg_10_1)
end

function HeroTeamHeadItem:SetHp(arg_11_1)
	self.hpController_:SetSelectedState(arg_11_1 and "show" or "no")
end

function HeroTeamHeadItem:RefreshHpValue(arg_12_1)
	self.bloodImg_.fillAmount = arg_12_1 / 100
	self.hptextText_.text = arg_12_1 .. "%"
end

function HeroTeamHeadItem:SetLocking(arg_13_1)
	self.lockingController_:SetSelectedState(arg_13_1 and "on" or "off")
end

function HeroTeamHeadItem:SetTrial(arg_14_1)
	self.trialController_:SetSelectedState(tostring(arg_14_1))
end

function HeroTeamHeadItem:Dispose()
	self.teamMark_ = nil
	self.teamMarkText_ = nil
	self.heroLock_ = nil
	self.challenge_ = nil

	HeroTeamHeadItem.super.Dispose(self)
end

function HeroTeamHeadItem:SetSoloChallengeIndex(arg_16_1)
	if arg_16_1 ~= -1 then
		SetActive(self.teamMark_, false)
		SetActive(self.teamOrder_, true)

		self.teamOrderText_.text = GetTips(string.format("TEAM_%d", arg_16_1))
	else
		SetActive(self.teamOrder_, false)
	end
end

function HeroTeamHeadItem:SetLove(arg_17_1)
	self.loveCon_:SetSelectedState(arg_17_1 and "off" or "on")
end

function HeroTeamHeadItem:SetShowAttackType(arg_18_1)
	if not self.showAttackTypeController_ then
		return
	end

	local var_18_0 = HeroCfg[self.heroId_]

	if arg_18_1 and var_18_0 then
		for iter_18_0, iter_18_1 in ipairs(GameDisplayCfg.hero_atack_type_tag.value) do
			if iter_18_1[1] == var_18_0.ATK_attribute[1] then
				self.m_attributeIcon.sprite = pureGetSpriteWithoutAtlas("TextureConfig/HeroIconUI/AttributeIcon/" .. iter_18_1[2])

				break
			end
		end

		self.showAttackTypeController_:SetSelectedIndex(1)
	else
		self.showAttackTypeController_:SetSelectedIndex(0)
	end
end

return HeroTeamHeadItem
