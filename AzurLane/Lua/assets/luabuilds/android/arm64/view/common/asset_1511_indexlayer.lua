class = var_0_10000

local var_0_0 = "IndexLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "IndexUI"
end

var_0_1.panelNames = {
	{
		"indexsort_sort",
		"indexsort_sorteng"
	},
	{
		"indexsort_index",
		"indexsort_indexeng"
	},
	{
		"indexsort_camp",
		"indexsort_campeng"
	},
	{
		"indexsort_rarity",
		"indexsort_rarityeng"
	},
	{
		"indexsort_extraindex",
		"indexsort_indexeng"
	}
}

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.panel = var_1.Find(var_2_0, "index_panel")

	local var_2_1 = {}
	local var_2_2 = arg_2_0.panel

	var_2_1[1] = var_2.Find(var_2_2, "layout/sort")

	local var_2_3 = arg_2_0.panel

	var_2_1[2] = var_2.Find(var_2_3, "layout/index")

	local var_2_4 = arg_2_0.panel

	var_2_1[3] = var_2.Find(var_2_4, "layout/camp")

	local var_2_5 = arg_2_0.panel

	var_2_1[4] = var_2.Find(var_2_5, "layout/rarity")

	local var_2_6 = arg_2_0.panel

	var_2_1[5] = var_2.Find(var_2_6, "layout/extra")

	local var_2_7 = arg_2_0.panel

	var_2_1[6] = var_2.Find(var_2_7, "layout/EquipSkinSort")

	local var_2_8 = arg_2_0.panel

	var_2_1[7] = var_2.Find(var_2_8, "layout/EquipSkinIndex")

	local var_2_9 = arg_2_0.panel

	var_2_1[8] = var_2.Find(var_2_9, "layout/EquipSkinTheme")
	arg_2_0.displayTFs = var_2_1
	_ = var_2_1

	var_2_1.each(arg_2_0.displayTFs, function(arg_3_0)
		setActive = var_2_10001

		var_2_10001(arg_3_0, false)

		return
	end)

	for iter_2_0 = 1, #var_0_1.panelNames do
		setText = var_5

		local var_2_10 = arg_2_0.displayTFs[iter_2_0]
		local var_2_11 = var_7.Find(var_2_10, "title1/Image")

		i18n = var_1_10008

		var_5(var_2_11, var_1_10008(var_0_1.panelNames[iter_2_0][1]))

		setText = var_5

		local var_2_12 = arg_2_0.displayTFs[iter_2_0]
		local var_2_13 = var_7.Find(var_2_12, "title1/Image_en")

		i18n = var_1_10008

		var_5(var_2_13, var_1_10008(var_0_1.panelNames[iter_2_0][2]))
	end

	arg_2_0.displayList = {}
	arg_2_0.typeList = {}

	local var_2_14 = arg_2_0.panel

	arg_2_0.btnConfirm = var_1.Find(var_2_14, "layout/btns/ok")

	local var_2_15 = arg_2_0.panel

	arg_2_0.btnCancel = var_1.Find(var_2_15, "layout/btns/cancel")

	local var_2_16 = arg_2_0.panel
	local var_2_17 = var_1.Find(var_2_16, "resource/grey")
	local var_2_18 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.greySprite = var_2_18(var_2_17, var_4(var_1_10006)).sprite

	local var_2_19 = arg_2_0.panel
	local var_2_20 = var_1.Find(var_2_19, "resource/blue")
	local var_2_21 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.blueSprite = var_2_21(var_2_20, var_4(var_1_10006)).sprite

	local var_2_22 = arg_2_0.panel
	local var_2_23 = var_1.Find(var_2_22, "resource/yellow")
	local var_2_24 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.yellowSprite = var_2_24(var_2_23, var_4(var_1_10006)).sprite

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.btnConfirm

	local function var_4_2()
		if arg_4_0.contextData.callback then
			local var_5_0 = arg_4_0.contextData.callback
			local var_5_1 = {}

			Clone = var_2_10003
			var_5_1.sort = var_2_10003(arg_4_0.contextData.sort)
			Clone = var_3
			var_5_1.index = var_3(arg_4_0.contextData.index)
			Clone = var_3
			var_5_1.camp = var_3(arg_4_0.contextData.camp)
			Clone = var_3
			var_5_1.rarity = var_3(arg_4_0.contextData.rarity)
			Clone = var_3
			var_5_1.extra = var_3(arg_4_0.contextData.extra)
			Clone = var_3
			var_5_1.equipSkinSort = var_3(arg_4_0.contextData.equipSkinSort)
			Clone = var_3
			var_5_1.equipSkinIndex = var_3(arg_4_0.contextData.equipSkinIndex)
			Clone = var_3
			var_5_1.equipSkinTheme = var_3(arg_4_0.contextData.equipSkinTheme)

			var_5_0(var_5_1)

			arg_4_0.contextData.callback = nil
		end

		local var_5_2 = arg_4_0

		var_0.emit(var_5_2, var_0_1.ON_CLOSE)

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10006)

	onButton = var_1_10001

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.btnCancel

	local function var_4_5()
		local var_6_0 = arg_4_0

		var_0.emit(var_6_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_4_3, var_4_4, var_4_5, var_1_10006)

	onButton = var_1_10001

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0.panel
	local var_4_8 = var_4.Find(var_4_7, "btn")

	local function var_4_9()
		local var_7_0 = arg_4_0

		var_0.emit(var_7_0, var_0_1.ON_CLOSE)

		return
	end

	SFX_CANCEL = var_4_7

	var_1_10001(var_4_6, var_4_8, var_4_9, var_4_7)

	local var_4_10 = arg_4_0.panel

	Vector3 = var_1_10002
	var_4_10.localScale = var_1_10002.zero
	LeanTween = var_4_10

	local var_4_11 = var_4_10.scale
	local var_4_12 = arg_4_0.panel

	Vector3 = var_4_8

	var_4_11(var_4_12, var_4_8(1, 1, 1), 0.2)
	arg_4_0:initDisplays()

	pg = var_1

	local var_4_13 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_4_13, arg_4_0._tf)

	return
