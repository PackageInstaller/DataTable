class = var_0_10000

local var_0_0 = "InstagramLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "InstagramUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.SetProxy

	getProxy = var_1_10005
	InstagramProxy = var_1_10007

	var_2_1(var_2_0, var_1_10005(var_1_10007))
	arg_2_1()

	return
end

function var_0_1.SetProxy(arg_3_0, arg_3_1)
	arg_3_0.proxy = arg_3_1
	arg_3_0.instagramVOById = arg_3_1:GetData()
	arg_3_0.messages = arg_3_1:GetMessages()

	return
end

function var_0_1.UpdateSelectedInstagram(arg_4_0, arg_4_1)
	if arg_4_0.contextData.instagram and arg_4_0.contextData.instagram.id == arg_4_1 then
		arg_4_0.contextData.instagram = arg_4_0.instagramVOById[arg_4_1]

		arg_4_0:UpdateCommentList()
	end

	return
end

function var_0_1.init(arg_5_0)
	GameObject = var_1_10001

	local var_5_0 = var_1_10001.Find("MainObject")

	BulletinBoardMgr = var_1_10002
	arg_5_0.downloadmgr = var_1_10002.Inst

	local var_5_1 = arg_5_0._tf

	arg_5_0.listTF = var_2.Find(var_5_1, "list")

	local var_5_2 = arg_5_0._tf

	arg_5_0.mainTF = var_2.Find(var_5_2, "main")

	local var_5_3 = arg_5_0._tf

	arg_5_0.closeBtn = var_2.Find(var_5_3, "closeBtn")

	local var_5_4 = arg_5_0._tf

	arg_5_0.noMsgTF = var_2.Find(var_5_4, "list/bg/no_msg")

	local var_5_5 = arg_5_0._tf

	arg_5_0.scrollBarTF = var_2.Find(var_5_5, "list/bg/scroll_bar")

	local var_5_6 = arg_5_0._tf
	local var_5_7 = var_2.Find(var_5_6, "list/bg/scrollrect")

	arg_5_0.list = var_2.GetComponent(var_5_7, "LScrollRect")

	local var_5_8 = arg_5_0._tf
	local var_5_9 = var_2.Find(var_5_8, "main/left_panel/mask/Image")
	local var_5_10 = var_2.GetComponent

	typeof = var_5
	RawImage = var_1_10007
	arg_5_0.imageTF = var_5_10(var_5_9, var_5(var_1_10007))

	local var_5_11 = arg_5_0._tf

	arg_5_0.likeBtn = var_2.Find(var_5_11, "main/left_panel/heart")

	local var_5_12 = arg_5_0._tf

	arg_5_0.bubbleTF = var_2.Find(var_5_12, "main/left_panel/bubble")

	local var_5_13 = arg_5_0._tf

	arg_5_0.planeTF = var_2.Find(var_5_13, "main/left_panel/plane")

	local var_5_14 = arg_5_0._tf
	local var_5_15 = var_2.Find(var_5_14, "main/left_panel/zan")
	local var_5_16 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_5_0.likeCntTxt = var_5_16(var_5_15, var_5(var_1_10007))

	local var_5_17 = arg_5_0._tf
	local var_5_18 = var_2.Find(var_5_17, "main/left_panel/time")
	local var_5_19 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_5_0.pushTimeTxt = var_5_19(var_5_18, var_5(var_1_10007))

	local var_5_20 = arg_5_0._tf

	arg_5_0.iconTF = var_2.Find(var_5_20, "main/right_panel/top/head/icon")

	local var_5_21 = arg_5_0._tf
	local var_5_22 = var_2.Find(var_5_21, "main/right_panel/top/name")
	local var_5_23 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_5_0.nameTxt = var_5_23(var_5_22, var_5(var_1_10007))

	local var_5_24 = arg_5_0._tf

	arg_5_0.centerTF = var_2.Find(var_5_24, "main/right_panel/center")

	local var_5_25 = arg_5_0._tf
	local var_5_26 = var_2.Find(var_5_25, "main/right_panel/center/Text/Text")
	local var_5_27 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_5_0.contentTxt = var_5_27(var_5_26, var_5(var_1_10007))
	UIItemList = var_2

	local var_5_28 = var_2.New
	local var_5_29 = arg_5_0._tf
	local var_5_30 = var_4.Find(var_5_29, "main/right_panel/center/bottom/scroll/content")
	local var_5_31 = arg_5_0._tf

	arg_5_0.commentList = var_5_28(var_5_30, var_5.Find(var_5_31, "main/right_panel/center/bottom/scroll/content/tpl"))

	local var_5_32 = arg_5_0._tf

	arg_5_0.commentPanel = var_2.Find(var_5_32, "main/right_panel/last/bg2")

	local var_5_33 = arg_5_0._tf

	arg_5_0.optionalPanel = var_2.Find(var_5_33, "main/right_panel/last/bg2/option")

	local var_5_34 = arg_5_0._tf

	arg_5_0.scroll = var_2.Find(var_5_34, "main/right_panel/center/bottom/scroll")
	setText = var_2

	local var_5_35 = arg_5_0._tf
	local var_5_36 = var_4.Find(var_5_35, "closeBtn/Text")

	i18n = var_5

	var_2(var_5_36, var_5("word_back"))

	arg_5_0.sprites = {}
	arg_5_0.timers = {}
	arg_5_0.toDownloadList = {}

	arg_5_0:OverlayPanel(arg_5_0._tf)

	return
