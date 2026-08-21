local var_0_0 = class("EquipRaceConfirmView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_equip/Develop/HeroEquipGroupReset"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.leftController_ = arg_3_0.leftCon_:GetController("state")
	arg_3_0.leftHeroController_ = arg_3_0.leftCon_:GetController("equippedHero")
	arg_3_0.rightController_ = arg_3_0.rightCon_:GetController("state")
	arg_3_0.rightHeroController_ = arg_3_0.rightCon_:GetController("equippedHero")
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnLeftChoose_, nil, function()
		arg_5_0:OnRaceConfirmClick(false)
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnRightChoose_, nil, function()
		arg_5_0:OnRaceConfirmClick(true)
		ShowTips("EQUIP_RACE_RESET")
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.equipId = arg_8_0.params_.equipId
	arg_8_0.heroId = arg_8_0.params_.heroId

	local var_8_0 = EquipData:GetEquipData(arg_8_0.equipId)
	local var_8_1 = HeroCfg[arg_8_0.heroId]

	if not var_8_0 then
		return
	end

	arg_8_0.equipIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/icon_s/" .. ItemCfg[var_8_0.prefab_id].icon)

	local var_8_2 = var_8_0.race
	local var_8_3 = var_8_2 ~= 0 and RaceEffectCfg[var_8_2]

	if var_8_3 then
		arg_8_0.leftController_:SetSelectedIndex(1)

		arg_8_0.leftGroupText_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(var_8_3.name))
		arg_8_0.leftGroupIcon_.sprite = getSprite("Atlas/SystemGroupAtlas", var_8_3.icon2)
		arg_8_0.leftIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Group_l/" .. var_8_3.icon2)

		local var_8_4 = var_8_1 and var_8_2 == var_8_1.race

		arg_8_0.leftHeroController_:SetSelectedState(var_8_4 and "on" or "off")

		if var_8_4 then
			arg_8_0.leftHeroIcon_.sprite = HeroTools.GetSmallHeadSprite(arg_8_0.heroId)
		end
	else
		arg_8_0.leftController_:SetSelectedIndex(0)
		arg_8_0.leftHeroController_:SetSelectedState("off")
	end

	local var_8_5 = var_8_0.race_preview
	local var_8_6 = var_8_5 ~= 0 and RaceEffectCfg[var_8_5]

	if var_8_6 then
		arg_8_0.rightController_:SetSelectedIndex(1)

		arg_8_0.rightGroupText_.text = string.format(GetTips("EQUIP_RACE_ATTRIBUTE_UP"), GetI18NText(var_8_6.name))
		arg_8_0.rightGroupIcon_.sprite = getSprite("Atlas/SystemGroupAtlas", var_8_6.icon2)
		arg_8_0.rightIcon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Group_l/" .. var_8_6.icon2)

		local var_8_7 = var_8_1 and var_8_5 == var_8_1.race

		arg_8_0.rightHeroController_:SetSelectedState(var_8_7 and "on" or "off")

		if var_8_7 then
			arg_8_0.rightHeroIcon_.sprite = HeroTools.GetSmallHeadSprite(arg_8_0.heroId)
		end
	else
		arg_8_0.rightController_:SetSelectedIndex(0)
		arg_8_0.rightHeroController_:SetSelectedState("off")
	end
end

function var_0_0.OnRaceConfirmClick(arg_9_0, arg_9_1)
	EquipAction.QueryEquipRaceConfirm(arg_9_0.equipId, arg_9_1)
end

function var_0_0.OnEquipRaceConfirm(arg_10_0)
	arg_10_0:Back()
end

return var_0_0
