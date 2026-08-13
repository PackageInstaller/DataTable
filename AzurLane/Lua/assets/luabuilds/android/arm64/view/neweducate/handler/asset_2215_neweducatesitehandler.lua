class = var_0_10000

local var_0_0 = var_0_10000("NewEducateSiteHandler")

var_0_0.TPL_TYPE = {
	TEXT = 2,
	DROP = 4,
	CONDITION = 1,
	ARROWS = 5,
	OPTION = 3
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)

	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0.windowTF = var_2.Find(var_1_0, "window")

	local var_1_1 = arg_1_0.windowTF

	arg_1_0.titleTF = var_2.Find(var_1_1, "title/Text")

	local var_1_2 = arg_1_0.windowTF

	arg_1_0.closeBtn = var_2.Find(var_1_2, "close_btn")
	setActive = var_2

	var_2(arg_1_0.closeBtn, false)

	local var_1_3 = arg_1_0.windowTF

	arg_1_0.endOptionsTF = var_2.Find(var_1_3, "end_options")

	local var_1_4 = arg_1_0.endOptionsTF

	arg_1_0.endBtn = var_2.Find(var_1_4, "end_btn")
	setScrollText = var_2

	local var_1_5 = arg_1_0.endBtn
	local var_1_6 = var_4.Find(var_1_5, "mask/Text")

	i18n = var_5

	var_2(var_1_6, var_5("child2_site_exit"))

	setActive = var_2

	var_2(arg_1_0.endOptionsTF, false)

	local var_1_7 = arg_1_0.endOptionsTF

	arg_1_0.againBtn = var_2.Find(var_1_7, "again_btn")
	setScrollText = var_2

	local var_1_8 = arg_1_0.againBtn
	local var_1_9 = var_4.Find(var_1_8, "mask/Text")

	i18n = var_5

	var_2(var_1_9, var_5("child2_site_again"))

	local var_1_10 = arg_1_0._tf

	arg_1_0.closeBtn2 = var_2.Find(var_1_10, "close")
	setActive = var_2

	var_2(arg_1_0.closeBtn2, false)

	local var_1_11 = arg_1_0.windowTF

	arg_1_0.scrollrect = var_2.Find(var_1_11, "content/view")

	local var_1_12 = arg_1_0.scrollrect

	arg_1_0.contentTF = var_2.Find(var_1_12, "mask/content")

	local var_1_13 = arg_1_0.windowTF

	arg_1_0.optionsTF = var_2.Find(var_1_13, "content/options")
	UIItemList = var_2

	local var_1_14 = var_2.New
	local var_1_15 = arg_1_0.optionsTF
	local var_1_16 = arg_1_0.optionsTF

	arg_1_0.optionUIList = var_1_14(var_1_15, var_5.Find(var_1_16, "tpl"))

	local var_1_17 = arg_1_0.optionUIList

	var_2.make(var_1_17, function(arg_2_0, arg_2_1, arg_2_2)
		UIItemList = var_2_10003

		if arg_2_0 == var_2_10003.EventUpdate then
			local var_2_0 = arg_1_0

			var_3.UpdateOption(var_2_0, arg_2_1, arg_2_2)
		end

		return
	end)

	local var_1_18 = {}
	local var_1_19 = var_0_0.TPL_TYPE.CONDITION
	local var_1_20 = arg_1_0._tf

	var_1_18[var_1_19] = var_4.Find(var_1_20, "window/tpls/tpl_condition")

	local var_1_21 = var_0_0.TPL_TYPE.TEXT
	local var_1_22 = arg_1_0._tf

	var_1_18[var_1_21] = var_4.Find(var_1_22, "window/tpls/tpl_text")

	local var_1_23 = var_0_0.TPL_TYPE.OPTION
	local var_1_24 = arg_1_0._tf

	var_1_18[var_1_23] = var_4.Find(var_1_24, "window/tpls/tpl_option")

	local var_1_25 = var_0_0.TPL_TYPE.DROP
	local var_1_26 = arg_1_0._tf

	var_1_18[var_1_25] = var_4.Find(var_1_26, "window/tpls/tpl_drop")

	local var_1_27 = var_0_0.TPL_TYPE.ARROWS
	local var_1_28 = arg_1_0._tf

	var_1_18[var_1_27] = var_4.Find(var_1_28, "window/tpls/tpl_arrows")
	arg_1_0.tpls = var_1_18

	local var_1_29 = {}
	local var_1_30 = arg_1_0.windowTF

	var_1_29[1] = var_3.Find(var_1_30, "title")

	local var_1_31 = arg_1_0.windowTF

	var_1_29[2] = var_3.Find(var_1_31, "line")

	local var_1_32 = arg_1_0.tpls[var_0_0.TPL_TYPE.TEXT]

	var_1_29[3] = var_3.Find(var_1_32, "name_container/left/Image")

	local var_1_33 = arg_1_0.tpls[var_0_0.TPL_TYPE.TEXT]

	var_1_29[4] = var_3.Find(var_1_33, "name_container/right/Image")
	arg_1_0.imageColorTFs = var_1_29

	local var_1_34 = {}
	local var_1_35 = arg_1_0.tpls[var_0_0.TPL_TYPE.TEXT]

	var_1_34[1] = var_3.Find(var_1_35, "name_container/left")

	local var_1_36 = arg_1_0.tpls[var_0_0.TPL_TYPE.TEXT]

	var_1_34[2] = var_3.Find(var_1_36, "name_container/right")

	local var_1_37 = arg_1_0.tpls[var_0_0.TPL_TYPE.OPTION]

	var_1_34[3] = var_3.Find(var_1_37, "text")

	local var_1_38 = arg_1_0.tpls[var_0_0.TPL_TYPE.DROP]

	var_1_34[4] = var_3.Find(var_1_38, "tpl/content/value")
	arg_1_0.textColorTFs = var_1_34
	getProxy = var_1_34
	NewEducateProxy = var_4

	local var_1_39 = var_1_34(var_4)
	local var_1_40 = var_2.GetCurChar(var_1_39)

	arg_1_0.charName = var_2.getConfig(var_1_40, "name")
	getProxy = var_2
	PlayerProxy = var_1_40

	local var_1_41 = var_2(var_1_40)
	local var_1_42 = var_2.getRawData(var_1_41)

	arg_1_0.playerName = var_2.GetName(var_1_42)
	arg_1_0.passNodeIds = {}
	arg_1_0.optionIds = {}
	arg_1_0.dropRecords = {}
	NewEducateConst = var_2
	arg_1_0.speed = var_2.TYPEWRITE_SPEED

	return
