class = var_0_10000

local var_0_0 = "ShipEvaluationLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.EVENT_LIKE = "event like"
var_0_1.EVENT_EVA = "event eva"
var_0_1.EVENT_ZAN = "event zan"
var_0_1.EVENT_IMPEACH = "event impeach"

function var_0_1.getUIName(arg_1_0)
	return "EvaluationUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.mainPanel = var_1.Find(var_2_0, "mainPanel")

	local var_2_1 = arg_2_0.mainPanel

	arg_2_0.head = var_1.Find(var_2_1, "bg/left_panel/ship_tpl")

	local var_2_2 = arg_2_0.mainPanel

	arg_2_0.labelHeart = var_1.Find(var_2_2, "bg/left_panel/evaluation_count/heart")

	local var_2_3 = arg_2_0.mainPanel

	arg_2_0.labelEva = var_1.Find(var_2_3, "bg/left_panel/evaluation_count/count")

	local var_2_4 = arg_2_0.mainPanel

	arg_2_0.btnLike = var_1.Find(var_2_4, "bg/left_panel/btnLike")

	local var_2_5 = arg_2_0.mainPanel

	arg_2_0.btnEva = var_1.Find(var_2_5, "bg/bottom_panel/send_btn")

	local var_2_6 = arg_2_0.mainPanel

	arg_2_0.input = var_1.Find(var_2_6, "bg/bottom_panel/Input")

	local var_2_7 = arg_2_0.input

	arg_2_0.inputText = var_1.Find(var_2_7, "Text")

	local var_2_8 = arg_2_0.mainPanel

	arg_2_0.list = var_1.Find(var_2_8, "bg/right_panel/list")

	local var_2_9 = arg_2_0.list

	arg_2_0.hotContent = var_1.Find(var_2_9, "content/hots")

	local var_2_10 = arg_2_0.list

	arg_2_0.commonContent = var_1.Find(var_2_10, "content/commons")

	local var_2_11 = arg_2_0.list

	arg_2_0.hotTpl = var_1.Find(var_2_11, "content/hot_tpl")

	local var_2_12 = arg_2_0.list

	arg_2_0.commonTpl = var_1.Find(var_2_12, "content/commom_tpl")
	findTF = var_1

	local var_2_13 = var_1(arg_2_0.head, "content/main_bg/type_mask/type_icon")
	local var_2_14 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.iconType = var_2_14(var_2_13, var_4(var_1_10006))
	findTF = var_1

	local var_2_15 = var_1(arg_2_0.head, "content/icon_bg")
	local var_2_16 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.imageBg = var_2_16(var_2_15, var_4(var_1_10006))
	findTF = var_1
	arg_2_0.imageFrame = var_1(arg_2_0.head, "content/main_bg/frame")
	findTF = var_1

	local var_2_17 = var_1(arg_2_0.head, "content/icon")
	local var_2_18 = var_1.GetComponent

	typeof = var_4
	Image = var_1_10006
	arg_2_0.iconShip = var_2_18(var_2_17, var_4(var_1_10006))
	findTF = var_1

	local var_2_19 = var_1(arg_2_0.head, "content/main_bg/name_mask/name")
	local var_2_20 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.labelName = var_2_20(var_2_19, var_4(var_1_10006))
	findTF = var_1

	local var_2_21 = var_1(arg_2_0.head, "content/main_bg/name_mask/name")
	local var_2_22 = var_1.GetComponent

	typeof = var_4
	ScrollText = var_1_10006
	arg_2_0.scrollText = var_2_22(var_2_21, var_4(var_1_10006))
	findTF = var_1
	arg_2_0.stars = var_1(arg_2_0.head, "content/main_bg/stars")
	findTF = var_1
	arg_2_0.star = var_1(arg_2_0.stars, "tpl")

	local var_2_23 = arg_2_0._tf

	arg_2_0.bg = var_1.Find(var_2_23, "BG")

	local var_2_24 = arg_2_0._tf

	arg_2_0.btnHelp = var_1.Find(var_2_24, "mainPanel/bg/top_panel/title/help")
	setActive = var_1

	local var_2_25 = arg_2_0.btnHelp

	getProxy = var_4
	PlayerProxy = var_1_10006

	local var_2_26 = var_4(var_1_10006)
	local var_2_27 = var_4.getRawData(var_2_26)

	var_1(var_2_25, var_4.IsOpenShipEvaluationImpeach(var_2_27))
	arg_2_0:initImpeachPanel()

	setActive = var_1

	var_1(arg_2_0.mainPanel, true)

	setActive = var_1

	var_1(arg_2_0.impackPanel, false)

	pg = var_1

	local var_2_28 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_28, arg_2_0._tf)

	return