end

function var_0_1.initDisplays(arg_8_0)
	local var_8_0 = {
		"sort",
		"index",
		"camp",
		"rarity",
		"extra",
		"equipSkinSort",
		"equipSkinIndex",
		"equipSkinTheme"
	}

	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.displayTFs) do
		tobool = var_1_10007
		var_1_10007 = var_1_10007(arg_8_0.contextData.display[var_8_0[iter_8_0]])
		setActive = var_1_10008

		var_1_10008(iter_8_1, var_1_10007)

		if var_1_10007 then
			IndexConst = var_1_10008

			if iter_8_0 == var_1_10008.DisplayEquipSkinSort then
				arg_8_0:initEquipSkinSort()
				arg_8_0:updateEquipSkinSort()
			else
				IndexConst = var_1_10008

				if iter_8_0 == var_1_10008.DisplayEquipSkinIndex then
					arg_8_0:initEquipSkinIndex()
					arg_8_0:updateEquipSkinIndex()
				else
					IndexConst = var_1_10008

					if iter_8_0 == var_1_10008.DisplayEquipSkinTheme then
						arg_8_0:initEquipSkinTheme()
						arg_8_0:updateEquipSkinTheme()
					end
				end
			end
		end
	end

	return
end

function var_0_1.initEquipSkinSort(arg_9_0)
	local var_9_0 = {}

	_ = var_1_10002

	local var_9_1 = var_1_10002.each

	IndexConst = var_1_10004

	var_9_1(var_1_10004.EquipSkinSortTypes, function(arg_10_0)
		bit = var_2_10001

		local var_10_0 = var_2_10001.lshift(1, arg_10_0)

		bit = var_2_10002

		if var_2_10002.band(arg_9_0.contextData.display.equipSkinSort, var_10_0) > 0 then
			table = var_2

			var_2.insert(var_9_0, arg_10_0)
		end

		return
	end)

	local var_9_2 = arg_9_0.typeList

	IndexConst = var_1_10003
	var_9_2[var_1_10003.DisplayEquipSkinSort] = var_9_0

	local var_9_3 = arg_9_0.displayTFs

	IndexConst = var_3

	local var_9_4 = var_9_3[var_3.DisplayEquipSkinSort]

	UIItemList = var_3

	local var_9_5 = var_3.New(var_9_4:Find("panel"), var_9_4:Find("panel/tpl"))

	var_3.make(var_9_5, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = var_9_0[arg_11_1 + 1]

			table = var_4

			local var_11_1 = var_4.indexof

			IndexConst = var_2_10006

			local var_11_2 = var_11_1(var_2_10006.EquipSkinSortTypes, var_11_0)

			IndexConst = var_2_10005

			local var_11_3 = var_2_10005.EquipSkinSortNames[var_11_2]

			findTF = var_6

			local var_11_4 = var_6(arg_11_2, "Image")

			setText = var_7

			var_7(var_11_4, var_11_3)

			setImageSprite = var_7

			var_7(arg_11_2, arg_9_0.greySprite)

			GetOrAddComponent = var_7

			local var_11_5 = arg_11_2

			typeof = var_10
			Button = var_2_10012

			var_7(var_11_5, var_10(var_2_10012))

			onButton = var_7

			local var_11_6 = arg_9_0
			local var_11_7 = arg_11_2

			local function var_11_8()
				arg_9_0.contextData.equipSkinSort = var_11_0

				local var_12_0 = arg_9_0

				var_0.updateEquipSkinSort(var_12_0)

				return
			end

			SFX_UI_TAG = var_2_10012

			var_7(var_11_6, var_11_7, var_11_8, var_2_10012)
		end

		return
	end)
	var_3:align(#var_9_0)

	local var_9_6 = arg_9_0.displayList

	IndexConst = var_5
	var_9_6[var_5.DisplayEquipSkinSort] = var_3

	return
end

function var_0_1.updateEquipSkinSort(arg_13_0)
	local var_13_0 = arg_13_0.displayList

	IndexConst = var_1_10002

	local var_13_1 = var_13_0[var_1_10002.DisplayEquipSkinSort]
	local var_13_2 = arg_13_0.typeList

	IndexConst = var_1_10003

	local var_13_3 = var_13_2[var_1_10003.DisplayEquipSkinSort]

	var_13_1:each(function(arg_14_0, arg_14_1)
		local var_14_0 = arg_13_0.contextData.equipSkinSort == var_13_3[arg_14_0 + 1]

		findTF = var_3

		local var_14_1 = var_3(arg_14_1, "Image")

		setImageSprite = var_4

		local var_14_2 = arg_14_1
		local var_14_3

		if not var_14_0 or not arg_13_0.yellowSprite then
			var_14_3 = arg_13_0.greySprite
		end

		var_4(var_14_2, var_14_3)

		return
	end)

	return
end

function var_0_1.initEquipSkinIndex(arg_15_0)
	local var_15_0 = {}

	_ = var_1_10002

	local var_15_1 = var_1_10002.each

	IndexConst = var_1_10004

	var_15_1(var_1_10004.EquipSkinIndexTypes, function(arg_16_0)
		bit = var_2_10001

		local var_16_0 = var_2_10001.lshift(1, arg_16_0)

		bit = var_2_10002

		if var_2_10002.band(arg_15_0.contextData.display.equipSkinIndex, var_16_0) > 0 then
			table = var_2

			var_2.insert(var_15_0, arg_16_0)
		end

		return
	end)

	local var_15_2 = arg_15_0.typeList

	IndexConst = var_1_10003
	var_15_2[var_1_10003.DisplayEquipSkinIndex] = var_15_0

	local var_15_3 = arg_15_0.displayTFs

	IndexConst = var_3

	local var_15_4 = var_15_3[var_3.DisplayEquipSkinIndex]

	UIItemList = var_3

	local var_15_5 = var_3.New(var_15_4:Find("panel"), var_15_4:Find("panel/tpl"))

	var_3.make(var_15_5, function(arg_17_0, arg_17_1, arg_17_2)
		UIItemList = var_2_10003

		if arg_17_0 == var_2_10003.EventUpdate then
			local var_17_0 = var_15_0[arg_17_1 + 1]

			table = var_4

			local var_17_1 = var_4.indexof

			IndexConst = var_2_10006

			local var_17_2 = var_17_1(var_2_10006.EquipSkinIndexTypes, var_17_0)

			IndexConst = var_2_10005

			local var_17_3 = var_2_10005.EquipSkinIndexNames[var_17_2]

			findTF = var_6

			local var_17_4 = var_6(arg_17_2, "Image")

			setText = var_7

			var_7(var_17_4, var_17_3)

			setImageSprite = var_7

			var_7(arg_17_2, arg_15_0.greySprite)

			GetOrAddComponent = var_7

			local var_17_5 = arg_17_2

			typeof = var_10
			Button = var_2_10012

			var_7(var_17_5, var_10(var_2_10012))

			onButton = var_7

			local var_17_6 = arg_15_0
			local var_17_7 = arg_17_2

			local function var_17_8()
				local var_18_0 = arg_15_0.contextData

				IndexConst = var_3_10001

				local var_18_1 = var_3_10001.ToggleBits
				local var_18_2 = arg_15_0.contextData.equipSkinIndex
				local var_18_3 = var_15_0

				IndexConst = var_3_10005
				var_18_0.equipSkinIndex = var_18_1(var_18_2, var_18_3, var_3_10005.EquipSkinIndexAll, var_17_0)

				local var_18_4 = arg_15_0

				var_0.updateEquipSkinIndex(var_18_4)

				return
			end

			SFX_UI_TAG = var_2_10012

			var_7(var_17_6, var_17_7, var_17_8, var_2_10012)
		end

		return
	end)
	var_3:align(#var_15_0)

	local var_15_6 = arg_15_0.displayList

	IndexConst = var_5
	var_15_6[var_5.DisplayEquipSkinIndex] = var_3

	return
end

function var_0_1.updateEquipSkinIndex(arg_19_0)
	local var_19_0 = arg_19_0.displayList

	IndexConst = var_1_10002

	local var_19_1 = var_19_0[var_1_10002.DisplayEquipSkinIndex]
	local var_19_2 = arg_19_0.typeList

	IndexConst = var_1_10003

	local var_19_3 = var_19_2[var_1_10003.DisplayEquipSkinIndex]

	var_19_1:each(function(arg_20_0, arg_20_1)
		local var_20_0 = var_19_3[arg_20_0 + 1]

		bit = var_3

		local var_20_1 = var_3.band
		local var_20_2 = arg_19_0.contextData.equipSkinIndex

		bit = var_2_10006

		local var_20_3 = var_20_1(var_20_2, var_2_10006.lshift(1, var_20_0))
		local var_20_4 = 0 < var_20_3

		findTF = var_4

		local var_20_5 = var_4(arg_20_1, "Image")

		setImageSprite = var_20_2

		local var_20_6 = arg_20_1
		local var_20_7

		if not var_20_4 or not arg_19_0.yellowSprite then
			var_20_7 = arg_19_0.greySprite
		end

		var_20_2(var_20_6, var_20_7)

		return
	end)

	return
end

function var_0_1.initEquipSkinTheme(arg_21_0)
	local var_21_0 = {}

	_ = var_1_10002

	local var_21_1 = var_1_10002.each

	IndexConst = var_1_10004

	var_21_1(var_1_10004.EquipSkinThemeTypes, function(arg_22_0)
		IndexConst = var_2_10001

		local var_22_0 = var_2_10001.StrLShift("1", arg_22_0)

		string = var_2_10002

		local var_22_1 = var_2_10002.find

		IndexConst = var_4

		if var_22_1(var_4.StrAnd(arg_21_0.contextData.display.equipSkinTheme, var_22_0), "1") ~= nil then
			table = var_2

			var_2.insert(var_21_0, arg_22_0)
		end

		return
	end)

	local var_21_2 = arg_21_0.typeList

	IndexConst = var_1_10003
	var_21_2[var_1_10003.DisplayEquipSkinTheme] = var_21_0

	local var_21_3 = arg_21_0.displayTFs

	IndexConst = var_3

	local var_21_4 = var_21_3[var_3.DisplayEquipSkinTheme]

	UIItemList = var_3

	local var_21_5 = var_3.New(var_21_4:Find("bg/panel"), var_21_4:Find("bg/panel/tpl"))

	var_3.make(var_21_5, function(arg_23_0, arg_23_1, arg_23_2)
		UIItemList = var_2_10003

		if arg_23_0 == var_2_10003.EventUpdate then
			local var_23_0 = var_21_0[arg_23_1 + 1]

			table = var_4

			local var_23_1 = var_4.indexof

			IndexConst = var_2_10006

			local var_23_2 = var_23_1(var_2_10006.EquipSkinThemeTypes, var_23_0)

			IndexConst = var_2_10005

			local var_23_3 = var_2_10005.EquipSkinThemeNames[var_23_2]

			findTF = var_6

			local var_23_4 = var_6(arg_23_2, "Image")

			setText = var_7

			var_7(var_23_4, var_23_3)

			setImageSprite = var_7

			var_7(arg_23_2, arg_21_0.greySprite)

			GetOrAddComponent = var_7

			local var_23_5 = arg_23_2

			typeof = var_10
			Button = var_2_10012

			var_7(var_23_5, var_10(var_2_10012))

			onButton = var_7

			local var_23_6 = arg_21_0
			local var_23_7 = arg_23_2

			local function var_23_8()
				local var_24_0 = arg_21_0.contextData

				IndexConst = var_3_10001

				local var_24_1 = var_3_10001.ToggleStr
				local var_24_2 = arg_21_0.contextData.equipSkinTheme
				local var_24_3 = var_21_0

				IndexConst = var_3_10005
				var_24_0.equipSkinTheme = var_24_1(var_24_2, var_24_3, var_3_10005.EquipSkinThemeAll, var_23_0)

				local var_24_4 = arg_21_0

				var_0.updateEquipSkinTheme(var_24_4)

				return
			end

			SFX_UI_TAG = var_2_10012

			var_7(var_23_6, var_23_7, var_23_8, var_2_10012)
		end

		return
	end)
	var_3:align(#var_21_0)

	local var_21_6 = arg_21_0.displayList

	IndexConst = var_5
	var_21_6[var_5.DisplayEquipSkinTheme] = var_3

	return
end

function var_0_1.updateEquipSkinTheme(arg_25_0)
	local var_25_0 = arg_25_0.displayList

	IndexConst = var_1_10002

	local var_25_1 = var_25_0[var_1_10002.DisplayEquipSkinTheme]
	local var_25_2 = arg_25_0.typeList

	IndexConst = var_1_10003

	local var_25_3 = var_25_2[var_1_10003.DisplayEquipSkinTheme]

	var_25_1:each(function(arg_26_0, arg_26_1)
		local var_26_0 = var_25_3[arg_26_0 + 1]

		IndexConst = var_3

		local var_26_1 = var_3.StrLShift("1", var_26_0)

		string = var_2_10004

		local var_26_2 = var_2_10004.find

		IndexConst = var_6

		local var_26_3 = var_26_2(var_6.StrAnd(arg_25_0.contextData.equipSkinTheme, var_26_1), "1") ~= nil

		findTF = var_5

		local var_26_4 = var_5(arg_26_1, "Image")

		setImageSprite = var_6

		local var_26_5 = arg_26_1
		local var_26_6

		if not var_26_3 or not arg_25_0.yellowSprite then
			var_26_6 = arg_25_0.greySprite
		end

		var_6(var_26_5, var_26_6)

		return
	end)

	return
end

function var_0_1.willExit(arg_27_0)
	LeanTween = var_1_10001

	local var_27_0 = var_1_10001.cancel

	go = var_1_10003

	var_27_0(var_1_10003(arg_27_0.panel))

	pg = var_27_0

	local var_27_1 = var_27_0.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_27_1, arg_27_0._tf)

	return
end

return var_0_1
