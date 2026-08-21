local var_0_0 = class("IslandShipInfoPage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandShipInfoUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.energyTipTr = arg_2_0._tf:Find("adapt/name_panel/tip")
	arg_2_0.energyTipTxt = arg_2_0._tf:Find("adapt/name_panel/tip/Text"):GetComponent(typeof(Text))
	arg_2_0.energyTr = arg_2_0._tf:Find("adapt/name_panel/energy")
	arg_2_0.energyTxt = arg_2_0._tf:Find("adapt/name_panel/energy"):GetComponent(typeof(Text))
	arg_2_0.energyLabel = arg_2_0._tf:Find("adapt/name_panel/energy/label")
	arg_2_0.nameTxt = arg_2_0._tf:Find("adapt/name_panel/name"):GetComponent(typeof(Text))
	arg_2_0.nameEnTxt = arg_2_0._tf:Find("adapt/name_panel/en"):GetComponent(typeof(Text))
	arg_2_0.levelTxt = arg_2_0._tf:Find("adapt/main_panel/level/level"):GetComponent(typeof(Text))
	arg_2_0.expTxt = arg_2_0._tf:Find("adapt/main_panel/level/exp"):GetComponent(typeof(Text))
	arg_2_0.expProgress = arg_2_0._tf:Find("adapt/main_panel/level/progress")
	arg_2_0.upgradeBtn = arg_2_0._tf:Find("adapt/main_panel/level/add")
	arg_2_0.breakoutBtn = arg_2_0._tf:Find("adapt/main_panel/level/breakout")
	arg_2_0.uiAttrList = UIItemList.New(arg_2_0._tf:Find("adapt/main_panel/attr/list"), arg_2_0._tf:Find("adapt/main_panel/attr/list/tpl"))
	arg_2_0.attrUpgradeBtn = arg_2_0._tf:Find("adapt/main_panel/attr/upgrade")
	arg_2_0.skillTr = arg_2_0._tf:Find("adapt/main_panel/skill")
	arg_2_0.skillIconImg = arg_2_0._tf:Find("adapt/main_panel/skill/icon")
	arg_2_0.skillName = arg_2_0._tf:Find("adapt/main_panel/skill/info/name"):GetComponent(typeof(Text))
	arg_2_0.skillLevel = arg_2_0._tf:Find("adapt/main_panel/skill/info/level"):GetComponent(typeof(Text))
	arg_2_0.skillDesc = arg_2_0._tf:Find("adapt/main_panel/skill/info/desc/Text"):GetComponent(typeof(Text))
	arg_2_0.skillMask = arg_2_0._tf:Find("adapt/main_panel/skill_mask")
	arg_2_0.skillMaskLabel = arg_2_0._tf:Find("adapt/main_panel/skill_mask/content/Text")
	arg_2_0.skillUpgradeBtn = arg_2_0._tf:Find("adapt/main_panel/skill/upgrade")
	arg_2_0.skillInfoBtn = arg_2_0._tf:Find("adapt/main_panel/skill/click")
	arg_2_0.breakOutList = UIItemList.New(arg_2_0._tf:Find("adapt/main_panel/level/starts"), arg_2_0._tf:Find("adapt/main_panel/level/starts/tpl"))
	arg_2_0.statusPanel = IslandShipStatusPanel.New(arg_2_0._tf:Find("adapt/main_panel/status"), arg_2_0._tf:Find("adapt/main_panel/status_empty"))
	arg_2_0.followerBtn = arg_2_0._tf:Find("adapt/follower")
	arg_2_0.followerBtnInvite = arg_2_0._tf:Find("adapt/follower/1")
	arg_2_0.followerBtnCancel = arg_2_0._tf:Find("adapt/follower/2")
	arg_2_0.followerBtnDisable = arg_2_0._tf:Find("adapt/follower/3")

	setText(arg_2_0.energyLabel, i18n("island_ship_energy"))
	setText(arg_2_0.followerBtnInvite:Find("Text"), i18n("island_follow_btn_State_usable"))
	setText(arg_2_0.followerBtnCancel:Find("Text"), i18n("island_follow_btn_State_cancel"))
	setText(arg_2_0.followerBtnDisable:Find("Text"), i18n("island_follow_btn_State_disable"))
	setActive(arg_2_0.followerBtnInvite:Find("Text"), false)
	setActive(arg_2_0.followerBtnInvite:Find("Text"), true)

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.energyTr, function()
		arg_3_0:DisplayEnergyTip()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.skillUpgradeBtn, function()
		if arg_3_0.ship:GetSkill():IsMaxLevel() then
			return
		end

		arg_3_0:OpenPage(IslandShipSkillUpgradePage, arg_3_0.ship)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.upgradeBtn, function()
		if arg_3_0.ship:IsMaxLevel() then
			if arg_3_0.ship:IsMaxBreakLevel() then
				return
			end

			arg_3_0:OpenPage(IslandShipBreakoutPage, arg_3_0.ship)
		else
			arg_3_0:OpenPage(IslandShipUpgradePage, arg_3_0.ship)
		end

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.breakoutBtn, function()
		triggerButton(arg_3_0.upgradeBtn)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.attrUpgradeBtn, function()
		arg_3_0:OpenPage(IslandShipAttrUpgradePage, arg_3_0.ship)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.followerBtn, function()
		if getProxy(IslandProxy):GetIsland():GetFollowerAgency():Following(arg_3_0.ship.id) then
			arg_3_0:ShowMsgBox({
				content = i18n("island_cancel_follow_tip"),
				onYes = function()
					arg_3_0:emitCore(ISLAND_EVT.WILL_DEL_FOLLOWER, arg_3_0.ship.id)

					return
				end
			})
		else
			arg_3_0:emit(IslandMediator.ADD_FOLLOWER, arg_3_0.ship.id)
		end

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.skillInfoBtn, function()
		arg_3_0:ShowMsgBox({
			type = IslandMsgBox.TYPE_SHIP_SKILL,
			skill = arg_3_0.ship:GetSkill()
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnShow(arg_12_0, arg_12_1)
	local var_12_0 = getProxy(IslandProxy):GetIsland():GetCharacterAgency():GetShipById(arg_12_1)

	if var_12_0 == nil then
		return
	end

	arg_12_0:UpdateMainView(var_12_0)
	arg_12_0:UpdateFollowBtn(var_12_0)

	arg_12_0.ship = var_12_0

	return
end

function var_0_0.UpdateFollowBtn(arg_13_0, arg_13_1)
	local var_13_9000
	local var_13_0 = getProxy(IslandProxy).GetIsland(var_13_9000):GetFollowerAgency():Following(arg_13_1.id)
	local var_13_1 = getProxy(IslandProxy):GetIsland():GetCharacterAgency():CanFollowPlayer(arg_13_1.id)

	setActive(arg_13_0.followerBtnInvite, not var_13_0 and var_13_1)
	setActive(arg_13_0.followerBtnCancel, var_13_0)

	local var_13_2 = not var_13_1 and not var_13_0

	setActive(arg_13_0.followerBtnDisable, not var_13_1 and not var_13_0)
	setButtonEnabled(arg_13_0.followerBtn, not var_13_2)

	return
end

function var_0_0.AddListeners(arg_14_0)
	arg_14_0:AddListener(GAME.ISLAND_USE_SHIP_EXP_BOOK_DONE, arg_14_0.OnUseExpBook)
	arg_14_0:AddListener(GAME.ISLAND_SHIP_BREAKOUT_DONE, arg_14_0.OnBreakOut)
	arg_14_0:AddListener(GAME.ISLNAD_SHIP_ATTR_UPGRADE_DONE, arg_14_0.OnAttrUpgrade)
	arg_14_0:AddListener(GAME.ISLAND_SHIP_SKILL_UPGRADE_DONE, arg_14_0.OnSkillUpgrade)
	arg_14_0:AddListener(GAME.ISLAND_FOLLOWER_OP_DONE, arg_14_0.OnFollowOpDone)

	return
end

function var_0_0.RemoveListeners(arg_15_0)
	arg_15_0:RemoveListener(GAME.ISLAND_USE_SHIP_EXP_BOOK_DONE, arg_15_0.OnUseExpBook)
	arg_15_0:RemoveListener(GAME.ISLAND_SHIP_BREAKOUT_DONE, arg_15_0.OnBreakOut)
	arg_15_0:RemoveListener(GAME.ISLNAD_SHIP_ATTR_UPGRADE_DONE, arg_15_0.OnAttrUpgrade)
	arg_15_0:RemoveListener(GAME.ISLAND_SHIP_SKILL_UPGRADE_DONE, arg_15_0.OnSkillUpgrade)
	arg_15_0:RemoveListener(GAME.ISLAND_FOLLOWER_OP_DONE, arg_15_0.OnFollowOpDone)

	return
end

function var_0_0.OnFollowOpDone(arg_16_0)
	arg_16_0:UpdateFollowBtn(arg_16_0.ship)

	return
end

function var_0_0.OnAttrUpgrade(arg_17_0)
	arg_17_0:UpdateAttrs(arg_17_0.ship)

	return
end

function var_0_0.OnUseExpBook(arg_18_0)
	arg_18_0:UpdateLevelAndExp(arg_18_0.ship)
	arg_18_0:UpdateAttrs(arg_18_0.ship)

	return
end

function var_0_0.OnBreakOut(arg_19_0)
	arg_19_0:UpdateEnergy(arg_19_0.ship)
	arg_19_0:UpdateLevelAndExp(arg_19_0.ship)
	arg_19_0:UpdateAttrs(arg_19_0.ship)
	arg_19_0:UpdateSkill(arg_19_0.ship)
	arg_19_0:UpdateBreakOutLevel(arg_19_0.ship)

	return
end

function var_0_0.OnSkillUpgrade(arg_20_0)
	arg_20_0:UpdateSkill(arg_20_0.ship)

	return
end

function var_0_0.UpdateMainView(arg_21_0, arg_21_1)
	arg_21_0:UpdateEnergy(arg_21_1)
	arg_21_0:UpdateLevelAndExp(arg_21_1)
	arg_21_0:UpdateAttrs(arg_21_1)
	arg_21_0:UpdateSkill(arg_21_1)
	arg_21_0:UpdateBreakOutLevel(arg_21_1)
	arg_21_0:UpdateStatus(arg_21_1)

	arg_21_0.ship = arg_21_1

	return
end

function var_0_0.DisplayEnergyTip(arg_22_0)
	arg_22_0:RemoveCloseEnergyTipTimer()
	setActive(arg_22_0.energyTipTr, true)

	arg_22_0.energyTipTxt.text = i18n("island_ship_energy_full")

	arg_22_0:AddCloseEnergyTipTimer()

	return
end

function var_0_0.AddCloseEnergyTipTimer(arg_23_0)
	arg_23_0.timer = Timer.New(function()
		arg_23_0:RemoveCloseEnergyTipTimer()

		return
	end, 3)

	arg_23_0.timer:Start()

	return
end

function var_0_0.RemoveCloseEnergyTipTimer(arg_25_0)
	setActive(arg_25_0.energyTipTr, false)

	if arg_25_0.timer then
		arg_25_0.timer:Stop()

		arg_25_0.timer = nil
	end

	return
end

function var_0_0.UpdateBreakOutLevel(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1:GetBreakLevel()

	arg_26_0.breakOutList:make(function(arg_27_0, arg_27_1, arg_27_2)
		if arg_27_0 == UIItemList.EventUpdate then
			setActive(arg_27_2:Find("Image"), arg_27_1 + 1 <= var_26_0)
		end

		return
	end)
	arg_26_0.breakOutList:align(arg_26_1:GetBreakMaxLevel())

	return
end

function var_0_0.UpdateEnergy(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1:GetCurrentEnergy()
	local var_28_1 = arg_28_1:GetMaxEnergy()

	if var_28_0 <= 20 then
		local var_28_2 = "<color=#ab4734>" .. var_28_0 .. "</color>" or var_28_0

		arg_28_0.energyTxt.text = "[" .. var_28_2 .. "/" .. var_28_1 .. "]"

		return
	end
end

function var_0_0.UpdateLevelAndExp(arg_29_0, arg_29_1)
	arg_29_0.nameTxt.text = arg_29_1:GetName()
	arg_29_0.nameEnTxt.text = arg_29_1:GetEnName()
	arg_29_0.levelTxt.text = "Level:" .. arg_29_1:GetLevel()

	if not arg_29_1:IsMaxLevel() then
		local var_29_0 = arg_29_1:GetExp()
		local var_29_1 = arg_29_1:GetTargetExp()

		arg_29_0.expTxt.text = var_29_0 .. "/" .. var_29_1

		setSlider(arg_29_0.expProgress, 0, 1, var_29_0 / var_29_1)
	else
		arg_29_0.expTxt.text = "[MAX]"

		setSlider(arg_29_0.expProgress, 0, 1, 1)
	end

	setActive(arg_29_0.upgradeBtn, not arg_29_1:IsMaxLevel())

	local var_29_2 = arg_29_1:IsMaxLevel() and not arg_29_1:IsMaxBreakLevel()

	setActive(arg_29_0.breakoutBtn, var_29_2)

	return
end

function var_0_0.RemoveAttrTimer(arg_30_0)
	if arg_30_0.attrTimer then
		arg_30_0.attrTimer:Stop()

		arg_30_0.attrTimer = nil
	end

	return
end

function var_0_0.UpdateAttrs(arg_31_0, arg_31_1)
	local var_31_0 = IslandShipAttr.ATTRS

	arg_31_0.uiAttrList:make(function(arg_32_0, arg_32_1, arg_32_2)
		if arg_32_0 == UIItemList.EventUpdate then
			arg_31_0:UpdateAttr(arg_32_2, var_31_0, arg_32_1 + 1, arg_31_1)
		end

		return
	end)
	arg_31_0.uiAttrList:align(#IslandShipAttr.ATTRS)

	return
end

function var_0_0.UpdateAttr(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	local var_33_0 = arg_33_4:GetAttr(arg_33_2[arg_33_3])

	setText(arg_33_1:Find("name"), IslandShipAttr.ToChinese(arg_33_2[arg_33_3]))

	local var_33_1 = IslandProductTimeHelper.GetAttributeAddPercentByAttribute(arg_33_4.id, arg_33_3)

	setTextColor(arg_33_1:Find("value"), Color.NewHex(var_33_1 > 0 and "#00B91E" or var_33_1 < 0 and "#FF6767" or "#393A3C"))

	local var_33_3 = var_33_1 ~= 0 and math.floor(var_33_0 * (1 + 0.01 * var_33_1)) or var_33_0

	setText(arg_33_1:Find("value"), var_33_3)

	if var_33_1 ~= 0 then
		local var_33_4 = _.select(arg_33_4:GetDisplayStatus(), function(arg_34_0)
			return arg_34_0:GetBuffType() == IslandBuffType.SHIP_ATTR
		end)

		onButton(arg_33_0, arg_33_1, function()
			arg_33_0:ShowMsgBox({
				hideNo = true,
				type = IslandMsgBox.TYPE_SHIP_OWN_STATUS,
				title = i18n("island_word_ship_buff_desc"),
				statusList = var_33_4
			})

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_33_1)
	end

	local var_33_5 = IslandShipAttr.Grade2Img((arg_33_4:GetAttrGradeByValue(var_33_3)))

	GetImageSpriteFromAtlasAsync("ui/IslandShipUI_atlas", var_33_5[1], arg_33_1:Find("grade"))
	GetImageSpriteFromAtlasAsync("ui/IslandShipUI_atlas", var_33_5[2], arg_33_1:Find("grade_bg"))

	return
end

function var_0_0.UpdateSkill(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_1:GetSkill()

	GetImageSpriteFromAtlasAsync("island/IslandSkillIcon/" .. var_36_0:GetIcon(), "", arg_36_0.skillIconImg)

	arg_36_0.skillName.text = var_36_0:GetName()
	arg_36_0.skillLevel.text = "[Lv." .. var_36_0:GetLevel() .. "]"
	arg_36_0.skillDesc.text = var_36_0:GetEffectDesc()

	local var_36_1 = var_36_0:IsUnlock()

	setActive(arg_36_0.skillTr, var_36_1)
	setActive(arg_36_0.skillMask, not var_36_1)
	setText(arg_36_0.skillMaskLabel, i18n("island_need_star", arg_36_1:GetSkillUnlockLevel()))
	setActive(arg_36_0.skillUpgradeBtn, not var_36_0:IsMaxLevel())

	return
end

function var_0_0.UpdateStatus(arg_37_0, arg_37_1)
	arg_37_0.statusPanel:Flush(arg_37_1)

	local var_37_0 = arg_37_1:GetDisplayStatus()

	onButton(arg_37_0, arg_37_0.statusPanel.viewBtn, function()
		arg_37_0:ShowMsgBox({
			hideNo = true,
			type = IslandMsgBox.TYPE_SHIP_OWN_STATUS,
			title = i18n("island_word_ship_buff_desc"),
			statusList = var_37_0
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnHide(arg_39_0)
	arg_39_0:RemoveCloseEnergyTipTimer()

	return
end

function var_0_0.OnDestroy(arg_40_0)
	arg_40_0.statusPanel:Dispose()

	arg_40_0.statusPanel = nil

	arg_40_0:RemoveCloseEnergyTipTimer()

	return
end

return var_0_0