end

function var_0_1.SetImageByUrl(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_1 or arg_6_1 == "" then
		setActive = var_1_10004

		var_1_10004(arg_6_2.gameObject, false)

		if arg_6_3 then
			arg_6_3()
		end
	else
		setActive = var_1_10004

		var_1_10004(arg_6_2.gameObject, true)

		if arg_6_0.sprites[arg_6_1] then
			arg_6_2.texture = var_4

			if arg_6_3 then
				arg_6_3()
			end
		else
			arg_6_2.enabled = false

			local var_6_0 = arg_6_0.downloadmgr
			local var_6_1 = var_5.GetTexture
			local var_6_2 = "ins"
			local var_6_3 = "1"
			local var_6_4 = arg_6_1

			UnityEngine = var_1_10011

			var_6_1(var_6_0, var_6_2, var_6_3, var_6_4, var_1_10011.Events.UnityAction_UnityEngine_Texture(function(arg_7_0)
				if arg_6_0.exited then
					return
				end

				if not arg_6_0.sprites then
					return
				end

				arg_6_0.sprites[arg_6_1] = arg_7_0
				arg_6_2.texture = arg_7_0
				arg_6_2.enabled = true

				if arg_6_3 then
					arg_6_3()
				end

				return
			end))

			table = var_6_1

			var_6_1.insert(arg_6_0.toDownloadList, arg_6_1)
		end
	end

	return
end

function var_0_1.didEnter(arg_8_0)
	arg_8_0:SetUp()

	arg_8_0.cards = {}

	function arg_8_0.list.onInitItem(arg_9_0)
		InstagramCard = var_2_10001

		local var_9_0 = var_2_10001.New(arg_9_0, arg_8_0)

		onButton = var_2_10002

		local var_9_1 = arg_8_0
		local var_9_2 = var_9_0._go

		local function var_9_3()
			local var_10_0 = arg_8_0

			var_0.EnterDetail(var_10_0, var_9_0.instagram)

			return
		end

		SFX_PANEL = var_2_10007

		var_2_10002(var_9_1, var_9_2, var_9_3, var_2_10007)

		arg_8_0.cards[arg_9_0] = var_9_0

		return
	end

	function arg_8_0.list.onUpdateItem(arg_11_0, arg_11_1)
		local var_11_0

		if not arg_8_0.cards[arg_11_1] then
			InstagramCard = var_2_10003
			var_11_0 = var_2_10003.New(arg_11_1)
			arg_8_0.cards[arg_11_1] = var_11_0
		end

		local var_11_1 = arg_8_0.display[arg_11_0 + 1]
		local var_11_2 = arg_8_0.instagramVOById[var_11_1.id]

		var_11_0:Update(var_11_2)

		return
	end

	arg_8_0:InitList()

	return
end

function var_0_1.SetUp(arg_12_0)
	setActive = var_1_10001

	var_1_10001(arg_12_0.listTF, true)

	setActive = var_1_10001

	var_1_10001(arg_12_0.mainTF, false)

	setActive = var_1_10001

	var_1_10001(arg_12_0.closeBtn, false)

	onButton = var_1_10001

	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.closeBtn

	local function var_12_2()
		if arg_12_0.inDetail then
			local var_13_0 = arg_12_0

			var_0.ExitDetail(var_13_0)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_12_0, var_12_1, var_12_2, var_1_10006)

	return
