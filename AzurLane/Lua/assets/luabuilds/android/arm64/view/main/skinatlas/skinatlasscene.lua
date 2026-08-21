local var_0_0 = class("SkinAtlasScene", import("...base.BaseUI"))

var_0_0.PAGE_ALL = -1
var_0_0.ON_NEXT_SKIN = "SkinAtlasScene:ON_NEXT_SKIN"
var_0_0.ON_PREV_SKIN = "SkinAtlasScene:ON_PREV_SKIN"

function var_0_0.getUIName(arg_1_0)
	return "SkinAtlasUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.canvasGroup = arg_2_0._tf:GetComponent(typeof(CanvasGroup))
	arg_2_0.backBtn = arg_2_0._tf:Find("adapt/top_panel/back_btn")
	arg_2_0.homeBtn = arg_2_0._tf:Find("adapt/top_panel/option")
	arg_2_0.indexBtn = arg_2_0._tf:Find("adapt/top_panel/index_btn")
	arg_2_0.indexBtnSel = arg_2_0.indexBtn:Find("sel")
	arg_2_0.inptuTr = arg_2_0._tf:Find("adapt/top_panel/search")
	arg_2_0.emptyTr = arg_2_0._tf:Find("adapt/main_panel/empty")
	arg_2_0.rollingCircleRect = RollingCircleRect.New(arg_2_0._tf:Find("adapt/left_panel/mask/content/0"), (arg_2_0._tf:Find("adapt/left_panel")))

	arg_2_0.rollingCircleRect:SetCallback(arg_2_0, var_0_0.OnSelectSkinPage, var_0_0.OnConfirmSkinPage)

	arg_2_0.scrollrect = arg_2_0._tf:Find("adapt/main_panel/scrollrect"):GetComponent("LScrollRect")
	arg_2_0.previewPage = SkinAtlasPreviewPage.New(arg_2_0._tf, arg_2_0.event)

	setText(arg_2_0._tf:Find("adapt/main_panel/empty/Text1"), i18n("skinatlas_search_result_is_empty"))
	setText(arg_2_0._tf:Find("adapt/top_panel/search/holder"), i18n("skinatlas_search_holder"))

	arg_2_0.defaultIndex = {
		typeIndex = ShipIndexConst.TypeAll,
		campIndex = ShipIndexConst.CampAll,
		rarityIndex = ShipIndexConst.RarityAll,
		extraIndex = SkinAtlasIndexLayer.ExtraALL
	}

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0.cards = {}

	onButton(arg_3_0, arg_3_0.homeBtn, function()
		arg_3_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.backBtn, function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0.indexBtn, function()
		arg_3_0:emit(SkinAtlasMediator.OPEN_INDEX, {
			OnFilter = function(arg_7_0)
				arg_3_0:OnFilter(arg_7_0)

				return
			end,
			defaultIndex = arg_3_0.defaultIndex
		})

		return
	end, SFX_PANEL)
	arg_3_0:bind(var_0_0.ON_NEXT_SKIN, function(arg_8_0, arg_8_1)
		arg_3_0:SwitchPreviewSkin(arg_8_1 + 1)

		return
	end)
	arg_3_0:bind(var_0_0.ON_PREV_SKIN, function(arg_9_0, arg_9_1)
		arg_3_0:SwitchPreviewSkin(arg_9_1 - 1)

		return
	end)

	function arg_3_0.scrollrect.onInitItem(arg_10_0)
		arg_3_0:OnInitItem(arg_10_0)

		return
	end

	function arg_3_0.scrollrect.onUpdateItem(arg_11_0, arg_11_1)
		arg_3_0:OnUpdateItem(arg_11_0, arg_11_1)

		return
	end

	onInputChanged(arg_3_0, arg_3_0.inptuTr, function()
		arg_3_0:OnSearch()

		return
	end)
	arg_3_0:InitSkinPages()

	return
end

function var_0_0.SwitchPreviewSkin(arg_13_0, arg_13_1)
	if arg_13_0.displays and arg_13_0.displays[arg_13_1] then
		arg_13_0.previewPage:ExecuteAction("Flush", arg_13_0.displays[arg_13_1], arg_13_1)
	end

	return
end

