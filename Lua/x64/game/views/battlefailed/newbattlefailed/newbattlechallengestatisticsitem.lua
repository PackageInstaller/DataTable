local var_0_0 = class("NewBattleChallengeStatisticsItem", ReduxView)

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

	arg_3_0.haveController_ = ControllerUtil.GetController(arg_3_0.trs_, "haveHero")

	arg_3_0.haveController_:SetSelectedState("true")
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.userData = PlayerData:GetPlayerInfo()
	arg_5_0.toolsCfg = RecommendTools.GetHeroLvCfg(arg_5_0.userData.userLevel)

	SetActive(arg_5_0.tips2, true)
	SetActive(arg_5_0.tips3, true)

	if arg_5_2 > 0 then
		local var_5_0 = HeroData:GetHeroData(arg_5_2)
		local var_5_1 = var_5_0.using_skin > 0 and var_5_0.using_skin or arg_5_2

		arg_5_0.battleCountIcon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroIcon.path .. var_5_1)

		if arg_5_1 == 1 then
			arg_5_0:RefreshLv(arg_5_2)
		elseif arg_5_1 == 2 then
			arg_5_0:RefreshEquip(arg_5_2)
		elseif arg_5_1 == 3 then
			SetActive(arg_5_0.tips2, false)
			SetActive(arg_5_0.tips3, false)
			arg_5_0:RefreshTransition(arg_5_2)
		end
	else
		arg_5_0.haveController_:SetSelectedState("false")
	end
end

function var_0_0.RefreshLv(arg_6_0, arg_6_1)
	local var_6_0 = RecommendTools.GetHeroLv(arg_6_1) / arg_6_0.toolsCfg.lv

	arg_6_0.num1.text = string.format("%.1f%%", math.min(var_6_0 * 100, 100))
	arg_6_0.name1.text = GetTips("ERROR_HERO_NOT_LEVEL")
	arg_6_0.slider1.value = var_6_0

	local var_6_1 = RecommendTools.GetSkillLv(arg_6_1) / (arg_6_0.toolsCfg.skill * 5)

	arg_6_0.num2.text = string.format("%.1f%%", math.min(var_6_1 * 100, 100))
	arg_6_0.name2.text = GetTips("ERROR_HERO_NOT_SKILL")
	arg_6_0.slider2.value = var_6_1

	local var_6_2 = RecommendTools.GetWeaponServantLv(arg_6_1) / arg_6_0.toolsCfg.weaponservant

	arg_6_0.num3.text = string.format("%.1f%%", math.min(var_6_2 * 100, 100))
	arg_6_0.name3.text = GetTips("ERROR_HERO_NOT_WEAPON")
	arg_6_0.slider3.value = var_6_2
end

function var_0_0.RefreshEquip(arg_7_0, arg_7_1)
	local var_7_0 = RecommendTools.GetEquipLv(arg_7_1) / (arg_7_0.toolsCfg.equip * 6)

	arg_7_0.num1.text = string.format("%.1f%%", math.min(var_7_0 * 100, 100))
	arg_7_0.name1.text = GetTips("ERROR_HERO_NOT_EQUIP")
	arg_7_0.slider1.value = var_7_0

	local var_7_1 = RecommendTools.GetEquipEnchant(arg_7_1) / RecommendTools.GetEquipEnchantMaxByHeroStar(arg_7_1)

	arg_7_0.num2.text = string.format("%.1f%%", math.min(var_7_1 * 100, 100))
	arg_7_0.name2.text = GetTips("ERROR_HERO_NOT_ENCHANT")
	arg_7_0.slider2.value = var_7_1

	local var_7_2 = RecommendTools.GetEquipRebuild(arg_7_1) / 30

	arg_7_0.num3.text = string.format("%.1f%%", math.min(var_7_2 * 100, 100))
	arg_7_0.name3.text = GetTips("ERROR_HERO_NOT_RECONFIG")
	arg_7_0.slider3.value = var_7_2
end

function var_0_0.RefreshTransition(arg_8_0, arg_8_1)
	local var_8_0 = RecommendTools.GetTransitionLv(arg_8_1) / 36

	arg_8_0.num3.text = string.format("%.1f%%", math.min(var_8_0 * 100, 100))
	arg_8_0.name3.text = GetTips("ERROR_HERO_NOT_TRANSITION")
	arg_8_0.slider3.value = var_8_0
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
