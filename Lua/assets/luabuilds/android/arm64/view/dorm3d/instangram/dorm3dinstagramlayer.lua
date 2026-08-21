local var_0_0 = class("Dorm3dInstagramLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "Dorm3dInstagramUI"
end

function var_0_0.GetInstagramList(arg_2_0)
	assert(arg_2_0.contextData.apartmentGroupId, "groupId can not be nil")

	return getProxy(Dorm3dInsProxy):GetInstagramList(arg_2_0.contextData.apartmentGroupId)
end

function var_0_0.init(arg_3_0)
	arg_3_0.listTF = arg_3_0._tf:Find("list")
	arg_3_0.mainTF = arg_3_0._tf:Find("main")
	arg_3_0.closeBtn = arg_3_0._tf:Find("closeBtn")
	arg_3_0.noMsgTF = arg_3_0._tf:Find("list/bg/no_msg")
	arg_3_0.scrollBarTF = arg_3_0._tf:Find("list/bg/scroll_bar")
	arg_3_0.list = arg_3_0._tf:Find("list/bg/scrollrect"):GetComponent("LScrollRect")
	arg_3_0.mainBg = arg_3_0._tf:Find("main/left_panel/bg")
	arg_3_0.imageTF = arg_3_0._tf:Find("main/left_panel/mask/Image"):GetComponent(typeof(Image))
	arg_3_0.likeBtn = arg_3_0._tf:Find("main/left_panel/heart")
	arg_3_0.bubbleTF = arg_3_0._tf:Find("main/left_panel/bubble")
	arg_3_0.planeTF = arg_3_0._tf:Find("main/left_panel/plane")
	arg_3_0.likeCntTxt = arg_3_0._tf:Find("main/left_panel/zan"):GetComponent(typeof(Text))
	arg_3_0.pushTimeTxt = arg_3_0._tf:Find("main/left_panel/time"):GetComponent(typeof(Text))
	arg_3_0.iconTF = arg_3_0._tf:Find("main/right_panel/top/head/icon")
	arg_3_0.nameTxt = arg_3_0._tf:Find("main/right_panel/top/name"):GetComponent(typeof(Text))
	arg_3_0.centerTF = arg_3_0._tf:Find("main/right_panel/center")
	arg_3_0.contentTxt = arg_3_0._tf:Find("main/right_panel/center/Text/Text"):GetComponent(typeof(Text))
	arg_3_0.commentList = UIItemList.New(arg_3_0._tf:Find("main/right_panel/center/bottom/scroll/content"), arg_3_0._tf:Find("main/right_panel/center/bottom/scroll/content/tpl"))
	arg_3_0.commentPanel = arg_3_0._tf:Find("main/right_panel/last/bg2")
	arg_3_0.optionalPanel = arg_3_0._tf:Find("main/right_panel/last/bg2/option")
	arg_3_0.scroll = arg_3_0._tf:Find("main/right_panel/center/bottom/scroll")

	setText(arg_3_0._tf:Find("main_bg/Text"), i18n("dorm3d_privatechat_topics"))
	setText(arg_3_0.noMsgTF:Find("Text"), i18n("dorm3d_ins_no_msg"))
	arg_3_0:OverlayPanel(arg_3_0._tf)

	return
end

function var_0_0.didEnter(arg_4_0)
	setActive(arg_4_0.listTF, true)
	setActive(arg_4_0.mainTF, false)
	onButton(arg_4_0, arg_4_0.closeBtn, function()
		if arg_4_0.inDetail then
			arg_4_0:ExitDetail()

			return
		end

		arg_4_0:emit(var_0_0.ON_CLOSE)

		return
	end, SFX_PANEL)

	arg_4_0.cards = {}

	function arg_4_0.list.onInitItem(arg_6_0)
		arg_4_0:OnInitItem(arg_6_0)

		return
	end

	function arg_4_0.list.onUpdateItem(arg_7_0, arg_7_1)
		arg_4_0:OnUpdateItem(arg_7_0, arg_7_1)

		return
	end

	arg_4_0:InitCards()

	return
end

function var_0_0.OnInitItem(arg_8_0, arg_8_1)
	local var_8_0 = Dorm3dInstagramCard.New(arg_8_1)

	onButton(arg_8_0, var_8_0._go, function()
		if var_8_0.instagram:IsLock() then
			return
		end

		arg_8_0:EnterDetail(var_8_0.instagram)

		return
	end, SFX_PANEL)

	arg_8_0.cards[arg_8_1] = var_8_0

	return
end

function var_0_0.OnUpdateItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.cards[arg_10_2]

	if not arg_10_0.cards[arg_10_2] then
		var_10_0 = Dorm3dInstagramCard.New(arg_10_2)
		arg_10_0.cards[arg_10_2] = var_10_0
	end

	var_10_0:Update(arg_10_0.display[arg_10_1 + 1])

	return
end

function var_0_0.InitCards(arg_11_0)
	arg_11_0.display = {}

	for iter_11_0, iter_11_1 in ipairs((arg_11_0:GetInstagramList())) do
		if not iter_11_1:IsLock() and iter_11_1:CanShow() then
			table.insert(arg_11_0.display, iter_11_1)
		end
	end

	table.sort(arg_11_0.display, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_0:LockState()
		local var_12_1 = arg_12_1:LockState()

		if var_12_0 == var_12_1 then
			return var_12_1 < var_12_0
		else
			return arg_12_0.id > arg_12_1.id
		end

		return
	end)

	if isActive(arg_11_0.listTF) then
		arg_11_0.list:SetTotalCount(#arg_11_0.display)
	end

	setActive(arg_11_0.noMsgTF, #arg_11_0.display == 0)
	setActive(arg_11_0.scrollBarTF, not #arg_11_0.display == 0)

	return
end

function var_0_0.EnterDetail(arg_13_0, arg_13_1)
	arg_13_0.contextData.instagram = arg_13_1

	arg_13_0:InitDetailPage()

	arg_13_0.inDetail = true

	setActive(arg_13_0.listTF, false)
	setActive(arg_13_0.mainTF, true)
	scrollTo(arg_13_0.scroll, 0, 1)

	return
end

function var_0_0.ExitDetail(arg_14_0)
	arg_14_0:emit(Dorm3dInstagramMediator.ON_EXIT, arg_14_0.contextData.instagram.id)

	arg_14_0.contextData.instagram = nil
	arg_14_0.inDetail = false

	setActive(arg_14_0.listTF, true)
	setActive(arg_14_0.mainTF, false)
	arg_14_0:ClosePlayerCommentPanel()

	return
end

function var_0_0.MarkRead(arg_15_0, arg_15_1)
	if arg_15_1 and not arg_15_1:IsRead() then
		arg_15_0:emit(Dorm3dInstagramMediator.ON_READ, arg_15_1.id)
	end

	return
end

function var_0_0.InitDetailPage(arg_16_0)
	arg_16_0:MarkRead(arg_16_0.contextData.instagram)

	arg_16_0.pushTimeTxt.text = arg_16_0.contextData.instagram:GetPushTime()

	LoadSpriteAsync("Dorm3dIns/" .. arg_16_0.contextData.instagram:GetPicture(), function(arg_17_0)
		setImageSprite(arg_16_0.imageTF, arg_17_0, false)

		return
	end)

	local var_16_0 = arg_16_0.contextData.instagram:GetBackground()

	if var_16_0 and var_16_0 ~= "" then
		LoadSpriteAsync("Dorm3dIns/" .. var_16_0, function(arg_18_0)
			setImageSprite(arg_16_0.mainBg, arg_18_0, false)

			return
		end)
	end

	setImageSprite(arg_16_0.iconTF, LoadSprite("qicon/" .. arg_16_0.contextData.instagram:GetIcon()), false)

	arg_16_0.nameTxt.text = arg_16_0.contextData.instagram:GetName()
	arg_16_0.contentTxt.text = arg_16_0.contextData.instagram:GetText()

	onToggle(arg_16_0, arg_16_0.commentPanel, function(arg_19_0)
		if arg_19_0 then
			arg_16_0:OpenPlayerCommentPanel()
		else
			arg_16_0:ClosePlayerCommentPanel()
		end

		return
	end, SFX_PANEL)
	arg_16_0:UpdateLikeBtn()
	arg_16_0:UpdateShareBtn()
	arg_16_0:UpdateCommentList()

	return
end

function var_0_0.UpdateShareBtn(arg_20_0)
	local var_20_0 = arg_20_0.contextData.instagram

	onButton(arg_20_0, arg_20_0.planeTF, function()
		arg_20_0:emit(Dorm3dInstagramMediator.ON_SHARE, var_20_0.id)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateLikeBtn(arg_22_0)
	local var_22_0 = arg_22_0.contextData.instagram

	if not arg_22_0.contextData.instagram then
		return
	end

	local var_22_1 = arg_22_0.contextData.instagram:IsGood()

	if not var_22_1 then
		onButton(arg_22_0, arg_22_0.likeBtn, function()
			arg_22_0:emit(Dorm3dInstagramMediator.ON_LIKE, var_22_0.id)

			return
		end, SFX_PANEL)
	else
		removeOnButton(arg_22_0.likeBtn)
	end

	setActive(arg_22_0.likeBtn:Find("heart"), var_22_1)

	arg_22_0.likeBtn:GetComponent(typeof(Image)).enabled = not var_22_1

	return
end

function var_0_0.OnLikeInstagram(arg_24_0)
	if not arg_24_0.contextData.instagram then
		return
	end

	arg_24_0:UpdateLikeBtn()

	for iter_24_0, iter_24_1 in pairs(arg_24_0.cards) do
		if iter_24_1.instagram.id == arg_24_0.contextData.instagram.id then
			iter_24_1:Update(arg_24_0.contextData.instagram)

			break
		end
	end

	return
end

local function var_0_1(arg_25_0, arg_25_1, arg_25_2)
	setText(arg_25_1:Find("main/reply"), "reply")
	setText(arg_25_1:Find("main/content"), HXSet.hxLan((SwitchSpecialChar(arg_25_2:GetText()))))
	setText(arg_25_1:Find("main/time"), arg_25_2:GetPushTime())

	if isa(arg_25_2, InstagramPlayerComment3Dorm) then
		setImageSprite(arg_25_1:Find("main/head/icon"), GetSpriteFromAtlas("ui/InstagramUI_atlas", "txdi_3"))
	else
		setImageSprite(arg_25_1:Find("main/head/icon"), LoadSprite("qicon/" .. arg_25_2:GetIcon()), false)
	end

	return
end

local function var_0_2(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = _.select(arg_26_2:GetReplyedList(), function(arg_27_0)
		return arg_27_0:CanShow()
	end)
	local var_26_1 = UIItemList.New(arg_26_1:Find("replys"), arg_26_1:Find("replys/sub"))

	table.sort(var_26_0, function(arg_28_0, arg_28_1)
		if arg_28_0.time == arg_28_1.time then
			return arg_28_0.id < arg_28_1.id
		else
			return arg_28_0.time < arg_28_1.time
		end

		return
	end)
	var_26_1:make(function(arg_29_0, arg_29_1, arg_29_2)
		if arg_29_0 == UIItemList.EventUpdate then
			setImageSprite(arg_29_2:Find("head/icon"), LoadSprite("qicon/" .. var_26_0[arg_29_1 + 1]:GetIcon()), false)
			setText(arg_29_2:Find("content"), HXSet.hxLan((SwitchSpecialChar(var_26_0[arg_29_1 + 1]:GetText()))))
		end

		return
	end)
	var_26_1:align(#var_26_0)

	return
end

local function var_0_3(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_2:ExistAnyReplay()

	if var_30_0 then
		onToggle(arg_30_0, arg_30_1:Find("main/bubble"), function(arg_31_0)
			setActive(arg_30_1:Find("replys"), arg_31_0)

			return
		end, SFX_PANEL)
		var_0_2(arg_30_0, arg_30_1, arg_30_2)
	else
		setActive(arg_30_1:Find("replys"), false)
	end

	triggerToggle(arg_30_1:Find("main/bubble"), var_30_0)

	arg_30_1:Find("main/bubble"):GetComponent(typeof(Toggle)).enabled = var_30_0

	return
end

function var_0_0.UpdateCommentList(arg_32_0)
	if not arg_32_0.contextData.instagram then
		return
	end

	local var_32_0 = _.select(arg_32_0.contextData.instagram:GetReplyedList(), function(arg_33_0)
		return arg_33_0:CanShow()
	end)

	table.sort(var_32_0, function(arg_34_0, arg_34_1)
		return arg_34_0.time < arg_34_1.time
	end)
	arg_32_0.commentList:make(function(arg_35_0, arg_35_1, arg_35_2)
		if arg_35_0 == UIItemList.EventUpdate then
			var_0_1(arg_32_0, arg_35_2, var_32_0[arg_35_1 + 1])
			var_0_3(arg_32_0, arg_35_2, var_32_0[arg_35_1 + 1])
		end

		return
	end)
	setActive(arg_32_0.centerTF, false)
	setActive(arg_32_0.centerTF, true)
	Canvas.ForceUpdateCanvases()
	arg_32_0.commentList:align(#var_32_0)

	return
end

function var_0_0.OpenPlayerCommentPanel(arg_36_0)
	local var_36_0 = arg_36_0.contextData.instagram

	if not arg_36_0.contextData.instagram:ExistAnyReplyable() then
		return
	end

	setActive(arg_36_0.optionalPanel, true)

	local var_36_1 = arg_36_0.contextData.instagram:GetReplyableList()

	arg_36_0.commentPanel:GetComponent(typeof(Image)).enabled = true
	arg_36_0.commentPanel.sizeDelta = Vector2(0, #var_36_1 * 14 + 60)

	local var_36_2 = UIItemList.New(arg_36_0.optionalPanel, arg_36_0.optionalPanel:Find("option1"))

	var_36_2:make(function(arg_37_0, arg_37_1, arg_37_2)
		if arg_37_0 == UIItemList.EventUpdate then
			local var_37_0 = var_36_1[arg_37_1 + 1].id
			local var_37_1 = var_36_1[arg_37_1 + 1].index

			setText(arg_37_2:Find("Text"), HXSet.hxLan((var_36_1[arg_37_1 + 1]:GetText())))
			onButton(arg_36_0, arg_37_2, function()
				arg_36_0:emit(Dorm3dInstagramMediator.ON_DISCUSS, var_36_0.id, var_37_0, var_37_1)
				arg_36_0:ClosePlayerCommentPanel()

				return
			end, SFX_PANEL)
		end

		return
	end)
	var_36_2:align(#var_36_1)

	return
end

function var_0_0.ClosePlayerCommentPanel(arg_39_0)
	arg_39_0.commentPanel:GetComponent(typeof(Image)).enabled = false
	arg_39_0.commentPanel.sizeDelta = Vector2(0, 0)

	setActive(arg_39_0.optionalPanel, false)

	return
end

function var_0_0.onBackPressed(arg_40_0)
	if arg_40_0.inDetail then
		arg_40_0:ExitDetail()

		return
	end

	var_0_0.super.onBackPressed(arg_40_0)

	return
end

function var_0_0.willExit(arg_41_0)
	if arg_41_0.inDetail then
		arg_41_0:ExitDetail()
	end

	for iter_41_0, iter_41_1 in pairs(arg_41_0.cards) do
		iter_41_1:Dispose()
	end

	arg_41_0.cards = {}

	return
end

return var_0_0
