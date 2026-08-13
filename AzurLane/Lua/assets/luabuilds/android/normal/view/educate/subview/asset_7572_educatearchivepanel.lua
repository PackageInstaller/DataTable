class = var_0_10000

local var_0_0 = "EducateArchivePanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))
local var_0_2 = 0.005

function var_0_1.getUIName(arg_1_0)
	return "EducateArchivePanel"
end

function var_0_1.OnInit(arg_2_0)
	pg = var_1_10001
	arg_2_0.config = var_1_10001.child_attr

	local var_2_0 = arg_2_0._tf

	arg_2_0.foldPanelTF = var_1.Find(var_2_0, "fold_panel")

	local var_2_1 = arg_2_0.foldPanelTF

	arg_2_0.showBtn = var_1.Find(var_2_1, "show_btn")

	local var_2_2 = arg_2_0._tf

	arg_2_0.showPanelTF = var_1.Find(var_2_2, "show_panel")

	local var_2_3 = arg_2_0.showPanelTF
	local var_2_4 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004
	arg_2_0.showAnim = var_2_4(var_2_3, var_3(var_1_10004))

	local var_2_5 = arg_2_0.showPanelTF
	local var_2_6 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_1_10004
	arg_2_0.showAnimEvent = var_2_6(var_2_5, var_3(var_1_10004))

	local var_2_7 = arg_2_0.showAnimEvent

	var_1.SetEndEvent(var_2_7, function()
		setActive = var_2_10000

		var_2_10000(arg_2_0.showPanelTF, false)

		return
	end)

	local var_2_8 = arg_2_0.showPanelTF

	arg_2_0.blurBg = var_1.Find(var_2_8, "panel")

	local var_2_9 = arg_2_0.showPanelTF

	arg_2_0.foldBtn = var_1.Find(var_2_9, "fold_btn")

	local var_2_10 = arg_2_0.showPanelTF
	local var_2_11 = var_1.Find(var_2_10, "panel/event")

	arg_2_0.pageSnap = var_1.GetComponent(var_2_11, "HScrollSnap")

	local var_2_12 = arg_2_0.pageSnap

	var_1.Init(var_2_12)

	local var_2_13 = arg_2_0.showPanelTF

	arg_2_0.page1 = var_1.Find(var_2_13, "panel/event/content/page1")
	setText = var_1

	local var_2_14 = arg_2_0.page1
	local var_2_15 = var_2.Find(var_2_14, "title/name_title/name")

	i18n = var_2_14

	var_1(var_2_15, var_2_14("child_archive_name"))

	setText = var_1

	local var_2_16 = arg_2_0.page1
	local var_2_17 = var_2.Find(var_2_16, "attr_title/Text")

	i18n = var_2_16

	var_1(var_2_17, var_2_16("child_attr_name1"))

	setText = var_1

	local var_2_18 = arg_2_0.page1
	local var_2_19 = var_2.Find(var_2_18, "buff_title/Text")

	i18n = var_2_18

	var_1(var_2_19, var_2_18("child_buff_name"))

	local var_2_20 = arg_2_0.page1

	arg_2_0.avatarImageTF = var_1.Find(var_2_20, "title/avatar")
	UIItemList = var_1

	local var_2_21 = var_1.New
	local var_2_22 = arg_2_0.page1
	local var_2_23 = var_2.Find(var_2_22, "attrs/content")
	local var_2_24 = arg_2_0.page1

	arg_2_0.attrsList1 = var_2_21(var_2_23, var_3.Find(var_2_24, "attrs/tpl"))

	local var_2_25 = arg_2_0.page1

	arg_2_0.gradientBgTF = var_1.Find(var_2_25, "attrs/bg_gradient")

	local var_2_26 = arg_2_0.page1

	arg_2_0.buffContentTF = var_1.Find(var_2_26, "buff/content")
	UIItemList = var_1

	local var_2_27 = var_1.New
	local var_2_28 = arg_2_0.page1
	local var_2_29 = var_2.Find(var_2_28, "buff/content/content")
	local var_2_30 = arg_2_0.page1

	arg_2_0.buffItemList = var_2_27(var_2_29, var_3.Find(var_2_30, "buff/tpl"))

	local var_2_31 = arg_2_0.page1

	arg_2_0.buffLockTF = var_1.Find(var_2_31, "buff/lock")

	local var_2_32 = arg_2_0.showPanelTF

	arg_2_0.page2 = var_1.Find(var_2_32, "panel/event/content/page2")
	setText = var_1

	local var_2_33 = arg_2_0.page2
	local var_2_34 = var_2.Find(var_2_33, "attr_title/Text")

	i18n = var_2_33

	var_1(var_2_34, var_2_33("child_attr_name2"))

	local var_2_35 = arg_2_0.page2

	arg_2_0.attr3UnlockTF = var_1.Find(var_2_35, "attrs/unlock")

	local var_2_36 = arg_2_0.page2

	arg_2_0.attr3LockTF = var_1.Find(var_2_36, "attrs/lock")
	UIItemList = var_1

	local var_2_37 = var_1.New
	local var_2_38 = arg_2_0.attr3UnlockTF
	local var_2_39 = var_2.Find(var_2_38, "content")
	local var_2_40 = arg_2_0.attr3UnlockTF

	arg_2_0.attrsList2 = var_2_37(var_2_39, var_3.Find(var_2_40, "tpl"))

	local var_2_41 = arg_2_0.page2

	arg_2_0.attr2UnlockTF = var_1.Find(var_2_41, "nature/unlock")

	local var_2_42 = arg_2_0.page2

	arg_2_0.attr2LockTF = var_1.Find(var_2_42, "nature/lock")

	local var_2_43 = arg_2_0.attr2UnlockTF

	arg_2_0.natureContent = var_1.Find(var_2_43, "content")

	local var_2_44 = arg_2_0.page2

	arg_2_0.avatarTF = var_1.Find(var_2_44, "avatar")

	arg_2_0:addListener()
	arg_2_0:initAttrsPanel()
	arg_2_0:OverlayPanel(arg_2_0._tf, {
		groupDelta = -1,
		pbList = {
			arg_2_0.blurBg
		}
	})

	setActive = var_1

	var_1(arg_2_0.foldPanelTF, true)

	setActive = var_1

	var_1(arg_2_0.showPanelTF, false)

	if arg_2_0.contextData and arg_2_0.contextData.isShow then
		if arg_2_0.contextData.isMainEnter then
			onDelayTick = var_1

			var_1(function()
				local var_4_0 = arg_2_0

				var_0.showPanel(var_4_0)

				return
			end, 0.396)
		else
			arg_2_0:showPanel()
		end
	end

	return
