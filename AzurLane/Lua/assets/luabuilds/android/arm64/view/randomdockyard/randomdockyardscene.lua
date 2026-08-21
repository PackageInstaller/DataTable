local var_0_0 = class("RandomDockYardScene", import("view.base.BaseUI"))

var_0_0.MODE_VIEW = 1
var_0_0.MODE_ADD = 2
var_0_0.MODE_REMOVE = 3

function var_0_0.getUIName(arg_1_0)
	return "RandomDockYardUI"
end

function var_0_0.OnChangeRandomShips(arg_2_0)
	arg_2_0.randomFlagShips = nil
	arg_2_0.dockyardShips = nil

	arg_2_0:Switch(var_0_0.MODE_VIEW)

	return
end

function var_0_0.init(arg_3_0)
	arg_3_0.titleImg = arg_3_0._tf:Find("blur_panel/adapt/top/title"):GetComponent(typeof(Image))
	arg_3_0.titleEnImg = arg_3_0._tf:Find("blur_panel/adapt/top/title/title_en"):GetComponent(typeof(Image))
	arg_3_0.scrollrect = arg_3_0._tf:Find("main/ship_container/ships"):GetComponent("LScrollRect")
	arg_3_0.emptyTr = arg_3_0._tf:Find("empty")
	arg_3_0.backBtn = arg_3_0._tf:Find("blur_panel/adapt/top/back")
	arg_3_0.addBtn = arg_3_0._tf:Find("blur_panel/select_panel/add_button")
	arg_3_0.removeBtn = arg_3_0._tf:Find("blur_panel/select_panel/remove_button")
	arg_3_0.cancelBtn = arg_3_0._tf:Find("blur_panel/select_panel/cancel_button")
	arg_3_0.confirmBtn = arg_3_0._tf:Find("blur_panel/select_panel/confirm_button")
	arg_3_0.confirmBtnMask = arg_3_0.confirmBtn:Find("mask")
	arg_3_0.allBtn = arg_3_0._tf:Find("blur_panel/select_panel/all_button")
	arg_3_0.tipTxt = arg_3_0._tf:Find("blur_panel/select_panel/tip"):GetComponent(typeof(Text))
	arg_3_0.selectedTxt = arg_3_0._tf:Find("blur_panel/select_panel/bottom_info/bg_input/selected"):GetComponent(typeof(Text))
	arg_3_0.frequentlyUseToggle = arg_3_0._tf:Find("blur_panel/adapt/top/preference_toggle")
	arg_3_0.lockToggle = arg_3_0._tf:Find("blur_panel/adapt/top/lock_toggle")
	arg_3_0.sortBtn = arg_3_0._tf:Find("blur_panel/adapt/top/sort_button")
	arg_3_0.sortTxt = arg_3_0.sortBtn:Find("Image"):GetComponent(typeof(Text))
	arg_3_0.sortUp = arg_3_0.sortBtn:Find("asc")
	arg_3_0.sortDown = arg_3_0.sortBtn:Find("desc")
	arg_3_0.indexBtn = arg_3_0._tf:Find("blur_panel/adapt/top/index_button")
	arg_3_0.indexBtnSel = arg_3_0.indexBtn:Find("Image")
	arg_3_0.selectedCntTxt = arg_3_0._tf:Find("blur_panel/select_panel/bottom_info/bg_input/count"):GetComponent(typeof(Text))
	arg_3_0.phantomToggle = arg_3_0._tf:Find("toggle_phantom")
	arg_3_0.selectPanelFrame = arg_3_0._tf:Find("blur_panel/select_panel/bottom_info/bg_input")

	setActive(arg_3_0.sortUp, false)
	setActive(arg_3_0.sortDown, true)
	setText(arg_3_0.emptyTr:Find("Text"), i18n("random_ship_custom_mode_main_empty"))
	setText(arg_3_0.addBtn:Find("Text"), i18n("random_ship_custom_mode_main_button_add"))
	setText(arg_3_0.removeBtn:Find("Text"), i18n("random_ship_custom_mode_main_button_remove"))
	setText(arg_3_0.cancelBtn:Find("Text"), i18n("text_cancel"))
	setText(arg_3_0.confirmBtn:Find("Text"), i18n("text_confirm"))
	setText(arg_3_0.allBtn:Find("Text"), i18n("random_ship_custom_mode_select_all"))

	arg_3_0.msgbox = RandomDockYardMsgBoxPgae.New(arg_3_0._tf, arg_3_0.event)

	arg_3_0:InitDefault()

	return
