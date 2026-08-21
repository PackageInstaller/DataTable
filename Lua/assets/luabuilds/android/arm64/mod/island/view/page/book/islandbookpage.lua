local var_0_0 = class("IslandBookPage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandBookUI"
end

function var_0_0.OnLoaded(arg_2_0)
	setText(arg_2_0._tf:Find("top/title/Text"), i18n("island_guide"))
	setText(arg_2_0._tf:Find("top/title/Text/en"), i18n("island_guide_en"))

	arg_2_0.charBtn = arg_2_0._tf:Find("view/content/char")
	arg_2_0.charTip = arg_2_0.charBtn:Find("tip")
	arg_2_0.npcBtn = arg_2_0._tf:Find("view/content/npc")
	arg_2_0.npcTip = arg_2_0.npcBtn:Find("tip")
	arg_2_0.itemBtn = arg_2_0._tf:Find("view/content/item")
	arg_2_0.itemTip = arg_2_0.itemBtn:Find("tip")
	arg_2_0.fishBtn = arg_2_0._tf:Find("view/content/fish")
	arg_2_0.fishTip = arg_2_0.fishBtn:Find("tip")

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("top/back"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.charBtn, function()
		arg_3_0:OpenPage(IslandBookCharPage)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.npcBtn, function()
		arg_3_0:OpenPage(IslandBookNpcPage)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.itemBtn, function()
		arg_3_0:OpenPage(IslandBookItemPage)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.fishBtn, function()
		arg_3_0:OpenPage(IslandBookFishPage)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddListener(GAME.ISLAND_UNLOCK_ILLUSTRATION_DONE, arg_9_0.FlushTips)
	arg_9_0:AddListener(GAME.ISLAND_GET_COLLECT_POINT_DONE, arg_9_0.FlushTips)
	arg_9_0:AddListener(GAME.ISLAND_GET_POINT_AWARD_DONE, arg_9_0.FlushTips)

	return
end

function var_0_0.RemoveListeners(arg_10_0)
	arg_10_0:RemoveListener(GAME.ISLAND_UNLOCK_ILLUSTRATION_DONE, arg_10_0.FlushTips)
	arg_10_0:RemoveListener(GAME.ISLAND_GET_COLLECT_POINT_DONE, arg_10_0.FlushTips)
	arg_10_0:RemoveListener(GAME.ISLAND_GET_POINT_AWARD_DONE, arg_10_0.FlushTips)

	return
end

function var_0_0.OnShow(arg_11_0)
	arg_11_0:FlushTips()

	return
end

function var_0_0.FlushTips(arg_12_0)
	setActive(arg_12_0.fishBtn, IslandMainBtnTipHelper.IsUnlock("book_fish"))

	arg_12_0.bookAgency = getProxy(IslandProxy):GetIsland():GetBookAgency()

	setActive(arg_12_0.charTip, arg_12_0.bookAgency:IsTipFromTypes({
		IslandIllustration.TYPES.CHAR
	}))
	setActive(arg_12_0.npcTip, arg_12_0.bookAgency:IsTipFromTypes({
		IslandIllustration.TYPES.NPC
	}))
	setActive(arg_12_0.itemTip, arg_12_0.bookAgency:IsTipFromTypes({
		IslandIllustration.TYPES.ITEM
	}))
	setActive(arg_12_0.fishTip, arg_12_0.bookAgency:IsTipFromTypes({
		IslandIllustration.TYPES.FISH
	}))

	return
end

return var_0_0
