class = var_0_10000

local var_0_0 = "PrayPoolSelectShipView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseSubView"))

var_0_1.WIDTH_MIN = 328
var_0_1.WIDTH_MAX = 438
var_0_1.FONT_SIZE_MIN = 55
var_0_1.FONT_SIZE_MID = 44
var_0_1.FONT_SIZE_MAX = 34

function var_0_1.getUIName(arg_1_0)
	return "PrayPoolSelectShipView"
end

local var_0_2 = {}

ShipIndexConst = var_2
var_0_2.typeIndex = var_2.TypeAll
ShipIndexConst = var_2
var_0_2.campIndex = var_2.CampAll
ShipIndexConst = var_2
var_0_2.rarityIndex = var_2.RarityAll
var_0_1.ShipIndex = var_0_2

local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = {
	blueSeleted = true
}

CustomIndexLayer = var_0_10004
var_0_5.mode = var_0_10004.Mode.AND
ShipIndexConst = var_4
var_0_5.options = var_4.TypeIndexs
ShipIndexConst = var_4
var_0_5.names = var_4.TypeNames
var_0_4.typeIndex = var_0_5

local var_0_6 = {
	blueSeleted = true
}

CustomIndexLayer = var_4
var_0_6.mode = var_4.Mode.AND
ShipIndexConst = var_4
var_0_6.options = var_4.CampIndexs
ShipIndexConst = var_4
var_0_6.names = var_4.CampNames
var_0_4.campIndex = var_0_6

local var_0_7 = {
	blueSeleted = true
}

CustomIndexLayer = var_4
var_0_7.mode = var_4.Mode.AND
ShipIndexConst = var_4
var_0_7.options = var_4.RarityIndexs
ShipIndexConst = var_4
var_0_7.names = var_4.RarityNames
var_0_4.rarityIndex = var_0_7
var_0_3.customPanels = var_0_4
var_0_3.groupList = {
	{
		dropdown = false,
		titleENTxt = "indexsort_indexeng",
		titleTxt = "indexsort_index",
		tags = {
			"typeIndex"
		}
	},
	{
		dropdown = false,
		titleENTxt = "indexsort_campeng",
		titleTxt = "indexsort_camp",
		tags = {
			"campIndex"
		}
	},
	{
		dropdown = false,
		titleENTxt = "indexsort_rarityeng",
		titleTxt = "indexsort_rarity",
		tags = {
			"rarityIndex"
		}
	}
}
var_0_1.ShipIndexData = var_0_3

function var_0_1.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:updateUI()
	arg_2_0:Show()

	return
end

function var_0_1.OnDestroy(arg_3_0)
	return
end

function var_0_1.OnBackPress(arg_4_0)
	return
end

function var_0_1.initData(arg_5_0)
	getProxy = var_1_10001
	PrayProxy = var_1_10002
	arg_5_0.prayProxy = var_1_10001(var_1_10002)

	local var_5_0 = arg_5_0.prayProxy

	arg_5_0.poolType = var_1.getSelectedPoolType(var_5_0)

	local var_5_1 = arg_5_0.prayProxy

	arg_5_0.selectedCount = var_1.getSelectedShipCount(var_5_1)
	pg = var_1
	arg_5_0.pickUpNum = var_1.activity_ship_create[arg_5_0.poolType].pickup_num
	Clone = var_1
	pg = var_2
	arg_5_0.fliteList = var_1(var_2.activity_ship_create[arg_5_0.poolType].pickup_list)

	arg_5_0:orderIDListByRarity(arg_5_0.fliteList)

	Clone = var_1
	arg_5_0.orderFullList = var_1(arg_5_0.fliteList)

	return
end