end

function var_0_0.InitDefault(arg_4_0)
	arg_4_0.selected = {}
	arg_4_0.titles = {
		[var_0_0.MODE_VIEW] = GetSpriteFromAtlas("ui/dockyardui_atlas", "title_random_ship"),
		[var_0_0.MODE_ADD] = GetSpriteFromAtlas("ui/dockyardui_atlas", "title_add_random_ship"),
		[var_0_0.MODE_REMOVE] = GetSpriteFromAtlas("ui/dockyardui_atlas", "title_remove_random_ship")
	}
	arg_4_0.titleEns = {
		[var_0_0.MODE_VIEW] = GetSpriteFromAtlas("ui/dockyardui_atlas", "title_rd_en"),
		[var_0_0.MODE_ADD] = GetSpriteFromAtlas("ui/dockyardui_atlas", "title_add_en"),
		[var_0_0.MODE_REMOVE] = GetSpriteFromAtlas("ui/dockyardui_atlas", "title_remove_en")
	}
	arg_4_0.msgBoxTitle = {
		[var_0_0.MODE_VIEW] = {
			en = "",
			cn = ""
		},
		[var_0_0.MODE_ADD] = {
			en = "ADD",
			cn = i18n("random_ship_custom_mode_add_title")
		},
		[var_0_0.MODE_REMOVE] = {
			en = "REMOVE",
			cn = i18n("random_ship_custom_mode_remove_title")
		}
	}
	arg_4_0.msgBoxSubTitle = {
		[var_0_0.MODE_VIEW] = "",
		[var_0_0.MODE_ADD] = i18n("random_ship_custom_mode_add_tip2"),
		[var_0_0.MODE_REMOVE] = i18n("random_ship_custom_mode_remove_tip2")
	}
	arg_4_0.tips = {
		[var_0_0.MODE_VIEW] = i18n("random_ship_custom_mode_main_tip1"),
		[var_0_0.MODE_ADD] = i18n("random_ship_custom_mode_add_tip1"),
		[var_0_0.MODE_REMOVE] = i18n("random_ship_custom_mode_remove_tip1")
	}
	arg_4_0.selectedTxts = {
		[var_0_0.MODE_VIEW] = i18n("random_ship_custom_mode_main_tip2"),
		[var_0_0.MODE_ADD] = i18n("random_ship_custom_mode_select_number"),
		[var_0_0.MODE_REMOVE] = i18n("random_ship_custom_mode_select_number")
	}
	arg_4_0.frequentlyUseFlags = {
		[var_0_0.MODE_VIEW] = false,
		[var_0_0.MODE_ADD] = false,
		[var_0_0.MODE_REMOVE] = false
	}
	arg_4_0.lockFlags = {
		[var_0_0.MODE_VIEW] = false,
		[var_0_0.MODE_ADD] = false,
		[var_0_0.MODE_REMOVE] = false
	}
	arg_4_0.sortFlags = {
		[var_0_0.MODE_VIEW] = false,
		[var_0_0.MODE_ADD] = false,
		[var_0_0.MODE_REMOVE] = false
	}
	arg_4_0.indexDatas = {
		[var_0_0.MODE_VIEW] = {
			sortIndex = ShipIndexConst.SortLevel,
			typeIndex = ShipIndexConst.TypeAll,
			campIndex = ShipIndexConst.CampAll,
			rarityIndex = ShipIndexConst.RarityAll,
			extraIndex = ShipIndexConst.ExtraALL
		},
		[var_0_0.MODE_ADD] = {
			sortIndex = ShipIndexConst.SortLevel,
			typeIndex = ShipIndexConst.TypeAll,
			campIndex = ShipIndexConst.CampAll,
			rarityIndex = ShipIndexConst.RarityAll,
			extraIndex = ShipIndexConst.ExtraALL
		},
		[var_0_0.MODE_REMOVE] = {
			sortIndex = ShipIndexConst.SortLevel,
			typeIndex = ShipIndexConst.TypeAll,
			campIndex = ShipIndexConst.CampAll,
			rarityIndex = ShipIndexConst.RarityAll,
			extraIndex = ShipIndexConst.ExtraALL
		}
	}

	return