local function var_0_1(arg_14_0)
	local var_14_0 = pg.skin_page_template
	local var_14_1 = arg_14_0:GetID()
	local var_14_2 = var_14_1 == var_0_0.PAGE_ALL and "text_all" or "text_" .. var_14_0[var_14_1].res

	LoadSpriteAtlasAsync("SkinClassified", (var_14_1 == var_0_0.PAGE_ALL and "text_all" or "text_" .. var_14_0[var_14_1].res) .. "01", function(arg_15_0)
		local var_15_0 = arg_14_0._tr:Find("name"):GetComponent(typeof(Image))

		var_15_0.sprite = arg_15_0

		var_15_0:SetNativeSize()

		return
	end)
	LoadSpriteAtlasAsync("SkinClassified", var_14_2, function(arg_16_0)
		local var_16_0 = arg_14_0._tr:Find("selected/Image"):GetComponent(typeof(Image))

		var_16_0.sprite = arg_16_0

		var_16_0:SetNativeSize()

		return
	end)
	setText(arg_14_0._tr:Find("eng"), var_14_1 == var_0_0.PAGE_ALL and "ALL" or var_14_0[var_14_1].english_name)

	return
end

function var_0_0.InitSkinPages(arg_17_0, arg_17_1)
	local var_17_0 = Clone(pg.skin_page_template.all)

	table.insert(var_17_0, 1, var_0_0.PAGE_ALL)

	arg_17_0.canvasGroup.blocksRaycasts = false

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		table.insert({}, function(arg_18_0)
			var_0_1((arg_17_0.rollingCircleRect:AddItem(iter_17_1)))

			if (iter_17_0 - 1) % 3 == 0 or iter_17_0 == #var_17_0 then
				onNextTick(arg_18_0)
			else
				arg_18_0()
			end

			return
		end)
	end

	seriesAsync({}, function()
		setActive(arg_17_0.scrollrect.gameObject, true)
		arg_17_0.rollingCircleRect:ScrollTo(var_0_0.PAGE_ALL)

		arg_17_0.canvasGroup.blocksRaycasts = true

		return
	end)

	return
end

function var_0_0.OnSelectSkinPage(arg_20_0, arg_20_1)
	if arg_20_0.selectedSkinPageItem then
		setActive(arg_20_0.selectedSkinPageItem._tr:Find("selected"), false)
		setActive(arg_20_0.selectedSkinPageItem._tr:Find("name"), true)
	end

	setActive(arg_20_1._tr:Find("selected"), true)
	setActive(arg_20_1._tr:Find("name"), false)

	arg_20_0.selectedSkinPageItem = arg_20_1

	return
end

function var_0_0.OnConfirmSkinPage(arg_21_0, arg_21_1)
	arg_21_0.skinPageID = arg_21_1:GetID()

	arg_21_0:UpdateSkinCards()

	return
end

function var_0_0.OnSearch(arg_22_0)
	arg_22_0:UpdateSkinCards()

	return
end

function var_0_0.OnFilter(arg_23_0, arg_23_1)
	arg_23_0.defaultIndex = {
		typeIndex = arg_23_1.typeIndex,
		campIndex = arg_23_1.campIndex,
		rarityIndex = arg_23_1.rarityIndex,
		extraIndex = arg_23_1.extraIndex
	}

	arg_23_0:UpdateSkinCards()
	setActive(arg_23_0.indexBtnSel, arg_23_1.typeIndex ~= ShipIndexConst.TypeAll or arg_23_1.campIndex ~= ShipIndexConst.CampAll or arg_23_1.rarityIndex ~= ShipIndexConst.RarityAll or arg_23_1.extraIndex ~= SkinAtlasIndexLayer.ExtraALL)

	return
end

function var_0_0.ToVShip(arg_24_0, arg_24_1)
	if not arg_24_0.vship then
		arg_24_0.vship = {}

		function arg_24_0.vship.getNation()
			return arg_24_0.vship.config.nationality
		end

		function arg_24_0.vship.getShipType()
			return arg_24_0.vship.config.type
		end

		function arg_24_0.vship.getTeamType()
			return ShipType.GetTeamFromShipType(arg_24_0.vship.config.type)
		end

		function arg_24_0.vship.getRarity()
			return arg_24_0.vship.config.rarity
		end
	end

	arg_24_0.vship.config = arg_24_1

	return arg_24_0.vship