end

function var_0_1.onBackPressed(arg_3_0)
	isActive = var_1_10001

	if var_1_10001(arg_3_0.impackPanel) then
		setActive = var_1

		var_1(arg_3_0.mainPanel, true)

		setActive = var_1

		var_1(arg_3_0.impackPanel, false)
	else
		arg_3_0:closeView()
	end

	return
end

function var_0_1.didEnter(arg_4_0)
	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.bg

	local function var_4_2()
		local var_5_0 = arg_4_0

		var_0.onBackPressed(var_5_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10006)

	onButton = var_1_10001

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0._tf
	local var_4_5 = var_4.Find(var_4_4, "mainPanel/bg/top_panel/btnBack")

	local function var_4_6()
		local var_6_0 = arg_4_0

		var_0.onBackPressed(var_6_0)

		return
	end

	SFX_CANCEL = var_4_4

	var_1_10001(var_4_3, var_4_5, var_4_6, var_4_4)

	onButton = var_1_10001

	local var_4_7 = arg_4_0
	local var_4_8 = arg_4_0.btnHelp

	local function var_4_9()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_7_2.type = var_2_10004
		i18n = var_2_10004
		var_7_2.helps = var_2_10004("report_sent_help")

		var_7_1(var_7_0, var_7_2)

		return
	end

	SFX_PANEL = var_4_4

	var_1_10001(var_4_7, var_4_8, var_4_9, var_4_4)

	onButton = var_1_10001

	local var_4_10 = arg_4_0
	local var_4_11 = arg_4_0.btnLike

	local function var_4_12()
		local var_8_0 = arg_4_0

		var_0.emit(var_8_0, var_0_1.EVENT_LIKE)

		return
	end

	SFX_PANEL = var_4_4

	var_1_10001(var_4_10, var_4_11, var_4_12, var_4_4)

	onButton = var_1_10001

	local var_4_13 = arg_4_0
	local var_4_14 = arg_4_0.btnEva

	local function var_4_15()
		getInputText = var_2_10000

		local var_9_0 = var_2_10000(arg_4_0.input)

		string = var_2_10001

		if var_2_10001.len(var_9_0) > 0 then
			setInputText = var_1

			var_1(arg_4_0.input, "")

			local var_9_1 = arg_4_0

			var_1.emit(var_9_1, var_0_1.EVENT_EVA, var_9_0)
		else
			pg = var_1

			local var_9_2 = var_1.TipsMgr.GetInstance()
			local var_9_3 = var_1.ShowTips

			i18n = var_2_10004

			var_9_3(var_9_2, var_2_10004("eva_comment_send_null"))
		end

		return
	end

	SFX_PANEL = var_4_4

	var_1_10001(var_4_13, var_4_14, var_4_15, var_4_4)

	onInputChanged = var_1_10001

	var_1_10001(arg_4_0, arg_4_0.input, function()
		getInputText = var_2_10000

		local var_10_0 = var_2_10000(arg_4_0.input)
		local var_10_1
		local var_10_2

		string = var_2_10003

		local var_10_3 = var_2_10003.len(var_10_0)

		if 0 < var_10_3 then
			var_10_3 = arg_4_0.shipGroup.evaluation.ievaCount
			CollectionProxy = var_4

			if var_10_3 >= var_4.MAX_DAILY_EVA_COUNT then
				var_10_1 = true
				i18n = var_10_3
				var_10_2 = var_10_3("eva_count_limit")
			else
				wordVer = var_10_3

				if var_10_3(var_10_0) > 0 then
					var_10_1 = true
					i18n = var_10_3
					var_10_2 = var_10_3("invalidate_evaluation")
				end
			end
		end

		if var_10_1 then
			setTextColor = var_10_3

			local var_10_4 = arg_4_0.inputText

			Color = var_2_10006

			var_10_3(var_10_4, var_2_10006.red)

			setButtonEnabled = var_10_3

			var_10_3(arg_4_0.btnEva, false)

			pg = var_10_3

			local var_10_5 = var_10_3.TipsMgr.GetInstance()

			var_10_3.ShowTips(var_10_5, var_10_2)
		else
			setTextColor = var_10_3

			local var_10_6 = arg_4_0.inputText

			Color = var_2_10006

			var_10_3(var_10_6, var_2_10006.white)

			setButtonEnabled = var_10_3

			var_10_3(arg_4_0.btnEva, true)
		end

		return
	end)

	return
