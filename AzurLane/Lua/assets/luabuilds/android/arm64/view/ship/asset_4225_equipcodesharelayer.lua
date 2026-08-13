class = var_0_10000

local var_0_0 = "EquipCodeShareLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "EquipCodeShareUI"
end

function var_0_1.setShipGroup(arg_2_0, arg_2_1)
	arg_2_0.shipGroup = arg_2_1
	arg_2_0.codes = arg_2_1:getEquipCodes()

	local var_2_0 = {}

	underscore = var_1_10003

	local var_2_1 = var_1_10003(arg_2_0.codes)
	local var_2_2 = var_3.chain(var_2_1)
	local var_2_3 = var_3.filter(var_2_2, function(arg_3_0)
		return arg_3_0.new == 0 and arg_3_0.state == 0
	end)
	local var_2_4 = var_3.sort

	CompareFuncs = var_6

	local var_2_5 = var_2_4(var_2_3, var_6({
		function(arg_4_0)
			return -arg_4_0.like
		end
	}))
	local var_2_6 = var_3.first(var_2_5, 12)
	local var_2_7 = var_3.each(var_2_6, function(arg_5_0)
		var_2_0[arg_5_0.id] = true

		return
	end)
	local var_2_8 = var_3.sort

	CompareFuncs = var_6

	local var_2_9 = var_2_8(var_2_7, var_6({
		function(arg_6_0)
			return -arg_6_0.evaPoint
		end
	}))

	arg_2_0.firstPool = var_3.value(var_2_9)
	underscore = var_3
	arg_2_0.oldPool = var_3.filter(arg_2_0.codes, function(arg_7_0)
		return arg_7_0.new == 0 and not var_2_0[arg_7_0.id]
	end)
	underscore = var_3
	arg_2_0.newPool = var_3.filter(arg_2_0.codes, function(arg_8_0)
		return arg_8_0.new == 1
	end)

	return
end

local function var_0_2(arg_9_0, arg_9_1, arg_9_2)
	setActive = var_1_10003

	local var_9_0 = arg_9_0:Find("IconTpl")

	tobool = var_1_10006

	var_1_10003(var_9_0, var_1_10006(arg_9_1))

	if not arg_9_1 then
		return
	end

	updateEquipment = var_1_10003

	var_1_10003(arg_9_0:Find("IconTpl"), arg_9_1)

	if not arg_9_0:Find("IconTpl/icon_bg/equip_flag") then
		return
	end

	setActive = var_3

	var_3(arg_9_0:Find("IconTpl/icon_bg/equip_flag"), arg_9_2)

	if not arg_9_2 then
		return
	end

	setImageSprite = var_3

	local var_9_1 = arg_9_0:Find("IconTpl/icon_bg/equip_flag/Image")

	LoadSprite = var_6

	var_3(var_9_1, var_6("qicon/" .. arg_9_2:getPainting()))

	return
end

local function var_0_3(arg_10_0, arg_10_1, arg_10_2)
	setActive = var_1_10003

	var_1_10003(arg_10_0:Find("Icon"), arg_10_1)

	setActive = var_1_10003

	var_1_10003(arg_10_0:Find("IconShadow"), arg_10_1)

	if not arg_10_1 then
		return
	end

	UpdateSpWeaponSlot = var_1_10003

	var_1_10003(arg_10_0, arg_10_1)

	if not arg_10_0:Find("Icon/equip_flag") then
		return
	end

	setActive = var_3

	var_3(arg_10_0:Find("Icon/equip_flag"), arg_10_2)

	if not arg_10_2 then
		return
	end

	setImageSprite = var_3

	local var_10_0 = arg_10_0:Find("Icon/equip_flag/Image")

	LoadSprite = var_6

	var_3(var_10_0, var_6("qicon/" .. arg_10_2:getPainting()))

	return
end

local var_0_4 = {}
local var_0_5 = {
	minHeight = 650
}
local var_0_6 = {}