end

function var_0_1.addListener(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.showBtn

	local function var_5_2()
		local var_6_0 = arg_5_0

		var_0.showPanel(var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10005)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.foldBtn

	local function var_5_5()
		local var_7_0 = arg_5_0

		var_0.hidePanel(var_7_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_3, var_5_4, var_5_5, var_1_10005)

	return
end

function var_0_1.showPanel(arg_8_0)
	setActive = var_1_10001

	var_1_10001(arg_8_0.foldPanelTF, false)

	setActive = var_1_10001

	var_1_10001(arg_8_0.showPanelTF, true)

	return
end

function var_0_1.hidePanel(arg_9_0)
	setActive = var_1_10001

	var_1_10001(arg_9_0.foldPanelTF, true)

	local var_9_0 = arg_9_0.showAnim

	var_1.Play(var_9_0, "anim_educate_archive_show_out")

	return
end

function var_0_1.initAttrsPanel(arg_10_0)
	local var_10_0 = arg_10_0.attrsList1

	var_1.make(var_10_0, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = arg_10_0

			var_3.updateAttr1Item(var_11_0, arg_11_1, arg_11_2)
		end

		return
	end)

	local var_10_1 = arg_10_0.buffItemList

	var_1.make(var_10_1, function(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			local var_12_0 = arg_10_0

			var_3.updateBuffItem(var_12_0, arg_12_1, arg_12_2)
		end

		return
	end)

	local var_10_2 = arg_10_0.attrsList2

	var_1.make(var_10_2, function(arg_13_0, arg_13_1, arg_13_2)
		UIItemList = var_2_10003

		if arg_13_0 == var_2_10003.EventUpdate then
			local var_13_0 = arg_10_0

			var_3.updateAttr2Item(var_13_0, arg_13_1, arg_13_2)
		end

		return
	end)
	arg_10_0:Flush()

	return
end

function var_0_1.updateAttr1Item(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.char
	local var_14_1 = var_3.GetAttrGroupByType

	EducateChar = var_1_10005

	local var_14_2 = var_14_1(var_14_0, var_1_10005.ATTR_TYPE_MAJOR)[arg_14_1 + 1][1]
	local var_14_3 = arg_14_0.config[var_14_2]

	GetImageSpriteFromAtlasAsync = var_1_10006

	var_1_10006("ui/educatecommonui_atlas", "attr_" .. var_14_2, arg_14_2:Find("icon_bg/icon"), true)

	setScrollText = var_1_10006

	var_1_10006(arg_14_2:Find("name_mask/name"), var_14_3.name)

	local var_14_4 = arg_14_0.char
	local var_14_5, var_14_6 = var_6.GetAttrInfo(var_14_4, var_14_2)

	setText = var_8

	var_8(arg_14_2:Find("grade/Text"), var_14_5)

	setText = var_8

	var_8(arg_14_2:Find("value"), var_14_6)

	EducateConst = var_8

	local var_14_7 = var_8.GRADE_2_COLOR[var_14_5][1]

	EducateConst = var_9

	local var_14_8 = var_9.GRADE_2_COLOR[var_14_5][2]
	local var_14_9 = arg_14_0.gradientBgTF
	local var_14_10

	var_14_10, setImageColor = var_10.GetChild(var_14_9, arg_14_1), var_14_9
	Color = var_1_10013

	var_14_9(var_14_10, var_1_10013.NewHex(var_14_7))

	setImageColor = var_14_9

	local var_14_11 = arg_14_2
	local var_14_12 = arg_14_2.Find(var_14_11, "grade")

	Color = var_14_11

	var_14_9(var_14_12, var_14_11.NewHex(var_14_8))

	return
end

function var_0_1.updateBuffItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.buffList[arg_15_1 + 1]

	LoadImageSpriteAsync = var_4

	var_4("educateprops/" .. var_15_0:getConfig("icon"), arg_15_2:Find("icon"))

	setText = var_4

	local var_15_1 = arg_15_2:Find("time/Text")
	local var_15_2 = var_15_0
	local var_15_3 = var_15_0.GetReaminWeek(var_15_2)

	i18n = var_15_2

	var_4(var_15_1, var_15_3 .. var_15_2("word_week"))

	onButton = var_4

	local var_15_4 = arg_15_0
	local var_15_5 = arg_15_2

	local function var_15_6()
		local var_16_0 = arg_15_0

		var_0.showBuffBox(var_16_0, var_15_0.id)

		return
	end

	SFX_PANEL = var_8

	var_4(var_15_4, var_15_5, var_15_6, var_8)

	return
end

function var_0_1.showBuffBox(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.emit

	EducateBaseUI = var_1_10004

	local var_17_2 = var_1_10004.EDUCATE_ON_ITEM
	local var_17_3 = {}
	local var_17_4 = {
		number = 1
	}

	EducateConst = var_1_10007
	var_17_4.type = var_1_10007.DROP_TYPE_BUFF
	var_17_4.id = arg_17_1
	var_17_3.drop = var_17_4

	var_17_1(var_17_0, var_17_2, var_17_3)

	return
end

function var_0_1.updateAttr2Item(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.char
	local var_18_1 = var_3.GetAttrGroupByType

	EducateChar = var_1_10005

	local var_18_2 = var_18_1(var_18_0, var_1_10005.ATTR_TYPE_MINOR)[arg_18_1 + 1][1]
	local var_18_3 = arg_18_0.config[var_18_2]

	GetImageSpriteFromAtlasAsync = var_1_10006

	var_1_10006("ui/educatecommonui_atlas", "attr_" .. var_18_2, arg_18_2:Find("icon"), true)

	setText = var_1_10006

	var_1_10006(arg_18_2:Find("name"), var_18_3.name)

	setText = var_1_10006

	local var_18_4 = arg_18_2:Find("value")
	local var_18_5 = arg_18_0.char

	var_1_10006(var_18_4, var_8.GetAttrById(var_18_5, var_18_2))

	return
end

function var_0_1.updateNature(arg_19_0)
	ipairs = var_1_10001

	local var_19_0 = arg_19_0.char
	local var_19_1 = var_2.GetAttrGroupByType

	EducateChar = var_1_10004

	for iter_19_0, iter_19_1 in var_1_10001(var_19_1(var_19_0, var_1_10004.ATTR_TYPE_PERSONALITY)) do
		local var_19_2 = arg_19_0.natureContent
		local var_19_3 = var_6.GetChild(var_19_2, iter_19_0 - 1)

		var_19_3.name = iter_19_1[1]
		setScrollText = var_7

		var_7(var_19_3:Find("Text"), arg_19_0.config[iter_19_1[1]].name .. " " .. iter_19_1[2])
	end

	return
end

function var_0_1.Flush(arg_20_0)
	local var_20_0 = arg_20_0

	if not arg_20_0.GetLoaded(var_20_0) then
		return
	end

	getProxy = var_1
	EducateProxy = var_20_0
	arg_20_0.educateProxy = var_1(var_20_0)

	local var_20_1 = arg_20_0.educateProxy

	arg_20_0.char = var_1.GetCharData(var_20_1)

	local var_20_2 = arg_20_0.attrsList1
	local var_20_3 = var_1.align
	local var_20_4 = arg_20_0.char
	local var_20_5 = var_3.GetAttrGroupByType

	EducateChar = var_1_10005

	var_20_3(var_20_2, #var_20_5(var_20_4, var_1_10005.ATTR_TYPE_MAJOR))

	local var_20_6 = arg_20_0.educateProxy

	arg_20_0.buffList = var_1.GetBuffList(var_20_6)

	local var_20_7 = arg_20_0.buffItemList

	var_1.align(var_20_7, #arg_20_0.buffList)

	local var_20_8 = arg_20_0.attrsList2
	local var_20_9 = var_1.align
	local var_20_10 = arg_20_0.char
	local var_20_11 = var_3.GetAttrGroupByType

	EducateChar = var_5

	var_20_9(var_20_8, #var_20_11(var_20_10, var_5.ATTR_TYPE_MINOR))

	local var_20_12 = arg_20_0.char
	local var_20_13 = var_1.GetPaintingName(var_20_12)

	setImageSprite = var_20_12

	local var_20_14 = arg_20_0.avatarImageTF

	LoadSprite = var_20_10

	var_20_12(var_20_14, var_20_10("educateavatar/" .. var_20_13), true)
	arg_20_0:updateNature()

	setImageSprite = var_2

	local var_20_15 = arg_20_0.avatarTF
	local var_20_16 = var_3.Find(var_20_15, "mask/Image")

	LoadSprite = var_20_15

	var_2(var_20_16, var_20_15("squareicon/" .. var_20_13), true)

	setText = var_2

	local var_20_17 = arg_20_0.page1
	local var_20_18 = var_3.Find(var_20_17, "title/name/Text")
	local var_20_19 = arg_20_0.char

	var_2(var_20_18, var_4.GetName(var_20_19))

	EducateHelper = var_2

	local var_20_20 = var_2.IsSystemUnlock

	EducateConst = var_20_18

	local var_20_21 = var_20_20(var_20_18.SYSTEM_BUFF)

	setActive = var_3

	var_3(arg_20_0.buffContentTF, var_20_21)

	setActive = var_3

	var_3(arg_20_0.buffLockTF, not var_20_21)

	EducateHelper = var_3

	local var_20_22 = var_3.IsShowNature()

	setActive = var_4

	var_4(arg_20_0.attr2UnlockTF, var_20_22)

	setActive = var_4

	var_4(arg_20_0.attr2LockTF, not var_20_22)

	EducateHelper = var_4

	local var_20_23 = var_4.IsSystemUnlock

	EducateConst = var_5

	local var_20_24 = var_20_23(var_5.SYSTEM_ATTR_3)

	setActive = var_5

	var_5(arg_20_0.attr3UnlockTF, var_20_24)

	setActive = var_5

	var_5(arg_20_0.attr3LockTF, not var_20_24)

	local var_20_25 = var_20_24

	setActive = var_6

	local var_20_26 = arg_20_0.showPanelTF

	var_6(var_7.Find(var_20_26, "pagination"), var_20_25)

	setActive = var_6

	var_6(arg_20_0.page2, var_20_25)

	arg_20_0.pageSnap.enabled = var_20_25

	return
end

function var_0_1.OnDestroy(arg_21_0)
	arg_21_0:UnOverlayPanel(arg_21_0._tf)

	return
end

return var_0_1
