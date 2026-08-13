class = var_0_10000

local var_0_0 = "ShipGiftScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))
local var_0_2 = 0.3
local var_0_3 = 3

function var_0_1.getUIName(arg_1_0)
	return "ShipGiftUI"
end

function var_0_1.ResUISettings(arg_2_0)
	return true
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.adapt = var_1.Find(var_3_0, "adapt")

	local var_3_1 = arg_3_0._tf

	arg_3_0.topPanel = var_1.Find(var_3_1, "adapt/top")

	local var_3_2 = arg_3_0._tf

	arg_3_0.backBtn = var_1.Find(var_3_2, "adapt/top/back_btn")

	local var_3_3 = arg_3_0._tf

	arg_3_0.homeBtn = var_1.Find(var_3_3, "adapt/top/option")

	local var_3_4 = arg_3_0._tf

	arg_3_0.bgTf = var_1.Find(var_3_4, "bgGo")

	local var_3_5 = arg_3_0._tf

	arg_3_0.imageGrass = var_1.Find(var_3_5, "bgGo/ImageGrass")

	local var_3_6 = arg_3_0._tf

	arg_3_0.character = var_1.Find(var_3_6, "adapt/content")

	local var_3_7 = arg_3_0._tf

	arg_3_0.chat = var_1.Find(var_3_7, "adapt/content/chat")

	local var_3_8 = arg_3_0._tf

	arg_3_0.chatBg = var_1.Find(var_3_8, "adapt/content/chat/chatbgtop")

	local var_3_9 = arg_3_0._tf

	arg_3_0.chatText = var_1.Find(var_3_9, "adapt/content/chat/Text")
	rtf = var_1

	local var_3_10 = var_1(arg_3_0.chat)

	Vector3 = var_1_10002
	var_3_10.localScale = var_1_10002.New(0, 0, 1)
	arg_3_0.initChatBgH = arg_3_0.chatBg.sizeDelta.y
	arg_3_0.initChatTextH = arg_3_0.chatText.sizeDelta.y

	local var_3_11 = arg_3_0.chatText
	local var_3_12 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_3_0.initfontSize = var_3_12(var_3_11, var_4(var_6)).fontSize

	local var_3_13 = arg_3_0._tf

	arg_3_0.namePanel = var_1.Find(var_3_13, "adapt/name")

	local var_3_14 = arg_3_0._tf

	arg_3_0.shipName = var_1.Find(var_3_14, "adapt/name/nameRect/name_mask/Text")

	local var_3_15 = arg_3_0._tf

	arg_3_0.shipNameEn = var_1.Find(var_3_15, "adapt/name/english_name")

	local var_3_16 = arg_3_0._tf

	arg_3_0.starts = var_1.Find(var_3_16, "adapt/name/stars")

	local var_3_17 = arg_3_0._tf

	arg_3_0.shipInfoStarTpl = var_1.Find(var_3_17, "adapt/name/star_tpl")

	local var_3_18 = arg_3_0._tf

	arg_3_0.shipType = var_1.Find(var_3_18, "adapt/name/type")

	local var_3_19 = arg_3_0._tf

	arg_3_0.intimacyIcon = var_1.Find(var_3_19, "adapt/intimacy/icon")

	local var_3_20 = arg_3_0._tf

	arg_3_0.intimacyValueText = var_1.Find(var_3_20, "adapt/intimacy/value")
	GetComponent = var_1

	local var_3_21 = arg_3_0._tf
	local var_3_22 = var_3.Find(var_3_21, "adapt/intimacy/addValue")

	typeof = var_4
	RectTransform = var_6
	arg_3_0.intimacyAddValueText = var_1(var_3_22, var_4(var_6))

	local var_3_23 = arg_3_0.adapt

	arg_3_0.painting = var_1.Find(var_3_23, "content/paint/fitter")

	local var_3_24 = arg_3_0.adapt

	arg_3_0.l2dParent = var_1.Find(var_3_24, "content/paint/live2d")

	local var_3_25 = arg_3_0.adapt

	arg_3_0.spineParent = var_1.Find(var_3_25, "content/paint/spinePainting")

	local var_3_26 = arg_3_0.adapt

	arg_3_0.effectParent = var_1.Find(var_3_26, "content/paint/effect")
	arg_3_0.intimacyAddValuePos = arg_3_0.intimacyAddValueText.localPosition

	local var_3_27 = arg_3_0._tf

	arg_3_0.rightPanel = var_1.Find(var_3_27, "adapt/right")
	GetComponent = var_1

	local var_3_28 = arg_3_0._tf

	arg_3_0.scrollRect = var_1(var_3.Find(var_3_28, "adapt/right/scrollRect"), "LScrollRect")

	local var_3_29 = arg_3_0._tf

	arg_3_0.giftBtn = var_1.Find(var_3_29, "adapt/right/giftBtn")
	setText = var_1

	local var_3_30 = arg_3_0._tf
	local var_3_31 = var_3.Find(var_3_30, "adapt/right/titlePanel/title/text")

	i18n = var_4

	var_1(var_3_31, var_4("ship_gift"))

	setText = var_1

	local var_3_32 = arg_3_0.giftBtn
	local var_3_33 = var_3.Find(var_3_32, "label")

	i18n = var_4

	var_1(var_3_33, var_4("ship_gift2"))

	setActive = var_1

	var_1(arg_3_0.intimacyAddValueText, false)

	arg_3_0.giftItemList = {}

	local var_3_34 = arg_3_0._tf
	local var_3_35 = var_1.GetComponent

	typeof = var_4
	Animation = var_6
	arg_3_0.anim = var_3_35(var_3_34, var_4(var_6))

	return
