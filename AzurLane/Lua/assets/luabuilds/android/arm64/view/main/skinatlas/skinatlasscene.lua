class = var_0_10000

local var_0_0 = "SkinAtlasScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))

var_0_1.PAGE_ALL = -1
var_0_1.ON_NEXT_SKIN = "SkinAtlasScene:ON_NEXT_SKIN"
var_0_1.ON_PREV_SKIN = "SkinAtlasScene:ON_PREV_SKIN"

function var_0_1.getUIName(arg_1_0)
	return "SkinAtlasUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.GetComponent

	typeof = var_1_10004
	CanvasGroup = var_1_10006
	arg_2_0.canvasGroup = var_2_1(var_2_0, var_1_10004(var_1_10006))

	local var_2_2 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_2, "adapt/top_panel/back_btn")

	local var_2_3 = arg_2_0._tf

	arg_2_0.homeBtn = var_1.Find(var_2_3, "adapt/top_panel/option")

	local var_2_4 = arg_2_0._tf

	arg_2_0.indexBtn = var_1.Find(var_2_4, "adapt/top_panel/index_btn")

	local var_2_5 = arg_2_0.indexBtn

	arg_2_0.indexBtnSel = var_1.Find(var_2_5, "sel")

	local var_2_6 = arg_2_0._tf

	arg_2_0.inptuTr = var_1.Find(var_2_6, "adapt/top_panel/search")

	local var_2_7 = arg_2_0._tf

	arg_2_0.emptyTr = var_1.Find(var_2_7, "adapt/main_panel/empty")

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_1.Find(var_2_8, "adapt/left_panel/mask/content/0")
	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_2.Find(var_2_10, "adapt/left_panel")

	RollingCircleRect = var_2_8
	arg_2_0.rollingCircleRect = var_2_8.New(var_2_9, var_2_11)

	local var_2_12 = arg_2_0.rollingCircleRect

	var_3.SetCallback(var_2_12, arg_2_0, var_0_1.OnSelectSkinPage, var_0_1.OnConfirmSkinPage)

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_3.Find(var_2_13, "adapt/main_panel/scrollrect")

	arg_2_0.scrollrect = var_3.GetComponent(var_2_14, "LScrollRect")
	SkinAtlasPreviewPage = var_3
	arg_2_0.previewPage = var_3.New(arg_2_0._tf, arg_2_0.event)
	setText = var_3

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_5.Find(var_2_15, "adapt/main_panel/empty/Text1")

	i18n = var_6

	var_3(var_2_16, var_6("skinatlas_search_result_is_empty"))

	setText = var_3

	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_5.Find(var_2_17, "adapt/top_panel/search/holder")

	i18n = var_6

	var_3(var_2_18, var_6("skinatlas_search_holder"))

	local var_2_19 = {}

	ShipIndexConst = var_2_10
	var_2_19.typeIndex = var_2_10.TypeAll
	ShipIndexConst = var_4
	var_2_19.campIndex = var_4.CampAll
	ShipIndexConst = var_4
	var_2_19.rarityIndex = var_4.RarityAll
	SkinAtlasIndexLayer = var_4
	var_2_19.extraIndex = var_4.ExtraALL
	arg_2_0.defaultIndex = var_2_19

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0.cards = {}
	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.homeBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_HOME)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.backBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.closeView(var_5_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.indexBtn

	local function var_3_8()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.emit

		SkinAtlasMediator = var_2_10003

		var_6_1(var_6_0, var_2_10003.OPEN_INDEX, {
			OnFilter = function(arg_7_0)
				local var_7_0 = arg_3_0

				var_1.OnFilter(var_7_0, arg_7_0)

				return
			end,
			defaultIndex = arg_3_0.defaultIndex
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_6, var_3_7, var_3_8, var_1_10006)
	arg_3_0:bind(var_0_1.ON_NEXT_SKIN, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_3_0

		var_2.SwitchPreviewSkin(var_8_0, arg_8_1 + 1)

		return
	end)
	arg_3_0:bind(var_0_1.ON_PREV_SKIN, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_3_0

		var_2.SwitchPreviewSkin(var_9_0, arg_9_1 - 1)

		return
	end)

	function arg_3_0.scrollrect.onInitItem(arg_10_0)
		local var_10_0 = arg_3_0

		var_1.OnInitItem(var_10_0, arg_10_0)

		return
	end

	local var_3_9 = arg_3_0.scrollrect

	function var_3_9.onUpdateItem(arg_11_0, arg_11_1)
		local var_11_0 = arg_3_0

		var_2.OnUpdateItem(var_11_0, arg_11_0, arg_11_1)

		return
	end

	onInputChanged = var_3_9

	var_3_9(arg_3_0, arg_3_0.inptuTr, function()
		local var_12_0 = arg_3_0

		var_0.OnSearch(var_12_0)

		return
	end)
	arg_3_0:InitSkinPages()

	return
end

function var_0_1.SwitchPreviewSkin(arg_13_0, arg_13_1)
	if arg_13_0.displays and arg_13_0.displays[arg_13_1] then
		local var_13_0 = arg_13_0.displays[arg_13_1]
		local var_13_1 = arg_13_0.previewPage

		var_3.ExecuteAction(var_13_1, "Flush", var_13_0, arg_13_1)
	end

	return
end

local function var_0_2(arg_14_0)
	pg = var_1_10001

	local var_14_0 = var_1_10001.skin_page_template
	local var_14_1 = arg_14_0
	local var_14_2 = arg_14_0.GetID(var_14_1) == var_0_1.PAGE_ALL and "text_all" or "text_" .. var_14_0[var_2].res

	LoadSpriteAtlasAsync = var_14_1

	var_14_1("SkinClassified", var_14_2 .. "01", function(arg_15_0)
		local var_15_0 = arg_14_0._tr
		local var_15_1 = var_1.Find(var_15_0, "name")
		local var_15_2 = var_1.GetComponent

		typeof = var_4
		Image = var_2_10006

		local var_15_3 = var_15_2(var_15_1, var_4(var_2_10006))

		var_15_3.sprite = arg_15_0

		var_15_3:SetNativeSize()

		return
	end)

	LoadSpriteAtlasAsync = var_14_1

	var_14_1("SkinClassified", var_14_2, function(arg_16_0)
		local var_16_0 = arg_14_0._tr
		local var_16_1 = var_1.Find(var_16_0, "selected/Image")
		local var_16_2 = var_1.GetComponent

		typeof = var_4
		Image = var_2_10006

		local var_16_3 = var_16_2(var_16_1, var_4(var_2_10006))

		var_16_3.sprite = arg_16_0

		var_16_3:SetNativeSize()

		return
	end)

	setText = var_14_1

	local var_14_3 = arg_14_0._tr

	var_14_1(var_6.Find(var_14_3, "eng"), var_2 == var_0_1.PAGE_ALL and "ALL" or var_14_0[var_2].english_name)

	return
end

function var_0_1.InitSkinPages(arg_17_0, arg_17_1)
	Clone = var_1_10002
	pg = var_1_10004

	local var_17_0 = var_1_10002(var_1_10004.skin_page_template.all)

	table = var_1_10003

	var_1_10003.insert(var_17_0, 1, var_0_1.PAGE_ALL)

	arg_17_0.canvasGroup.blocksRaycasts = false

	local var_17_1 = {}

	ipairs = var_4

	for iter_17_0, iter_17_1 in var_4(var_17_0) do
		table = var_1_10009

		var_1_10009.insert(var_17_1, function(arg_18_0)
			local var_18_0 = arg_17_0.rollingCircleRect
			local var_18_1 = var_1.AddItem(var_18_0, iter_17_1)

			var_0_2(var_18_1)

			if (iter_17_0 - 1) % 3 == 0 or iter_17_0 == #var_17_0 then
				onNextTick = var_2

				var_2(arg_18_0)
			else
				arg_18_0()
			end

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_17_1, function()
		setActive = var_2_10000

		var_2_10000(arg_17_0.scrollrect.gameObject, true)

		local var_19_0 = arg_17_0.rollingCircleRect

		var_0.ScrollTo(var_19_0, var_0_1.PAGE_ALL)

		arg_17_0.canvasGroup.blocksRaycasts = true

		return
	end)

	return
end

function var_0_1.OnSelectSkinPage(arg_20_0, arg_20_1)
	if arg_20_0.selectedSkinPageItem then
		setActive = var_2

		local var_20_0 = arg_20_0.selectedSkinPageItem._tr

		var_2(var_4.Find(var_20_0, "selected"), false)

		setActive = var_2

		local var_20_1 = arg_20_0.selectedSkinPageItem._tr

		var_2(var_4.Find(var_20_1, "name"), true)
	end

	setActive = var_2

	local var_20_2 = arg_20_1._tr

	var_2(var_4.Find(var_20_2, "selected"), true)

	setActive = var_2

	local var_20_3 = arg_20_1._tr

	var_2(var_4.Find(var_20_3, "name"), false)

	arg_20_0.selectedSkinPageItem = arg_20_1

	return
end

function var_0_1.OnConfirmSkinPage(arg_21_0, arg_21_1)
	arg_21_0.skinPageID = arg_21_1:GetID()

	arg_21_0:UpdateSkinCards()

	return
end

function var_0_1.OnSearch(arg_22_0)
	arg_22_0:UpdateSkinCards()

	return
end

function var_0_1.OnFilter(arg_23_0, arg_23_1)
	arg_23_0.defaultIndex = {
		typeIndex = arg_23_1.typeIndex,
		campIndex = arg_23_1.campIndex,
		rarityIndex = arg_23_1.rarityIndex,
		extraIndex = arg_23_1.extraIndex
	}

	arg_23_0:UpdateSkinCards()

	setActive = var_2

	local var_23_0 = arg_23_0.indexBtnSel
	local var_23_1 = arg_23_1.typeIndex

	ShipIndexConst = var_1_10006

	local var_23_5

	if var_23_1 == var_1_10006.TypeAll then
		local var_23_2 = arg_23_1.campIndex

		ShipIndexConst = var_6

		if var_23_2 == var_6.CampAll then
			local var_23_3 = arg_23_1.rarityIndex

			ShipIndexConst = var_6

			if var_23_3 == var_6.RarityAll then
				local var_23_4 = arg_23_1.extraIndex

				SkinAtlasIndexLayer = var_6

				if var_23_4 == var_6.ExtraALL then
					var_23_5 = false

					goto label_23_0
				end
			end
		end
	end

	var_23_5 = true

	::label_23_0::

	var_2(var_23_0, var_23_5)

	return
end

function var_0_1.ToVShip(arg_24_0, arg_24_1)
	if not arg_24_0.vship then
		arg_24_0.vship = {}

		function arg_24_0.vship.getNation()
			return arg_24_0.vship.config.nationality
		end

		function arg_24_0.vship.getShipType()
			return arg_24_0.vship.config.type
		end

		function arg_24_0.vship.getTeamType()
			ShipType = var_2_10000

			return var_2_10000.GetTeamFromShipType(arg_24_0.vship.config.type)
		end

		function arg_24_0.vship.getRarity()
			return arg_24_0.vship.config.rarity
		end
	end

	arg_24_0.vship.config = arg_24_1

	return arg_24_0.vship
end

function var_0_1.MatchIndex(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1

	if not arg_29_1.GetDefaultShipConfig(var_29_0) then
		return false
	end

	local var_29_1 = arg_29_0
	local var_29_2 = arg_29_0.ToVShip(var_29_1, var_2)

	ShipIndexConst = var_29_0

	local var_29_3 = var_29_0.filterByType(var_29_2, arg_29_0.defaultIndex.typeIndex)

	ShipIndexConst = var_29_1

	local var_29_4 = var_29_1.filterByCamp(var_29_2, arg_29_0.defaultIndex.campIndex)

	ShipIndexConst = var_6

	local var_29_5 = var_6.filterByRarity(var_29_2, arg_29_0.defaultIndex.rarityIndex)

	SkinAtlasIndexLayer = var_7

	local var_29_6 = var_7.filterByExtra(arg_29_1, arg_29_0.defaultIndex.extraIndex)

	return var_29_3 and var_29_4 and var_29_5 and var_29_6
end

function var_0_1.GetSkinList(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = {}

	getProxy = var_1_10004
	ShipSkinProxy = var_1_10006

	local var_30_1 = var_1_10004(var_1_10006)
	local var_30_2 = var_4.GetOwnSkins(var_30_1)

	pairs = var_1_10005

	for iter_30_0, iter_30_1 in var_1_10005(var_30_2) do
		if (arg_30_1 == var_0_1.PAGE_ALL or iter_30_1:IsType(arg_30_1)) and not iter_30_1:IsDefault() and iter_30_1:IsMatchKey(arg_30_2) and arg_30_0:MatchIndex(iter_30_1) and iter_30_1:MatchChangeSkinMain() then
			table = var_10

			var_10.insert(var_30_0, iter_30_1)
		end
	end

	return var_30_0
end

function var_0_1.UpdateSkinCards(arg_31_0)
	local var_31_0 = arg_31_0.skinPageID

	getInputText = var_1_10002

	local var_31_1 = var_1_10002(arg_31_0.inptuTr)

	arg_31_0.displays = arg_31_0:GetSkinList(var_31_0, var_31_1)

	arg_31_0:SortDisplay(arg_31_0.displays)

	local var_31_2 = arg_31_0.scrollrect

	var_3.SetTotalCount(var_31_2, #arg_31_0.displays)

	setActive = var_3

	var_3(arg_31_0.emptyTr, #arg_31_0.displays == 0)

	return
end

function var_0_1.SortDisplay(arg_32_0, arg_32_1)
	table = var_1_10002

	var_1_10002.sort(arg_32_1, function(arg_33_0, arg_33_1)
		if arg_33_0:getConfig("ship_group") == arg_33_1:getConfig("ship_group") then
			return arg_33_0:getConfig("group_index") < arg_33_1:getConfig("group_index")
		else
			return var_2 < var_3
		end

		return
	end)

	return
end

function var_0_1.OnInitItem(arg_34_0, arg_34_1)
	SkinAtlasCard = var_1_10002

	local var_34_0 = var_1_10002.New(arg_34_1)

	onButton = var_1_10003

	local var_34_1 = arg_34_0
	local var_34_2 = var_34_0._tf

	local function var_34_3()
		local var_35_0 = arg_34_0.previewPage

		var_0.ExecuteAction(var_35_0, "Show", var_34_0.skin, var_34_0.index)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_34_1, var_34_2, var_34_3, var_1_10008)

	onButton = var_1_10003

	local var_34_4 = arg_34_0
	local var_34_5 = var_34_0.changeSkinUI

	local function var_34_6()
		local var_36_0 = var_34_0

		var_0.changeSkinNext(var_36_0)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_34_4, var_34_5, var_34_6, var_1_10008)

	arg_34_0.cards[arg_34_1] = var_34_0

	return
end

function var_0_1.OnUpdateItem(arg_37_0, arg_37_1, arg_37_2)
	if not arg_37_0.cards[arg_37_2] then
		arg_37_0:OnInitItem(arg_37_2)
	end

	local var_37_0 = arg_37_0.cards[arg_37_2]

	var_3.Update(var_37_0, arg_37_0.displays[arg_37_1 + 1], arg_37_1 + 1)

	return
end

function var_0_1.onBackPressed(arg_38_0)
	if arg_38_0.previewPage then
		local var_38_0 = arg_38_0.previewPage

		if var_1.GetLoaded(var_38_0) then
			local var_38_1 = arg_38_0.previewPage

			if var_1.isShowing(var_38_1) then
				local var_38_2 = arg_38_0.previewPage

				if var_1.IsShowSelectShipView(var_38_2) then
					local var_38_3 = arg_38_0.previewPage

					var_1.CloseSelectShipView(var_38_3)

					return
				end

				local var_38_4 = arg_38_0.previewPage

				var_1.Hide(var_38_4)

				return
			end
		end
	end

	var_0_1.super.onBackPressed(arg_38_0)

	return
end

function var_0_1.willExit(arg_39_0)
	pairs = var_1_10001

	for iter_39_0, iter_39_1 in var_1_10001(arg_39_0.cards) do
		iter_39_1:Dispose()
	end

	arg_39_0.cards = nil

	if arg_39_0.rollingCircleRect then
		local var_39_0 = arg_39_0.rollingCircleRect

		var_1.Dispose(var_39_0)

		arg_39_0.rollingCircleRect = nil
	end

	if arg_39_0.previewPage then
		local var_39_1 = arg_39_0.previewPage

		var_1.Destroy(var_39_1)

		arg_39_0.previewPage = nil
	end

	return
end

return var_0_1
