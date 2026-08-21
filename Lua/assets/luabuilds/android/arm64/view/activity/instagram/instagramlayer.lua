local var_0_0 = class("InstagramLayer", import("...base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "InstagramUI"
end

function var_0_0.preload(arg_2_0, arg_2_1)
	arg_2_0:SetProxy(getProxy(InstagramProxy))
	arg_2_1()

	return
end

function var_0_0.SetProxy(arg_3_0, arg_3_1)
	arg_3_0.proxy = arg_3_1
	arg_3_0.instagramVOById = arg_3_1:GetData()
	arg_3_0.messages = arg_3_1:GetMessages()

	return
end

function var_0_0.UpdateSelectedInstagram(arg_4_0, arg_4_1)
	if arg_4_0.contextData.instagram and arg_4_0.contextData.instagram.id == arg_4_1 then
		arg_4_0.contextData.instagram = arg_4_0.instagramVOById[arg_4_1]

		arg_4_0:UpdateCommentList()
	end

	return
end

function var_0_0.init(arg_5_0)
	local var_5_0 = GameObject.Find("MainObject")

	arg_5_0.downloadmgr = BulletinBoardMgr.Inst
	arg_5_0.listTF = arg_5_0._tf:Find("list")
	arg_5_0.mainTF = arg_5_0._tf:Find("main")
	arg_5_0.closeBtn = arg_5_0._tf:Find("closeBtn")
	arg_5_0.noMsgTF = arg_5_0._tf:Find("list/bg/no_msg")
	arg_5_0.scrollBarTF = arg_5_0._tf:Find("list/bg/scroll_bar")
	arg_5_0.list = arg_5_0._tf:Find("list/bg/scrollrect"):GetComponent("LScrollRect")
	arg_5_0.imageTF = arg_5_0._tf:Find("main/left_panel/mask/Image"):GetComponent(typeof(RawImage))
	arg_5_0.likeBtn = arg_5_0._tf:Find("main/left_panel/heart")
	arg_5_0.bubbleTF = arg_5_0._tf:Find("main/left_panel/bubble")
	arg_5_0.planeTF = arg_5_0._tf:Find("main/left_panel/plane")
	arg_5_0.likeCntTxt = arg_5_0._tf:Find("main/left_panel/zan"):GetComponent(typeof(Text))
	arg_5_0.pushTimeTxt = arg_5_0._tf:Find("main/left_panel/time"):GetComponent(typeof(Text))
	arg_5_0.iconTF = arg_5_0._tf:Find("main/right_panel/top/head/icon")
	arg_5_0.nameTxt = arg_5_0._tf:Find("main/right_panel/top/name"):GetComponent(typeof(Text))
	arg_5_0.centerTF = arg_5_0._tf:Find("main/right_panel/center")
	arg_5_0.contentTxt = arg_5_0._tf:Find("main/right_panel/center/Text/Text"):GetComponent(typeof(Text))
	arg_5_0.commentList = UIItemList.New(arg_5_0._tf:Find("main/right_panel/center/bottom/scroll/content"), arg_5_0._tf:Find("main/right_panel/center/bottom/scroll/content/tpl"))
	arg_5_0.commentPanel = arg_5_0._tf:Find("main/right_panel/last/bg2")
	arg_5_0.optionalPanel = arg_5_0._tf:Find("main/right_panel/last/bg2/option")
	arg_5_0.scroll = arg_5_0._tf:Find("main/right_panel/center/bottom/scroll")

	setText(arg_5_0._tf:Find("closeBtn/Text"), i18n("word_back"))

	arg_5_0.sprites = {}
	arg_5_0.timers = {}
	arg_5_0.toDownloadList = {}

	arg_5_0:OverlayPanel(arg_5_0._tf)

	return
end

function var_0_0.SetImageByUrl(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_1 or arg_6_1 == "" then
		setActive(arg_6_2.gameObject, false)

		if arg_6_3 then
			arg_6_3()
		end
	else
		setActive(arg_6_2.gameObject, true)

		if arg_6_0.sprites[arg_6_1] then
			arg_6_2.texture = arg_6_0.sprites[arg_6_1]

			if arg_6_3 then
				arg_6_3()
			end
		else
			arg_6_2.enabled = false

			arg_6_0.downloadmgr:GetTexture("ins", "1", arg_6_1, UnityEngine.Events.UnityAction_UnityEngine_Texture(function(arg_7_0)
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
			table.insert(arg_6_0.toDownloadList, arg_6_1)
		end
	end

	return
end

function var_0_0.didEnter(arg_8_0)
	arg_8_0:SetUp()

	arg_8_0.cards = {}

	function arg_8_0.list.onInitItem(arg_9_0)
		local var_9_0 = InstagramCard.New(arg_9_0, arg_8_0)

		onButton(arg_8_0, var_9_0._go, function()
			arg_8_0:EnterDetail(var_9_0.instagram)

			return
		end, SFX_PANEL)

		arg_8_0.cards[arg_9_0] = var_9_0

		return
	end

	function arg_8_0.list.onUpdateItem(arg_11_0, arg_11_1)
		local var_11_0 = arg_8_0.cards[arg_11_1]

		if not arg_8_0.cards[arg_11_1] then
			var_11_0 = InstagramCard.New(arg_11_1)
			arg_8_0.cards[arg_11_1] = var_11_0
		end

		var_11_0:Update(arg_8_0.instagramVOById[arg_8_0.display[arg_11_0 + 1].id])

		return
	end

	arg_8_0:InitList()

	return
end

function var_0_0.SetUp(arg_12_0)
	setActive(arg_12_0.listTF, true)
	setActive(arg_12_0.mainTF, false)
	setActive(arg_12_0.closeBtn, false)
	onButton(arg_12_0, arg_12_0.closeBtn, function()
		if arg_12_0.inDetail then
			arg_12_0:ExitDetail()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.InitList(arg_14_0)
	arg_14_0.display = _.map(arg_14_0.messages, function(arg_15_0)
		return {
			time = arg_15_0:GetLasterUpdateTime(),
			id = arg_15_0.id,
			order = arg_15_0:GetSortIndex()
		}
	end)

	table.sort(arg_14_0.display, function(arg_16_0, arg_16_1)
		if arg_16_0.order == arg_16_1.order then
			return arg_16_0.id > arg_16_1.id
		else
			return arg_16_0.order > arg_16_1.order
		end

		return
	end)

	if isActive(arg_14_0.listTF) then
		arg_14_0.list:SetTotalCount(#arg_14_0.display)
	end

	setActive(arg_14_0.noMsgTF, #arg_14_0.display == 0)
	setActive(arg_14_0.scrollBarTF, not #arg_14_0.display == 0)

	return
end

function var_0_0.UpdateInstagram(arg_17_0, arg_17_1, arg_17_2)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.cards) do
		if iter_17_1.instagram and iter_17_1.instagram.id == arg_17_1 then
			iter_17_1:Update(arg_17_0.instagramVOById[arg_17_1], arg_17_2)
		end
	end

	return
end

function var_0_0.EnterDetail(arg_18_0, arg_18_1)
	arg_18_0.contextData.instagram = arg_18_1

	arg_18_0:InitDetailPage()

	arg_18_0.inDetail = true

	setActive(arg_18_0.listTF, false)
	setActive(arg_18_0.mainTF, true)
	setActive(arg_18_0.closeBtn, true)
	pg.SystemGuideMgr.GetInstance():Play(arg_18_0)
	arg_18_0:RefreshInstagram()
	scrollTo(arg_18_0.scroll, 0, 1)

	return
end

function var_0_0.ExitDetail(arg_19_0)
	if arg_19_0.contextData.instagram and not arg_19_0.contextData.instagram:IsReaded() then
		arg_19_0:emit(InstagramMediator.ON_READED, arg_19_0.contextData.instagram.id)
	end

	arg_19_0.contextData.instagram = nil
	arg_19_0.inDetail = false

	setActive(arg_19_0.listTF, true)
	setActive(arg_19_0.mainTF, false)
	setActive(arg_19_0.closeBtn, false)
	arg_19_0:CloseCommentPanel()

	return
end

function var_0_0.RefreshInstagram(arg_20_0)
	local var_20_0 = arg_20_0.contextData.instagram:GetFastestRefreshTime()

	if var_20_0 then
		if var_20_0 - pg.TimeMgr.GetInstance():GetServerTime() <= 0 then
			arg_20_0:emit(InstagramMediator.ON_REPLY_UPDATE, arg_20_0.contextData.instagram.id)
		end
	end

	return
end

function var_0_0.InitDetailPage(arg_21_0)
	local var_21_0 = arg_21_0.contextData.instagram

	arg_21_0:SetImageByUrl(arg_21_0.contextData.instagram:GetImage(), arg_21_0.imageTF)
	onButton(arg_21_0, arg_21_0.planeTF, function()
		arg_21_0:emit(InstagramMediator.ON_SHARE, var_21_0.id)

		return
	end, SFX_PANEL)

	arg_21_0.pushTimeTxt.text = arg_21_0.contextData.instagram:GetPushTime()

	setImageSprite(arg_21_0.iconTF, LoadSprite("qicon/" .. arg_21_0.contextData.instagram:GetIcon()), false)

	arg_21_0.nameTxt.text = arg_21_0.contextData.instagram:GetName()
	arg_21_0.contentTxt.text = arg_21_0.contextData.instagram:GetContent()

	onToggle(arg_21_0, arg_21_0.commentPanel, function(arg_23_0)
		if arg_23_0 then
			arg_21_0:OpenCommentPanel()
		else
			arg_21_0:CloseCommentPanel()
		end

		return
	end, SFX_PANEL)
	arg_21_0:UpdateLikeBtn()
	arg_21_0:UpdateCommentList()

	return
end

function var_0_0.UpdateLikeBtn(arg_24_0)
	local var_24_0 = arg_24_0.contextData.instagram
	local var_24_1 = arg_24_0.contextData.instagram:IsLiking()

	if not var_24_1 then
		onButton(arg_24_0, arg_24_0.likeBtn, function()
			arg_24_0:emit(InstagramMediator.ON_LIKE, var_24_0.id)

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_24_0.likeBtn)
	end

	setActive(arg_24_0.likeBtn:Find("heart"), var_24_1)

	arg_24_0.likeBtn:GetComponent(typeof(Image)).enabled = not var_24_1
	arg_24_0.likeCntTxt.text = i18n("ins_word_like", var_24_0:GetLikeCnt())

	return
end

function var_0_0.UpdateCommentList(arg_26_0)
	if not arg_26_0.contextData.instagram then
		return
	end

	local var_26_0, var_26_1 = arg_26_0.contextData.instagram:GetCanDisplayComments()

	table.sort(var_26_0, function(arg_27_0, arg_27_1)
		return arg_27_0.time < arg_27_1.time
	end)
	arg_26_0.commentList:make(function(arg_28_0, arg_28_1, arg_28_2)
		if arg_28_0 == UIItemList.EventUpdate then
			local var_28_0 = var_26_0[arg_28_1 + 1]
			local var_28_1 = var_26_0[arg_28_1 + 1]:HasReply()

			setText(arg_28_2:Find("main/reply"), var_26_0[arg_28_1 + 1]:GetReplyBtnTxt())
			setText(arg_28_2:Find("main/content"), HXSet.hxLan((SwitchSpecialChar((var_28_0:GetContent())))))
			setText(arg_28_2:Find("main/bubble/Text"), var_28_0:GetReplyCnt())
			setText(arg_28_2:Find("main/time"), var_28_0:GetTime())

			if var_28_0:GetType() == Instagram.TYPE_PLAYER_COMMENT then
				local var_28_2, var_28_3 = var_28_0:GetIcon()

				setImageSprite(arg_28_2:Find("main/head/icon"), GetSpriteFromAtlas(var_28_2, var_28_3))
			else
				setImageSprite(arg_28_2:Find("main/head/icon"), LoadSprite("qicon/" .. var_28_0:GetIcon()), false)
			end

			if var_28_1 then
				onToggle(arg_26_0, arg_28_2:Find("main/bubble"), function(arg_29_0)
					setActive(arg_28_2:Find("replys"), arg_29_0)

					return
				end, SFX_PANEL)
				arg_26_0:UpdateReplys(arg_28_2, var_28_0)
				triggerToggle(arg_28_2:Find("main/bubble"), true)
			else
				setActive(arg_28_2:Find("replys"), false)
				triggerToggle(arg_28_2:Find("main/bubble"), false)
			end

			local var_28_4 = arg_28_2:Find("main/bubble")

			var_28_4:GetComponent(typeof(Toggle)).enabled = var_28_1
		end

		return
	end)
	setActive(arg_26_0.centerTF, false)
	setActive(arg_26_0.centerTF, true)
	Canvas.ForceUpdateCanvases()
	arg_26_0.commentList:align(#var_26_0)

	return
end

function var_0_0.UpdateReplys(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0, var_30_1 = arg_30_2:GetCanDisplayReply()
	local var_30_2 = UIItemList.New(arg_30_1:Find("replys"), arg_30_1:Find("replys/sub"))

	table.sort(var_30_0, function(arg_31_0, arg_31_1)
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
	var_30_2:make(function(arg_32_0, arg_32_1, arg_32_2)
		if arg_32_0 == UIItemList.EventUpdate then
			setImageSprite(arg_32_2:Find("head/icon"), LoadSprite("qicon/" .. var_30_0[arg_32_1 + 1]:GetIcon()), false)
			setText(arg_32_2:Find("content"), HXSet.hxLan((SwitchSpecialChar((var_30_0[arg_32_1 + 1]:GetContent())))))
		end

		return
	end)
	var_30_2:align(#var_30_0)

	return
end

function var_0_0.OpenCommentPanel(arg_33_0)
	local var_33_0 = arg_33_0.contextData.instagram

	if not arg_33_0.contextData.instagram:CanOpenComment() then
		return
	end

	setActive(arg_33_0.optionalPanel, true)

	local var_33_1 = arg_33_0.contextData.instagram:GetOptionComment()

	arg_33_0.commentPanel:GetComponent(typeof(Image)).enabled = true
	arg_33_0.commentPanel.sizeDelta = Vector2(0, #var_33_1 * 14 + 60)

	local var_33_2 = UIItemList.New(arg_33_0.optionalPanel, arg_33_0.optionalPanel:Find("option1"))

	var_33_2:make(function(arg_34_0, arg_34_1, arg_34_2)
		if arg_34_0 == UIItemList.EventUpdate then
			local var_34_0 = var_33_1[arg_34_1 + 1].id
			local var_34_1 = var_33_1[arg_34_1 + 1].index

			setText(arg_34_2:Find("Text"), HXSet.hxLan(var_33_1[arg_34_1 + 1].text))
			onButton(arg_33_0, arg_34_2, function()
				arg_33_0:emit(InstagramMediator.ON_COMMENT, var_33_0.id, var_34_1, var_34_0)
				arg_33_0:CloseCommentPanel()

				return
			end, SFX_PANEL)
		end

		return
	end)
	var_33_2:align(#var_33_1)

	return
end

function var_0_0.CloseCommentPanel(arg_36_0)
	arg_36_0.commentPanel:GetComponent(typeof(Image)).enabled = false
	arg_36_0.commentPanel.sizeDelta = Vector2(0, 0)

	setActive(arg_36_0.optionalPanel, false)

	return
end

function var_0_0.onBackPressed(arg_37_0)
	if arg_37_0.inDetail then
		arg_37_0:ExitDetail()

		return
	end

	arg_37_0:emit(InstagramMediator.CLOSE_ALL)

	return
end

function var_0_0.CloseDetail(arg_38_0)
	if arg_38_0.inDetail then
		arg_38_0:ExitDetail()

		return
	end

	return
end

function var_0_0.willExit(arg_39_0)
	local var_39_0 = arg_39_0.toDownloadList or {}

	for iter_39_0, iter_39_1 in ipairs(var_39_0) do
		arg_39_0.downloadmgr:StopLoader(iter_39_1)
	end

	arg_39_0.toDownloadList = {}

	arg_39_0:UnOverlayPanel(arg_39_0._tf)
	arg_39_0:ExitDetail()

	for iter_39_2, iter_39_3 in pairs(arg_39_0.sprites) do
		if not IsNil(iter_39_3) then
			Object.Destroy(iter_39_3)
		end
	end

	arg_39_0.sprites = nil

	for iter_39_4, iter_39_5 in pairs(arg_39_0.cards) do
		iter_39_5:Dispose()
	end

	arg_39_0.cards = {}

	return
end

return var_0_0