end

function var_0_0.MatchIndex(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1:GetDefaultShipConfig()

	if not var_29_0 then
		return false
	end

	local var_29_1 = arg_29_0:ToVShip(var_29_0)

	return ShipIndexConst.filterByType(var_29_1, arg_29_0.defaultIndex.typeIndex) and ShipIndexConst.filterByCamp(var_29_1, arg_29_0.defaultIndex.campIndex) and ShipIndexConst.filterByRarity(var_29_1, arg_29_0.defaultIndex.rarityIndex) and SkinAtlasIndexLayer.filterByExtra(arg_29_1, arg_29_0.defaultIndex.extraIndex)
end

function var_0_0.GetSkinList(arg_30_0, arg_30_1, arg_30_2)
	for iter_30_0, iter_30_1 in pairs((getProxy(ShipSkinProxy):GetOwnSkins())) do
		if (arg_30_1 == var_0_0.PAGE_ALL or iter_30_1:IsType(arg_30_1)) and not iter_30_1:IsDefault() and iter_30_1:IsMatchKey(arg_30_2) and arg_30_0:MatchIndex(iter_30_1) and iter_30_1:MatchChangeSkinMain() then
			table.insert({}, iter_30_1)
		end
	end

	return {}
end

function var_0_0.UpdateSkinCards(arg_31_0)
	arg_31_0.displays = arg_31_0:GetSkinList(arg_31_0.skinPageID, (getInputText(arg_31_0.inptuTr)))

	arg_31_0:SortDisplay(arg_31_0.displays)
	arg_31_0.scrollrect:SetTotalCount(#arg_31_0.displays)
	setActive(arg_31_0.emptyTr, #arg_31_0.displays == 0)

	return
end

function var_0_0.SortDisplay(arg_32_0, arg_32_1)
	table.sort(arg_32_1, function(arg_33_0, arg_33_1)
		local var_33_0 = arg_33_0:getConfig("ship_group")
		local var_33_1 = arg_33_1:getConfig("ship_group")

		if var_33_0 == var_33_1 then
			return arg_33_0:getConfig("group_index") < arg_33_1:getConfig("group_index")
		else
			return var_33_0 < var_33_1
		end

		return
	end)

	return
end

function var_0_0.OnInitItem(arg_34_0, arg_34_1)
	local var_34_0 = SkinAtlasCard.New(arg_34_1)

	onButton(arg_34_0, var_34_0._tf, function()
		arg_34_0.previewPage:ExecuteAction("Show", var_34_0.skin, var_34_0.index)

		return
	end, SFX_PANEL)
	onButton(arg_34_0, var_34_0.changeSkinUI, function()
		var_34_0:changeSkinNext()

		return
	end, SFX_PANEL)

	arg_34_0.cards[arg_34_1] = var_34_0

	return
end

function var_0_0.OnUpdateItem(arg_37_0, arg_37_1, arg_37_2)
	if not arg_37_0.cards[arg_37_2] then
		arg_37_0:OnInitItem(arg_37_2)
	end

	arg_37_0.cards[arg_37_2]:Update(arg_37_0.displays[arg_37_1 + 1], arg_37_1 + 1)

	return
end

function var_0_0.onBackPressed(arg_38_0)
	if arg_38_0.previewPage and arg_38_0.previewPage:GetLoaded() and arg_38_0.previewPage:isShowing() then
		if arg_38_0.previewPage:IsShowSelectShipView() then
			arg_38_0.previewPage:CloseSelectShipView()

			return
		end

		arg_38_0.previewPage:Hide()

		return
	end

	var_0_0.super.onBackPressed(arg_38_0)

	return
end

function var_0_0.willExit(arg_39_0)
	for iter_39_0, iter_39_1 in pairs(arg_39_0.cards) do
		iter_39_1:Dispose()
	end

	arg_39_0.cards = nil

	if arg_39_0.rollingCircleRect then
		arg_39_0.rollingCircleRect:Dispose()

		arg_39_0.rollingCircleRect = nil
	end

	if arg_39_0.previewPage then
		arg_39_0.previewPage:Destroy()

		arg_39_0.previewPage = nil
	end

	return
end

return var_0_0