end

function var_0_0.SetSite(arg_3_0, arg_3_1)
	setActive = var_1_10002

	var_1_10002(arg_3_0._go, true)

	arg_3_0.siteId = arg_3_1
	pg = var_1_10002
	arg_3_0.siteType = var_1_10002.child2_site_display[arg_3_1].type
	NewEducateHelper = var_3

	local var_3_0, var_3_1 = var_3.GetSiteColors(arg_3_0.siteId)

	underscore = var_5

	var_5.each(arg_3_0.imageColorTFs, function(arg_4_0)
		setImageColor = var_2_10001

		var_2_10001(arg_4_0, var_3_0)

		return
	end)

	underscore = var_5

	var_5.each(arg_3_0.textColorTFs, function(arg_5_0)
		setTextColor = var_2_10001

		var_2_10001(arg_5_0, var_3_1)

		return
	end)

	setText = var_5

	var_5(arg_3_0.titleTF, var_2.title)

	getProxy = var_5
	NewEducateProxy = var_7

	local var_3_2 = var_5(var_7)
	local var_3_3 = var_5.GetCurChar(var_3_2)

	switch = var_1_10006

	local var_3_4 = arg_3_0.siteType
	local var_3_5 = {}

	NewEducateConst = var_1_10010
	var_3_5[var_1_10010.SITE_TYPE.WORK] = function()
		existCall = var_2_10000

		var_2_10000(arg_3_0.onNormal)

		setActive = var_2_10000

		var_2_10000(arg_3_0._tf, false)

		local var_6_0 = var_3_3
		local var_6_1 = var_0.GetNormalIdByType

		NewEducateConst = var_3

		local var_6_2 = var_6_1(var_6_0, var_3.SITE_NORMAL_TYPE.WORK)

		pg = var_2_10001

		local var_6_3 = var_2_10001.child2_site_normal[var_6_2]
		local var_6_4 = arg_3_0

		var_2.AddConditions(var_6_4, var_3_3, var_6_3)

		local var_6_5 = arg_3_0

		var_2.AddEnterOption(var_6_5, var_6_3.title)

		return
	end
	NewEducateConst = var_10
	var_3_5[var_10.SITE_TYPE.TRAVEL] = function()
		existCall = var_2_10000

		var_2_10000(arg_3_0.onNormal)

		setActive = var_2_10000

		var_2_10000(arg_3_0._tf, false)

		local var_7_0 = var_3_3
		local var_7_1 = var_0.GetNormalIdByType

		NewEducateConst = var_3

		local var_7_2 = var_7_1(var_7_0, var_3.SITE_NORMAL_TYPE.TRAVEL)

		pg = var_2_10001

		local var_7_3 = var_2_10001.child2_site_normal[var_7_2]
		local var_7_4 = arg_3_0

		var_2.AddConditions(var_7_4, var_3_3, var_7_3)

		local var_7_5 = arg_3_0

		var_2.AddEnterOption(var_7_5, var_7_3.title)

		return
	end
	NewEducateConst = var_10
	var_3_5[var_10.SITE_TYPE.SHIP] = function()
		return
	end
	NewEducateConst = var_10
	var_3_5[var_10.SITE_TYPE.EVENT] = function()
		setText = var_2_10000

		local var_9_0 = arg_3_0.titleTF

		pg = var_2_10003

		var_2_10000(var_9_0, var_2_10003.child2_site_event_group[var_0.param].event_title)

		return
	end

	var_1_10006(var_3_4, var_3_5)

	return
end

