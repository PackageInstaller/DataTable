class = var_0_10000

local var_0_0 = "Dorm3dInstagramLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dInstagramUI"
end

function var_0_1.GetInstagramList(arg_2_0)
	local var_2_0 = arg_2_0.contextData.apartmentGroupId

	assert = var_1_10002

	var_1_10002(var_2_0, "groupId can not be nil")

	getProxy = var_1_10002
	Dorm3dInsProxy = var_3

	local var_2_1 = var_1_10002(var_3)

	return var_2.GetInstagramList(var_2_1, var_2_0)
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.listTF = var_1.Find(var_3_0, "list")

	local var_3_1 = arg_3_0._tf

	arg_3_0.mainTF = var_1.Find(var_3_1, "main")

	local var_3_2 = arg_3_0._tf

	arg_3_0.closeBtn = var_1.Find(var_3_2, "closeBtn")

	local var_3_3 = arg_3_0._tf

	arg_3_0.noMsgTF = var_1.Find(var_3_3, "list/bg/no_msg")

	local var_3_4 = arg_3_0._tf

	arg_3_0.scrollBarTF = var_1.Find(var_3_4, "list/bg/scroll_bar")

	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_1.Find(var_3_5, "list/bg/scrollrect")

	arg_3_0.list = var_1.GetComponent(var_3_6, "LScrollRect")

	local var_3_7 = arg_3_0._tf

	arg_3_0.mainBg = var_1.Find(var_3_7, "main/left_panel/bg")

	local var_3_8 = arg_3_0._tf
	local var_3_9 = var_1.Find(var_3_8, "main/left_panel/mask/Image")
	local var_3_10 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_3_0.imageTF = var_3_10(var_3_9, var_3(var_1_10004))

	local var_3_11 = arg_3_0._tf

	arg_3_0.likeBtn = var_1.Find(var_3_11, "main/left_panel/heart")

	local var_3_12 = arg_3_0._tf

	arg_3_0.bubbleTF = var_1.Find(var_3_12, "main/left_panel/bubble")

	local var_3_13 = arg_3_0._tf

	arg_3_0.planeTF = var_1.Find(var_3_13, "main/left_panel/plane")

	local var_3_14 = arg_3_0._tf
	local var_3_15 = var_1.Find(var_3_14, "main/left_panel/zan")
	local var_3_16 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_3_0.likeCntTxt = var_3_16(var_3_15, var_3(var_1_10004))

	local var_3_17 = arg_3_0._tf
	local var_3_18 = var_1.Find(var_3_17, "main/left_panel/time")
	local var_3_19 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_3_0.pushTimeTxt = var_3_19(var_3_18, var_3(var_1_10004))

	local var_3_20 = arg_3_0._tf

	arg_3_0.iconTF = var_1.Find(var_3_20, "main/right_panel/top/head/icon")

	local var_3_21 = arg_3_0._tf
	local var_3_22 = var_1.Find(var_3_21, "main/right_panel/top/name")
	local var_3_23 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_3_0.nameTxt = var_3_23(var_3_22, var_3(var_1_10004))

	local var_3_24 = arg_3_0._tf

	arg_3_0.centerTF = var_1.Find(var_3_24, "main/right_panel/center")

	local var_3_25 = arg_3_0._tf
	local var_3_26 = var_1.Find(var_3_25, "main/right_panel/center/Text/Text")
	local var_3_27 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_3_0.contentTxt = var_3_27(var_3_26, var_3(var_1_10004))
	UIItemList = var_1

	local var_3_28 = var_1.New
	local var_3_29 = arg_3_0._tf
	local var_3_30 = var_2.Find(var_3_29, "main/right_panel/center/bottom/scroll/content")
	local var_3_31 = arg_3_0._tf

	arg_3_0.commentList = var_3_28(var_3_30, var_3.Find(var_3_31, "main/right_panel/center/bottom/scroll/content/tpl"))

	local var_3_32 = arg_3_0._tf

	arg_3_0.commentPanel = var_1.Find(var_3_32, "main/right_panel/last/bg2")

	local var_3_33 = arg_3_0._tf

	arg_3_0.optionalPanel = var_1.Find(var_3_33, "main/right_panel/last/bg2/option")

	local var_3_34 = arg_3_0._tf

	arg_3_0.scroll = var_1.Find(var_3_34, "main/right_panel/center/bottom/scroll")
	setText = var_1

	local var_3_35 = arg_3_0._tf
	local var_3_36 = var_2.Find(var_3_35, "main_bg/Text")

	i18n = var_3_35

	var_1(var_3_36, var_3_35("dorm3d_privatechat_topics"))

	setText = var_1

	local var_3_37 = arg_3_0.noMsgTF
	local var_3_38 = var_2.Find(var_3_37, "Text")

	i18n = var_3_37

	var_1(var_3_38, var_3_37("dorm3d_ins_no_msg"))
	arg_3_0:OverlayPanel(arg_3_0._tf)

	return