end

function var_0_0.didEnter(arg_5_0)
	arg_5_0.cards = {}

	function arg_5_0.scrollrect.onInitItem(arg_6_0)
		arg_5_0:OnItemUpdate(arg_6_0)

		return
	end

	function arg_5_0.scrollrect.onUpdateItem(arg_7_0, arg_7_1)
		arg_5_0:OnUpdateItem(arg_7_0, arg_7_1)

		return
	end

	function arg_5_0.scrollrect.onReturnItem(arg_8_0, arg_8_1)
		arg_5_0:onReturnItem(arg_8_0, arg_8_1)

		return
	end

	onButton(arg_5_0, arg_5_0.backBtn, function()
		if arg_5_0.mode ~= var_0_0.MODE_VIEW then
			arg_5_0:Switch(var_0_0.MODE_VIEW)

			return
		end

		arg_5_0:emit(var_0_0.ON_RETURN, {
			page = NewSettingsScene.PAGE_OPTION,
			scroll = SettingsRandomFlagShipAndSkinPanel
		})

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.addBtn, function()
		arg_5_0:Switch(var_0_0.MODE_ADD)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.removeBtn, function()
		arg_5_0:Switch(var_0_0.MODE_REMOVE)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.cancelBtn, function()
		if arg_5_0.mode == var_0_0.MODE_VIEW then
			return
		end

		arg_5_0:Switch(var_0_0.MODE_VIEW)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.confirmBtn, function()
		if arg_5_0.mode == var_0_0.MODE_VIEW then
			return
		end

		arg_5_0:OnConfirm()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.allBtn, function()
		if arg_5_0.mode == var_0_0.MODE_VIEW then
			return
		end

		arg_5_0:OnAll()

		return
	end, SFX_PANEL)
	onToggle(arg_5_0, arg_5_0.frequentlyUseToggle, function(arg_15_0)
		arg_5_0.frequentlyUseFlags[arg_5_0.mode] = arg_15_0

		arg_5_0:FlushShipList((arg_5_0:GetShipList(arg_5_0.mode)))

		return
	end, SFX_PANEL)
	onToggle(arg_5_0, arg_5_0.lockToggle, function(arg_16_0)
		arg_5_0.lockFlags[arg_5_0.mode] = arg_16_0

		arg_5_0:FlushShipList((arg_5_0:GetShipList(arg_5_0.mode)))

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.sortBtn, function()
		arg_5_0.sortFlags[arg_5_0.mode] = not arg_5_0.sortFlags[arg_5_0.mode]

		setActive(arg_5_0.sortUp, arg_5_0.sortFlags[arg_5_0.mode])
		setActive(arg_5_0.sortDown, not arg_5_0.sortFlags[arg_5_0.mode])
		arg_5_0:FlushShipList((arg_5_0:GetShipList(arg_5_0.mode)))

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.indexBtn, function()
		arg_5_0:emit(RandomDockYardMediator.OPEN_INDEX, {
			OnFilter = function(arg_19_0)
				arg_5_0:OnFilter(arg_19_0)

				return
			end,
			defaultIndex = arg_5_0.indexDatas[arg_5_0.mode]
		})

		return
	end, SFX_PANEL)
	setToggleEnabled(arg_5_0.phantomToggle, false)
	onButton(arg_5_0, arg_5_0.phantomToggle:Find("off"), function()
		arg_5_0:emit(RandomDockYardMediator.OPEN_PHANTOM_LAYER)

		return
	end, SFX_PANEL)
	arg_5_0:Switch(var_0_0.MODE_VIEW)

	return