end

function var_0_1.InitList(arg_14_0)
	_ = var_1_10001
	arg_14_0.display = var_1_10001.map(arg_14_0.messages, function(arg_15_0)
		return {
			time = arg_15_0:GetLasterUpdateTime(),
			id = arg_15_0.id,
			order = arg_15_0:GetSortIndex()
		}
	end)
	table = var_1

	var_1.sort(arg_14_0.display, function(arg_16_0, arg_16_1)
		if arg_16_0.order == arg_16_1.order then
			return arg_16_0.id > arg_16_1.id
		else
			return arg_16_0.order > arg_16_1.order
		end

		return
	end)

	isActive = var_1

	if var_1(arg_14_0.listTF) then
		local var_14_0 = arg_14_0.list

		var_1.SetTotalCount(var_14_0, #arg_14_0.display)
	end

	setActive = var_1

	var_1(arg_14_0.noMsgTF, #arg_14_0.display == 0)

	setActive = var_1

	var_1(arg_14_0.scrollBarTF, not #arg_14_0.display == 0)

	return
end

function var_0_1.UpdateInstagram(arg_17_0, arg_17_1, arg_17_2)
	pairs = var_1_10003

	for iter_17_0, iter_17_1 in var_1_10003(arg_17_0.cards) do
		if iter_17_1.instagram and iter_17_1.instagram.id == arg_17_1 then
			iter_17_1:Update(arg_17_0.instagramVOById[arg_17_1], arg_17_2)
		end
	end

	return
end

function var_0_1.EnterDetail(arg_18_0, arg_18_1)
	arg_18_0.contextData.instagram = arg_18_1

	arg_18_0:InitDetailPage()

	arg_18_0.inDetail = true
	setActive = var_2

	var_2(arg_18_0.listTF, false)

	setActive = var_2

	var_2(arg_18_0.mainTF, true)

	setActive = var_2

	var_2(arg_18_0.closeBtn, true)

	pg = var_2

	local var_18_0 = var_2.SystemGuideMgr.GetInstance()

	var_2.Play(var_18_0, arg_18_0)
	arg_18_0:RefreshInstagram()

	scrollTo = var_2

	var_2(arg_18_0.scroll, 0, 1)

	return
end

function var_0_1.ExitDetail(arg_19_0)
	if arg_19_0.contextData.instagram and not var_1:IsReaded() then
		local var_19_0 = arg_19_0
		local var_19_1 = arg_19_0.emit

		InstagramMediator = var_1_10005

		var_19_1(var_19_0, var_1_10005.ON_READED, var_1.id)
	end

	arg_19_0.contextData.instagram = nil
	arg_19_0.inDetail = false
	setActive = var_2

	var_2(arg_19_0.listTF, true)

	setActive = var_2

	var_2(arg_19_0.mainTF, false)

	setActive = var_2

	var_2(arg_19_0.closeBtn, false)
	arg_19_0:CloseCommentPanel()

	return
end

function var_0_1.RefreshInstagram(arg_20_0)
	local var_20_0 = arg_20_0.contextData.instagram

	if var_1.GetFastestRefreshTime(var_20_0) then
		pg = var_1_10003

		local var_20_1 = var_1_10003.TimeMgr.GetInstance()

		if var_2 - var_3.GetServerTime(var_20_1) <= 0 then
			local var_20_2 = arg_20_0
			local var_20_3 = arg_20_0.emit

			InstagramMediator = var_1_10008

			var_20_3(var_20_2, var_1_10008.ON_REPLY_UPDATE, var_1.id)
		end
	end

	return
end

function var_0_1.InitDetailPage(arg_21_0)
	local var_21_0 = arg_21_0.contextData.instagram
	local var_21_1 = arg_21_0
	local var_21_2 = arg_21_0.SetImageByUrl
	local var_21_3 = var_21_0

	var_21_2(var_21_1, var_21_0.GetImage(var_21_3), arg_21_0.imageTF)

	onButton = var_21_2

	local var_21_4 = arg_21_0
	local var_21_5 = arg_21_0.planeTF

	local function var_21_6()
		local var_22_0 = arg_21_0
		local var_22_1 = var_0.emit

		InstagramMediator = var_2_10003

		var_22_1(var_22_0, var_2_10003.ON_SHARE, var_21_0.id)

		return
	end

	SFX_PANEL = var_21_3

	var_21_2(var_21_4, var_21_5, var_21_6, var_21_3)

	local var_21_7 = arg_21_0.pushTimeTxt
	local var_21_8 = var_21_0

	var_21_7.text = var_21_0.GetPushTime(var_21_8)
	setImageSprite = var_21_7

	local var_21_9 = arg_21_0.iconTF

	LoadSprite = var_21_8

	var_21_7(var_21_9, var_21_8("qicon/" .. var_21_0:GetIcon()), false)

	arg_21_0.nameTxt.text = var_21_0:GetName()

	local var_21_10 = arg_21_0.contentTxt

	var_21_10.text = var_21_0:GetContent()
	onToggle = var_21_10

	local var_21_11 = arg_21_0
	local var_21_12 = arg_21_0.commentPanel

	local function var_21_13(arg_23_0)
		if arg_23_0 then
			local var_23_0 = arg_21_0

			var_1.OpenCommentPanel(var_23_0)
		else
			local var_23_1 = arg_21_0

			var_1.CloseCommentPanel(var_23_1)
		end

		return
	end

	SFX_PANEL = var_7

	var_21_10(var_21_11, var_21_12, var_21_13, var_7)
	arg_21_0:UpdateLikeBtn()
	arg_21_0:UpdateCommentList()

	return
end

function var_0_1.UpdateLikeBtn(arg_24_0)
	local var_24_0 = arg_24_0.contextData.instagram

	if not var_1.IsLiking(var_24_0) then
		onButton = var_1_10003

		local var_24_1 = arg_24_0
		local var_24_2 = arg_24_0.likeBtn

		local function var_24_3()
			local var_25_0 = arg_24_0
			local var_25_1 = var_0.emit

			InstagramMediator = var_2_10003

			var_25_1(var_25_0, var_2_10003.ON_LIKE, var_0.id)

			return
		end

		SFX_PANEL = var_1_10008

		var_1_10003(var_24_1, var_24_2, var_24_3, var_1_10008)
	else
		removeOnButton = var_1_10003

		var_1_10003(arg_24_0.likeBtn)
	end

	setActive = var_1_10003

	local var_24_4 = arg_24_0.likeBtn

	var_1_10003(var_5.Find(var_24_4, "heart"), var_2)

	local var_24_5 = arg_24_0.likeBtn
	local var_24_6 = var_3.GetComponent

	typeof = var_6
	Image = var_8
	var_24_6(var_24_5, var_6(var_8)).enabled = not var_2

	local var_24_7 = arg_24_0.likeCntTxt

	i18n = var_4
	var_24_7.text = var_4("ins_word_like", var_1:GetLikeCnt())

	return
end

function var_0_1.UpdateCommentList(arg_26_0)
	if not arg_26_0.contextData.instagram then
		return
	end

	local var_26_0 = var_1
	local var_26_1, var_26_2 = var_1.GetCanDisplayComments(var_26_0)

	table = var_26_0

	var_26_0.sort(var_26_1, function(arg_27_0, arg_27_1)
		return arg_27_0.time < arg_27_1.time
	end)

	local var_26_3 = arg_26_0.commentList

	var_4.make(var_26_3, function(arg_28_0, arg_28_1, arg_28_2)
		UIItemList = var_2_10003

		if arg_28_0 == var_2_10003.EventUpdate then
			local var_28_0 = var_26_1[arg_28_1 + 1]
			local var_28_1 = var_3.HasReply(var_28_0)

			setText = var_2_10005

			local var_28_2 = arg_28_2

			var_2_10005(arg_28_2.Find(var_28_2, "main/reply"), var_3:GetReplyBtnTxt())

			local var_28_3 = var_3
			local var_28_4 = var_3.GetContent(var_28_3)

			SwitchSpecialChar = var_28_0

			local var_28_5 = var_28_0(var_28_4)

			setText = var_6

			local var_28_6 = arg_28_2:Find("main/content")

			HXSet = var_28_2

			var_6(var_28_6, var_28_2.hxLan(var_28_5))

			setText = var_6

			var_6(arg_28_2:Find("main/bubble/Text"), var_3:GetReplyCnt())

			setText = var_6

			local var_28_7 = arg_28_2:Find("main/time")
			local var_28_8 = var_3

			var_6(var_28_7, var_3.GetTime(var_28_8))

			local var_28_9 = var_3:GetType()

			Instagram = var_28_3

			if var_28_9 == var_28_3.TYPE_PLAYER_COMMENT then
				local var_28_10 = var_3
				local var_28_11

				var_28_9, var_28_11 = var_3.GetIcon(var_28_10)
				setImageSprite = var_28_10

				local var_28_12 = arg_28_2:Find("main/head/icon")

				GetSpriteFromAtlas = var_28_8

				var_28_10(var_28_12, var_28_8(var_28_9, var_28_11))
			else
				setImageSprite = var_28_9

				local var_28_13 = arg_28_2:Find("main/head/icon")

				LoadSprite = var_9

				var_28_9(var_28_13, var_9("qicon/" .. var_3:GetIcon()), false)
			end

			if var_28_1 then
				onToggle = var_28_9

				local var_28_14 = arg_26_0

				var_28_8 = arg_28_2

				local var_28_15 = arg_28_2.Find(var_28_8, "main/bubble")

				local function var_28_16(arg_29_0)
					setActive = var_3_10001

					local var_29_0 = arg_28_2

					var_3_10001(var_3.Find(var_29_0, "replys"), arg_29_0)

					return
				end

				SFX_PANEL = var_28_8

				var_28_9(var_28_14, var_28_15, var_28_16, var_28_8)

				local var_28_17 = arg_26_0

				var_28_9.UpdateReplys(var_28_17, arg_28_2, var_3)

				triggerToggle = var_28_9

				var_28_9(arg_28_2:Find("main/bubble"), true)
			else
				setActive = var_28_9

				var_28_9(arg_28_2:Find("replys"), false)

				triggerToggle = var_28_9

				var_28_9(arg_28_2:Find("main/bubble"), false)
			end

			local var_28_18 = arg_28_2:Find("main/bubble")
			local var_28_19 = var_6.GetComponent

			typeof = var_9
			Toggle = var_28_8
			var_28_19(var_28_18, var_9(var_28_8)).enabled = var_28_1
		end

		return
	end)

	setActive = var_4

	var_4(arg_26_0.centerTF, false)

	setActive = var_4

	var_4(arg_26_0.centerTF, true)

	Canvas = var_4

	var_4.ForceUpdateCanvases()

	local var_26_4 = arg_26_0.commentList

	var_4.align(var_26_4, #var_26_1)

	return
end

function var_0_1.UpdateReplys(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_2
	local var_30_1, var_30_2 = arg_30_2.GetCanDisplayReply(var_30_0)

	UIItemList = var_30_0

	local var_30_3 = var_30_0.New(arg_30_1:Find("replys"), arg_30_1:Find("replys/sub"))

	table = var_1_10006

	var_1_10006.sort(var_30_1, function(arg_31_0, arg_31_1)
		if arg_31_0.level == arg_31_1.level then
			if arg_31_0.time == arg_31_1.time then
				return arg_31_0.id < arg_31_1.id
			else
				return arg_31_0.time < arg_31_1.time
			end
		else
			return arg_31_0.level < arg_31_1.level
		end

		return
	end)
	var_30_3:make(function(arg_32_0, arg_32_1, arg_32_2)
		UIItemList = var_2_10003

		if arg_32_0 == var_2_10003.EventUpdate then
			local var_32_0 = var_30_1[arg_32_1 + 1]

			setImageSprite = var_4

			local var_32_1 = arg_32_2:Find("head/icon")

			LoadSprite = var_2_10007

			var_4(var_32_1, var_2_10007("qicon/" .. var_32_0:GetIcon()), false)

			local var_32_2 = var_32_0:GetContent()

			SwitchSpecialChar = var_2_10005

			local var_32_3 = var_2_10005(var_32_2)

			setText = var_5

			local var_32_4 = arg_32_2:Find("content")

			HXSet = var_8

			var_5(var_32_4, var_8.hxLan(var_32_3))
		end

		return
	end)
	var_30_3:align(#var_30_1)

	return
end

function var_0_1.OpenCommentPanel(arg_33_0)
	local var_33_0 = arg_33_0.contextData.instagram

	if not var_1.CanOpenComment(var_33_0) then
		return
	end

	setActive = var_2

	var_2(arg_33_0.optionalPanel, true)

	local var_33_1 = var_1:GetOptionComment()
	local var_33_2 = arg_33_0.commentPanel
	local var_33_3 = var_3.GetComponent

	typeof = var_1_10006
	Image = var_1_10008
	var_33_3(var_33_2, var_1_10006(var_1_10008)).enabled = true

	local var_33_4 = arg_33_0.commentPanel

	Vector2 = var_4
	var_33_4.sizeDelta = var_4(0, #var_33_1 * 14 + 60)
	UIItemList = var_33_4

	local var_33_5 = var_33_4.New
	local var_33_6 = arg_33_0.optionalPanel
	local var_33_7 = arg_33_0.optionalPanel
	local var_33_8 = var_33_5(var_33_6, var_6.Find(var_33_7, "option1"))

	var_3.make(var_33_8, function(arg_34_0, arg_34_1, arg_34_2)
		UIItemList = var_2_10003

		if arg_34_0 == var_2_10003.EventUpdate then
			local var_34_0 = arg_34_1 + 1
			local var_34_1 = var_33_1[var_34_0].text
			local var_34_2 = var_33_1[var_34_0].id
			local var_34_3 = var_33_1[var_34_0].index

			setText = var_2_10007

			local var_34_4 = arg_34_2:Find("Text")

			HXSet = var_2_10010

			var_2_10007(var_34_4, var_2_10010.hxLan(var_34_1))

			onButton = var_2_10007

			local var_34_5 = arg_33_0
			local var_34_6 = arg_34_2

			local function var_34_7()
				local var_35_0 = arg_33_0
				local var_35_1 = var_0.emit

				InstagramMediator = var_3_10003

				var_35_1(var_35_0, var_3_10003.ON_COMMENT, var_0.id, var_34_3, var_34_2)

				local var_35_2 = arg_33_0

				var_0.CloseCommentPanel(var_35_2)

				return
			end

			SFX_PANEL = var_12

			var_2_10007(var_34_5, var_34_6, var_34_7, var_12)
		end

		return
	end)
	var_3:align(#var_33_1)

	return
end

function var_0_1.CloseCommentPanel(arg_36_0)
	local var_36_0 = arg_36_0.commentPanel
	local var_36_1 = var_1.GetComponent

	typeof = var_1_10004
	Image = var_1_10006
	var_36_1(var_36_0, var_1_10004(var_1_10006)).enabled = false

	local var_36_2 = arg_36_0.commentPanel

	Vector2 = var_2
	var_36_2.sizeDelta = var_2(0, 0)
	setActive = var_36_2

	var_36_2(arg_36_0.optionalPanel, false)

	return
end

function var_0_1.onBackPressed(arg_37_0)
	if arg_37_0.inDetail then
		arg_37_0:ExitDetail()

		return
	end

	local var_37_0 = arg_37_0
	local var_37_1 = arg_37_0.emit

	InstagramMediator = var_1_10004

	var_37_1(var_37_0, var_1_10004.CLOSE_ALL)

	return
end

function var_0_1.CloseDetail(arg_38_0)
	if arg_38_0.inDetail then
		arg_38_0:ExitDetail()

		return
	end

	return
end

function var_0_1.willExit(arg_39_0)
	ipairs = var_1_10001

	local var_39_0

	if not arg_39_0.toDownloadList then
		var_39_0 = {}
	end

	for iter_39_0, iter_39_1 in var_1_10001(var_39_0) do
		local var_39_1 = arg_39_0.downloadmgr

		var_1_10006.StopLoader(var_39_1, iter_39_1)
	end

	arg_39_0.toDownloadList = {}

	arg_39_0:UnOverlayPanel(arg_39_0._tf)
	arg_39_0:ExitDetail()

	pairs = var_1

	for iter_39_2, iter_39_3 in var_1(arg_39_0.sprites) do
		IsNil = var_1_10006

		if not var_1_10006(iter_39_3) then
			Object = var_1_10006

			var_1_10006.Destroy(iter_39_3)
		end
	end

	arg_39_0.sprites = nil
	pairs = var_1

	for iter_39_4, iter_39_5 in var_1(arg_39_0.cards) do
		iter_39_5:Dispose()
	end

	arg_39_0.cards = {}

	return
end

return var_0_1