end

function var_0_1.didEnter(arg_4_0)
	setActive = var_1_10001

	var_1_10001(arg_4_0.listTF, true)

	setActive = var_1_10001

	var_1_10001(arg_4_0.mainTF, false)

	onButton = var_1_10001

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.closeBtn

	local function var_4_2()
		if arg_4_0.inDetail then
			local var_5_0 = arg_4_0

			var_0.ExitDetail(var_5_0)

			return
		end

		local var_5_1 = arg_4_0

		var_0.emit(var_5_1, var_0_1.ON_CLOSE)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_4_0, var_4_1, var_4_2, var_1_10005)

	arg_4_0.cards = {}

	function arg_4_0.list.onInitItem(arg_6_0)
		local var_6_0 = arg_4_0

		var_1.OnInitItem(var_6_0, arg_6_0)

		return
	end

	function arg_4_0.list.onUpdateItem(arg_7_0, arg_7_1)
		local var_7_0 = arg_4_0

		var_2.OnUpdateItem(var_7_0, arg_7_0, arg_7_1)

		return
	end

	arg_4_0:InitCards()

	return
end

function var_0_1.OnInitItem(arg_8_0, arg_8_1)
	Dorm3dInstagramCard = var_1_10002

	local var_8_0 = var_1_10002.New(arg_8_1)

	onButton = var_3

	local var_8_1 = arg_8_0
	local var_8_2 = var_8_0._go

	local function var_8_3()
		local var_9_0 = var_8_0.instagram

		if var_0.IsLock(var_9_0) then
			return
		end

		local var_9_1 = arg_8_0

		var_0.EnterDetail(var_9_1, var_8_0.instagram)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_8_1, var_8_2, var_8_3, var_1_10007)

	arg_8_0.cards[arg_8_1] = var_8_0

	return
end

function var_0_1.OnUpdateItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0

	if not arg_10_0.cards[arg_10_2] then
		Dorm3dInstagramCard = var_1_10004
		var_10_0 = var_1_10004.New(arg_10_2)
		arg_10_0.cards[arg_10_2] = var_10_0
	end

	local var_10_1 = arg_10_0.display[arg_10_1 + 1]

	var_10_0:Update(var_10_1)

	return
end

