local var_0_0 = import("game.views.newHero.HeroInfoView")
local var_0_1 = class("ChallengeRogueTeamSectionHeroInfoView", var_0_0)

function var_0_1.Init(arg_1_0)
	arg_1_0:InitUI()
	arg_1_0:AddUIListener()

	arg_1_0.skillItemList_ = {}

	for iter_1_0 = 1, 5 do
		local var_1_0 = arg_1_0["skillItemGo" .. iter_1_0 .. "_"]

		arg_1_0.skillItemList_[iter_1_0] = ChallengeRogueTeamHeroSkillItem.New(arg_1_0, var_1_0)
	end
end

function var_0_1.UpdateUnlockedView(arg_2_0)
	var_0_1.super.UpdateUnlockedView(arg_2_0)

	local var_2_0 = arg_2_0.heroViewProxy_:GetHeroSkillInfo(arg_2_0.heroInfo_.id)

	for iter_2_0 = 1, 5 do
		arg_2_0.skillItemList_[iter_2_0]:RefreshData(arg_2_0, var_2_0[iter_2_0], arg_2_0.heroViewProxy_, iter_2_0)
	end

	arg_2_0.proficiencyText_.text = HeroTools.GetHeroProficiency(arg_2_0.heroInfo_.id) .. "/" .. GameSetting.mastery_level_max.value[1]

	if arg_2_0.heroInfo_.modifyLevel or arg_2_0.heroInfo_.tempID then
		arg_2_0.nowLevelText_.text = "<color=#3596ED>" .. arg_2_0.heroInfo_.level .. "</color>"
	else
		arg_2_0.nowLevelText_.text = arg_2_0.heroInfo_.level
	end

	if arg_2_0.heroInfo_.modifyStar or arg_2_0.heroInfo_.tempID then
		SetActive(arg_2_0.starBgGo_, true)
	else
		SetActive(arg_2_0.starBgGo_, false)
	end

	if arg_2_0.heroInfo_.modifyServant or arg_2_0.heroInfo_.tempID then
		SetActive(arg_2_0.weaponBgGo_, true)
	else
		SetActive(arg_2_0.weaponBgGo_, false)
	end
end

function var_0_1.UpdateModuleView(arg_3_0)
	SetActive(arg_3_0.moduleView_.gameObject, false)

	local var_3_0 = arg_3_0.heroInfo_.servantInfo
	local var_3_1 = arg_3_0.heroInfo_.weapon_info
	local var_3_2 = WeaponServantCfg[var_3_0.id]

	arg_3_0.weaponName_.text = HeroCfg[arg_3_0.heroInfo_.id].weapon_name

	if arg_3_0.heroInfo_.modifyWeapon or arg_3_0.heroInfo_.tempID then
		arg_3_0.weaponLevel_.text = GetTips("LEVEL") .. "<color=#3596ED>" .. var_3_1.level .. "</color>"
	else
		arg_3_0.weaponLevel_.text = GetTips("LEVEL") .. var_3_1.level
	end

	if var_3_0.id == 0 then
		print("不应该出现 钥从ID为0")
	else
		arg_3_0.servantName_.text = ItemTools.getItemName(var_3_0.id)
	end

	arg_3_0.servantStage_.text = string.format(GetTips("ROGUE_TEAM_SERVANT_LEVEL"), var_3_0.stage)
	arg_3_0.servantIcon_.sprite = ItemTools.getItemSprite(var_3_0.id, nil, true)
end

function var_0_1.UpdateView(arg_4_0)
	var_0_1.super.UpdateView(arg_4_0)
	arg_4_0.isSelfController_:SetSelectedState(tostring(arg_4_0.heroInfo_.tempID == nil))
end

function var_0_1.UpdateUnlockBtnState(arg_5_0)
	arg_5_0.levelStateController_:SetSelectedState("maxLevel")
end

function var_0_1.Dispose(arg_6_0)
	var_0_1.super.Dispose(arg_6_0)

	if arg_6_0.skillItemList_ then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0.skillItemList_) do
			iter_6_1:Dispose()
		end

		arg_6_0.skillItemList_ = nil
	end
end

return var_0_1