end

function var_0_0.GetRandomFlagShips(arg_21_0)
	if not arg_21_0.randomFlagShips then
		local var_21_0 = getProxy(PlayerProxy):getRawData()

		arg_21_0.randomFlagShips = {}
		arg_21_0.phantomCount = 0

		local var_21_1 = getProxy(BayProxy)

		for iter_21_0, iter_21_1 in ipairs(var_21_1:getRandomFlagShipPhantomMarks()) do
			local var_21_2 = var_21_1:GetShipPhantom(iter_21_1)

			if var_21_2 then
				if var_21_2.phantomId == 0 then
					table.insert(arg_21_0.randomFlagShips, var_21_2)
				else
					arg_21_0.phantomCount = arg_21_0.phantomCount + 1
				end
			end
		end
	end

	return arg_21_0.randomFlagShips
end

function var_0_0.GetDockYardShipAndNotInRandom(arg_22_0)
	if not arg_22_0.dockyardShips then
		for iter_22_0, iter_22_1 in ipairs((arg_22_0:GetRandomFlagShips())) do
			({})[iter_22_1.id] = true
		end

		arg_22_0.dockyardShips = {}

		for iter_22_2, iter_22_3 in pairs((getProxy(BayProxy):getRawData())) do
			if not ({})[iter_22_3.id] and not iter_22_3:isActivityNpc() then
				table.insert(arg_22_0.dockyardShips, iter_22_3)
			end
		end
	end

	return arg_22_0.dockyardShips
end

function var_0_0.GetShipList(arg_23_0, arg_23_1)
	local var_23_0 = {}

	if arg_23_1 == var_0_0.MODE_VIEW then
		var_23_0 = arg_23_0:GetRandomFlagShips()
	elseif arg_23_1 == var_0_0.MODE_ADD then
		var_23_0 = arg_23_0:GetDockYardShipAndNotInRandom()
	elseif arg_23_1 == var_0_0.MODE_REMOVE then
		var_23_0 = arg_23_0:GetRandomFlagShips()
	end

	return var_23_0
end