function var_0_1.initUI(arg_6_0)
	arg_6_0.minRaritySpriteMap = {}
	arg_6_0.maxRaritySpriteMap = {}
	arg_6_0.ratioSpriteMap = {}

	local var_6_0 = arg_6_0._tf
	local var_6_1 = var_1.Find(var_6_0, "MiniRarity")
	local var_6_2 = arg_6_0._tf
	local var_6_3 = var_2.Find(var_6_2, "MaxRarity")
	local var_6_4 = arg_6_0._tf
	local var_6_5 = var_3.Find(var_6_4, "Ratio")

	for iter_6_0 = 2, 6 do
		getImageSprite = var_1_10008

		local var_6_6 = var_6_1

		var_1_10009 = var_6_1.Find
		tostring = var_1_10011
		var_1_10008 = var_1_10008(var_1_10009(var_6_6, var_1_10011(iter_6_0)))
		getImageSprite = var_1_10009
		var_1_10011 = var_6_3

		local var_6_7 = var_6_3.Find

		tostring = var_1_10012
		var_1_10009 = var_1_10009(var_6_7(var_1_10011, var_1_10012(iter_6_0)))
		getImageSprite = var_10
		var_1_10012 = var_6_5
		var_1_10011 = var_6_5.Find
		tostring = var_13

		local var_6_8 = var_10(var_1_10011(var_1_10012, var_13(iter_6_0)))

		var_1_10011 = arg_6_0.minRaritySpriteMap
		var_1_10011[iter_6_0] = var_1_10008
		var_1_10011 = arg_6_0.maxRaritySpriteMap
		var_1_10011[iter_6_0] = var_1_10009
		var_1_10011 = arg_6_0.ratioSpriteMap
		var_1_10011[iter_6_0] = var_6_8
	end

	arg_6_0.poolSpriteMap = {}

	local var_6_9 = arg_6_0._tf
	local var_6_10 = var_4.Find(var_6_9, "Pool")

	for iter_6_1 = 1, 3 do
		getImageSprite = var_1_10009

		local var_6_11 = var_6_10
		local var_6_12 = var_6_10.Find

		tostring = var_1_10012
		var_1_10009 = var_1_10009(var_6_12(var_6_11, var_1_10012(iter_6_1)))
		arg_6_0.poolSpriteMap[iter_6_1] = var_1_10009
	end

	local var_6_13 = arg_6_0._tf

	arg_6_0.poolNameImg = var_5.Find(var_6_13, "PoolNameImg")

	local var_6_14 = arg_6_0._tf

	arg_6_0.shipCardTpl = var_5.Find(var_6_14, "ShipCardTpl")

	local var_6_15 = arg_6_0._tf
	local var_6_16 = var_5.Find(var_6_15, "SelectedShipMax")
	local var_6_17 = var_5.Find(var_6_16, "Light")
	local var_6_18 = var_5:Find("Ship1")
	local var_6_19 = var_5:Find("Ship2")
	local var_6_20 = arg_6_0._tf
	local var_6_21 = var_9.Find(var_6_20, "SelectedShipMini")
	local var_6_22 = var_9.Find(var_6_21, "Light")
	local var_6_23 = var_9:Find("Ship1")
	local var_6_24 = var_9:Find("Ship2")

	arg_6_0.selectedShipTFMap = {}
	arg_6_0.selectedShipTFMap.Max = {
		lightTF = var_6_17,
		var_6_18,
		var_6_19
	}
	arg_6_0.selectedShipTFMap.Min = {
		lightTF = var_6_22,
		var_6_23,
		var_6_24
	}

	local var_6_25 = arg_6_0
	local var_6_26 = arg_6_0.isMinPrefs(var_6_25)

	setActive = var_6_25

	var_6_25(var_5, not var_6_26)

	setActive = var_6_25

	var_6_25(var_9, var_6_26)

	local var_6_27 = arg_6_0._tf

	arg_6_0.shipListArea = var_14.Find(var_6_27, "ShipListArea")

	local var_6_28 = arg_6_0.shipListArea

	arg_6_0.shipListContainer = var_14.Find(var_6_28, "Viewport/Content")
	GetComponent = var_14
	arg_6_0.shipListSC = var_14(arg_6_0.shipListArea, "LScrollRect")
	setLocalPosition = var_14

	var_14(arg_6_0.shipListArea, {
		x = 0,
		y = var_6_26 and -40 or -120
	})

	local var_6_29 = arg_6_0._tf

	arg_6_0.bg2 = var_14.Find(var_6_29, "BG2")
	setLocalPosition = var_14

	var_14(arg_6_0.bg2, {
		x = 0,
		y = var_6_26 and -62.5 or -174
	})

	local var_6_30 = arg_6_0._tf

	arg_6_0.indexBtn = var_14.Find(var_6_30, "IndexBtn")

	local var_6_31 = arg_6_0._tf

	arg_6_0.preBtn = var_14.Find(var_6_31, "PreBtn")

	local var_6_32 = arg_6_0._tf

	arg_6_0.nextBtn = var_14.Find(var_6_32, "NextBtn")
	GetComponent = var_14
	arg_6_0.nextBtnCom = var_14(arg_6_0.nextBtn, "Button")

	local var_6_33 = arg_6_0.indexBtn
	local var_6_34 = var_14.GetComponent

	typeof = var_16
	Image = var_17

	local var_6_35 = var_6_34(var_6_33, var_16(var_17))

	var_14.SetNativeSize(var_6_35)

	ipairs = var_14

	for iter_6_2, iter_6_3 in var_14(arg_6_0.selectedShipTFMap.Max) do
		local var_6_36 = iter_6_3:Find("Tip/Tip")
		local var_6_37 = var_1_10019.GetComponent

		typeof = var_1_10022
		Image = var_1_10023

		local var_6_38 = var_6_37(var_6_36, var_1_10022(var_1_10023))

		var_20.SetNativeSize(var_6_38)
	end

	ipairs = var_14

	for iter_6_4, iter_6_5 in var_14(arg_6_0.selectedShipTFMap.Min) do
		local var_6_39 = iter_6_5:Find("Tip/Tip")
		local var_6_40 = var_1_10019.GetComponent

		typeof = var_1_10022
		Image = var_1_10023

		local var_6_41 = var_6_40(var_6_39, var_1_10022(var_1_10023))

		var_20.SetNativeSize(var_6_41)
	end

	arg_6_0.nextBtnCom.interactable = false

	local var_6_42 = arg_6_0._tf
	local var_6_43

	var_6_43, setText = var_14.Find(var_6_42, "InstructionText"), var_6_42
	i18n = iter_6_4

	var_6_42(var_6_43, iter_6_4("pray_build_select_ship_instruction"))

	onButton = var_6_42

	local var_6_44 = arg_6_0
	local var_6_45 = arg_6_0.preBtn

	local function var_6_46()
		local var_7_0 = arg_6_0.prayProxy
		local var_7_1 = var_0.updatePageState

		PrayProxy = var_2_10002

		var_7_1(var_7_0, var_2_10002.STATE_SELECT_POOL)

		local var_7_2 = arg_6_0
		local var_7_3 = var_0.emit

		PrayPoolConst = var_2

		local var_7_4 = var_2.SWITCH_TO_SELECT_POOL_PAGE

		PrayProxy = var_2_10003

		var_7_3(var_7_2, var_7_4, var_2_10003.STATE_SELECT_POOL)

		return
	end

	SFX_PANEL = var_1_10019

	var_6_42(var_6_44, var_6_45, var_6_46, var_1_10019)

	onButton = var_6_42

	local var_6_47 = arg_6_0
	local var_6_48 = arg_6_0.nextBtn

	local function var_6_49()
		pg = var_2_10000

		local var_8_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_8_1 = var_0.ShowMsgBox
		local var_8_2 = {}

		i18n = var_2_10003
		var_8_2.content = var_2_10003("warning_pray_build_pool")

		function var_8_2.onYes()
			local function var_9_0()
				local var_10_0 = arg_6_0
				local var_10_1 = var_0.emit

				PrayPoolConst = var_4_10002

				local var_10_2 = var_4_10002.CLICK_BUILD_BTN
				local var_10_3 = {}
				local var_10_4 = arg_6_0.prayProxy

				var_10_3.pooltype = var_4.getSelectedPoolType(var_10_4)

				local var_10_5 = arg_6_0.prayProxy

				var_10_3.shipIDList = var_4.getSelectedShipIDList(var_10_5)

				var_10_1(var_10_0, var_10_2, var_10_3)

				return
			end

			local var_9_1 = arg_6_0

			if not var_1.isMinPrefs(var_9_1) then
				var_9_0()
			else
				local var_9_2 = {}
				local var_9_3 = arg_6_0.prayProxy
				local var_9_4 = var_3.getSelectedShipIDList(var_9_3)

				ipairs = var_9_3

				for iter_9_0, iter_9_1 in var_9_3(var_9_4) do
					PaintingGroupConst = var_3_10009

					var_3_10009.AddPaintingNameByShipConfigID(var_9_2, iter_9_1)
				end

				local var_9_5 = {
					isShowBox = true,
					paintingNameList = var_9_2,
					finishFunc = var_9_0
				}

				PaintingGroupConst = var_5

				var_5.PaintingDownload(var_9_5)
			end

			return
		end

		var_8_1(var_8_0, var_8_2)

		return
	end

	SFX_PANEL = var_1_10019

	var_6_42(var_6_47, var_6_48, var_6_49, var_1_10019)

	onButton = var_6_42

	var_6_42(arg_6_0, arg_6_0.indexBtn, function()
		Clone = var_2_10000

		local var_11_0 = var_2_10000(var_0_1.ShipIndexData)

		Clone = var_1
		var_11_0.indexDatas = var_1(var_0_1.ShipIndex)

		function var_11_0.callback(arg_12_0)
			var_0_1.ShipIndex.typeIndex = arg_12_0.typeIndex
			var_0_1.ShipIndex.rarityIndex = arg_12_0.rarityIndex

			if arg_12_0.campIndex then
				var_0_1.ShipIndex.campIndex = arg_12_0.campIndex
			end

			local var_12_0 = arg_6_0

			var_1.fliteShipIDList(var_12_0)

			local var_12_1 = arg_6_0

			var_1.updateShipList(var_12_1, arg_6_0.fliteList)

			return
		end

		local var_11_1 = arg_6_0
		local var_11_2 = var_1.emit

		PrayPoolConst = var_2_10003

		var_11_2(var_11_1, var_2_10003.CLICK_INDEX_BTN, var_11_0)

		return
	end)

	return