function var_0_1.InitCards(arg_11_0)
	local var_11_0 = arg_11_0:GetInstagramList()

	arg_11_0.display = {}
	ipairs = var_2

	for iter_11_0, iter_11_1 in var_2(var_11_0) do
		if not iter_11_1:IsLock() and iter_11_1:CanShow() then
			table = var_7

			var_7.insert(arg_11_0.display, iter_11_1)
		end
	end

	table = var_2

	var_2.sort(arg_11_0.display, function(arg_12_0, arg_12_1)
		if arg_12_0:LockState() == arg_12_1:LockState() then
			return var_3 < var_2
		else
			return arg_12_0.id > arg_12_1.id
		end

		return
	end)

	isActive = var_2

	if var_2(arg_11_0.listTF) then
		local var_11_1 = arg_11_0.list

		var_2.SetTotalCount(var_11_1, #arg_11_0.display)
	end

	setActive = var_2

	var_2(arg_11_0.noMsgTF, #arg_11_0.display == 0)

	setActive = var_2

	var_2(arg_11_0.scrollBarTF, not #arg_11_0.display == 0)

	return
end

function var_0_1.EnterDetail(arg_13_0, arg_13_1)
	arg_13_0.contextData.instagram = arg_13_1

	arg_13_0:InitDetailPage()

	arg_13_0.inDetail = true
	setActive = var_2

	var_2(arg_13_0.listTF, false)

	setActive = var_2

	var_2(arg_13_0.mainTF, true)

	scrollTo = var_2

	var_2(arg_13_0.scroll, 0, 1)

	return
end

function var_0_1.ExitDetail(arg_14_0)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.emit

	Dorm3dInstagramMediator = var_1_10003

	var_14_1(var_14_0, var_1_10003.ON_EXIT, arg_14_0.contextData.instagram.id)

	arg_14_0.contextData.instagram = nil
	arg_14_0.inDetail = false
	setActive = var_1

	var_1(arg_14_0.listTF, true)

	setActive = var_1

	var_1(arg_14_0.mainTF, false)
	arg_14_0:ClosePlayerCommentPanel()

	return
end

function var_0_1.MarkRead(arg_15_0, arg_15_1)
	if arg_15_1 and not arg_15_1:IsRead() then
		local var_15_0 = arg_15_0
		local var_15_1 = arg_15_0.emit

		Dorm3dInstagramMediator = var_1_10004

		var_15_1(var_15_0, var_1_10004.ON_READ, arg_15_1.id)
	end

	return
end

function var_0_1.InitDetailPage(arg_16_0)
	local var_16_0 = arg_16_0.contextData.instagram

	arg_16_0:MarkRead(var_16_0)

	local var_16_1 = arg_16_0.pushTimeTxt

	var_16_1.text = var_16_0:GetPushTime()
	LoadSpriteAsync = var_16_1

	local var_16_2 = "Dorm3dIns/"
	local var_16_3 = var_16_0

	var_16_1(var_16_2 .. var_16_0.GetPicture(var_16_3), function(arg_17_0)
		setImageSprite = var_2_10001

		var_2_10001(arg_16_0.imageTF, arg_17_0, false)

		return
	end)

	local var_16_4 = var_16_0

	if var_16_0.GetBackground(var_16_4) and var_2 ~= "" then
		LoadSpriteAsync = var_16_4

		var_16_4("Dorm3dIns/" .. var_2, function(arg_18_0)
			setImageSprite = var_2_10001

			var_2_10001(arg_16_0.mainBg, arg_18_0, false)

			return
		end)
	end

	setImageSprite = var_16_4

	local var_16_5 = arg_16_0.iconTF

	LoadSprite = var_16_3

	var_16_4(var_16_5, var_16_3("qicon/" .. var_16_0:GetIcon()), false)

	arg_16_0.nameTxt.text = var_16_0:GetName()

	local var_16_6 = arg_16_0.contentTxt

	var_16_6.text = var_16_0:GetText()
	onToggle = var_16_6

	local var_16_7 = arg_16_0
	local var_16_8 = arg_16_0.commentPanel

	local function var_16_9(arg_19_0)
		if arg_19_0 then
			local var_19_0 = arg_16_0

			var_1.OpenPlayerCommentPanel(var_19_0)
		else
			local var_19_1 = arg_16_0

			var_1.ClosePlayerCommentPanel(var_19_1)
		end

		return
	end

	SFX_PANEL = var_7

	var_16_6(var_16_7, var_16_8, var_16_9, var_7)
	arg_16_0:UpdateLikeBtn()
	arg_16_0:UpdateShareBtn()
	arg_16_0:UpdateCommentList()

	return
end

function var_0_1.UpdateShareBtn(arg_20_0)
	local var_20_0 = arg_20_0.contextData.instagram

	onButton = var_1_10002

	local var_20_1 = arg_20_0
	local var_20_2 = arg_20_0.planeTF

	local function var_20_3()
		local var_21_0 = arg_20_0
		local var_21_1 = var_0.emit

		Dorm3dInstagramMediator = var_2_10002

		var_21_1(var_21_0, var_2_10002.ON_SHARE, var_20_0.id)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10002(var_20_1, var_20_2, var_20_3, var_1_10006)

	return
end

function var_0_1.UpdateLikeBtn(arg_22_0)
	if not arg_22_0.contextData.instagram then
		return
	end

	local var_22_0 = var_1

	if not var_1.IsGood(var_22_0) then
		onButton = var_22_0

		local var_22_1 = arg_22_0
		local var_22_2 = arg_22_0.likeBtn

		local function var_22_3()
			local var_23_0 = arg_22_0
			local var_23_1 = var_0.emit

			Dorm3dInstagramMediator = var_2_10002

			var_23_1(var_23_0, var_2_10002.ON_LIKE, var_0.id)

			return
		end

		SFX_PANEL = var_1_10007

		var_22_0(var_22_1, var_22_2, var_22_3, var_1_10007)
	else
		removeOnButton = var_22_0

		var_22_0(arg_22_0.likeBtn)
	end

	setActive = var_22_0

	local var_22_4 = arg_22_0.likeBtn

	var_22_0(var_4.Find(var_22_4, "heart"), var_2)

	local var_22_5 = arg_22_0.likeBtn
	local var_22_6 = var_3.GetComponent

	typeof = var_5
	Image = var_6
	var_22_6(var_22_5, var_5(var_6)).enabled = not var_2

	return
end

function var_0_1.OnLikeInstagram(arg_24_0)
	if not arg_24_0.contextData.instagram then
		return
	end

	arg_24_0:UpdateLikeBtn()

	pairs = var_2

	for iter_24_0, iter_24_1 in var_2(arg_24_0.cards) do
		if iter_24_1.instagram.id == var_1.id then
			iter_24_1:Update(var_1)

			break
		end
	end

	return
end

local function var_0_2(arg_25_0, arg_25_1, arg_25_2)
	setText = var_1_10003

	var_1_10003(arg_25_1:Find("main/reply"), "reply")

	SwitchSpecialChar = var_1_10003

	local var_25_0 = var_1_10003(arg_25_2:GetText())

	setText = var_4

	local var_25_1 = arg_25_1
	local var_25_2 = arg_25_1.Find(var_25_1, "main/content")

	HXSet = var_25_1

	var_4(var_25_2, var_25_1.hxLan(var_25_0))

	setText = var_4

	var_4(arg_25_1:Find("main/time"), arg_25_2:GetPushTime())

	isa = var_4

	local var_25_3 = arg_25_2

	InstagramPlayerComment3Dorm = var_6

	if var_4(var_25_3, var_6) then
		setImageSprite = var_4

		local var_25_4 = arg_25_1
		local var_25_5 = arg_25_1.Find(var_25_4, "main/head/icon")

		GetSpriteFromAtlas = var_25_4

		var_4(var_25_5, var_25_4("ui/InstagramUI_atlas", "txdi_3"))
	else
		setImageSprite = var_4

		local var_25_6 = arg_25_1
		local var_25_7 = arg_25_1.Find(var_25_6, "main/head/icon")

		LoadSprite = var_25_6

		var_4(var_25_7, var_25_6("qicon/" .. arg_25_2:GetIcon()), false)
	end

	return
end

local function var_0_3(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_2
	local var_26_1 = arg_26_2.GetReplyedList(var_26_0)

	_ = var_26_0

	local var_26_2 = var_26_0.select(var_26_1, function(arg_27_0)
		return arg_27_0:CanShow()
	end)

	UIItemList = var_5

	local var_26_3 = var_5.New(arg_26_1:Find("replys"), arg_26_1:Find("replys/sub"))

	table = var_6

	var_6.sort(var_26_2, function(arg_28_0, arg_28_1)
		if arg_28_0.time == arg_28_1.time then
			return arg_28_0.id < arg_28_1.id
		else
			return arg_28_0.time < arg_28_1.time
		end

		return
	end)
	var_26_3:make(function(arg_29_0, arg_29_1, arg_29_2)
		UIItemList = var_2_10003

		if arg_29_0 == var_2_10003.EventUpdate then
			local var_29_0 = var_26_2[arg_29_1 + 1]

			setImageSprite = var_4

			local var_29_1 = arg_29_2
			local var_29_2 = arg_29_2.Find(var_29_1, "head/icon")

			LoadSprite = var_29_1

			var_4(var_29_2, var_29_1("qicon/" .. var_29_0:GetIcon()), false)

			SwitchSpecialChar = var_4

			local var_29_3 = var_4(var_29_0:GetText())

			setText = var_5

			local var_29_4 = arg_29_2
			local var_29_5 = arg_29_2.Find(var_29_4, "content")

			HXSet = var_29_4

			var_5(var_29_5, var_29_4.hxLan(var_29_3))
		end

		return
	end)
	var_26_3:align(#var_26_2)

	return
end

local function var_0_4(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_2

	if arg_30_2.ExistAnyReplay(var_30_0) then
		onToggle = var_30_0

		local var_30_1 = arg_30_0
		local var_30_2 = arg_30_1:Find("main/bubble")

		local function var_30_3(arg_31_0)
			setActive = var_2_10001

			local var_31_0 = arg_30_1

			var_2_10001(var_2.Find(var_31_0, "replys"), arg_31_0)

			return
		end

		SFX_PANEL = var_8

		var_30_0(var_30_1, var_30_2, var_30_3, var_8)
		var_0_3(arg_30_0, arg_30_1, arg_30_2)
	else
		setActive = var_30_0

		var_30_0(arg_30_1:Find("replys"), false)
	end

	triggerToggle = var_30_0

	var_30_0(arg_30_1:Find("main/bubble"), var_3)

	local var_30_4 = arg_30_1:Find("main/bubble")
	local var_30_5 = var_4.GetComponent

	typeof = var_6
	Toggle = var_7
	var_30_5(var_30_4, var_6(var_7)).enabled = var_3

	return
end

function var_0_1.UpdateCommentList(arg_32_0)
	if not arg_32_0.contextData.instagram then
		return
	end

	local var_32_0 = var_1
	local var_32_1 = var_1.GetReplyedList(var_32_0)

	_ = var_32_0

	local var_32_2 = var_32_0.select(var_32_1, function(arg_33_0)
		return arg_33_0:CanShow()
	end)

	table = var_4

	var_4.sort(var_32_2, function(arg_34_0, arg_34_1)
		return arg_34_0.time < arg_34_1.time
	end)

	local var_32_3 = arg_32_0.commentList

	var_4.make(var_32_3, function(arg_35_0, arg_35_1, arg_35_2)
		UIItemList = var_2_10003

		if arg_35_0 == var_2_10003.EventUpdate then
			local var_35_0 = var_32_2[arg_35_1 + 1]

			var_0_2(arg_32_0, arg_35_2, var_35_0)
			var_0_4(arg_32_0, arg_35_2, var_35_0)
		end

		return
	end)

	setActive = var_4

	var_4(arg_32_0.centerTF, false)

	setActive = var_4

	var_4(arg_32_0.centerTF, true)

	Canvas = var_4

	var_4.ForceUpdateCanvases()

	local var_32_4 = arg_32_0.commentList

	var_4.align(var_32_4, #var_32_2)

	return
end

function var_0_1.OpenPlayerCommentPanel(arg_36_0)
	local var_36_0 = arg_36_0.contextData.instagram

	if not var_1.ExistAnyReplyable(var_36_0) then
		return
	end

	setActive = var_2

	var_2(arg_36_0.optionalPanel, true)

	local var_36_1 = var_1:GetReplyableList()
	local var_36_2 = arg_36_0.commentPanel
	local var_36_3 = var_3.GetComponent

	typeof = var_1_10005
	Image = var_1_10006
	var_36_3(var_36_2, var_1_10005(var_1_10006)).enabled = true

	local var_36_4 = arg_36_0.commentPanel

	Vector2 = var_4
	var_36_4.sizeDelta = var_4(0, #var_36_1 * 14 + 60)
	UIItemList = var_36_4

	local var_36_5 = var_36_4.New
	local var_36_6 = arg_36_0.optionalPanel
	local var_36_7 = arg_36_0.optionalPanel
	local var_36_8 = var_36_5(var_36_6, var_5.Find(var_36_7, "option1"))

	var_3.make(var_36_8, function(arg_37_0, arg_37_1, arg_37_2)
		UIItemList = var_2_10003

		if arg_37_0 == var_2_10003.EventUpdate then
			local var_37_0 = var_36_1[arg_37_1 + 1]
			local var_37_1 = var_3.GetText(var_37_0)
			local var_37_2 = var_3.id
			local var_37_3 = var_3.index

			setText = var_2_10007

			local var_37_4 = arg_37_2
			local var_37_5 = arg_37_2.Find(var_37_4, "Text")

			HXSet = var_37_4

			var_2_10007(var_37_5, var_37_4.hxLan(var_37_1))

			onButton = var_2_10007

			local var_37_6 = arg_36_0
			local var_37_7 = arg_37_2

			local function var_37_8()
				local var_38_0 = arg_36_0
				local var_38_1 = var_0.emit

				Dorm3dInstagramMediator = var_3_10002

				var_38_1(var_38_0, var_3_10002.ON_DISCUSS, var_0.id, var_37_2, var_37_3)

				local var_38_2 = arg_36_0

				var_0.ClosePlayerCommentPanel(var_38_2)

				return
			end

			SFX_PANEL = var_2_10011

			var_2_10007(var_37_6, var_37_7, var_37_8, var_2_10011)
		end

		return
	end)
	var_3:align(#var_36_1)

	return
end

function var_0_1.ClosePlayerCommentPanel(arg_39_0)
	local var_39_0 = arg_39_0.commentPanel
	local var_39_1 = var_1.GetComponent

	typeof = var_1_10003
	Image = var_1_10004
	var_39_1(var_39_0, var_1_10003(var_1_10004)).enabled = false

	local var_39_2 = arg_39_0.commentPanel

	Vector2 = var_2
	var_39_2.sizeDelta = var_2(0, 0)
	setActive = var_39_2

	var_39_2(arg_39_0.optionalPanel, false)

	return
end

function var_0_1.onBackPressed(arg_40_0)
	if arg_40_0.inDetail then
		arg_40_0:ExitDetail()

		return
	end

	var_0_1.super.onBackPressed(arg_40_0)

	return
end

function var_0_1.willExit(arg_41_0)
	if arg_41_0.inDetail then
		arg_41_0:ExitDetail()
	end

	pairs = var_1

	for iter_41_0, iter_41_1 in var_1(arg_41_0.cards) do
		iter_41_1:Dispose()
	end

	arg_41_0.cards = {}

	return
end

return var_0_1