function var_0_0.Switch(arg_24_0, arg_24_1)
	arg_24_0:Clear()

	arg_24_0.selected = {}

	local var_24_0 = arg_24_0:GetShipList(arg_24_1)

	arg_24_0:UpdateModeStyle(arg_24_1, #var_24_0)

	arg_24_0.mode = arg_24_1

	arg_24_0:FlushShipList(var_24_0)

	if arg_24_0.mode == var_0_0.MODE_VIEW then
		arg_24_0:UpdateSelectedCnt(#var_24_0 + arg_24_0.phantomCount)
	else
		arg_24_0:UpdateSelectedCnt(table.getCount(arg_24_0.selected))
	end

	setActive(arg_24_0.phantomToggle, arg_24_0.mode == var_0_0.MODE_VIEW)

	return
end

function var_0_0.UpdateModeStyle(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0.titleImg.sprite = arg_25_0.titles[arg_25_1]

	arg_25_0.titleImg:SetNativeSize()

	arg_25_0.titleEnImg.sprite = arg_25_0.titleEns[arg_25_1]

	arg_25_0.titleEnImg:SetNativeSize()
	setActive(arg_25_0.addBtn, arg_25_1 == var_0_0.MODE_VIEW)
	setActive(arg_25_0.removeBtn, arg_25_1 == var_0_0.MODE_VIEW)
	setActive(arg_25_0.cancelBtn, arg_25_1 == var_0_0.MODE_ADD or arg_25_1 == var_0_0.MODE_REMOVE)
	setActive(arg_25_0.confirmBtn, arg_25_1 == var_0_0.MODE_ADD or arg_25_1 == var_0_0.MODE_REMOVE)
	setActive(arg_25_0.allBtn, arg_25_1 == var_0_0.MODE_ADD or arg_25_1 == var_0_0.MODE_REMOVE)

	arg_25_0.tipTxt.text = arg_25_0.tips[arg_25_1]
	arg_25_0.selectedTxt.text = arg_25_0.selectedTxts[arg_25_1]

	setButtonEnabled(arg_25_0.removeBtn, arg_25_1 == var_0_0.MODE_VIEW and arg_25_2 > 0)
	setAnchoredPosition(arg_25_0.selectPanelFrame, {
		x = arg_25_1 == var_0_0.MODE_VIEW and 0 or 180
	})

	return
end

function var_0_0.OnConfirm(arg_26_0)
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(arg_26_0.selected) do
		table.insert({}, iter_26_0)
	end

	arg_26_0.msgbox:ExecuteAction("Flush", arg_26_0.msgBoxTitle[arg_26_0.mode], arg_26_0.msgBoxSubTitle[arg_26_0.mode], {}, function()
		if arg_26_0.mode == var_0_0.MODE_ADD then
			arg_26_0:emit(RandomDockYardMediator.ON_ADD_SHIPS, var_26_0)
		elseif arg_26_0.mode == var_0_0.MODE_REMOVE then
			arg_26_0:emit(RandomDockYardMediator.ON_REMOVE_SHIPS, var_26_0)
		end

		return
	end)

	return
end

function var_0_0.OnAll(arg_28_0)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0.displays) do
		arg_28_0.selected[iter_28_1.id] = true
	end

	arg_28_0.scrollrect:SetTotalCount(#arg_28_0.displays)
	arg_28_0:UpdateSelectedCnt(table.getCount(arg_28_0.selected))

	return
end

function var_0_0.UpdateSelectedCnt(arg_29_0, arg_29_1)
	arg_29_0.selectedCntTxt.text = arg_29_1

	setButtonEnabled(arg_29_0.confirmBtn, arg_29_1 > 0)
	setActive(arg_29_0.confirmBtnMask, arg_29_1 <= 0)

	return
end

local function var_0_1(arg_30_0)
	return arg_30_0.sortIndex ~= ShipIndexConst.SortLevel or arg_30_0.typeIndex ~= ShipIndexConst.TypeAll or arg_30_0.campIndex ~= ShipIndexConst.CampAll or arg_30_0.rarityIndex ~= ShipIndexConst.RarityAll or arg_30_0.extraIndex ~= ShipIndexConst.ExtraALL
end

function var_0_0.OnFilter(arg_31_0, arg_31_1)
	arg_31_0.indexDatas[arg_31_0.mode].sortIndex = arg_31_1.sortIndex
	arg_31_0.indexDatas[arg_31_0.mode].typeIndex = arg_31_1.typeIndex
	arg_31_0.indexDatas[arg_31_0.mode].campIndex = arg_31_1.campIndex
	arg_31_0.indexDatas[arg_31_0.mode].rarityIndex = arg_31_1.rarityIndex
	arg_31_0.indexDatas[arg_31_0.mode].extraIndex = arg_31_1.extraIndex

	setActive(arg_31_0.indexBtnSel, var_0_1(arg_31_0.indexDatas[arg_31_0.mode]))
	arg_31_0:FlushShipList((arg_31_0:GetShipList(arg_31_0.mode)))

	return
end

function var_0_0.OnItemUpdate(arg_32_0, arg_32_1)
	local var_32_0 = RandomDockYardCard.New(arg_32_1)

	onButton(arg_32_0, var_32_0._go, function()
		if arg_32_0.mode == var_0_0.MODE_VIEW then
			return
		end

		if arg_32_0.selected[var_32_0.ship.id] then
			arg_32_0.selected[var_32_0.ship.id] = nil
		else
			arg_32_0.selected[var_32_0.ship.id] = true
		end

		arg_32_0:UpdateSelectedCnt(table.getCount(arg_32_0.selected))
		var_32_0:UpdateSelected(arg_32_0.selected[var_32_0.ship.id])

		return
	end, SFX_PANEL)

	arg_32_0.cards[arg_32_1] = var_32_0

	return
end

function var_0_0.OnUpdateItem(arg_34_0, arg_34_1, arg_34_2)
	if not arg_34_0.cards[arg_34_2] then
		arg_34_0:OnItemUpdate(arg_34_2)
	end

	arg_34_0.cards[arg_34_2]:Update(arg_34_0.displays[arg_34_1 + 1], arg_34_0.selected[arg_34_0.displays[arg_34_1 + 1].id])

	return
end

function var_0_0.onReturnItem(arg_35_0, arg_35_1, arg_35_2)
	if arg_35_0.exited then
		return
	end

	if arg_35_0.cards[arg_35_2] then
		var_35_0:Dispose()
	end

	return
end

function var_0_0.FlushShipList(arg_36_0, arg_36_1)
	arg_36_0.displays = {}

	arg_36_0:FilterShips(arg_36_1, arg_36_0.displays)
	arg_36_0:SortShips(arg_36_0.displays)

	local var_36_0 = #arg_36_0.displays

	arg_36_0.scrollrect:SetTotalCount(#arg_36_0.displays)
	setActive(arg_36_0.emptyTr, var_36_0 <= 0)

	return
end

function var_0_0.FilterShips(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = arg_37_0.lockFlags[arg_37_0.mode]
	local var_37_1 = arg_37_0.frequentlyUseFlags[arg_37_0.mode]
	local var_37_2 = arg_37_0.indexDatas[arg_37_0.mode]

	for iter_37_0, iter_37_1 in ipairs(arg_37_1) do
		if (function(arg_38_0)
			local var_38_0 = not var_37_1 or not not arg_38_0:IsPreferenceTag()
			local var_38_1 = ShipIndexConst.filterByType(arg_38_0, var_37_2.typeIndex)

			return (not var_37_0 or not not arg_38_0:IsLocked()) and var_38_0 and var_38_1 and ShipIndexConst.filterByCamp(arg_38_0, var_37_2.campIndex) and ShipIndexConst.filterByRarity(arg_38_0, var_37_2.rarityIndex) and ShipIndexConst.filterByExtra(arg_38_0, var_37_2.extraIndex)
		end)(iter_37_1) then
			table.insert(arg_37_2, iter_37_1)
		end
	end

	return
end

function var_0_0.SortShips(arg_39_0, arg_39_1)
	local var_39_0, var_39_1 = ShipIndexConst.getSortFuncAndName(arg_39_0.indexDatas[arg_39_0.mode].sortIndex, arg_39_0.sortFlags[arg_39_0.mode])

	table.insert(var_39_0, 1, function(arg_40_0)
		return -arg_40_0.activityNpc
	end)
	table.sort(arg_39_1, CompareFuncs(var_39_0))

	arg_39_0.sortTxt.text = i18n(var_39_1)

	return
end

function var_0_0.onBackPressed(arg_41_0)
	var_0_0.super.onBackPressed(arg_41_0)

	return
end

function var_0_0.Clear(arg_42_0)
	for iter_42_0, iter_42_1 in pairs(arg_42_0.cards) do
		iter_42_1:Dispose()
	end

	arg_42_0.cards = {}

	return
end

function var_0_0.willExit(arg_43_0)
	arg_43_0.titles = nil

	if arg_43_0.msgbox then
		arg_43_0.msgbox:Destroy()
	end

	arg_43_0.msgbox = nil

	return
end

return var_0_0
