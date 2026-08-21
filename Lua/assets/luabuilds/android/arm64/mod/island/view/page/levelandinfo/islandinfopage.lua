local var_0_0 = class("IslandInfoPage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandInfoUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.backBtn = arg_2_0._tf:Find("frame/back")
	arg_2_0.levelTxt = arg_2_0._tf:Find("frame/left/level"):GetComponent(typeof(Text))
	arg_2_0.expTxt = arg_2_0._tf:Find("frame/left/objective/exp"):GetComponent(typeof(Text))
	arg_2_0.goldTxt = arg_2_0._tf:Find("frame/left/objective/gold"):GetComponent(typeof(Text))
	arg_2_0.expProgress = arg_2_0._tf:Find("frame/left/exp/bar")
	arg_2_0.preViewBtn = arg_2_0._tf:Find("frame/left/preview")
	arg_2_0.prosperityLevel = arg_2_0._tf:Find("frame/right/prosperity/level"):GetComponent(typeof(Text))
	arg_2_0.prosperityExp = arg_2_0._tf:Find("frame/right/prosperity/exp"):GetComponent(typeof(Text))
	arg_2_0.prosperityIcon = arg_2_0._tf:Find("frame/right/prosperity/icon")
	arg_2_0.nameTxt = arg_2_0._tf:Find("frame/left/name/Text"):GetComponent(typeof(Text))
	arg_2_0.editNameBtn = arg_2_0._tf:Find("frame/left/name")
	arg_2_0.uiShipList = UIItemList.New(arg_2_0._tf:Find("frame/right/ships/list"), arg_2_0._tf:Find("frame/right/ships/list/tpl"))
	arg_2_0.upgradePreviewPanel = arg_2_0._tf:Find("frame/left/upgrade_preview")
	arg_2_0.upgradeAwardList = UIItemList.New(arg_2_0._tf:Find("frame/left/upgrade_preview/content/awards/list/content"), arg_2_0._tf:Find("frame/left/upgrade_preview/content/awards/list/content/tpl"))
	arg_2_0.upgradeUnlockList = UIItemList.New(arg_2_0._tf:Find("frame/left/upgrade_preview/content/unlock/list/content"), arg_2_0._tf:Find("frame/left/upgrade_preview/content/awards/list/content/tpl"))
	arg_2_0.prosperityLevelList = UIItemList.New(arg_2_0._tf:Find("frame/right/prosperity/objective/content"), arg_2_0._tf:Find("frame/right/prosperity/objective/content/tpl"))
	arg_2_0.prosperityAwardList = UIItemList.New(arg_2_0._tf:Find("frame/right/prosperity/objective/awards"), arg_2_0._tf:Find("frame/right/prosperity/objective/awards/tpl"))
	arg_2_0.getProsperityBtn = arg_2_0._tf:Find("frame/right/prosperity/objective/get_btn")
	arg_2_0.goProsperityBtn = arg_2_0._tf:Find("frame/right/prosperity/objective/go_btn")
	arg_2_0.goProsperityBtnTxt = arg_2_0._tf:Find("frame/right/prosperity/objective/go_btn/Text"):GetComponent(typeof(Text))

	setText(arg_2_0._tf:Find("frame/left/preview/Text"), i18n("island_upgrade_preview"))
	setText(arg_2_0._tf:Find("frame/left/objective/label_exp"), i18n("island_upgrade_exp"))
	setText(arg_2_0._tf:Find("frame/left/objective/label_gold"), i18n("island_upgrade_res"))
	setText(arg_2_0._tf:Find("frame/left/upgrade_preview/content/awards/label"), i18n("island_word_award"))
	setText(arg_2_0._tf:Find("frame/left/upgrade_preview/content/unlock/label"), i18n("island_word_unlock"))
	setText(arg_2_0._tf:Find("frame/right/prosperity/objective/get_btn/Text"), i18n("island_word_get"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.backBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.editNameBtn, function()
		arg_3_0:OpenPage(IslandEditNamePage)

		return
	end, SFX_PANEL)

	arg_3_0.showPreviewPanel = false
	arg_3_0.displayPreviewLevel = -1

	onButton(arg_3_0, arg_3_0.preViewBtn, function()
		local var_7_0 = getProxy(IslandProxy):GetIsland()

		if var_7_0:IsMaxLevel() then
			return
		end

		arg_3_0.showPreviewPanel = not arg_3_0.showPreviewPanel

		setActive(arg_3_0.upgradePreviewPanel, arg_3_0.showPreviewPanel)

		local var_7_1 = var_7_0:GetLevel()

		if arg_3_0.showPreviewPanel and arg_3_0.displayPreviewLevel ~= var_7_1 then
			arg_3_0.displayPreviewLevel = var_7_1

			arg_3_0:InitUpgradeAwards(var_7_0)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddListener(GAME.ISLAND_UPGRADE_DONE, arg_8_0.OnUpgrade)
	arg_8_0:AddListener(GAME.ISLAND_PROSPERITY_AWARD_DONE, arg_8_0.OnGetAward)
	arg_8_0:AddListener(GAME.ISLAND_SET_NAME_DONE, arg_8_0.OnModifyName)

	return
end

function var_0_0.RemoveListeners(arg_9_0)
	arg_9_0:RemoveListener(GAME.ISLAND_UPGRADE_DONE, arg_9_0.OnUpgrade)
	arg_9_0:RemoveListener(GAME.ISLAND_PROSPERITY_AWARD_DONE, arg_9_0.OnGetAward)
	arg_9_0:RemoveListener(GAME.ISLAND_SET_NAME_DONE, arg_9_0.OnModifyName)

	return
end

function var_0_0.OnUpgrade(arg_10_0)
	arg_10_0:UpdateLevel((getProxy(IslandProxy):GetIsland()))

	return
end

function var_0_0.OnGetAward(arg_11_0)
	arg_11_0:UpdateProsperity((getProxy(IslandProxy):GetIsland()))

	return
end

function var_0_0.OnModifyName(arg_12_0)
	arg_12_0:UpdateName((getProxy(IslandProxy):GetIsland()))

	return
end

function var_0_0.Show(arg_13_0)
	var_0_0.super.Show(arg_13_0)

	local var_13_0 = getProxy(IslandProxy):GetIsland()

	arg_13_0:UpdateLevel(var_13_0)
	arg_13_0:UpdateProsperity(var_13_0)
	arg_13_0:UpdateName(var_13_0)
	arg_13_0:UpdateShips(var_13_0)
	pg.UIMgr.GetInstance():OverlayPanel(arg_13_0._tf, {
		pbList = {
			arg_13_0._tf:Find("frame/right")
		}
	})

	return
end

function var_0_0.Hide(arg_14_0)
	var_0_0.super.Hide(arg_14_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_14_0._tf, arg_14_0._parentTf)

	return
end

function var_0_0.InitUpgradeAwards(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1:GetUpgradeAwards()

	arg_15_0.upgradeAwardList:make(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_0 == UIItemList.EventUpdate then
			updateCustomDrop(arg_16_2, (Drop.Create(var_15_0[arg_16_1 + 1])))
		end

		return
	end)
	arg_15_0.upgradeAwardList:align(#arg_15_1:GetUpgradeAwards())

	local var_15_1 = arg_15_1:GetUnlockBuildingList()

	arg_15_0.upgradeUnlockList:make(function(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_0 == UIItemList.EventUpdate then
			updateCustomDrop(arg_17_2, (Drop.Create(var_15_1[arg_17_1 + 1])))
		end

		return
	end)
	arg_15_0.upgradeUnlockList:align(#arg_15_1:GetUnlockBuildingList())

	return
end

function var_0_0.UpdateLevel(arg_18_0, arg_18_1)
	arg_18_0.levelTxt.text = arg_18_1:GetLevel()

	local var_18_0 = arg_18_1:GetExp()
	local var_18_1 = arg_18_1:GetTargeExp()

	customColorCount(arg_18_0.expTxt, var_18_0, var_18_1, "#39bfff", "#f36c6e")
	setFillAmount(arg_18_0.expProgress, Mathf.Clamp01(var_18_0 / var_18_1))

	return
end

function var_0_0.UpdateProsperity(arg_19_0, arg_19_1)
	local var_19_0 = {}

	arg_19_0.prosperityLevelList:make(function(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_0 == UIItemList.EventUpdate then
			arg_19_0:UpdateProsperityCard(arg_20_2, pg.island_prosperity.all[arg_20_1 + 1], arg_19_1)

			var_19_0[pg.island_prosperity.all[arg_20_1 + 1]] = arg_20_2
		end

		return
	end)
	arg_19_0.prosperityLevelList:align(#pg.island_prosperity.all)

	local var_19_1 = ({})[arg_19_1:GetProsperityLevel()] or ({})[1]

	if var_19_1 then
		triggerToggle(var_19_1, true)
	end

	return
end

function var_0_0.UpdateProsperityCard(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_3:CanGetProsperityAwards(arg_21_2)
	local var_21_1 = arg_21_3:IsReceiveProsperityAwards(arg_21_2)
	local var_21_2 = arg_21_3:GetProsperityLevel() == arg_21_2

	setActive(arg_21_1:Find("line"), arg_21_3:GetMaxProsperityLevel() ~= arg_21_2)
	setActive(arg_21_1:Find("got"), var_21_1)
	setActive(arg_21_1:Find("get"), var_21_0)
	setActive(arg_21_1:Find("lock"), not var_21_0 and not var_21_1 and not var_21_2)
	setActive(arg_21_1:Find("curr"), var_21_2 and not var_21_1)
	onToggle(arg_21_0, arg_21_1, function()
		arg_21_0:FlushProsperity(arg_21_3, arg_21_2, var_21_0, var_21_1)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.FlushProsperity(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	arg_23_0.prosperityLevel.text = ArabicToRoman(arg_23_2)

	local var_23_0 = arg_23_1:GetTargetProsperityByLevel(arg_23_2)

	arg_23_0.prosperityExp.text = i18n("island_prosperity_level_display", arg_23_1:GetProsperity() .. "/" .. var_23_0)

	local var_23_1 = arg_23_1:GetProsperityAward(arg_23_2)

	arg_23_0.prosperityAwardList:make(function(arg_24_0, arg_24_1, arg_24_2)
		if arg_24_0 == UIItemList.EventUpdate then
			updateCustomDrop(arg_24_2, (Drop.Create(var_23_1[arg_24_1 + 1])))
		end

		return
	end)
	arg_23_0.prosperityAwardList:align(#arg_23_1:GetProsperityAward(arg_23_2))
	setActive(arg_23_0.getProsperityBtn, arg_23_3)
	setActive(arg_23_0.goProsperityBtn, not arg_23_4 and not arg_23_3)

	arg_23_0.goProsperityBtnTxt.text = i18n("island_prosperity_value_display", var_23_0)

	onButton(arg_23_0, arg_23_0.getProsperityBtn, function()
		arg_23_0:emit(IslandMediator.GET_PROSPERITY_AWARD, arg_23_2)

		return
	end, SFX_PANEL)
	GetImageSpriteFromAtlasAsync("island/IslandProsperityIcon/" .. arg_23_2, "", arg_23_0.prosperityIcon)

	return
end

function var_0_0.UpdateName(arg_26_0, arg_26_1)
	arg_26_0.nameTxt.text = arg_26_1:GetName()

	return
end

function var_0_0.UpdateShips(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1:GetCharacterAgency():GetShips()

	arg_27_0.uiShipList:make(function(arg_28_0, arg_28_1, arg_28_2)
		if arg_28_0 == UIItemList.EventUpdate then
			arg_27_0:UpdateShipCard(arg_28_2, var_27_0[arg_28_1 + 1])
		end

		return
	end)
	arg_27_0.uiShipList:align(5)

	return
end

function var_0_0.UpdateShipCard(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_2 == nil

	setActive(arg_29_1:Find("add"), arg_29_2 == nil)
	setActive(arg_29_1:Find("ship"), not var_29_0)

	if not var_29_0 then
		GetImageSpriteFromAtlasAsync("SquareIcon/" .. arg_29_2:GetPrefab(), "", arg_29_1:Find("ship/mask/icon"))
	end

	onButton(arg_29_0, arg_29_1, function()
		pg.TipsMgr.GetInstance():ShowTips(i18n("word_comingSoon"))

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnDestroy(arg_31_0)
	return
end

return var_0_0