CustomIndexLayer = var_0_10006
var_0_6.mode = var_0_10006.Mode.AND
IndexConst = var_6
var_0_6.options = var_6.ECodeLabelIndexs
IndexConst = var_6
var_0_6.names = var_6.ECodeLabelNames
var_0_5.labelIndex = var_0_6
var_0_4.customPanels = var_0_5
var_0_4.groupList = {
	{
		dropdown = false,
		titleENTxt = "indexsort_labeleng",
		titleTxt = "indexsort_label",
		tags = {
			"labelIndex"
		}
	}
}

function var_0_1.init(arg_11_0)
	onButton = var_1_10001

	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0._tf
	local var_11_2 = var_4.Find(var_11_1, "BG")

	local function var_11_3()
		local var_12_0 = arg_11_0

		var_0.closeView(var_12_0)

		return
	end

	SFX_CANCEL = var_11_1

	var_1_10001(var_11_0, var_11_2, var_11_3, var_11_1)

	local var_11_4 = arg_11_0._tf

	arg_11_0.rtMainPanel = var_1.Find(var_11_4, "mainPanel")
	onButton = var_1

	local var_11_5 = arg_11_0
	local var_11_6 = arg_11_0.rtMainPanel
	local var_11_7 = var_4.Find(var_11_6, "top_panel/btnBack")

	local function var_11_8()
		local var_13_0 = arg_11_0

		var_0.closeView(var_13_0)

		return
	end

	SFX_CANCEL = var_11_6

	var_1(var_11_5, var_11_7, var_11_8, var_11_6)

	local var_11_9

	if not arg_11_0.indexData then
		var_11_9 = {}
	end

	arg_11_0.indexData = var_11_9

	local var_11_10 = arg_11_0.rtMainPanel
	local var_11_11 = var_1.Find(var_11_10, "top_panel/btn_filter")

	onButton = var_1_10002

	local var_11_12 = arg_11_0
	local var_11_13 = var_11_11

	local function var_11_14()
		local var_14_0 = arg_11_0
		local var_14_1 = var_0.emit

		EquipCodeShareMediator = var_2_10003

		local var_14_2 = var_2_10003.OPEN_TAG_INDEX

		setmetatable = var_2_10004

		local var_14_3 = {}

		Clone = var_2_10007
		var_14_3.indexDatas = var_2_10007(arg_11_0.indexData)

		function var_14_3.callback(arg_15_0)
			arg_11_0.indexData.labelIndex = arg_15_0.labelIndex

			local var_15_0 = arg_11_0
			local var_15_1 = var_1.isDefaultFilter(var_15_0)

			setImageAlpha = var_2

			var_2(var_11_11, var_15_1 and 1 or 0)

			setActive = var_2

			local var_15_2 = var_11_11

			var_2(var_4.Find(var_15_2, "on"), not var_15_1)

			arg_11_0.refreshCount = 0

			local var_15_3 = arg_11_0

			var_2.refreshCodes(var_15_3)

			return
		end

		var_14_1(var_14_0, var_14_2, var_2_10004(var_14_3, {
			__index = var_0_4
		}))

		return
	end

	SFX_PANEL = var_7

	var_1_10002(var_11_12, var_11_13, var_11_14, var_7)

	local var_11_15 = arg_11_0.rtMainPanel

	arg_11_0.rtShipCard = var_2.Find(var_11_15, "left_panel/ship_tpl")
	onButton = var_2

	local var_11_16 = arg_11_0
	local var_11_17 = arg_11_0.rtMainPanel
	local var_11_18 = var_5.Find(var_11_17, "left_panel/btn_refresh")

	local function var_11_19()
		local var_16_0 = arg_11_0

		var_0.refreshCodes(var_16_0)

		return
	end

	SFX_PANEL = var_11_17

	var_2(var_11_16, var_11_18, var_11_19, var_11_17)

	local var_11_20 = arg_11_0.rtMainPanel
	local var_11_21 = var_2.Find(var_11_20, "right_panel/content/container")

	UIItemList = var_11_10
	arg_11_0.itemList = var_11_10.New(var_11_21, var_11_21:Find("tpl"))
	pg = var_3

	local var_11_22 = var_3.equip_data_template

	pg = var_11_20

	local var_11_23 = var_11_20.spweapon_data_statistics
	local var_11_24 = arg_11_0.itemList

	var_5.make(var_11_24, function(arg_17_0, arg_17_1, arg_17_2)
		arg_17_1 = arg_17_1 + 1
		UIItemList = var_2_10003

		if arg_17_0 == var_2_10003.EventUpdate then
			local var_17_0 = arg_11_0.filterCodes[arg_17_1]
			local var_17_1 = {}
			local var_17_2
			local var_17_3

			unpack = var_2_10007
			string = var_2_10009

			local var_17_4, var_17_5, var_17_6, var_17_7 = var_2_10007(var_2_10009.split(var_17_0.str, "&"))

			var_17_1[2] = var_17_7
			var_17_1[1] = var_17_6

			local var_17_8 = var_17_5
			local var_17_9 = var_17_4

			ipairs = var_17_4
			parseEquipCode = var_17_6

			for iter_17_0, iter_17_1 in var_17_4(var_17_6(var_17_9)) do
				if iter_17_0 == 6 then
					local var_17_10 = var_0_3
					local var_17_11 = arg_17_2:Find("left/equipments/SpSlot")

					if var_11_23[iter_17_1] then
						SpWeapon = var_2_10015

						if not var_2_10015.New({
							id = iter_17_1
						}) then
							var_2_10015 = false
						end

						var_17_10(var_17_11, var_2_10015)

						goto label_17_0

						var_17_10 = var_0_2

						local var_17_12 = arg_17_2:Find("left/equipments")
						local var_17_13 = var_14.GetChild(var_17_12, iter_17_0 - 1)

						if var_11_22[iter_17_1] then
							Equipment = var_2_10015

							if not var_2_10015.New({
								id = iter_17_1
							}) then
								var_2_10015 = false
							end

							var_17_10(var_17_13, var_2_10015)

							::label_17_0::
						end
					end
				end
			end

			ipairs = var_7

			for iter_17_2, iter_17_3 in var_7(var_17_1) do
				setText = var_17_10

				local var_17_14 = arg_17_2:Find("left/tags/" .. iter_17_2 .. "/Text")

				i18n = var_2_10015

				var_17_10(var_17_14, var_2_10015("equip_share_label_" .. iter_17_3))
			end

			setText = var_7

			var_7(arg_17_2:Find("right/like/Text"), var_17_0.like)

			onButton = var_7

			local var_17_15 = arg_11_0
			local var_17_16 = arg_17_2
			local var_17_17 = arg_17_2.Find(var_17_16, "right/like/btn_like")

			local function var_17_18()
				if var_17_0.afterLike then
					pg = var_0

					local var_18_0 = var_0.TipsMgr.GetInstance()
					local var_18_1 = var_0.ShowTips

					i18n = var_3_10003

					var_18_1(var_18_0, var_3_10003("equipcode_like_limited"))
				else
					function arg_11_0.successCallback()
						local var_19_0 = arg_11_0

						var_19_0.successCallback = nil
						setText = var_19_0

						local var_19_1 = arg_17_2

						var_19_0(var_2.Find(var_19_1, "right/like/Text"), var_17_0.like)

						return
					end

					local var_18_2 = arg_11_0
					local var_18_3 = var_0.emit

					EquipCodeShareMediator = var_3_10003

					var_18_3(var_18_2, var_3_10003.LIKE_EQUIP_CODE, arg_11_0.shipGroup.id, var_17_0.id)
				end

				return
			end

			SFX_PANEL = var_17_16

			var_7(var_17_15, var_17_17, var_17_18, var_17_16)

			onButton = var_7

			local var_17_19 = arg_11_0
			local var_17_20 = arg_17_2
			local var_17_21 = arg_17_2.Find(var_17_20, "right/like/btn_impeach")

			local function var_17_22()
				local var_20_0 = arg_11_0

				var_20_0.impeachCodeId = var_17_0.id
				setActive = var_20_0

				var_20_0(arg_11_0.rtMainPanel, false)

				setActive = var_20_0

				var_20_0(arg_11_0.impackPanel, true)

				triggerToggle = var_20_0

				local var_20_1 = arg_11_0.impackPanel

				var_20_0(var_2.Find(var_20_1, "window/msg_panel/content/options/tpl"), true)

				return
			end

			SFX_PANEL = var_17_20

			var_7(var_17_19, var_17_21, var_17_22, var_17_20)

			onButton = var_7

			local var_17_23 = arg_11_0
			local var_17_24 = arg_17_2
			local var_17_25 = arg_17_2.Find(var_17_24, "right/btn_copy")

			local function var_17_26()
				UniPasteBoard = var_3_10000

				var_3_10000.SetClipBoardString(var_17_9)

				pg = var_0

				local var_21_0 = var_0.TipsMgr.GetInstance()
				local var_21_1 = var_0.ShowTips

				i18n = var_3_10003

				var_21_1(var_21_0, var_3_10003("equipcode_export_success"))

				return
			end

			SFX_CONFIRM = var_17_24

			var_7(var_17_23, var_17_25, var_17_26, var_17_24)
		end

		return
	end)

	setText = var_5

	local var_11_25 = arg_11_0.rtMainPanel
	local var_11_26 = var_7.Find(var_11_25, "right_panel/content/nothing/Text_2")

	i18n = var_8

	var_5(var_11_26, var_8("equipcode_share_listempty"))

	setText = var_5

	local var_11_27 = arg_11_0.rtMainPanel
	local var_11_28 = var_7.Find(var_11_27, "top_panel/title/name")

	i18n = var_8

	var_5(var_11_28, var_8("equipcode_share_title"))

	setText = var_5

	local var_11_29 = arg_11_0.rtMainPanel
	local var_11_30 = var_7.Find(var_11_29, "top_panel/title/name/name_en")

	i18n = var_8

	var_5(var_11_30, var_8("equipcode_share_titleeng"))
	arg_11_0:initImpeachPanel()
	arg_11_0:BlurPanel(arg_11_0._tf)

	return