end

function var_0_1.setShipGroup(arg_11_0, arg_11_1)
	arg_11_0.shipGroup = arg_11_1

	return
end

function var_0_1.setShowTrans(arg_12_0, arg_12_1)
	arg_12_0.showTrans = arg_12_1

	return
end

function var_0_1.flushAll(arg_13_0)
	arg_13_0:flushShip()
	arg_13_0:flushHeart()
	arg_13_0:flushEva()

	return
end

function var_0_1.flushShip(arg_14_0)
	local var_14_0 = arg_14_0.shipGroup.shipConfig
	local var_14_1 = arg_14_0.shipGroup
	local var_14_2 = var_2.getPainting(var_14_1, arg_14_0.showTrans)
	local var_14_3 = arg_14_0.shipGroup
	local var_14_4 = var_3.rarity2bgPrint(var_14_3, arg_14_0.showTrans)

	setShipCardFrame = var_14_1

	var_14_1(arg_14_0.imageFrame, var_14_4, nil)

	GetImageSpriteFromAtlasAsync = var_14_1

	var_14_1("bg/star_level_card_" .. var_14_4, "", arg_14_0.imageBg)

	local var_14_5 = arg_14_0.iconShip

	GetSpriteFromAtlas = var_14_3
	var_14_5.sprite = var_14_3("shipYardIcon/unknown", "")
	LoadImageSpriteAsync = var_14_5

	var_14_5("shipYardIcon/" .. var_14_2, arg_14_0.iconShip)

	local var_14_6 = arg_14_0.labelName
	local var_14_7 = arg_14_0.shipGroup

	var_14_6.text = var_5.getName(var_14_7, arg_14_0.showTrans)

	local var_14_9

	if arg_14_0.scrollText then
		local var_14_8 = arg_14_0.scrollText

		var_14_9 = var_14_9.SetText

		local var_14_10 = arg_14_0.shipGroup

		var_14_9(var_14_8, var_14_7.getName(var_14_10, arg_14_0.showTrans))
	end

	GetSpriteFromAtlas = var_14_9

	local var_14_11 = "shiptype"

	shipType2print = var_14_7

	local var_14_12 = arg_14_0.shipGroup

	if not var_14_9(var_14_11, var_14_7(var_9.getShipType(var_14_12, arg_14_0.showTrans))) then
		warning = var_5

		var_5("找不到船形, shipConfigId: " .. var_14_0.id)
	end

	local var_14_13 = arg_14_0.iconType

	var_14_13.sprite = var_4
	pg = var_14_13

	local var_14_14 = var_14_13.ship_data_template[var_14_0.id].star_max

	for iter_14_0 = arg_14_0.stars.childCount, var_14_14 - 1 do
		cloneTplTo = var_14_12
		var_14_12 = var_14_12(arg_14_0.star, arg_14_0.stars)
	end

	return
end