end

function var_0_1.updateUI(arg_13_0)
	setImageSprite = var_1_10001

	var_1_10001(arg_13_0.poolNameImg, arg_13_0.poolSpriteMap[arg_13_0.poolType], true)
	arg_13_0:updateSelectedShipList()
	arg_13_0:updateShipList(arg_13_0.fliteList)

	return
end

function var_0_1.updateSelectedShipList(arg_14_0)
	if arg_14_0:isMinPrefs() then
		arg_14_0:updateMin()
	else
		arg_14_0:updateMax()
	end

	return
end

function var_0_1.updateMax(arg_15_0)
	local var_15_0 = arg_15_0.prayProxy
	local var_15_1 = var_1.getSelectedShipIDList(var_15_0)
	local var_15_2 = arg_15_0.selectedShipTFMap.Max

	for iter_15_0 = 1, 2 do
		local var_15_3 = var_15_1[iter_15_0]
		local var_15_4 = var_15_2[iter_15_0]
		local var_15_5 = var_8.Find(var_15_4, "Paint")
		local var_15_6 = var_8:Find("Tip")
		local var_15_7 = var_8:Find("Info")
		local var_15_8 = var_8:Find("Btn")
		local var_15_9 = var_15_7:Find("Name/Text")
		local var_15_10 = var_8:Find("RarityBG")
		local var_15_11 = var_15_7
		local var_15_12 = var_15_7.Find(var_15_11, "Ratio/NumImg")

		if var_15_3 then
			setActive = var_15_11

			var_15_11(var_15_5, true)

			setPaintingPrefabAsync = var_15_11

			local var_15_13 = var_15_5

			Ship = var_18

			var_15_11(var_15_13, var_18.getPaintingName(var_15_3), "biandui")

			if iter_15_0 == 2 then
				setLocalRotation = var_15_11

				var_15_11(var_15_5, {
					z = 180
				})
			end

			setActive = var_15_11

			var_15_11(var_15_6, false)

			setActive = var_15_11

			var_15_11(var_15_7, true)

			pg = var_15_11
			var_15_11 = var_15_11.ship_data_statistics[var_15_3].name
			setText = var_17

			var_17(var_15_9, var_15_11)

			local var_15_14 = var_15_9.localPosition
			local var_15_15

			if #var_15_11 <= 6 then
				Vector2 = var_15_15
				var_15_7.sizeDelta = var_15_15(var_0_1.WIDTH_MIN, var_15_7.sizeDelta.y)
				GetComponent = var_15_15
				var_15_15 = var_15_15(var_15_9, "Text")
				var_15_15.fontSize = var_0_1.FONT_SIZE_MIN
				setAnchoredPosition = var_15_15

				var_15_15(var_15_9, {
					y = 14
				})
			elseif var_18 <= 21 then
				Vector2 = var_15_15
				var_15_7.sizeDelta = var_15_15(var_0_1.WIDTH_MAX, var_15_7.sizeDelta.y)
				GetComponent = var_15_15
				var_15_15 = var_15_15(var_15_9, "Text")
				var_15_15.fontSize = var_0_1.FONT_SIZE_MID
				setAnchoredPosition = var_15_15

				var_15_15(var_15_9, {
					y = 19
				})
			else
				Vector2 = var_15_15
				var_15_7.sizeDelta = var_15_15(var_0_1.WIDTH_MAX, var_15_7.sizeDelta.y)
				GetComponent = var_15_15
				var_15_15 = var_15_15(var_15_9, "Text")
				var_15_15.fontSize = var_0_1.FONT_SIZE_MAX
				setAnchoredPosition = var_15_15

				var_15_15(var_15_9, {
					y = 25
				})
			end

			pg = var_15_15

			local var_15_16 = var_15_15.ship_data_statistics[var_15_3].rarity

			setImageSprite = var_1_10020

			var_1_10020(var_15_12, arg_15_0.ratioSpriteMap[var_15_16], true)

			setActive = var_1_10020

			var_1_10020(var_15_10, true)

			setImageSprite = var_1_10020

			var_1_10020(var_15_10, arg_15_0.maxRaritySpriteMap[var_15_16])
		else
			setActive = var_15_11

			var_15_11(var_15_5, false)

			setActive = var_15_11

			var_15_11(var_15_6, true)

			setActive = var_15_11

			var_15_11(var_15_7, false)

			setActive = var_15_11

			var_15_11(var_15_10, false)
		end

		onButton = var_15_11

		local var_15_17 = arg_15_0
		local var_15_18 = var_15_8

		local function var_15_19()
			isActive = var_2_10000

			if var_2_10000(var_15_5) then
				local var_16_0 = arg_15_0.prayProxy

				var_0.removeSelectedShipIDList(var_16_0, var_15_3)

				arg_15_0.selectedCount = arg_15_0.selectedCount - 1

				local var_16_1 = arg_15_0

				var_0.updateSelectedShipList(var_16_1)

				local var_16_2 = arg_15_0

				var_0.updateShipList(var_16_2, arg_15_0.fliteList)
			end

			return
		end

		SFX_PANEL = var_1_10020

		var_15_11(var_15_17, var_15_18, var_15_19, var_1_10020)
	end

	local var_15_20 = var_15_2.lightTF

	if #var_15_1 == arg_15_0.pickUpNum then
		local var_15_21 = arg_15_0.nextBtnCom

		var_15_21.interactable = true
		setActive = var_15_21

		var_15_21(var_15_20, true)
	elseif #var_15_1 < arg_15_0.pickUpNum then
		local var_15_22 = arg_15_0.nextBtnCom

		var_15_22.interactable = false
		setActive = var_15_22

		var_15_22(var_15_20, false)
	end

	return
