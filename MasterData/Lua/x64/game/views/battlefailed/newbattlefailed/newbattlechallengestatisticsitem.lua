local NewBattleChallengeStatisticsItem = class("NewBattleChallengeStatisticsItem", ReduxView)

function NewBattleChallengeStatisticsItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function NewBattleChallengeStatisticsItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewBattleChallengeStatisticsItem:InitUI()
	self:BindCfgUI()

	self.haveController_ = ControllerUtil.GetController(self.trs_, "haveHero")

	self.haveController_:SetSelectedState("true")
end

function NewBattleChallengeStatisticsItem:AddUIListener()
	return
end

function NewBattleChallengeStatisticsItem:SetData(arg_5_1, arg_5_2)
	self.userData = PlayerData:GetPlayerInfo()
	self.toolsCfg = RecommendTools.GetHeroLvCfg(self.userData.userLevel)

	SetActive(self.tips2, true)
	SetActive(self.tips3, true)

	if arg_5_2 > 0 then
		local var_5_0 = HeroData:GetHeroData(arg_5_2)

		self.battleCountIcon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroIcon.path .. ((var_5_0.using_skin > 0 or nil) and (var_5_0.using_skin or arg_5_2)))

		if arg_5_1 == 1 then
			self:RefreshLv(arg_5_2)
		elseif arg_5_1 == 2 then
			self:RefreshEquip(arg_5_2)
		elseif arg_5_1 == 3 then
			SetActive(self.tips2, false)
			SetActive(self.tips3, false)
			self:RefreshTransition(arg_5_2)
		end
	else
		self.haveController_:SetSelectedState("false")
	end
end

function NewBattleChallengeStatisticsItem:RefreshLv(arg_6_1)
	local var_6_0 = RecommendTools.GetHeroLv(arg_6_1) / self.toolsCfg.lv

	self.num1.text = string.format("%.1f%%", math.min(var_6_0 * 100, 100))
	self.name1.text = GetTips("ERROR_HERO_NOT_LEVEL")
	self.slider1.value = var_6_0

	local var_6_1 = RecommendTools.GetSkillLv(arg_6_1) / (self.toolsCfg.skill * 5)

	self.num2.text = string.format("%.1f%%", math.min(var_6_1 * 100, 100))
	self.name2.text = GetTips("ERROR_HERO_NOT_SKILL")
	self.slider2.value = var_6_1

	local var_6_2 = RecommendTools.GetWeaponServantLv(arg_6_1) / self.toolsCfg.weaponservant

	self.num3.text = string.format("%.1f%%", math.min(var_6_2 * 100, 100))
	self.name3.text = GetTips("ERROR_HERO_NOT_WEAPON")
	self.slider3.value = var_6_2
end

function NewBattleChallengeStatisticsItem:RefreshEquip(arg_7_1)
	local var_7_0 = RecommendTools.GetEquipLv(arg_7_1) / (self.toolsCfg.equip * 6)

	self.num1.text = string.format("%.1f%%", math.min(var_7_0 * 100, 100))
	self.name1.text = GetTips("ERROR_HERO_NOT_EQUIP")
	self.slider1.value = var_7_0

	local var_7_1 = RecommendTools.GetEquipEnchant(arg_7_1) / RecommendTools.GetEquipEnchantMaxByHeroStar(arg_7_1)

	self.num2.text = string.format("%.1f%%", math.min(var_7_1 * 100, 100))
	self.name2.text = GetTips("ERROR_HERO_NOT_ENCHANT")
	self.slider2.value = var_7_1

	local var_7_2 = RecommendTools.GetEquipRebuild(arg_7_1) / 30

	self.num3.text = string.format("%.1f%%", math.min(var_7_2 * 100, 100))
	self.name3.text = GetTips("ERROR_HERO_NOT_RECONFIG")
	self.slider3.value = var_7_2
end

function NewBattleChallengeStatisticsItem:RefreshTransition(arg_8_1)
	local var_8_0 = RecommendTools.GetTransitionLv(arg_8_1) / 36

	self.num3.text = string.format("%.1f%%", math.min(var_8_0 * 100, 100))
	self.name3.text = GetTips("ERROR_HERO_NOT_TRANSITION")
	self.slider3.value = var_8_0
end

function NewBattleChallengeStatisticsItem:Dispose()
	NewBattleChallengeStatisticsItem.super.Dispose(self)
end

return NewBattleChallengeStatisticsItem