function var_0_0.AddConditions(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1

	if not arg_10_1.GetConditionIdsFromComplex(var_10_0, arg_10_2.special_args) or #var_3 == 0 then
		return
	end

	cloneTplTo = var_1_10004

	local var_10_1 = var_1_10004(arg_10_0.tpls[var_0_0.TPL_TYPE.CONDITION], arg_10_0.contentTF, arg_10_0.siteId .. "Conditions")

	underscore = var_10_0

	local var_10_2

	if var_10_0.detect(var_3, function(arg_11_0)
		pg = var_2_10001

		local var_11_0 = var_2_10001.child2_condition[arg_11_0].type

		NewEducateConst = var_2_10002

		return var_11_0 == var_2_10002.CONDITION_TYPE.NORMAL_SITE_CNT
	end) and not arg_10_1:IsMatchCondition(var_5) then
		pg = var_6
		var_10_2 = var_6.child2_condition[var_5].param[3] - arg_10_1:GetNormalCnt(arg_10_2.id)

		if var_6[1] == ">" then
			var_10_2 = var_10_2 + 1
		end

		setText = var_8
		var_1_10012 = var_10_1

		local var_10_3 = var_10_1.Find(var_1_10012, "count")

		i18n = var_11

		var_8(var_10_3, var_11("child2_unlock_site_cnt", var_10_2))
	end

	setActive = var_6

	var_6(var_10_1:Find("count"), var_5)

	underscore = var_6

	if var_6.detect(var_3, function(arg_12_0)
		pg = var_2_10001

		local var_12_0 = var_2_10001.child2_condition[arg_12_0].type

		NewEducateConst = var_2_10002

		return var_12_0 == var_2_10002.CONDITION_TYPE.ROUND
	end) and not arg_10_1:IsMatchCondition(var_6) then
		pg = var_10_2

		local var_10_4 = var_10_2.child2_condition[var_6].param[2] - arg_10_1:GetRoundData().round

		if var_10_2[1] == ">" then
			var_10_4 = var_10_4 + 1
		end

		setText = var_9

		local var_10_5 = var_10_1:Find("round")

		i18n = var_1_10012

		var_9(var_10_5, var_1_10012("child2_unlock_site_round", var_10_4))
	end

	setActive = var_10_2

	local var_10_6 = var_10_1

	var_10_2(var_10_1.Find(var_10_6, "round"), var_6)

	underscore = var_10_2

	local var_10_7

	if not var_10_2.select(var_3, function(arg_13_0)
		pg = var_2_10001

		local var_13_0 = var_2_10001.child2_condition[arg_13_0].type

		NewEducateConst = var_2_10003

		local var_13_3

		if var_13_0 == var_2_10003.CONDITION_TYPE.DROP then
			local var_13_1 = var_1.param[1]

			NewEducateConst = var_3

			if var_13_1 == var_3.DROP_TYPE.ATTR then
				local var_13_2 = arg_10_1

				var_13_3 = not var_2.IsMatchCondition(var_13_2, arg_13_0)

				goto label_13_0
			end
		end

		var_13_3 = false

		if false then
			var_13_3 = true
		end

		::label_13_0::

		return var_13_3
	end) then
		var_10_7 = {}
	end

	local var_10_8 = #var_10_7

	if 0 < var_10_8 then
		setText = var_10_8

		local var_10_9 = var_10_1:Find("attrs/text")

		i18n = var_10_6

		var_10_8(var_10_9, var_10_6("child2_unlock_site_attr"))

		var_10_8 = var_10_1:Find("attrs/content")
		UIItemList = var_9

		local var_10_10 = var_9.New(var_10_8, var_10_8:Find("tpl"))

		var_9.make(var_10_10, function(arg_14_0, arg_14_1, arg_14_2)
			UIItemList = var_2_10003

			if arg_14_0 == var_2_10003.EventUpdate then
				pg = var_3

				local var_14_0 = var_3.child2_condition[var_10_7[arg_14_1 + 1]].param[2]

				pg = var_5

				local var_14_1 = var_5.child2_attr[var_14_0]
				local var_14_2 = var_3[4]

				LoadImageSpriteAsync = var_2_10007

				var_2_10007("neweducateicon/" .. var_14_1.icon, arg_14_2:Find("icon_bg/icon"))

				setText = var_2_10007

				local var_14_3 = arg_14_2

				var_2_10007(arg_14_2.Find(var_14_3, "name"), var_14_1.name)

				local var_14_4 = arg_10_1
				local var_14_5 = var_7.GetAttr(var_14_4, var_14_0)

				setText = var_2_10008

				local var_14_6 = arg_14_2:Find("value")

				if var_14_5 < var_14_2 then
					setColorStr = var_14_3

					local var_14_7

					if not var_14_3(var_14_5, "#a9a9b0") then
						var_14_7 = var_14_5
					end

					var_2_10008(var_14_6, var_14_7 .. "/" .. var_14_2)

					return
				end
			end
		end)
		var_9:align(#var_10_7)
	end

	setActive = var_10_8

	var_10_8(var_10_1:Find("attrs"), #var_10_7 > 0)

	return
end

function var_0_0.AddEnterOption(arg_15_0, arg_15_1)
	cloneTplTo = var_1_10002

	local var_15_0 = var_1_10002(arg_15_0.tpls[var_0_0.TPL_TYPE.OPTION], arg_15_0.contentTF, arg_15_0.siteId .. "_EnterOption")

	setText = var_1_10003

	var_1_10003(var_15_0:Find("name_container/name"), arg_15_0.charName)

	setText = var_1_10003

	var_1_10003(var_15_0:Find("text"), ">>" .. arg_15_1)

	return
end

function var_0_0.AddEnterText(arg_16_0, arg_16_1, arg_16_2)
	cloneTplTo = var_1_10003

	local var_16_0 = var_1_10003(arg_16_0.tpls[var_0_0.TPL_TYPE.TEXT], arg_16_0.contentTF, arg_16_0.siteId .. "_EnterText")

	setActive = var_1_10004

	var_1_10004(var_16_0:Find("name_container"), true)

	setActive = var_1_10004

	var_1_10004(var_16_0:Find("name_container/left"), true)

	setActive = var_1_10004

	var_1_10004(var_16_0:Find("name_container/right"), false)

	setText = var_1_10004

	var_1_10004(var_16_0:Find("name_container/left"), arg_16_1)

	setText = var_1_10004

	var_1_10004(var_16_0:Find("text"), arg_16_2)

	return
end

function var_0_0.Play(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if not arg_17_0.callName then
		getProxy = var_4
		NewEducateProxy = var_1_10006
		var_1_10006 = var_4(var_1_10006)
		var_1_10006 = var_4.GetCurChar(var_1_10006)
		arg_17_0.callName = var_4.GetCallName(var_1_10006)
	end

	local function var_17_0(...)
		existCall = var_2_10000

		var_2_10000(arg_17_2(...))

		scrollTo = var_2_10000

		var_2_10000(arg_17_0.scrollrect, 0, 0)

		return
	end

	table = var_1_10005

	var_1_10005.insert(arg_17_0.passNodeIds, arg_17_1)

	pg = var_5

	local var_17_1 = var_5.child2_node[arg_17_1]

	switch = var_1_10006

	local var_17_2 = var_17_1.type
	local var_17_3 = {}

	NewEducateNodePanel = var_1_10010
	var_17_3[var_1_10010.NODE_TYPE.EVENT_TEXT] = function()
		local var_19_0 = arg_17_0

		var_0.AddText(var_19_0, var_17_1, var_17_0)

		return
	end
	NewEducateNodePanel = var_10
	var_17_3[var_10.NODE_TYPE.EVENT_OPTION] = function()
		local var_20_0 = arg_17_0

		var_0.AddOption(var_20_0, var_17_1, var_17_0)

		return
	end
	NewEducateNodePanel = var_10
	var_17_3[var_10.NODE_TYPE.DROP] = function()
		local var_21_0 = arg_17_0

		var_0.AddDrops(var_21_0, arg_17_1, arg_17_3, var_17_0)

		return
	end

	var_1_10006(var_17_2, var_17_3)

	return
end

function var_0_0._GetText(arg_22_0, arg_22_1)
	pg = var_1_10002

	local var_22_0 = var_1_10002.child2_word[arg_22_1].word

	string = var_1_10003

	return var_1_10003.gsub(var_22_0, "$1", arg_22_0.callName)
end

function var_0_0.UpdateOption(arg_23_0, arg_23_1, arg_23_2)
	arg_23_2.name = arg_23_0.optionIds[arg_23_1 + 1]
	pg = var_4

	local var_23_0 = var_4.child2_node[var_3]

	setScrollText = var_1_10005

	var_1_10005(arg_23_2:Find("mask/name"), arg_23_0:_GetText(var_23_0.text))

	getProxy = var_1_10005
	NewEducateProxy = var_7

	local var_23_1 = var_1_10005(var_7)
	local var_23_2 = var_5.GetCurChar(var_23_1)
	local var_23_3 = var_23_0.performance_param

	setActive = var_23_1

	var_23_1(arg_23_2:Find("bg"), var_23_3 ~= "")

	if var_23_3 ~= "" then
		if var_23_3 == 3 then
			LoadImageSpriteAtlasAsync = var_23_1

			var_23_1("ui/neweducatenodeui_atlas", "option_bg" .. var_23_3, arg_23_2:Find("bg"))
		else
			local var_23_4 = var_23_2:GetPersonalityTagOptionBg(var_23_3)

			LoadImageSpriteAsync = var_8

			var_8("neweducateicon/" .. var_23_4, arg_23_2:Find("bg"))
		end
	end

	local var_23_5 = false

	if #var_23_0.option_condition > 0 then
		var_23_5 = not var_23_2:IsMatchComplex(var_23_0.option_condition)
	end

	setActive = var_8

	local var_23_6 = arg_23_2:Find("cost")
	local var_23_7 = #var_23_0.option_cost

	var_8(var_23_6, 0 < var_23_7)

	NewEducateHelper = var_8

	local var_23_8

	if #var_8.Config2Drops(var_23_0.option_cost) > 0 then
		UIItemList = var_9
		var_23_8 = var_9.New(arg_23_2:Find("cost"), arg_23_2:Find("cost/tpl"))

		var_9.make(var_23_8, function(arg_24_0, arg_24_1, arg_24_2)
			UIItemList = var_2_10003

			if arg_24_0 == var_2_10003.EventUpdate then
				local var_24_0 = var_0[arg_24_1 + 1]

				NewEducateHelper = var_4

				local var_24_1 = var_4.GetDropConfig(var_24_0).icon

				LoadImageSpriteAsync = var_2_10005

				var_2_10005("neweducateicon/" .. var_24_1, arg_24_2:Find("Image"))

				setText = var_2_10005

				var_2_10005(arg_24_2:Find("Text"), "-" .. var_24_0.number)
			end

			return
		end)

		var_23_8 = var_9

		var_9.align(var_23_8, #var_8)

		underscore = var_10

		local var_23_9 = var_10.map(var_8, function(arg_25_0)
			arg_25_0.operator = ">="

			return arg_25_0
		end)

		var_23_5 = var_23_5 or not var_23_2:IsMatchs(var_23_9)
	end

	setImageColor = var_9

	local var_23_10 = arg_23_2

	Color = var_23_8

	var_9(var_23_10, var_23_8.NewHex(var_23_5 and "C8CAD5" or "FFFFFF"))

	setTextColor = var_9

	local var_23_11 = arg_23_2:Find("mask/name")

	Color = var_12

	var_9(var_23_11, var_12.NewHex(var_23_5 and "717171" or "393A3C"))

	if not var_23_5 then
		onButton = var_9

		local var_23_12 = arg_23_0
		local var_23_13 = arg_23_2

		local function var_23_14()
			existCall = var_2_10000

			var_2_10000(arg_23_0.callback(var_0, var_0))

			return
		end

		SFX_PANEL = var_14

		var_9(var_23_12, var_23_13, var_23_14, var_14)
	else
		removeOnButton = var_9

		var_9(arg_23_2)
	end

	return
end

function var_0_0.AddText(arg_27_0, arg_27_1, arg_27_2)
	NewEducateConst = var_1_10003
	arg_27_0.speed = var_1_10003.TYPEWRITE_SPEED
	cloneTplTo = var_3

	local var_27_0 = var_3(arg_27_0.tpls[var_0_0.TPL_TYPE.TEXT], arg_27_0.contentTF, arg_27_1.id)
	local var_27_1 = arg_27_1.name ~= 0

	setActive = var_5

	var_5(var_27_0:Find("name_container"), var_27_1)

	local var_27_2 = false
	local var_27_5

	if var_27_1 then
		pg = var_6

		local var_27_3 = var_6.child2_word[arg_27_1.name]
		local var_27_4 = arg_27_0

		var_27_5 = arg_27_0._GetText(var_27_4, var_27_3.id)

		local var_27_6 = var_27_3.char_type

		NewEducateConst = var_27_4

		if var_27_6 == var_27_4.WORD_TYPE.SITE_LEFT then
			setActive = var_27_6
			var_1_10012 = var_27_0

			var_27_6(var_27_0.Find(var_1_10012, "name_container/left"), true)

			setActive = var_27_6
			var_1_10012 = var_27_0

			var_27_6(var_27_0.Find(var_1_10012, "name_container/right"), false)

			setText = var_27_6
			var_1_10012 = var_27_0

			var_27_6(var_27_0.Find(var_1_10012, "name_container/left"), var_27_5)
		else
			local var_27_7 = var_27_3.char_type

			NewEducateConst = var_9

			if var_27_7 == var_9.WORD_TYPE.SITE_RIGHT then
				var_27_2 = true
				setActive = var_27_7
				var_1_10012 = var_27_0

				var_27_7(var_27_0.Find(var_1_10012, "name_container/left"), false)

				setActive = var_27_7
				var_1_10012 = var_27_0

				var_27_7(var_27_0.Find(var_1_10012, "name_container/right"), true)

				setText = var_27_7
				var_1_10012 = var_27_0

				var_27_7(var_27_0.Find(var_1_10012, "name_container/right"), var_27_5)
			end
		end
	end

	local var_27_8 = arg_27_0:_GetText(arg_27_1.text)

	if var_27_2 then
		GetPerceptualSize = var_27_5

		if var_27_5(var_27_8) < 22 then
			local var_27_9 = var_27_0:Find("text")

			var_27_5 = var_27_5.GetComponent
			typeof = var_10
			Text = var_1_10012
			var_27_5 = var_27_5(var_27_9, var_10(var_1_10012))
			TextAnchor = var_8
			var_27_5.alignment = var_8.UpperRight
		end
	end

	setText = var_27_5

	var_27_5(var_27_0:Find("text"), var_27_8)

	GetComponent = var_27_5

	local var_27_10 = var_27_0:Find("text")

	typeof = var_10
	Typewriter = var_12

	local var_27_11 = var_27_5(var_27_10, var_10(var_12))

	function var_27_11.endFunc()
		local var_28_0 = arg_27_1.next_type

		NewEducateNodePanel = var_2_10001

		if var_28_0 == var_2_10001.NEXT_TYPE.OPTION then
			local var_28_1 = arg_27_0
			local var_28_2 = arg_27_0

			var_28_1.optionIds = var_1.FilterOptions(var_28_2, arg_27_1.next)
			arg_27_0.callback = arg_27_2

			local var_28_3 = arg_27_0.optionUIList

			var_0.align(var_28_3, #arg_27_0.optionIds)
		else
			local var_28_4 = arg_27_0.optionUIList

			var_0.align(var_28_4, #arg_27_0.optionIds)

			existCall = var_0

			var_0(arg_27_2)
		end

		local var_28_5 = arg_27_0

		var_0.StopAutoScroll(var_28_5)

		scrollTo = var_0

		var_0(arg_27_0.scrollrect, 0, 0)

		return
	end

	var_27_11:setSpeed(arg_27_0.speed)
	var_27_11:Play()

	local var_27_12 = arg_27_0.speed

	NewEducateConst = var_27_10

	if var_27_12 ~= var_27_10.TYPEWRITE_SPEED_UP then
		onButton = var_27_12

		var_27_12(arg_27_0, arg_27_0.windowTF, function()
			removeOnButton = var_2_10000

			var_2_10000(arg_27_0.windowTF)

			local var_29_0 = arg_27_0

			NewEducateConst = var_2_10001
			var_29_0.speed = var_2_10001.TYPEWRITE_SPEED_UP

			local var_29_1 = var_27_11

			var_0.setSpeed(var_29_1, arg_27_0.speed)

			return
		end)
	end

	arg_27_0:StartAutoScroll()

	return
end

function var_0_0.FilterOptions(arg_30_0, arg_30_1)
	getProxy = var_1_10002
	NewEducateProxy = var_1_10004

	local var_30_0 = var_1_10002(var_1_10004)
	local var_30_1 = var_2.GetCurChar(var_30_0)

	underscore = var_1_10003

	return var_1_10003.select(arg_30_1, function(arg_31_0)
		pg = var_2_10001

		if var_2_10001.child2_node[arg_31_0].option_condition_show == 0 then
			return true
		end

		local var_31_0 = false

		if #var_1.option_condition > 0 then
			local var_31_1 = var_30_1

			var_31_0 = not var_3.IsMatchComplex(var_31_1, var_1.option_condition)
		end

		return not var_31_0
	end)
end

function var_0_0.AddOption(arg_32_0, arg_32_1, arg_32_2)
	cloneTplTo = var_1_10003

	local var_32_0 = var_1_10003(arg_32_0.tpls[var_0_0.TPL_TYPE.OPTION], arg_32_0.contentTF, arg_32_1.id)

	pg = var_1_10004

	local var_32_1 = var_1_10004.child2_word[arg_32_1.text].char_type

	NewEducateConst = var_5

	if var_32_1 == var_5.WORD_TYPE.CHILD then
		setActive = var_5

		var_5(var_32_0:Find("name_container"), true)

		setText = var_5

		var_5(var_32_0:Find("name_container/name"), arg_32_0.charName)
	else
		NewEducateConst = var_5

		if var_32_1 == var_5.WORD_TYPE.PLAYER then
			setActive = var_5

			var_5(var_32_0:Find("name_container"), true)

			setText = var_5

			var_5(var_32_0:Find("name_container/name"), arg_32_0.playerName)
		else
			setActive = var_5

			var_5(var_32_0:Find("name_container"), false)
		end
	end

	setText = var_5

	var_5(var_32_0:Find("text"), ">>" .. arg_32_0:_GetText(arg_32_1.text))

	local var_32_2 = arg_32_1.next_type

	NewEducateNodePanel = var_6

	if var_32_2 == var_6.NEXT_TYPE.OPTION then
		arg_32_0.optionIds = arg_32_1.next
		arg_32_0.callback = arg_32_2

		local var_32_3 = arg_32_0.optionUIList

		var_5.align(var_32_3, #arg_32_0.optionIds)
	else
		arg_32_0.optionIds = {}

		local var_32_4 = arg_32_0.optionUIList

		var_5.align(var_32_4, #arg_32_0.optionIds)

		existCall = var_5

		var_5(arg_32_2)
	end

	return
end

function var_0_0.AddDrops(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	cloneTplTo = var_1_10004

	local var_33_0 = var_1_10004(arg_33_0.tpls[var_0_0.TPL_TYPE.DROP], arg_33_0.contentTF, arg_33_1)

	setActive = var_1_10005

	var_1_10005(var_33_0:Find("tpl"), false)

	local var_33_1 = {}

	NewEducateHelper = var_6

	local var_33_2 = var_6.MergeDrops(arg_33_2)

	ipairs = var_7

	for iter_33_0, iter_33_1 in var_7(var_33_2) do
		table = var_1_10012

		var_1_10012.insert(var_33_1, function(arg_34_0)
			cloneTplTo = var_2_10001

			local var_34_0 = var_33_0
			local var_34_1 = var_2_10001(var_3.Find(var_34_0, "tpl"), var_33_0, iter_33_1.type .. "_" .. iter_33_1.id)
			local var_34_2 = arg_33_0

			var_2.UpdateDropText(var_34_2, iter_33_1, var_34_1, arg_34_0)

			return
		end)
	end

	seriesAsync = var_7

	var_7(var_33_1, function()
		underscore = var_2_10000

		if var_2_10000.reduce(var_33_2, 0, function(arg_36_0, arg_36_1)
			NewEducateHelper = var_3_10002

			local var_36_0

			if not var_3_10002.IsPersonalDrop(arg_36_1) or not arg_36_1.number then
				var_36_0 = 0
			end

			return arg_36_0 + var_36_0
		end) ~= 0 then
			local var_35_0 = arg_33_0

			var_2_10001.CheckPersonalChange(var_35_0, var_0)
		end

		existCall = var_2_10001

		var_2_10001(arg_33_3)

		return
	end)

	return
end

function var_0_0.UpdateDropText(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	NewEducateConst = var_1_10004
	arg_37_0.speed = var_1_10004.TYPEWRITE_SPEED
	NewEducateHelper = var_4

	local var_37_0 = var_4.GetDropConfig(arg_37_1)

	getProxy = var_1_10005
	NewEducateProxy = var_1_10007

	local var_37_1 = var_1_10005(var_1_10007)
	local var_37_2 = var_5.GetCurChar(var_37_1)

	NewEducateHelper = var_6

	local var_37_3

	if var_6.IsPersonalDrop(arg_37_1) then
		var_37_3 = arg_37_1.number

		if not (0 < var_37_3) or not var_37_2:GetPersonalityTagTip(2) then
			var_37_3 = var_37_2:GetPersonalityTagTip(1)
		end

		setText = var_37_1

		local var_37_4 = arg_37_2:Find("content/value")

		var_1_10010 = var_37_3

		local var_37_5 = "+"

		math = var_12

		var_37_1(var_37_4, var_1_10010 .. var_37_5 .. var_12.abs(arg_37_1.number))
	else
		var_37_3 = arg_37_1.type
		NewEducateConst = var_37_1

		if var_37_3 ~= var_37_1.DROP_TYPE.ATTR then
			var_37_3 = arg_37_1.type
			NewEducateConst = var_37_6

			if var_37_3 ~= var_37_6.DROP_TYPE.RES then
				var_37_3 = false

				goto label_37_0
			end
		end

		var_37_3 = true

		do
			local var_37_6
		end

		::label_37_0::

		if var_37_3 then
			var_37_6 = arg_37_1.number > 0 and "child2_site_drop_add" or "child2_site_drop_reduce"
			var_1_10010 = var_37_2

			local var_37_7 = var_37_2.GetOwnCnt(var_1_10010, arg_37_1) - arg_37_1.number

			if not arg_37_1.overflow then
				var_1_10010 = 0
			end

			local var_37_8 = var_37_7 + var_1_10010

			math = var_1_10010
			var_1_10010 = var_1_10010.abs

			local var_37_9 = arg_37_1.number
			local var_37_10

			if not arg_37_1.overflow then
				var_37_10 = 0
			end

			var_1_10010 = var_1_10010(var_37_9 - var_37_10)
			setText = var_11

			local var_37_11 = arg_37_2:Find("content/value")

			i18n = var_1_10014

			var_11(var_37_11, var_1_10014(var_37_6, var_37_0.name, var_37_8, var_8, var_1_10010))
		else
			setText = var_37_6

			local var_37_12 = arg_37_2:Find("content/value")

			i18n = var_1_10010

			var_37_6(var_37_12, var_1_10010("child2_site_drop_item", var_37_0.name))
		end
	end

	setActive = var_37_3

	var_37_3(arg_37_2:Find("content/benefit"), false)

	GetComponent = var_37_3

	local var_37_13 = arg_37_2:Find("content/value")

	typeof = var_9
	Typewriter = var_11

	local var_37_14 = var_37_3(var_37_13, var_9(var_11))

	function var_37_14.endFunc()
		onDelayTick = var_2_10000

		var_2_10000(function()
			existCall = var_3_10000

			var_3_10000(arg_37_3)

			return
		end, 0.5)

		return
	end

	var_37_14:setSpeed(arg_37_0.speed)

	isActive = var_7

	if not var_7(arg_37_0._tf) then
		existCall = var_7

		var_7(arg_37_3)
	else
		var_37_14:Play()

		local var_37_15 = arg_37_0.speed

		NewEducateConst = var_37_13

		if var_37_15 ~= var_37_13.TYPEWRITE_SPEED_UP then
			onButton = var_37_15

			var_37_15(arg_37_0, arg_37_0.windowTF, function()
				removeOnButton = var_2_10000

				var_2_10000(arg_37_0.windowTF)

				local var_40_0 = arg_37_0

				NewEducateConst = var_2_10001
				var_40_0.speed = var_2_10001.TYPEWRITE_SPEED_UP

				local var_40_1 = var_37_14

				var_0.setSpeed(var_40_1, arg_37_0.speed)

				return
			end)
		end

		scrollTo = var_37_15

		var_37_15(arg_37_0.scrollrect, 0, 0)
	end

	return
end

function var_0_0.CheckPersonalChange(arg_41_0, arg_41_1)
	NewEducateConst = var_1_10002
	arg_41_0.speed = var_1_10002.TYPEWRITE_SPEED
	getProxy = var_2
	NewEducateProxy = var_1_10004

	local var_41_0 = var_2(var_1_10004)
	local var_41_1 = var_2.GetCurChar(var_41_0)
	local var_41_2 = var_2.GetPersonalityTag(var_41_1)

	if var_2:GetPersonalityTag(var_2:GetPersonality() - arg_41_1) ~= var_41_2 then
		cloneTplTo = var_41_1

		local var_41_3 = var_41_1(arg_41_0.tpls[var_0_0.TPL_TYPE.DROP], arg_41_0.contentTF, "personal_change")
		local var_41_4 = var_5.Find(var_41_3, "tpl")
		local var_41_5

		if not (arg_41_1 > 0) or not var_2:GetPersonalityTagTip(2) then
			var_41_5 = var_2:GetPersonalityTagTip(1)
		end

		setText = var_41_3

		local var_41_6 = var_41_4:Find("content/value")

		i18n = var_1_10011

		var_41_3(var_41_6, var_1_10011("child2_personal_change") .. ">>" .. var_41_5)

		setActive = var_41_3

		var_41_3(var_41_4:Find("content/benefit"), false)

		GetComponent = var_41_3

		local var_41_7 = var_41_4:Find("content/value")

		typeof = var_11
		Typewriter = var_13

		local var_41_8 = var_41_3(var_41_7, var_11(var_13))

		function var_41_8.endFunc()
			return
		end

		var_41_8:setSpeed(arg_41_0.speed)
		var_41_8:Play()

		local var_41_9 = arg_41_0.speed

		NewEducateConst = var_41_7

		if var_41_9 ~= var_41_7.TYPEWRITE_SPEED_UP then
			onButton = var_41_9

			var_41_9(arg_41_0, arg_41_0.windowTF, function()
				removeOnButton = var_2_10000

				var_2_10000(arg_41_0.windowTF)

				local var_43_0 = arg_41_0

				NewEducateConst = var_2_10001
				var_43_0.speed = var_2_10001.TYPEWRITE_SPEED_UP

				local var_43_1 = var_41_8

				var_0.setSpeed(var_43_1, arg_41_0.speed)

				return
			end)
		end

		scrollTo = var_41_9

		var_41_9(arg_41_0.scrollrect, 0, 0)
	end

	return
end

function var_0_0.AddFavorUpgrade(arg_44_0)
	NewEducateConst = var_1_10001
	arg_44_0.speed = var_1_10001.TYPEWRITE_SPEED
	cloneTplTo = var_1

	local var_44_0 = var_1(arg_44_0.tpls[var_0_0.TPL_TYPE.DROP], arg_44_0.contentTF, "favor_drop")
	local var_44_1 = var_1.Find(var_44_0, "tpl")

	pg = var_3

	local var_44_2 = var_3.child2_site_display[arg_44_0.siteId]

	pg = var_4

	local var_44_3 = var_4.child2_site_character[var_44_2.param].level + 1

	setText = var_5

	local var_44_4 = var_44_1:Find("content/value")

	i18n = var_1_10008

	var_5(var_44_4, var_1_10008("child2_ship_upgrade_favor", var_44_2.name, var_44_3))

	setActive = var_5

	var_5(var_44_1:Find("content/benefit"), false)

	GetComponent = var_5

	local var_44_5 = var_44_1:Find("content/value")

	typeof = var_8
	Typewriter = var_10

	local var_44_6 = var_5(var_44_5, var_8(var_10))

	function var_44_6.endFunc()
		return
	end

	var_44_6:setSpeed(arg_44_0.speed)
	var_44_6:Play()

	local var_44_7 = arg_44_0.speed

	NewEducateConst = var_44_5

	if var_44_7 ~= var_44_5.TYPEWRITE_SPEED_UP then
		onButton = var_44_7

		var_44_7(arg_44_0, arg_44_0.windowTF, function()
			removeOnButton = var_2_10000

			var_2_10000(arg_44_0.windowTF)

			local var_46_0 = arg_44_0

			NewEducateConst = var_2_10001
			var_46_0.speed = var_2_10001.TYPEWRITE_SPEED_UP

			local var_46_1 = var_44_6

			var_0.setSpeed(var_46_1, arg_44_0.speed)

			return
		end)
	end

	scrollTo = var_44_7

	var_44_7(arg_44_0.scrollrect, 0, 0)

	pg = var_44_7

	local var_44_8 = var_44_7.m02
	local var_44_9 = var_6.sendNotification

	NewEducateMapMediator = var_9

	var_44_9(var_44_8, var_9.ON_SHIP_UPGRADE_LEVEL)

	return
end

function var_0_0.Reset(arg_47_0)
	setActive = var_1_10001

	var_1_10001(arg_47_0._go, false)

	setActive = var_1_10001

	var_1_10001(arg_47_0.endOptionsTF, false)

	setActive = var_1_10001

	var_1_10001(arg_47_0.closeBtn, false)

	setActive = var_1_10001

	var_1_10001(arg_47_0.closeBtn2, false)

	removeAllChildren = var_1_10001

	var_1_10001(arg_47_0.contentTF)
	arg_47_0:StopAutoScroll()

	arg_47_0.dropRecords = {}
	arg_47_0.passNodeIds = {}
	arg_47_0.optionIds = {}
	arg_47_0.callback = nil
	arg_47_0.siteId = 0
	NewEducateConst = var_1
	arg_47_0.speed = var_1.TYPEWRITE_SPEED
	removeOnButton = var_1

	var_1(arg_47_0.windowTF)

	return
end

function var_0_0.BindEndBtn(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	onButton = var_1_10004

	local var_48_0 = arg_48_0
	local var_48_1 = arg_48_0.endBtn

	local function var_48_2()
		existCall = var_2_10000

		var_2_10000(arg_48_1)

		return
	end

	SFX_PANEL = var_1_10009

	var_1_10004(var_48_0, var_48_1, var_48_2, var_1_10009)

	onButton = var_1_10004

	local var_48_3 = arg_48_0
	local var_48_4 = arg_48_0.closeBtn

	local function var_48_5()
		existCall = var_2_10000

		var_2_10000(arg_48_1)

		return
	end

	SFX_PANEL = var_1_10009

	var_1_10004(var_48_3, var_48_4, var_48_5, var_1_10009)

	onButton = var_1_10004

	local var_48_6 = arg_48_0
	local var_48_7 = arg_48_0.closeBtn2

	local function var_48_8()
		existCall = var_2_10000

		var_2_10000(arg_48_1)

		return
	end

	SFX_PANEL = var_1_10009

	var_1_10004(var_48_6, var_48_7, var_48_8, var_1_10009)

	arg_48_0.onSiteEnd = arg_48_2
	arg_48_0.onNormal = arg_48_3

	return
end

function var_0_0.AddDropRecords(arg_52_0, arg_52_1)
	table = var_1_10002
	arg_52_0.dropRecords = var_1_10002.mergeArray(arg_52_0.dropRecords, arg_52_1)

	return
end

function var_0_0.OnEventEnd(arg_53_0)
	setActive = var_1_10001

	var_1_10001(arg_53_0._tf, true)

	existCall = var_1_10001

	var_1_10001(arg_53_0.onSiteEnd)
	arg_53_0:UpdateAgainBtn()

	setActive = var_1

	var_1(arg_53_0.endOptionsTF, true)

	setActive = var_1

	var_1(arg_53_0.closeBtn, true)

	setActive = var_1

	var_1(arg_53_0.closeBtn2, true)

	pg = var_1

	local var_53_0 = var_1.child2_site_display[arg_53_0.siteId].type

	NewEducateConst = var_2

	if var_53_0 == var_2.SITE_TYPE.SHIP then
		arg_53_0:AddFavorUpgrade()
	end

	return
end

function var_0_0.UpdateAgainBtn(arg_54_0)
	pg = var_1_10001

	local var_54_0 = var_1_10001.child2_site_display[arg_54_0.siteId].type

	NewEducateConst = var_2

	local var_54_1

	if var_54_0 ~= var_2.SITE_TYPE.WORK then
		NewEducateConst = var_2

		if var_54_0 ~= var_2.SITE_TYPE.TRAVEL then
			var_54_1 = false

			goto label_54_0
		end
	end

	var_54_1 = true

	::label_54_0::

	setActive = var_1_10003

	var_1_10003(arg_54_0.againBtn, var_54_1)

	if var_54_1 then
		getProxy = var_1_10003
		NewEducateProxy = var_5

		local var_54_2 = var_1_10003(var_5)
		local var_54_3 = var_3.GetCurChar(var_54_2)

		NewEducateConst = var_1_10004

		if var_54_0 == var_1_10004.SITE_TYPE.WORK then
			NewEducateConst = var_54_4

			local var_54_4

			if not var_54_4.SITE_NORMAL_TYPE.WORK then
				NewEducateConst = var_54_4
				var_54_4 = var_54_4.SITE_NORMAL_TYPE.TRAVEL
			end

			local var_54_5 = var_54_3
			local var_54_6 = var_54_3.GetNormalIdByType(var_54_5, var_54_4)

			NewEducateHelper = var_6

			local var_54_7 = var_6.Config2Drop

			pg = var_8

			local var_54_8 = var_54_7(var_8.child2_site_normal[var_54_6].cost)

			NewEducateHelper = var_54_5

			local var_54_9 = var_54_5.GetDropConfig(var_54_8).icon

			LoadImageSpriteAsync = var_8

			local var_54_10 = "neweducateicon/" .. var_54_9
			local var_54_11 = arg_54_0.againBtn

			var_8(var_54_10, var_11.Find(var_54_11, "cost/Image"))

			setText = var_8

			local var_54_12 = arg_54_0.againBtn

			var_8(var_10.Find(var_54_12, "cost/Text"), "-" .. var_54_8.number)

			var_54_8.operator = ">="

			local var_54_13 = not var_54_3:IsMatch(var_54_8)

			setImageColor = var_9

			local var_54_14 = arg_54_0.againBtn

			Color = var_12

			var_9(var_54_14, var_12.NewHex(var_54_13 and "C8CAD5" or "FFFFFF"))

			setTextColor = var_9

			local var_54_15 = arg_54_0.againBtn
			local var_54_16 = var_11.Find(var_54_15, "mask/Text")

			Color = var_12

			var_9(var_54_16, var_12.NewHex(var_54_13 and "717171" or "393A3C"))

			if not var_54_13 then
				onButton = var_9

				local var_54_17 = arg_54_0
				local var_54_18 = arg_54_0.againBtn

				local function var_54_19()
					pg = var_2_10000

					local var_55_0 = var_2_10000.m02
					local var_55_1 = var_0.sendNotification

					GAME = var_2_10003

					var_55_1(var_55_0, var_2_10003.NEW_EDUCATE_MAP_NORMAL, {
						id = var_54_3.id,
						normalId = var_54_6
					})

					existCall = var_55_1

					var_55_1(arg_54_0.onNormal)

					return
				end

				SFX_PANEL = var_14

				var_9(var_54_17, var_54_18, var_54_19, var_14)
			else
				removeOnButton = var_9

				var_9(arg_54_0.againBtn)
			end

			return
		end
	end
end

function var_0_0.StartAutoScroll(arg_56_0)
	Timer = var_1_10001
	arg_56_0.timer = var_1_10001.New(function()
		scrollTo = var_2_10000

		var_2_10000(arg_56_0.scrollrect, 0, 0)

		return
	end, 0.4, -1)

	local var_56_0 = arg_56_0.timer

	var_1.Start(var_56_0)

	return
end

function var_0_0.StopAutoScroll(arg_58_0)
	if arg_58_0.timer then
		local var_58_0 = arg_58_0.timer

		var_1.Stop(var_58_0)

		arg_58_0.timer = nil
	end

	return
end

function var_0_0.UpdateCallName(arg_59_0)
	getProxy = var_1_10001
	NewEducateProxy = var_1_10003

	local var_59_0 = var_1_10001(var_1_10003)
	local var_59_1 = var_1.GetCurChar(var_59_0)

	arg_59_0.callName = var_1.GetCallName(var_59_1)

	return
end

function var_0_0.Destroy(arg_60_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_60_0)

	return
end

return var_0_0