end

function var_0_1.updateMin(arg_17_0)
	local var_17_0 = arg_17_0.prayProxy
	local var_17_1 = var_1.getSelectedShipIDList(var_17_0)
	local var_17_2 = arg_17_0.selectedShipTFMap.Min

	for iter_17_0 = 1, 2 do
		local var_17_3 = var_17_1[iter_17_0]
		local var_17_4 = var_17_2[iter_17_0]
		local var_17_5 = var_8.Find(var_17_4, "Mask/Paint")
		local var_17_6 = var_8:Find("Tip")
		local var_17_7 = var_8:Find("Info")
		local var_17_8 = var_8:Find("Btn")
		local var_17_9 = var_17_7:Find("Name/Text")
		local var_17_10 = var_8:Find("Mask/RarityBG")
		local var_17_11 = var_17_7
		local var_17_12 = var_17_7.Find(var_17_11, "Ratio/NumImg")

		if var_17_3 then
			setActive = var_17_11

			var_17_11(var_17_5, true)

			setImageSprite = var_17_11

			local var_17_13 = var_17_5

			LoadSprite = var_18

			local var_17_14 = "herohrzicon/"

			Ship = var_1_10020

			var_17_11(var_17_13, var_18(var_17_14 .. var_1_10020.getPaintingName(var_17_3)))

			setActive = var_17_11

			var_17_11(var_17_6, false)

			setActive = var_17_11

			var_17_11(var_17_7, true)

			pg = var_17_11
			var_17_11 = var_17_11.ship_data_statistics[var_17_3].name
			setText = var_17

			var_17(var_17_9, var_17_11)

			local var_17_15 = var_17_9.localPosition
			local var_17_16

			if #var_17_11 <= 6 then
				Vector2 = var_17_16
				var_17_7.sizeDelta = var_17_16(var_0_1.WIDTH_MIN, var_17_7.sizeDelta.y)
				GetComponent = var_17_16
				var_17_16 = var_17_16(var_17_9, "Text")
				var_17_16.fontSize = var_0_1.FONT_SIZE_MIN
				setAnchoredPosition = var_17_16

				var_17_16(var_17_9, {
					y = 0
				})
			elseif var_18 <= 21 then
				Vector2 = var_17_16
				var_17_7.sizeDelta = var_17_16(var_0_1.WIDTH_MAX, var_17_7.sizeDelta.y)
				GetComponent = var_17_16
				var_17_16 = var_17_16(var_17_9, "Text")
				var_17_16.fontSize = var_0_1.FONT_SIZE_MID
				setAnchoredPosition = var_17_16

				var_17_16(var_17_9, {
					y = 5
				})
			else
				Vector2 = var_17_16
				var_17_7.sizeDelta = var_17_16(var_0_1.WIDTH_MAX, var_17_7.sizeDelta.y)
				GetComponent = var_17_16
				var_17_16 = var_17_16(var_17_9, "Text")
				var_17_16.fontSize = var_0_1.FONT_SIZE_MAX
				setAnchoredPosition = var_17_16

				var_17_16(var_17_9, {
					y = 11
				})
			end

			Canvas = var_17_16

			var_17_16.ForceUpdateCanvases()

			pg = var_19

			local var_17_17 = var_19.ship_data_statistics[var_17_3].rarity

			setImageSprite = var_1_10020

			var_1_10020(var_17_12, arg_17_0.ratioSpriteMap[var_17_17], true)

			setActive = var_1_10020

			var_1_10020(var_17_10, true)

			setImageSprite = var_1_10020

			var_1_10020(var_17_10, arg_17_0.minRaritySpriteMap[var_17_17])
		else
			setActive = var_17_11

			var_17_11(var_17_5, false)

			setActive = var_17_11

			var_17_11(var_17_6, true)

			setActive = var_17_11

			var_17_11(var_17_7, false)

			setActive = var_17_11

			var_17_11(var_17_10, false)
		end

		onButton = var_17_11

		local var_17_18 = arg_17_0
		local var_17_19 = var_17_8

		local function var_17_20()
			isActive = var_2_10000

			if var_2_10000(var_17_5) then
				local var_18_0 = arg_17_0.prayProxy

				var_0.removeSelectedShipIDList(var_18_0, var_17_3)

				arg_17_0.selectedCount = arg_17_0.selectedCount - 1

				local var_18_1 = arg_17_0

				var_0.updateSelectedShipList(var_18_1)

				local var_18_2 = arg_17_0

				var_0.updateShipList(var_18_2, arg_17_0.fliteList)
			end

			return
		end

		SFX_PANEL = var_1_10020

		var_17_11(var_17_18, var_17_19, var_17_20, var_1_10020)
	end

	local var_17_21 = var_17_2.lightTF

	if #var_17_1 == arg_17_0.pickUpNum then
		local var_17_22 = arg_17_0.nextBtnCom

		var_17_22.interactable = true
		setActive = var_17_22

		var_17_22(var_17_21, true)
	elseif #var_17_1 < arg_17_0.pickUpNum then
		local var_17_23 = arg_17_0.nextBtnCom

		var_17_23.interactable = false
		setActive = var_17_23

		var_17_23(var_17_21, false)
	end

	return