function var_0_1.flushHeart(arg_15_0)
	setButtonEnabled = var_1_10001

	var_1_10001(arg_15_0.btnLike, not arg_15_0.shipGroup.iheart)

	setText = var_1_10001

	var_1_10001(arg_15_0.labelHeart, arg_15_0.shipGroup.evaluation.hearts)

	return
end

function var_0_1.flushEva(arg_16_0)
	local var_16_0 = arg_16_0.shipGroup.evaluation

	setText = var_1_10002

	var_1_10002(arg_16_0.labelEva, var_16_0.evaCount)

	local var_16_1 = var_16_0.evas

	for iter_16_0 = 1, arg_16_0.hotContent.childCount do
		go = var_1_10007

		local var_16_2 = arg_16_0.hotContent

		if var_1_10007(var_9.GetChild(var_16_2, iter_16_0 - 1)).name ~= "tag" then
			Destroy = var_8

			var_8(var_1_10007)
		end
	end

	for iter_16_1 = 1, arg_16_0.commonContent.childCount do
		go = var_1_10007

		local var_16_3 = arg_16_0.commonContent

		if var_1_10007(var_9.GetChild(var_16_3, iter_16_1 - 1)).name ~= "tag" then
			Destroy = var_8

			var_8(var_1_10007)
		end
	end

	getProxy = var_3
	PlayerProxy = var_5

	local var_16_4 = var_3(var_5)
	local var_16_5 = var_3.getRawData(var_16_4)
	local var_16_6 = var_3.IsOpenShipEvaluationImpeach(var_16_5)

	for iter_16_2 = 1, #var_16_1 do
		local var_16_7

		if var_16_1[iter_16_2].hot then
			cloneTplTo = var_1_10010
			var_16_7 = var_1_10010(arg_16_0.hotTpl, arg_16_0.hotContent)
		else
			cloneTplTo = var_1_10010
			var_16_7 = var_1_10010(arg_16_0.commonTpl, arg_16_0.commonContent)
		end

		local var_16_8 = var_16_7:Find("bg/evaluation")

		var_1_10010 = var_1_10010.GetComponent
		typeof = var_13
		Text = var_1_10015
		var_1_10010 = var_1_10010(var_16_8, var_13(var_1_10015))

		local var_16_9 = var_16_7
		local var_16_10 = var_16_7.Find(var_16_9, "bg/name")
		local var_16_11 = var_16_7
		local var_16_12 = var_16_7.Find(var_16_11, "bg/zan_bg/Text")

		setText = var_16_9

		var_16_9(var_16_10, var_9.nick_name .. ":")

		setText = var_16_9

		var_16_9(var_16_12, var_9.good_count - var_9.bad_count)

		var_1_10010.supportRichText = false
		var_1_10010.text = var_9.context

		local function var_16_13(arg_17_0)
			if not var_0.izan then
				local var_17_0 = arg_16_0

				var_1.emit(var_17_0, var_0_1.EVENT_ZAN, var_0.id, arg_17_0)
			else
				pg = var_1

				local var_17_1 = var_1.TipsMgr.GetInstance()
				local var_17_2 = var_1.ShowTips

				i18n = var_2_10004

				var_17_2(var_17_1, var_2_10004("zan_ship_eva_error_7"))
			end

			return
		end

		onButton = var_16_11

		local var_16_14 = arg_16_0
		local var_16_15 = var_16_7
		local var_16_16 = var_16_7.Find(var_16_15, "bg/zan_bg/up")

		local function var_16_17()
			var_16_13(0)

			return
		end

		SFX_PANEL = var_16_15

		var_16_11(var_16_14, var_16_16, var_16_17, var_16_15)

		onButton = var_16_11

		local var_16_18 = arg_16_0
		local var_16_19 = var_16_7
		local var_16_20 = var_16_7.Find(var_16_19, "bg/zan_bg/down")

		local function var_16_21()
			var_16_13(1)

			return
		end

		SFX_PANEL = var_16_19

		var_16_11(var_16_18, var_16_20, var_16_21, var_16_19)

		onButton = var_16_11

		local var_16_22 = arg_16_0
		local var_16_23 = var_16_7
		local var_16_24 = var_16_7.Find(var_16_23, "bg/zan_bg/impeach")

		local function var_16_25()
			local var_20_0 = arg_16_0

			var_0.openImpeachPanel(var_20_0, var_0.id)

			return
		end

		SFX_PANEL = var_16_23

		var_16_11(var_16_22, var_16_24, var_16_25, var_16_23)

		SetActive = var_16_11

		local var_16_26 = var_16_7:Find("bg/zan_bg/down")

		defaultValue = var_16_24
		LOCK_DOWNVOTE = var_19

		var_16_11(var_16_26, not var_16_24(var_19, true))

		setActive = var_16_11

		var_16_11(var_16_7:Find("bg/zan_bg/impeach"), var_16_6)
	end

	local var_16_27 = 1

	for iter_16_3 = 1, arg_16_0.hotContent.childCount do
		local var_16_28 = arg_16_0.hotContent
		local var_16_29 = var_9.GetChild(var_16_28, iter_16_3 - 1)

		go = var_1_10010

		if var_1_10010(var_16_29).name ~= "tag" then
			setActive = var_1_10010

			var_1_10010(var_16_29:Find("print1"), var_16_27 % 2 ~= 0)

			setActive = var_1_10010

			var_1_10010(var_16_29:Find("print2"), var_16_27 % 2 == 0)

			var_16_27 = var_16_27 + 1
		end
	end

	setActive = var_5

	local var_16_30 = arg_16_0.hotContent

	var_5(var_7.Find(var_16_30, "tag"), arg_16_0.hotContent.childCount > 1)

	setActive = var_5

	local var_16_31 = arg_16_0.commonContent

	var_5(var_7.Find(var_16_31, "tag"), arg_16_0.commonContent.childCount > 1)

	local var_16_32 = arg_16_0.hotContent
	local var_16_33 = var_5.Find(var_16_32, "tag")

	var_5.SetAsLastSibling(var_16_33)

	local var_16_34 = arg_16_0.commonContent
	local var_16_35 = var_5.Find(var_16_34, "tag")

	var_5.SetAsLastSibling(var_16_35)

	return