end

function var_0_1.refreshLikeCommand(arg_22_0, arg_22_1, arg_22_2)
	underscore = var_1_10003

	local var_22_0 = var_1_10003.detect(arg_22_0.codes, function(arg_23_0)
		return arg_23_0.id == arg_22_1
	end)

	var_22_0.afterLike = true
	var_22_0.like = var_22_0.like + (arg_22_2 and 1 or 0)
	existCall = var_4

	var_4(arg_22_0.successCallback)

	return
end

function var_0_1.initImpeachPanel(arg_24_0)
	local var_24_0 = arg_24_0._tf

	arg_24_0.impackPanel = var_1.Find(var_24_0, "impeachPanel")
	setText = var_1

	local var_24_1 = arg_24_0.impackPanel
	local var_24_2 = var_3.Find(var_24_1, "window/top/bg/impeach/title")

	i18n = var_4

	var_1(var_24_2, var_4("report_sent_title"))

	onButton = var_1

	local var_24_3 = arg_24_0
	local var_24_4 = arg_24_0.impackPanel
	local var_24_5 = var_4.Find(var_24_4, "window/top/btnBack")

	local function var_24_6()
		local var_25_0 = arg_24_0

		var_0.onBackPressed(var_25_0)

		return
	end

	SFX_CANCEL = var_24_4

	var_1(var_24_3, var_24_5, var_24_6, var_24_4)

	local var_24_7 = {
		{
			"equipcode_report_type_1",
			"equipcode_report_type_1"
		},
		{
			"equipcode_report_type_2",
			"equipcode_report_type_2"
		}
	}
	local var_24_8 = arg_24_0.impackPanel
	local var_24_9 = var_2.Find(var_24_8, "window/msg_panel/content")

	setText = var_24_3

	local var_24_10 = var_24_9:Find("title")

	i18n = var_24_4

	var_24_3(var_24_10, var_24_4("report_sent_desc"))

	UIItemList = var_24_3

	local var_24_11 = var_24_3.New(var_24_9:Find("options"), var_24_9:Find("options/tpl"))

	var_3.make(var_24_11, function(arg_26_0, arg_26_1, arg_26_2)
		arg_26_1 = arg_26_1 + 1
		UIItemList = var_2_10003

		if arg_26_0 == var_2_10003.EventUpdate then
			local var_26_0 = var_24_7[arg_26_1]

			setText = var_2_10004

			local var_26_1 = arg_26_2:Find("Text")

			i18n = var_2_10007

			var_2_10004(var_26_1, var_2_10007(var_26_0[1]))

			setText = var_2_10004

			local var_26_2 = arg_26_2:Find("Text_2")

			i18n = var_7

			var_2_10004(var_26_2, var_7(var_26_0[2]))

			onToggle = var_2_10004

			var_2_10004(arg_24_0, arg_26_2, function(arg_27_0)
				arg_24_0.impeachOption = arg_26_1

				return
			end)
		end

		return
	end)
	var_3:align(#var_24_7)

	local var_24_12 = var_24_9:Find("other/field/input")

	onButton = var_5

	local var_24_13 = arg_24_0
	local var_24_14 = arg_24_0.impackPanel
	local var_24_15 = var_8.Find(var_24_14, "window/button_container/button")

	local function var_24_16()
		local var_28_0 = arg_24_0
		local var_28_1 = var_0.emit

		EquipCodeShareMediator = var_2_10003

		var_28_1(var_28_0, var_2_10003.IMPEACH_EQUIP_CODE, arg_24_0.shipGroup.id, arg_24_0.impeachCodeId, arg_24_0.impeachOption)

		local var_28_2 = arg_24_0

		var_0.onBackPressed(var_28_2)

		return
	end

	SFX_CONFIRM = var_24_14

	var_5(var_24_13, var_24_15, var_24_16, var_24_14)

	return
end

function var_0_1.onBackPressed(arg_29_0)
	isActive = var_1_10001

	if var_1_10001(arg_29_0.impackPanel) then
		setActive = var_1

		var_1(arg_29_0.rtMainPanel, true)

		setActive = var_1

		var_1(arg_29_0.impackPanel, false)

		return
	end

	arg_29_0:closeView()

	return
end

function var_0_1.didEnter(arg_30_0)
	arg_30_0:flushShip()

	arg_30_0.refreshCount = 0

	arg_30_0:refreshCodes()

	return
end

function var_0_1.flushShip(arg_31_0)
	local var_31_0 = arg_31_0.rtMainPanel

	arg_31_0.head = var_1.Find(var_31_0, "left_panel/ship_tpl")

	local var_31_1 = arg_31_0.head
	local var_31_2 = var_1.Find(var_31_1, "content/main_bg/type_mask/type_icon")
	local var_31_3 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_31_0.iconType = var_31_3(var_31_2, var_4(var_1_10006))

	local var_31_4 = arg_31_0.head
	local var_31_5 = var_1.Find(var_31_4, "content/icon_bg")
	local var_31_6 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_31_0.imageBg = var_31_6(var_31_5, var_4(var_1_10006))

	local var_31_7 = arg_31_0.head

	arg_31_0.imageFrame = var_1.Find(var_31_7, "content/main_bg/frame")

	local var_31_8 = arg_31_0.head
	local var_31_9 = var_1.Find(var_31_8, "content/icon")
	local var_31_10 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_31_0.iconShip = var_31_10(var_31_9, var_4(var_1_10006))

	local var_31_11 = arg_31_0.head
	local var_31_12 = var_1.Find(var_31_11, "content/main_bg/name_mask/name")
	local var_31_13 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_31_0.labelName = var_31_13(var_31_12, var_4(var_1_10006))

	local var_31_14 = arg_31_0.head
	local var_31_15 = var_1.Find(var_31_14, "content/main_bg/name_mask/name")
	local var_31_16 = var_1.GetComponent

	typeof = var_4
	ScrollText = var_1_10006
	arg_31_0.scrollText = var_31_16(var_31_15, var_4(var_1_10006))

	local var_31_17 = arg_31_0.head

	arg_31_0.stars = var_1.Find(var_31_17, "content/main_bg/stars")

	local var_31_18 = arg_31_0.stars

	arg_31_0.star = var_1.Find(var_31_18, "tpl")

	local var_31_19 = arg_31_0.shipGroup.shipConfig
	local var_31_20 = arg_31_0.shipGroup
	local var_31_21 = var_2.getPainting(var_31_20, arg_31_0.showTrans)
	local var_31_22 = arg_31_0.shipGroup
	local var_31_23 = var_3.rarity2bgPrint(var_31_22, arg_31_0.showTrans)

	setShipCardFrame = var_31_20

	var_31_20(arg_31_0.imageFrame, var_31_23, nil)

	GetImageSpriteFromAtlasAsync = var_31_20

	var_31_20("bg/star_level_card_" .. var_31_23, "", arg_31_0.imageBg)

	local var_31_24 = arg_31_0.iconShip

	GetSpriteFromAtlas = var_31_22
	var_31_24.sprite = var_31_22("shipYardIcon/unknown", "")
	LoadImageSpriteAsync = var_31_24

	var_31_24("shipYardIcon/" .. var_31_21, arg_31_0.iconShip)

	local var_31_25 = arg_31_0.labelName
	local var_31_26 = arg_31_0.shipGroup

	var_31_25.text = var_5.getName(var_31_26, arg_31_0.showTrans)

	local var_31_28

	if arg_31_0.scrollText then
		local var_31_27 = arg_31_0.scrollText

		var_31_28 = var_31_28.SetText

		local var_31_29 = arg_31_0.shipGroup

		var_31_28(var_31_27, var_31_26.getName(var_31_29, arg_31_0.showTrans))
	end

	GetSpriteFromAtlas = var_31_28

	local var_31_30 = "shiptype"

	shipType2print = var_31_26

	local var_31_31 = arg_31_0.shipGroup

	if not var_31_28(var_31_30, var_31_26(var_9.getShipType(var_31_31, arg_31_0.showTrans))) then
		warning = var_5

		var_5("找不到船形, shipConfigId: " .. var_31_19.id)
	end

	local var_31_32 = arg_31_0.iconType

	var_31_32.sprite = var_4
	pg = var_31_32

	local var_31_33 = var_31_32.ship_data_template[var_31_19.id].star_max

	for iter_31_0 = arg_31_0.stars.childCount, var_31_33 - 1 do
		cloneTplTo = var_31_31
		var_31_31 = var_31_31(arg_31_0.star, arg_31_0.stars)
	end

	return
end

function var_0_1.isDefaultFilter(arg_32_0)
	underscore = var_1_10001

	local var_32_0 = var_1_10001(arg_32_0.indexData)
	local var_32_1 = var_1.chain(var_32_0)
	local var_32_2 = var_1.keys(var_32_1)
	local var_32_3 = var_1.all(var_32_2, function(arg_33_0)
		return arg_32_0.indexData[arg_33_0] == var_0_4.customPanels[arg_33_0].options[1]
	end)

	return var_1.value(var_32_3)
end

function var_0_1.codesFilter(arg_34_0, arg_34_1)
	underscore = var_1_10002

	return var_1_10002.filter(arg_34_1, function(arg_35_0)
		IndexConst = var_2_10001

		return var_2_10001.filterEquipCodeByLable(arg_35_0, arg_34_0.indexData.labelIndex)
	end)
end

function var_0_1.refreshCodes(arg_36_0)
	arg_36_0.refreshCount = arg_36_0.refreshCount + 1
	arg_36_0.filterCodes = {}

	if arg_36_0.refreshCount > 4 or not arg_36_0:isDefaultFilter() then
		if #arg_36_0:codesFilter(arg_36_0.codes) > 4 then
			for iter_36_0 = 1, 4 do
				math = var_1_10006
				var_1_10006 = var_1_10006.random(#var_1)
				table = var_1_10007

				var_1_10007.insert(arg_36_0.filterCodes, var_1[var_1_10006])

				table = var_1_10007

				var_1_10007.remove(var_1, var_1_10006)
			end
		else
			arg_36_0.filterCodes = var_1
		end

		table = var_2

		local var_36_0 = var_2.sort
		local var_36_1 = arg_36_0.filterCodes

		CompareFuncs = iter_36_0

		var_36_0(var_36_1, iter_36_0({
			function(arg_37_0)
				return -arg_37_0.like
			end
		}, false))
	else
		if #arg_36_0.firstPool < 3 then
			underscore = var_1
			arg_36_0.filterCodes = var_1.rest(arg_36_0.firstPool, 1)
		else
			local var_36_2

			if #arg_36_0.firstPool < arg_36_0.refreshCount * 3 then
				underscore = var_36_2
				var_36_2 = var_36_2.rest(arg_36_0.firstPool, 1)

				for iter_36_1 = 1, 3 do
					math = var_1_10006
					var_1_10006 = var_1_10006.random(#var_36_2)
					table = var_1_10007

					var_1_10007.insert(arg_36_0.filterCodes, var_36_2[var_1_10006])

					table = var_1_10007

					var_1_10007.remove(var_36_2, var_1_10006)
				end
			else
				underscore = var_36_2
				arg_36_0.filterCodes = var_36_2.slice(arg_36_0.firstPool, (arg_36_0.refreshCount - 1) * 3 + 1, 3)
			end
		end

		local var_36_3 = {}

		underscore = var_2
		var_36_3[1] = var_2.rest(arg_36_0.newPool, 1)
		underscore = var_2
		var_36_3[2] = var_2.rest(arg_36_0.oldPool, 1)
		underscore = var_2
		var_36_3[3] = var_2.filter(arg_36_0.firstPool, function(arg_38_0)
			underscore = var_2_10001

			return var_2_10001.all(arg_36_0.filterCodes, function(arg_39_0)
				return arg_39_0.id ~= arg_38_0.id
			end)
		end)

		local var_36_4

		::label_36_0::

		while #arg_36_0.filterCodes < 4 do
			if var_36_4 then
				local var_36_5 = #var_36_4

				if 0 < var_36_5 then
					math = var_36_5

					local var_36_6 = var_36_5.random(#var_36_4)

					table = var_4

					var_4.insert(arg_36_0.filterCodes, var_36_4[var_36_6])

					table = var_4

					var_4.remove(var_36_4, var_36_6)

					goto label_36_0
				end
			end

			if #var_36_3 > 0 then
				table = var_3
				var_36_4 = var_3.remove(var_36_3, 1)
			else
				break
			end
		end
	end

	local var_36_7 = arg_36_0.itemList

	var_1.align(var_36_7, #arg_36_0.filterCodes)

	setActive = var_1

	local var_36_8 = arg_36_0.rtMainPanel

	var_1(var_3.Find(var_36_8, "right_panel/content/nothing"), #arg_36_0.filterCodes == 0)

	return
end

function var_0_1.willExit(arg_40_0)
	arg_40_0:UnOverlayPanel(arg_40_0._tf)

	return
end

return var_0_1