end

function var_0_1.updateShipList(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.prayProxy
	local var_19_1 = var_2.getSelectedShipIDList(var_19_0)

	function arg_19_0.shipListSC.onUpdateItem(arg_20_0, arg_20_1)
		local var_20_0 = arg_19_1[arg_20_0 + 1]

		tf = var_3

		local var_20_1 = var_3(arg_20_1)
		local var_20_2 = arg_20_1.Find(var_20_1, "BG/Icon")

		GetImageSpriteFromAtlasAsync = var_20_1

		local var_20_3 = "SquareIcon/"

		Ship = var_2_10006

		var_20_1(var_20_3 .. var_2_10006.getPaintingName(var_20_0), "", var_20_2)

		local var_20_4 = arg_20_1
		local var_20_5 = arg_20_1.Find(var_20_4, "BG/GroupLocked")

		pg = var_20_4

		if var_20_4.ship_data_template[var_20_0].group_type and 0 < var_6 then
			setActive = var_7

			local var_20_6 = var_20_5

			getProxy = var_2_10009
			CollectionProxy = var_2_10010

			local var_20_7 = var_2_10009(var_2_10010)

			var_7(var_20_6, not var_9.getShipGroup(var_20_7, var_6))
		else
			setActive = var_7

			var_7(var_20_5, false)
		end

		local var_20_8 = arg_20_1
		local var_20_9 = arg_20_1.Find(var_20_8, "BG/icon_bg/frame")

		pg = var_20_8

		local var_20_10 = var_20_8.ship_data_statistics[var_20_0].rarity

		ShipRarity = var_9

		local var_20_11 = var_9.Rarity2Print(var_20_10)

		setFrame = var_10

		var_10(var_20_9, var_20_11)

		setIconColorful = var_10

		var_10(arg_20_1:Find("BG"), var_20_10 - 1, {})

		local var_20_12 = arg_20_1
		local var_20_13

		var_20_13, setImageSprite = arg_20_1.Find(var_20_12, "BG"), var_20_12
		GetSpriteFromAtlas = var_13

		var_20_12(var_20_13, var_13("weaponframes", "bg" .. var_20_11))

		pg = var_20_12

		local var_20_14 = var_20_12.ship_data_statistics[var_20_0].name
		local var_20_15 = arg_20_1
		local var_20_16

		var_20_16, setText = arg_20_1.Find(var_20_15, "NameBG/NameText"), var_20_15
		shortenString = var_15

		var_20_15(var_20_16, var_15(var_20_14, 6))

		local var_20_17 = arg_20_1
		local var_20_18 = arg_20_1.Find(var_20_17, "BG/SelectedImg")

		table = var_20_17

		if var_20_17.indexof(var_19_1, var_20_0, 1) then
			SetActive = var_14

			var_14(var_20_18, true)
		else
			SetActive = var_14

			var_14(var_20_18, false)
		end

		setBlackMask = var_14
		tf = var_15

		local var_20_19 = var_15(arg_20_1)

		ShipRarity = var_16

		local var_20_21

		if var_20_10 == var_16.SSR then
			local var_20_20 = arg_19_0

			if var_20_21.isSelectedSSR(var_20_20) then
				isActive = var_20_21
				var_20_21 = not var_20_21(var_20_18)
			end
		else
			var_20_21 = false
		end

		if false then
			var_20_21 = true
		end

		local var_20_22 = {
			recursive = true
		}

		Color = var_2_10018
		var_20_22.color = var_2_10018(0, 0, 0, 0.6)

		var_14(var_20_19, var_20_21, var_20_22)

		onButton = var_14

		local var_20_23 = arg_19_0
		local var_20_24 = arg_20_1

		local function var_20_25()
			if arg_19_0.selectedCount < arg_19_0.pickUpNum then
				isActive = var_0

				local var_21_0

				if var_0(var_20_18) then
					var_21_0 = arg_19_0.prayProxy

					var_0.removeSelectedShipIDList(var_21_0, var_20_0)

					local var_21_1 = arg_19_0

					var_21_1.selectedCount = arg_19_0.selectedCount - 1
					SetActive = var_21_1

					var_21_1(var_20_18, false)

					var_21_0 = arg_19_0

					var_0.updateSelectedShipList(var_21_0)

					var_21_0 = arg_19_0

					var_0.updateShipList(var_21_0, arg_19_0.fliteList)
				else
					local var_21_2 = var_20_10

					ShipRarity = var_21_0

					if var_21_2 == var_21_0.SSR then
						local var_21_3 = arg_19_0

						if var_0.isSelectedSSR(var_21_3) then
							pg = var_0

							local var_21_4 = var_0.TipsMgr.GetInstance()
							local var_21_5 = var_0.ShowTips

							i18n = var_3_10002

							var_21_5(var_21_4, var_3_10002("pray_build_UR_warning"))

							goto label_21_0
						end
					end

					local var_21_6 = arg_19_0.prayProxy

					var_0.insertSelectedShipIDList(var_21_6, var_20_0)

					local var_21_7 = arg_19_0

					var_21_7.selectedCount = arg_19_0.selectedCount + 1
					SetActive = var_21_7

					var_21_7(var_20_18, true)

					local var_21_8 = arg_19_0

					var_0.updateSelectedShipList(var_21_8)

					local var_21_9 = arg_19_0

					var_0.updateShipList(var_21_9, arg_19_0.fliteList)
				end
			elseif arg_19_0.selectedCount == arg_19_0.pickUpNum then
				isActive = var_0

				local var_21_11

				if var_0(var_20_18) then
					local var_21_10 = arg_19_0.prayProxy

					var_21_11.removeSelectedShipIDList(var_21_10, var_20_0)

					var_21_11 = arg_19_0
					var_21_11.selectedCount = arg_19_0.selectedCount - 1
					SetActive = var_21_11

					var_21_11(var_20_18, false)

					local var_21_12 = arg_19_0

					var_21_11.updateSelectedShipList(var_21_12)

					local var_21_13 = arg_19_0

					var_21_11.updateShipList(var_21_13, arg_19_0.fliteList)
				else
					pg = var_21_11

					local var_21_14 = var_21_11.TipsMgr.GetInstance()
					local var_21_15 = var_0.ShowTips

					i18n = var_3_10002

					var_21_15(var_21_14, var_3_10002("error_pray_select_ship_max"))
				end
			end

			::label_21_0::

			return
		end

		SFX_PANEL = var_18

		var_14(var_20_23, var_20_24, var_20_25, var_18)

		return
	end

	function arg_19_0.shipListSC.onReturnItem(arg_22_0, arg_22_1)
		return
	end

	local var_19_2 = arg_19_0.shipListSC

	var_3.SetTotalCount(var_19_2, #arg_19_1)

	return
end

function var_0_1.orderIDListByRarity(arg_23_0, arg_23_1)
	getProxy = var_1_10002
	CollectionProxy = var_1_10003

	local var_23_0 = var_1_10002(var_1_10003)

	local function var_23_1(arg_24_0, arg_24_1)
		pg = var_2_10002

		local var_24_0 = var_2_10002.ship_data_statistics[arg_24_0].rarity

		pg = var_2_10003

		local var_24_1 = var_2_10003.ship_data_statistics[arg_24_1].rarity
		local var_24_2 = var_23_0
		local var_24_3 = var_4.getShipGroup

		pg = var_2_10006

		local var_24_4 = var_24_3(var_24_2, var_2_10006.ship_data_template[arg_24_0].group_type) and 1 or 0
		local var_24_5 = var_23_0
		local var_24_6 = var_5.getShipGroup

		pg = var_2_10007

		if var_24_4 == (var_24_6(var_24_5, var_2_10007.ship_data_template[arg_24_1].group_type) and 1 or 0) then
			return var_24_1 < var_24_0
		else
			return var_24_4 < var_5
		end

		return
	end

	table = var_1_10004

	var_1_10004.sort(arg_23_1, var_23_1)

	return
end

function var_0_1.fliteShipIDList(arg_25_0)
	local var_25_0 = {}
	local var_25_1 = arg_25_0.prayProxy

	if var_2.getSelectedShipIDList(var_25_1) and #var_2 > 0 then
		ipairs = var_25_1

		for iter_25_0, iter_25_1 in var_25_1(var_2) do
			table = var_1_10008

			var_1_10008.insert(var_25_0, 1, iter_25_1)
		end
	end

	ipairs = var_25_1

	for iter_25_2, iter_25_3 in var_25_1(arg_25_0.orderFullList) do
		table = var_1_10008

		if not var_1_10008.indexof(var_2, iter_25_3, 1) then
			math = var_1_10008
			var_1_10008 = var_1_10008.modf(iter_25_3 / 10)
			ShipGroup = var_9

			local var_25_2 = var_9.New({
				id = var_1_10008
			})

			ShipIndexConst = var_10

			if var_10.filterByType(var_25_2, var_0_1.ShipIndex.typeIndex) then
				ShipIndexConst = var_10

				if var_10.filterByRarity(var_25_2, var_0_1.ShipIndex.rarityIndex) then
					ShipIndexConst = var_10

					if var_10.filterByCamp(var_25_2, var_0_1.ShipIndex.campIndex) then
						var_25_0[#var_25_0 + 1] = iter_25_3
					end
				end
			end
		end
	end

	arg_25_0.fliteList = var_25_0

	return
end

function var_0_1.isMinPrefs(arg_26_0)
	GroupHelper = var_1_10001

	local var_26_0 = var_1_10001.GetGroupPrefsByName("PAINTING")

	DMFileChecker = var_2

	return var_26_0 == var_2.Prefs.Min
end

function var_0_1.isSelectedSSR(arg_27_0)
	local var_27_0 = false
	local var_27_1 = arg_27_0.prayProxy

	if var_2.getSelectedShipIDList(var_27_1) and #var_2 > 0 then
		ipairs = var_3

		for iter_27_0, iter_27_1 in var_3(var_2) do
			pg = var_1_10008
			var_1_10008 = var_1_10008.ship_data_statistics[iter_27_1].rarity
			ShipRarity = var_1_10009

			if var_1_10008 == var_1_10009.SSR then
				var_27_0 = true

				break
			end
		end
	end

	return var_27_0
end

return var_0_1