end

local var_0_2 = 3

function var_0_1.initImpeachPanel(arg_21_0)
	local var_21_0 = arg_21_0._tf

	arg_21_0.impackPanel = var_1.Find(var_21_0, "impeachPanel")
	setText = var_1

	local var_21_1 = arg_21_0.impackPanel
	local var_21_2 = var_3.Find(var_21_1, "window/top/bg/impeach/title")

	i18n = var_4

	var_1(var_21_2, var_4("report_sent_title"))

	onButton = var_1

	local var_21_3 = arg_21_0
	local var_21_4 = arg_21_0.impackPanel
	local var_21_5 = var_4.Find(var_21_4, "window/top/btnBack")

	local function var_21_6()
		local var_22_0 = arg_21_0

		var_0.onBackPressed(var_22_0)

		return
	end

	SFX_CANCEL = var_21_4

	var_1(var_21_3, var_21_5, var_21_6, var_21_4)

	local var_21_7 = arg_21_0.impackPanel
	local var_21_8 = var_1.Find(var_21_7, "window/msg_panel/content")

	setText = var_1_10002

	local var_21_9 = var_21_8:Find("title")

	i18n = var_21_6

	var_1_10002(var_21_9, var_21_6("report_sent_desc"))

	UIItemList = var_1_10002

	local var_21_10 = var_1_10002.New(var_21_8:Find("options"), var_21_8:Find("options/tpl"))

	var_2.make(var_21_10, function(arg_23_0, arg_23_1, arg_23_2)
		arg_23_1 = arg_23_1 + 1
		UIItemList = var_2_10003

		if arg_23_0 == var_2_10003.EventUpdate then
			setText = var_3

			local var_23_0 = arg_23_2:Find("Text")

			i18n = var_2_10006

			var_3(var_23_0, var_2_10006("report_type_" .. arg_23_1))

			setText = var_3

			local var_23_1 = arg_23_2:Find("Text_2")

			i18n = var_6

			var_3(var_23_1, var_6("report_type_" .. arg_23_1 .. "_1"))

			onToggle = var_3

			var_3(arg_21_0, arg_23_2, function(arg_24_0)
				arg_21_0.impeachOption = arg_23_1

				return
			end)
		end

		return
	end)
	var_2:align(var_0_2)

	setText = var_3

	local var_21_11 = var_21_8:Find("other/field/Text")

	i18n = var_6

	var_3(var_21_11, var_6("report_type_other"))

	setText = var_3

	local var_21_12 = var_21_8:Find("other/field/input/Placeholder")

	i18n = var_6

	var_3(var_21_12, var_6("report_type_other_1"))

	onToggle = var_3

	var_3(arg_21_0, var_21_8:Find("other"), function(arg_25_0)
		local var_25_0 = arg_21_0

		var_25_0.impeachOption = "other"
		setActive = var_25_0

		local var_25_1 = var_21_8

		var_25_0(var_3.Find(var_25_1, "other/field/input"), arg_25_0)

		return
	end)

	local var_21_13 = var_21_8:Find("other/field/input")

	onInputChanged = var_4

	var_4(arg_21_0, var_21_13, function()
		Canvas = var_2_10000

		var_2_10000.ForceUpdateCanvases()

		return
	end)

	onButton = var_4

	local var_21_14 = arg_21_0
	local var_21_15 = arg_21_0.impackPanel
	local var_21_16 = var_7.Find(var_21_15, "window/button_container/button")

	local function var_21_17()
		if arg_21_0.impeachOption == "other" then
			getInputText = var_0

			local var_27_0 = var_0(var_21_13)

			string = var_2_10001

			local var_27_2

			if var_2_10001.len(var_27_0) > 0 then
				local var_27_1 = arg_21_0

				var_27_2 = var_27_2.emit
				var_2_10004 = var_0_1.EVENT_IMPEACH
				var_2_10005 = arg_21_0.targetEvaId
				i18n = var_2_10006

				var_27_2(var_27_1, var_2_10004, var_2_10005, var_2_10006("report_type_other") .. ":" .. var_27_0)
			else
				pg = var_27_2

				local var_27_3 = var_27_2.TipsMgr.GetInstance()
				local var_27_4 = var_1.ShowTips

				i18n = var_2_10004

				var_27_4(var_27_3, var_2_10004("report_type_other_2"))

				return
			end
		else
			local var_27_5 = arg_21_0
			local var_27_6 = var_0.emit
			local var_27_7 = var_0_1.EVENT_IMPEACH
			local var_27_8 = arg_21_0.targetEvaId

			i18n = var_2_10005

			var_27_6(var_27_5, var_27_7, var_27_8, var_2_10005("report_type_" .. arg_21_0.impeachOption))
		end

		local var_27_9 = arg_21_0

		var_0.onBackPressed(var_27_9)

		return
	end

	SFX_CONFIRM = var_21_15

	var_4(var_21_14, var_21_16, var_21_17, var_21_15)

	return
end

function var_0_1.openImpeachPanel(arg_28_0, arg_28_1)
	arg_28_0.targetEvaId = arg_28_1
	setActive = var_1_10002

	var_1_10002(arg_28_0.mainPanel, false)

	setActive = var_1_10002

	var_1_10002(arg_28_0.impackPanel, true)

	triggerToggle = var_1_10002

	local var_28_0 = arg_28_0.impackPanel

	var_1_10002(var_4.Find(var_28_0, "window/msg_panel/content/other"), true)

	triggerToggle = var_1_10002

	local var_28_1 = arg_28_0.impackPanel

	var_1_10002(var_4.Find(var_28_1, "window/msg_panel/content/options/tpl"), true)

	return
end

function var_0_1.willExit(arg_29_0)
	pg = var_1_10001

	local var_29_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_29_0, arg_29_0._tf)

	return
end

return var_0_1