end

function var_0_1.didEnter(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.GetComponent

	typeof = var_1_10004
	DftAniEvent = var_1_10006

	local var_4_2 = var_4_1(var_4_0, var_1_10004(var_1_10006))

	var_1.SetEndEvent(var_4_2, function(arg_5_0)
		local var_5_0 = arg_4_0

		var_1.closeView(var_5_0)

		return
	end)

	onButton = var_1

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.backBtn

	local function var_4_5()
		local var_6_0 = arg_4_0.anim

		var_0.Play(var_6_0, "anim_ShipGiftUI_out")

		return
	end

	SFX_CANEL = var_1_10006

	var_1(var_4_3, var_4_4, var_4_5, var_1_10006)

	onButton = var_1

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0.homeBtn

	local function var_4_8()
		local var_7_0 = arg_4_0

		var_0.emit(var_7_0, var_0_1.ON_HOME)

		return
	end

	SFX_CANEL = var_1_10006

	var_1(var_4_6, var_4_7, var_4_8, var_1_10006)

	onButton = var_1

	local var_4_9 = arg_4_0
	local var_4_10 = arg_4_0.giftBtn

	local function var_4_11()
		local var_8_1

		if arg_4_0.selectIndex == nil then
			pg = var_8_1

			local var_8_0 = var_8_1.TipsMgr.GetInstance()

			var_8_1 = var_8_1.ShowTips
			i18n = var_2_10003

			var_8_1(var_8_0, var_2_10003("shipyard_gift_non_existent"))

			return
		end

		ShipGiftTools = var_8_1

		if var_8_1.GetShipNeedIntimacyValue(arg_4_0.shipVO) == 0 then
			local var_8_3

			if arg_4_0.shipVO.propose then
				pg = var_8_3

				local var_8_2 = var_8_3.TipsMgr.GetInstance()

				var_8_3 = var_8_3.ShowTips
				i18n = var_2_10004

				var_8_3(var_8_2, var_2_10004("shipyard_favorability_max"))
			else
				pg = var_8_3

				local var_8_4 = var_8_3.TipsMgr.GetInstance()
				local var_8_5 = var_1.ShowTips

				i18n = var_2_10004

				var_8_5(var_8_4, var_2_10004("shipyard_favorability_threshold"))
			end

			return
		end

		if arg_4_0.selectCnt == 0 then
			pg = var_1

			local var_8_6 = var_1.TipsMgr.GetInstance()
			local var_8_7 = var_1.ShowTips

			i18n = var_2_10004

			var_8_7(var_8_6, var_2_10004("shipyard_gift_non_existent"))

			return
		end

		local var_8_8 = arg_4_0.selectCnt
		local var_8_9 = arg_4_0.giftList[arg_4_0.selectIndex + 1].id

		ShipGiftTools = var_2_10004

		local var_8_10 = var_2_10004.GetItemIntimacyValue(arg_4_0.shipVO, var_2) * var_8_8 - var_0

		if 0 < var_8_10 then
			pg = var_6

			local var_8_11 = var_6.MsgboxMgr.GetInstance()
			local var_8_12 = var_6.ShowMsgBox

			var_2_10009 = {}
			i18n = var_2_10010

			local var_8_13 = "shipyard_favorability_exceed"

			math = var_2_10013
			var_2_10009.content = var_2_10010(var_8_13, var_2_10013.floor(var_8_10 / 100))

			function var_2_10009.onYes()
				local var_9_0 = arg_4_0
				local var_9_1 = var_0.emit

				ShipGiftMediator = var_3_10003

				var_9_1(var_9_0, var_3_10003.SHIP_GIFT, var_8_9, var_8_8, arg_4_0.shipVO.id)

				return
			end

			var_8_12(var_8_11, var_2_10009)
		else
			local var_8_14 = arg_4_0
			local var_8_15 = var_6.emit

			ShipGiftMediator = var_2_10009

			var_8_15(var_8_14, var_2_10009.SHIP_GIFT, var_8_9, var_8_8, arg_4_0.shipVO.id)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_4_9, var_4_10, var_4_11, var_1_10006)

	local var_4_12 = arg_4_0.scrollRect

	handler = var_1_10002
	var_4_12.onInitItem = var_1_10002(arg_4_0, arg_4_0.ScrollInit)

	local var_4_13 = arg_4_0.scrollRect

	handler = var_2
	var_4_13.onUpdateItem = var_2(arg_4_0, arg_4_0.ScrollUpdate)

	local var_4_14 = arg_4_0.scrollRect

	handler = var_2
	var_4_14.onReturnItem = var_2(arg_4_0, arg_4_0.ScrollReturn)

	local var_4_15 = arg_4_0.contextData.shipID

	getProxy = var_2
	BayProxy = var_4

	local var_4_16 = var_2(var_4)

	arg_4_0.shipVO = var_2.getShipById(var_4_16, var_4_15)
	ShipGiftTools = var_3
	arg_4_0.giftList = var_3.GetGiftList(arg_4_0.shipVO)
	ShipLoad = var_3
	arg_4_0.shipLoadClass = var_3.New(function(arg_10_0)
		setParent = var_2_10001

		var_2_10001(arg_10_0.transform, arg_4_0.painting)

		return
	end)

	local var_4_17 = arg_4_0.shipLoadClass

	var_3.LoadShip(var_4_17, var_4_15)
	arg_4_0:updatePreference()
	arg_4_0:RefreshUI()
	arg_4_0:OverlayPanel(arg_4_0.bgTf, {
		pbList = {
			arg_4_0.imageGrass
		}
	})
	arg_4_0:OverlayPanel(arg_4_0.adapt)

	arg_4_0.selectIndex = nil

	local var_4_18 = {}
	local var_4_19 = arg_4_0
	local var_4_20 = arg_4_0.bind

	ShipGiftItem = var_7

	local var_4_21 = var_7.SELECT_ITEM

	handler = var_8
	var_4_18[1] = var_4_20(var_4_19, var_4_21, var_8(arg_4_0, arg_4_0.OnSelectItem))

	local var_4_22 = arg_4_0
	local var_4_23 = arg_4_0.bind

	ShipGiftItem = var_4_21

	local var_4_24 = var_4_21.REFRESH_USE_ITEM_CNT

	handler = var_8
	var_4_18[2] = var_4_23(var_4_22, var_4_24, var_8(arg_4_0, arg_4_0.OnRefreshUseItemCnt))
	arg_4_0.eventList = var_4_18

	return
end

function var_0_1.willExit(arg_11_0)
	arg_11_0:StopPreVoice()

	ipairs = var_1

	for iter_11_0, iter_11_1 in var_1(arg_11_0.eventList) do
		arg_11_0:disconnect(iter_11_1)
	end

	arg_11_0.eventList = nil

	arg_11_0:StopWaitClickTimer()
	arg_11_0:StopAutoClickTimer()

	ClearLScrollrect = var_1

	var_1(arg_11_0.scrollRect)

	pairs = var_1

	for iter_11_2, iter_11_3 in var_1(arg_11_0.giftItemList) do
		iter_11_3:willExit()
	end

	arg_11_0.giftItemList = nil

	local var_11_0 = arg_11_0.shipLoadClass

	var_1.Dispose(var_11_0)

	arg_11_0.shipLoadClass = nil

	arg_11_0:UnOverlayPanel(arg_11_0.bgTf, arg_11_0._tf)
	arg_11_0:UnOverlayPanel(arg_11_0.adapt, arg_11_0._tf)

	return
end

function var_0_1.ScrollInit(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.giftItemList

	ShipGiftItem = var_1_10003
	var_12_0[arg_12_1] = var_1_10003.New(arg_12_1, arg_12_0)

	return
end

function var_0_1.ScrollUpdate(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0

	if not arg_13_0.giftItemList[arg_13_2] then
		ShipGiftItem = var_13_0
		var_13_0 = var_13_0.New(arg_13_2, arg_13_0)
	end

	local var_13_1 = arg_13_0.giftList[arg_13_1 + 1]

	var_13_0:didEnter(arg_13_0.shipVO, var_13_1, arg_13_1, arg_13_0.selectCnt, arg_13_0.selectIndex)

	return
end

function var_0_1.ScrollReturn(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0

	if not arg_14_0.giftItemList[arg_14_2] then
		ShipGiftItem = var_14_0
		var_14_0 = var_14_0.New(arg_14_2, arg_14_0)
	end

	var_14_0:willExit()

	return
end

function var_0_1.RefreshScroll(arg_15_0)
	pairs = var_1_10001

	for iter_15_0, iter_15_1 in var_1_10001(arg_15_0.giftItemList) do
		iter_15_1:RefreshUI(arg_15_0.selectIndex, arg_15_0.selectCnt)
	end

	return
end

function var_0_1.RefreshUI(arg_16_0)
	setImageSprite = var_1_10001

	local var_16_0 = arg_16_0.intimacyIcon

	GetSpriteFromAtlas = var_1_10004

	local var_16_1 = "energy"
	local var_16_2 = arg_16_0.shipVO

	var_1_10001(var_16_0, var_1_10004(var_16_1, var_7.getIntimacyIcon(var_16_2)), true)

	local var_16_3 = arg_16_0.shipVO
	local var_16_4, var_16_5 = var_1.getIntimacyDetail(var_16_3)

	setText = var_16_3

	var_16_3(arg_16_0.intimacyValueText, var_16_5)

	local var_16_6 = arg_16_0.scrollRect

	var_3.SetTotalCount(var_16_6, #arg_16_0.giftList)

	return
end

function var_0_1.updatePreference(arg_17_0)
	local var_17_0 = arg_17_0.shipVO
	local var_17_1 = var_1.getConfigTable(var_17_0)
	local var_17_2 = arg_17_0.shipVO
	local var_17_3 = var_3.getName(var_17_2)

	setScrollText = var_17_0

	var_17_0(arg_17_0.shipName, var_17_3)

	setText = var_17_0

	var_17_0(arg_17_0.shipNameEn, var_17_1.english_name)

	local var_17_4 = arg_17_0.starts

	removeAllChildren = var_17_2

	var_17_2(var_17_4)

	local var_17_5 = var_1:getStar()
	local var_17_6 = var_1:getMaxStar()

	for iter_17_0 = 1, var_17_6 do
		cloneTplTo = var_1_10011
		var_1_10011 = var_1_10011(arg_17_0.shipInfoStarTpl, var_17_4, "star_" .. iter_17_0)
		setActive = var_1_10012

		var_1_10012(var_1_10011:Find("star_tpl"), iter_17_0 <= var_17_5)

		setActive = var_1_10012

		var_1_10012(var_1_10011:Find("empty_star_tpl"), true)
	end

	GetSpriteFromAtlas = var_7

	local var_17_7 = var_7("shiptype", var_1:getShipType())

	setImageSprite = var_8

	var_8(arg_17_0.shipType, var_17_7, true)

	return
end

function var_0_1.OnGiftSuccess(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.giftList[arg_18_0.selectIndex + 1]

	ShipGiftTools = var_3

	local var_18_1 = var_3.GetItemFavoriteState(arg_18_0.shipVO, var_18_0)
	local var_18_2 = ""

	ShipGiftConst = var_5

	if var_18_1 == var_5.GIFT_FAVORITE_STATE.HATE then
		var_1_10007 = arg_18_0

		arg_18_0.displayShipWord(var_1_10007, "gift_dislike", true)

		ShipExpressionHelper = var_5

		local var_18_3 = var_5.SetExpression
		local var_18_4 = arg_18_0.painting

		var_1_10007 = var_1_10007.GetChild(var_18_4, 0)

		local var_18_5 = arg_18_0.shipVO

		var_18_3(var_1_10007, var_8.getPainting(var_18_5), "gift_dislike")
	else
		var_1_10007 = arg_18_0

		arg_18_0.displayShipWord(var_1_10007, "gift_prefer", true)

		ShipExpressionHelper = var_5

		local var_18_6 = var_5.SetExpression
		local var_18_7 = arg_18_0.painting

		var_1_10007 = var_1_10007.GetChild(var_18_7, 0)

		local var_18_8 = arg_18_0.shipVO

		var_18_6(var_1_10007, var_8.getPainting(var_18_8), "gift_prefer")
	end

	local var_18_9 = arg_18_0.selectCnt - arg_18_1

	ShipGiftTools = var_6

	local var_18_10 = var_18_9 * var_6.GetItemIntimacyValue(arg_18_0.shipVO, var_18_0)

	if 0 < var_18_10 then
		setText = var_6

		local var_18_11 = arg_18_0.intimacyAddValueText

		string = var_9

		var_6(var_18_11, var_9.format("+%s", var_18_10 / 100))
		arg_18_0:PlayAddValueAnimation()

		setActive = var_6

		var_6(arg_18_0.intimacyAddValueText, true)
	else
		setActive = var_6

		var_6(arg_18_0.intimacyAddValueText, false)
	end

	arg_18_0:StopWaitClickTimer()

	FrameTimer = var_6
	arg_18_0.waitClickTimer = var_6.New(function()
		Input = var_2_10000

		if var_2_10000.anyKeyDown then
			local var_19_0 = arg_18_0

			var_0.ClickBackGift(var_19_0)
		end

		return
	end, 1, -1)

	local var_18_12 = arg_18_0.waitClickTimer

	var_6.Start(var_18_12)
	arg_18_0:StopAutoClickTimer()

	Timer = var_6
	arg_18_0.autoClickTimer = var_6.New(function()
		local var_20_0 = arg_18_0

		var_0.ClickBackGift(var_20_0)

		return
	end, 1.5, 1)

	local var_18_13 = arg_18_0.autoClickTimer

	var_6.Start(var_18_13)

	if var_18_10 > 0 then
		local var_18_14 = arg_18_0
		local var_18_15 = arg_18_0.emit

		ShipGiftMediator = var_9

		var_18_15(var_18_14, var_9.ADD_SHIP_INTIMACY, arg_18_0.shipVO, var_18_10)
	end

	local var_18_16 = arg_18_0.contextData.shipID

	getProxy = var_1_10007
	BayProxy = var_9

	local var_18_17 = var_1_10007(var_9)

	arg_18_0.shipVO = var_7.getShipById(var_18_17, var_18_16)
	ShipGiftTools = var_8
	arg_18_0.giftList = var_8.GetGiftList(arg_18_0.shipVO)
	arg_18_0.selectIndex = nil
	arg_18_0.selectCnt = 0

	arg_18_0:RefreshUI()

	ShipGiftConst = var_8

	local var_18_18 = var_18_1 == var_8.GIFT_FAVORITE_STATE.HATE

	eachChild = var_9

	local var_18_19 = arg_18_0.adapt

	var_9(var_11.Find(var_18_19, "VX"), function(arg_21_0, arg_21_1)
		setActive = var_2_10002

		var_2_10002(arg_21_0, not var_18_18)

		return
	end)

	local var_18_20 = arg_18_0.anim

	var_9.Play(var_18_20, "anim_ShipGiftUI_success")

	return
end

function var_0_1.displayShipWord(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_2 or not arg_22_0.chatFlag then
		arg_22_0.chatFlag = true

		local var_22_0 = arg_22_0.chat

		Vector3 = var_1_10004
		var_22_0.localScale = var_1_10004.zero
		setActive = var_22_0

		var_22_0(arg_22_0.chat, true)

		local var_22_1 = arg_22_0.shipVO
		local var_22_2 = var_3.getCVIntimacy(var_22_1)

		ShipWordHelper = var_4

		local var_22_3 = var_4.GetWordAndCV
		local var_22_4 = arg_22_0.shipVO
		local var_22_5, var_22_6, var_22_7 = var_22_3(var_6.getSkinId(var_22_4), arg_22_1, nil, nil, var_22_2)

		if var_22_7 == "" then
			if arg_22_1 == "gift_dislike" then
				local var_22_8 = arg_22_0.shipVO
				local var_22_9 = var_7.getName(var_22_8)

				i18n = var_8
				var_22_7 = var_22_9 .. var_8("gift_giving_dislike")
			else
				local var_22_10 = arg_22_0.shipVO
				local var_22_11 = var_7.getName(var_22_10)

				i18n = var_8
				var_22_7 = var_22_11 .. var_8("gift_giving_prefer")
			end
		end

		local var_22_12 = arg_22_0.chatText
		local var_22_13 = var_7.GetComponent

		typeof = var_10
		Text = var_1_10012

		local var_22_14 = var_22_13(var_22_12, var_10(var_1_10012))

		PLATFORM_CODE = var_8
		PLATFORM_US = var_22_12

		local var_22_15

		if var_8 ~= var_22_12 then
			setText = var_8
			var_22_15 = arg_22_0.chatText
			SwitchSpecialChar = var_1_10011

			var_8(var_22_15, var_1_10011(var_22_7))
		else
			var_22_14.fontSize = arg_22_0.initfontSize
			setTextEN = var_8

			var_8(arg_22_0.chatText, var_22_7)

			::label_22_0::

			local var_22_16 = var_22_14.preferredHeight

			if arg_22_0.initChatTextH < var_22_16 then
				repeat
					var_22_14.fontSize = var_22_14.fontSize - 2
					setTextEN = var_8

					var_8(arg_22_0.chatText, var_22_7)

					if var_22_14.fontSize < 20 then
						break
					end

					goto label_22_0
				until true
			end
		end

		local var_22_17 = #var_22_14.text

		CHAT_POP_STR_LEN = var_22_12

		if var_22_12 < var_22_17 then
			TextAnchor = var_22_17
			var_22_14.alignment = var_22_17.MiddleLeft
		else
			TextAnchor = var_22_17
			var_22_14.alignment = var_22_17.MiddleCenter
		end

		if var_22_14.preferredHeight + 120 > arg_22_0.initChatBgH then
			local var_22_18 = arg_22_0.chatBg

			Vector2 = var_22_15
			var_22_18.sizeDelta = var_22_15.New(arg_22_0.chatBg.sizeDelta.x, var_8)
		else
			local var_22_19 = arg_22_0.chatBg

			Vector2 = var_22_15
			var_22_19.sizeDelta = var_22_15.New(arg_22_0.chatBg.sizeDelta.x, arg_22_0.initChatBgH)
		end

		local var_22_20 = var_0_3

		local function var_22_21()
			if arg_22_0.chatFlag then
				if arg_22_0.chatani1Id then
					LeanTween = var_0

					var_0.cancel(arg_22_0.chatani1Id)
				end

				if arg_22_0.chatani2Id then
					LeanTween = var_0

					var_0.cancel(arg_22_0.chatani2Id)
				end
			end

			local var_23_0 = arg_22_0

			LeanTween = var_2_10001

			local var_23_1 = var_2_10001.scale

			rtf = var_2_10003

			local var_23_2 = var_2_10003(arg_22_0.chat.gameObject)

			Vector3 = var_2_10004

			local var_23_3 = var_23_1(var_23_2, var_2_10004.New(1, 1, 1), var_0_2)
			local var_23_4 = var_1.setEase

			LeanTweenType = var_4

			local var_23_5 = var_23_4(var_23_3, var_4.easeOutBack)
			local var_23_6 = var_1.setOnComplete

			System = var_4
			var_23_0.chatani1Id = var_23_6(var_23_5, var_4.Action(function()
				local var_24_0 = arg_22_0

				LeanTween = var_3_10001

				local var_24_1 = var_3_10001.scale

				rtf = var_3_10003

				local var_24_2 = var_3_10003(arg_22_0.chat.gameObject)

				Vector3 = var_3_10004

				local var_24_3 = var_24_1(var_24_2, var_3_10004.New(0, 0, 1), var_0_2)
				local var_24_4 = var_1.setEase

				LeanTweenType = var_4

				local var_24_5 = var_24_4(var_24_3, var_4.easeInBack)
				local var_24_6 = var_1.setDelay(var_24_5, var_0_2 + var_22_20)
				local var_24_7 = var_1.setOnComplete

				System = var_4
				var_24_0.chatani2Id = var_24_7(var_24_6, var_4.Action(function()
					arg_22_0.chatFlag = nil

					return
				end)).uniqueId

				return
			end)).uniqueId

			return
		end

		if var_22_6 then
			arg_22_0:StopPreVoice()

			pg = var_11

			local var_22_22 = var_11.CriMgr.GetInstance()

			var_11.PlaySoundEffect_V3(var_22_22, var_22_6, function(arg_26_0)
				if arg_26_0 then
					var_22_20 = arg_26_0:GetLength() * 0.001
				end

				var_22_21()

				return
			end)

			arg_22_0.preVoiceContent = var_22_6
		else
			var_22_21()
		end
	end

	return
end

function var_0_1.StopPreVoice(arg_27_0)
	if arg_27_0.preVoiceContent ~= nil then
		pg = var_1

		local var_27_0 = var_1.CriMgr.GetInstance()

		var_1.UnloadSoundEffect_V3(var_27_0, arg_27_0.preVoiceContent)
	end

	return
end

function var_0_1.ShowPanel(arg_28_0)
	local var_28_0 = arg_28_0.anim

	var_1.Play(var_28_0, "anim_ShipGiftUI_success_re")

	return
end

function var_0_1.PlayAddValueAnimation(arg_29_0)
	setActive = var_1_10001

	var_1_10001(arg_29_0.intimacyAddValueText, true)

	local var_29_0 = arg_29_0.intimacyAddValueText

	Vector2 = var_1_10002
	var_29_0.localPosition = var_1_10002(arg_29_0.intimacyAddValuePos.x, arg_29_0.intimacyAddValuePos.y)

	local var_29_1 = arg_29_0
	local var_29_2 = arg_29_0.managedTween

	LeanTween = var_4

	local var_29_3 = var_29_2(var_29_1, var_4.moveY, nil, arg_29_0.intimacyAddValueText, arg_29_0.intimacyAddValuePos.y + 20, 0.35)
	local var_29_4 = var_1.setOnComplete

	System = var_4

	var_29_4(var_29_3, var_4.Action(function()
		setActive = var_2_10000

		var_2_10000(arg_29_0.intimacyAddValueText, false)

		return
	end))

	return
end

function var_0_1.ClickBackGift(arg_31_0)
	arg_31_0:StopWaitClickTimer()
	arg_31_0:StopAutoClickTimer()
	arg_31_0:ShowPanel()

	ShipExpressionHelper = var_1

	local var_31_0 = var_1.SetExpression
	local var_31_1 = arg_31_0.painting
	local var_31_2 = var_3.GetChild(var_31_1, 0)
	local var_31_3 = arg_31_0.shipVO

	var_31_0(var_31_2, var_4.getPainting(var_31_3))

	return
end

function var_0_1.StopWaitClickTimer(arg_32_0)
	if arg_32_0.waitClickTimer then
		local var_32_0 = arg_32_0.waitClickTimer

		var_1.Stop(var_32_0)

		arg_32_0.waitClickTimer = nil
	end

	return
end

function var_0_1.StopAutoClickTimer(arg_33_0)
	if arg_33_0.autoClickTimer then
		local var_33_0 = arg_33_0.autoClickTimer

		var_1.Stop(var_33_0)

		arg_33_0.autoClickTimer = nil
	end

	return
end

function var_0_1.OnSelectItem(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0.selectIndex = arg_34_2

	local var_34_0 = arg_34_0.giftList[arg_34_2 + 1]

	ShipGiftTools = var_4
	arg_34_0.selectCnt = var_4.GetNeedMinCnt(arg_34_0.shipVO, var_34_0)

	arg_34_0:RefreshScroll()

	return
end

function var_0_1.OnRefreshUseItemCnt(arg_35_0, arg_35_1, arg_35_2)
	arg_35_0.selectCnt = arg_35_2

	return
end

function var_0_1.onBackPressed(arg_36_0)
	if arg_36_0.waitClickTimer then
		arg_36_0:ClickBackGift()

		return
	end

	var_0_1.super.onBackPressed(arg_36_0)

	return
end

return var_0_1
