local InstagramLayer = class("InstagramLayer", import("...base.BaseUI"))

function InstagramLayer:getUIName()
	return "InstagramUI"
end

function InstagramLayer:preload(arg_2_1)
	self:SetProxy(getProxy(InstagramProxy))
	arg_2_1()

	return
end

function InstagramLayer:SetProxy(arg_3_1)
	self.proxy = arg_3_1
	self.instagramVOById = arg_3_1:GetData()
	self.messages = arg_3_1:GetMessages()

	return
end

function InstagramLayer:UpdateSelectedInstagram(arg_4_1)
	if self.contextData.instagram and self.contextData.instagram.id == arg_4_1 then
		self.contextData.instagram = self.instagramVOById[arg_4_1]

		self:UpdateCommentList()
	end

	return
end

function InstagramLayer:init()
	local var_5_0 = GameObject.Find("MainObject")

	self.downloadmgr = BulletinBoardMgr.Inst
	self.listTF = self._tf:Find("list")
	self.mainTF = self._tf:Find("main")
	self.closeBtn = self._tf:Find("closeBtn")
	self.noMsgTF = self._tf:Find("list/bg/no_msg")
	self.scrollBarTF = self._tf:Find("list/bg/scroll_bar")
	self.list = self._tf:Find("list/bg/scrollrect"):GetComponent("LScrollRect")
	self.imageTF = self._tf:Find("main/left_panel/mask/Image"):GetComponent(typeof(RawImage))
	self.likeBtn = self._tf:Find("main/left_panel/heart")
	self.bubbleTF = self._tf:Find("main/left_panel/bubble")
	self.planeTF = self._tf:Find("main/left_panel/plane")
	self.likeCntTxt = self._tf:Find("main/left_panel/zan"):GetComponent(typeof(Text))
	self.pushTimeTxt = self._tf:Find("main/left_panel/time"):GetComponent(typeof(Text))
	self.iconTF = self._tf:Find("main/right_panel/top/head/icon")
	self.nameTxt = self._tf:Find("main/right_panel/top/name"):GetComponent(typeof(Text))
	self.centerTF = self._tf:Find("main/right_panel/center")
	self.contentTxt = self._tf:Find("main/right_panel/center/Text/Text"):GetComponent(typeof(Text))
	self.commentList = UIItemList.New(self._tf:Find("main/right_panel/center/bottom/scroll/content"), self._tf:Find("main/right_panel/center/bottom/scroll/content/tpl"))
	self.commentPanel = self._tf:Find("main/right_panel/last/bg2")
	self.optionalPanel = self._tf:Find("main/right_panel/last/bg2/option")
	self.scroll = self._tf:Find("main/right_panel/center/bottom/scroll")

	setText(self._tf:Find("closeBtn/Text"), i18n("word_back"))

	self.sprites = {}
	self.timers = {}
	self.toDownloadList = {}

	self:OverlayPanel(self._tf)

	return
end

function InstagramLayer:SetImageByUrl(arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_1 or arg_6_1 == "" then
		setActive(arg_6_2.gameObject, false)

		if arg_6_3 then
			arg_6_3()
		end
	else
		setActive(arg_6_2.gameObject, true)

		if self.sprites[arg_6_1] then
			arg_6_2.texture = self.sprites[arg_6_1]

			if arg_6_3 then
				arg_6_3()
			end
		else
			arg_6_2.enabled = false

			self.downloadmgr:GetTexture("ins", "1", arg_6_1, UnityEngine.Events.UnityAction_UnityEngine_Texture(function(arg_7_0)
				if self.exited then
					return
				end

				if not self.sprites then
					return
				end

				self.sprites[arg_6_1] = arg_7_0
				arg_6_2.texture = arg_7_0
				arg_6_2.enabled = true

				if arg_6_3 then
					arg_6_3()
				end

				return
			end))
			table.insert(self.toDownloadList, arg_6_1)
		end
	end

	return
end

function InstagramLayer:didEnter()
	self:SetUp()

	self.cards = {}

	function self.list.onInitItem(arg_9_0)
		local var_9_0 = InstagramCard.New(arg_9_0, self)

		onButton(self, var_9_0._go, function()
			self:EnterDetail(var_9_0.instagram)

			return
		end, SFX_PANEL)

		self.cards[arg_9_0] = var_9_0

		return
	end

	function self.list.onUpdateItem(arg_11_0, arg_11_1)
		local var_11_0 = self.cards[arg_11_1]

		if not self.cards[arg_11_1] then
			var_11_0 = InstagramCard.New(arg_11_1)
			self.cards[arg_11_1] = var_11_0
		end

		var_11_0:Update(self.instagramVOById[self.display[arg_11_0 + 1].id])

		return
	end

	self:InitList()

	return
end

function InstagramLayer:SetUp()
	setActive(self.listTF, true)
	setActive(self.mainTF, false)
	setActive(self.closeBtn, false)
	onButton(self, self.closeBtn, function()
		if self.inDetail then
			self:ExitDetail()
		end

		return
	end, SFX_PANEL)

	return
end

function InstagramLayer:InitList()
	self.display = _.map(self.messages, function(arg_15_0)
		return {
			time = arg_15_0:GetLasterUpdateTime(),
			id = arg_15_0.id,
			order = arg_15_0:GetSortIndex()
		}
	end)

	table.sort(self.display, function(arg_16_0, arg_16_1)
		if arg_16_0.order == arg_16_1.order then
			return arg_16_0.id > arg_16_1.id
		else
			return arg_16_0.order > arg_16_1.order
		end

		return
	end)

	if isActive(self.listTF) then
		self.list:SetTotalCount(#self.display)
	end

	setActive(self.noMsgTF, #self.display == 0)
	setActive(self.scrollBarTF, not #self.display == 0)

	return
end

function InstagramLayer:UpdateInstagram(arg_17_1, arg_17_2)
	for iter_17_0, iter_17_1 in pairs(self.cards) do
		if iter_17_1.instagram and iter_17_1.instagram.id == arg_17_1 then
			iter_17_1:Update(self.instagramVOById[arg_17_1], arg_17_2)
		end
	end

	return
end

function InstagramLayer:EnterDetail(arg_18_1)
	self.contextData.instagram = arg_18_1

	self:InitDetailPage()

	self.inDetail = true

	setActive(self.listTF, false)
	setActive(self.mainTF, true)
	setActive(self.closeBtn, true)
	pg.SystemGuideMgr.GetInstance():Play(self)
	self:RefreshInstagram()
	scrollTo(self.scroll, 0, 1)

	return
end

function InstagramLayer:ExitDetail()
	if self.contextData.instagram and not self.contextData.instagram:IsReaded() then
		self:emit(InstagramMediator.ON_READED, self.contextData.instagram.id)
	end

	self.contextData.instagram = nil
	self.inDetail = false

	setActive(self.listTF, true)
	setActive(self.mainTF, false)
	setActive(self.closeBtn, false)
	self:CloseCommentPanel()

	return
end

function InstagramLayer:RefreshInstagram()
	local var_20_0 = self.contextData.instagram:GetFastestRefreshTime()

	if var_20_0 then
		if var_20_0 - pg.TimeMgr.GetInstance():GetServerTime() <= 0 then
			self:emit(InstagramMediator.ON_REPLY_UPDATE, self.contextData.instagram.id)
		end
	end

	return
end

function InstagramLayer:InitDetailPage()
	local var_21_0 = self.contextData.instagram

	self:SetImageByUrl(self.contextData.instagram:GetImage(), self.imageTF)
	onButton(self, self.planeTF, function()
		self:emit(InstagramMediator.ON_SHARE, var_21_0.id)

		return
	end, SFX_PANEL)

	self.pushTimeTxt.text = self.contextData.instagram:GetPushTime()

	setImageSprite(self.iconTF, LoadSprite("qicon/" .. self.contextData.instagram:GetIcon()), false)

	self.nameTxt.text = self.contextData.instagram:GetName()
	self.contentTxt.text = self.contextData.instagram:GetContent()

	onToggle(self, self.commentPanel, function(arg_23_0)
		if arg_23_0 then
			self:OpenCommentPanel()
		else
			self:CloseCommentPanel()
		end

		return
	end, SFX_PANEL)
	self:UpdateLikeBtn()
	self:UpdateCommentList()

	return
end

function InstagramLayer:UpdateLikeBtn()
	local var_24_0 = self.contextData.instagram
	local var_24_1 = self.contextData.instagram:IsLiking()

	if not var_24_1 then
		onButton(self, self.likeBtn, function()
			self:emit(InstagramMediator.ON_LIKE, var_24_0.id)

			return
		end, SFX_PANEL)
	else
		removeOnButton(self.likeBtn)
	end

	setActive(self.likeBtn:Find("heart"), var_24_1)

	self.likeBtn:GetComponent(typeof(Image)).enabled = not var_24_1
	self.likeCntTxt.text = i18n("ins_word_like", var_24_0:GetLikeCnt())

	return
end

function InstagramLayer:UpdateCommentList()
	if not self.contextData.instagram then
		return
	end

	local var_26_0, var_26_1 = self.contextData.instagram:GetCanDisplayComments()

	table.sort(var_26_0, function(arg_27_0, arg_27_1)
		return arg_27_0.time < arg_27_1.time
	end)
	self.commentList:make(function(arg_28_0, arg_28_1, arg_28_2)
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
				onToggle(self, arg_28_2:Find("main/bubble"), function(arg_29_0)
					setActive(arg_28_2:Find("replys"), arg_29_0)

					return
				end, SFX_PANEL)
				self:UpdateReplys(arg_28_2, var_28_0)
				triggerToggle(arg_28_2:Find("main/bubble"), true)
			else
				setActive(arg_28_2:Find("replys"), false)
				triggerToggle(arg_28_2:Find("main/bubble"), false)
			end

			arg_28_2:Find("main/bubble"):GetComponent(typeof(Toggle)).enabled = var_28_1
		end

		return
	end)
	setActive(self.centerTF, false)
	setActive(self.centerTF, true)
	Canvas.ForceUpdateCanvases()
	self.commentList:align(#var_26_0)

	return
end

function InstagramLayer:UpdateReplys(arg_30_1, arg_30_2)
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

function InstagramLayer:OpenCommentPanel()
	local var_33_0 = self.contextData.instagram

	if not self.contextData.instagram:CanOpenComment() then
		return
	end

	setActive(self.optionalPanel, true)

	local var_33_1 = self.contextData.instagram:GetOptionComment()

	self.commentPanel:GetComponent(typeof(Image)).enabled = true
	self.commentPanel.sizeDelta = Vector2(0, #var_33_1 * 14 + 60)

	local var_33_2 = UIItemList.New(self.optionalPanel, self.optionalPanel:Find("option1"))

	var_33_2:make(function(arg_34_0, arg_34_1, arg_34_2)
		if arg_34_0 == UIItemList.EventUpdate then
			local var_34_0 = var_33_1[arg_34_1 + 1].id
			local var_34_1 = var_33_1[arg_34_1 + 1].index

			setText(arg_34_2:Find("Text"), HXSet.hxLan(var_33_1[arg_34_1 + 1].text))
			onButton(self, arg_34_2, function()
				self:emit(InstagramMediator.ON_COMMENT, var_33_0.id, var_34_1, var_34_0)
				self:CloseCommentPanel()

				return
			end, SFX_PANEL)
		end

		return
	end)
	var_33_2:align(#var_33_1)

	return
end

function InstagramLayer:CloseCommentPanel()
	self.commentPanel:GetComponent(typeof(Image)).enabled = false
	self.commentPanel.sizeDelta = Vector2(0, 0)

	setActive(self.optionalPanel, false)

	return
end

function InstagramLayer:onBackPressed()
	if self.inDetail then
		self:ExitDetail()

		return
	end

	self:emit(InstagramMediator.CLOSE_ALL)

	return
end

function InstagramLayer:CloseDetail()
	if self.inDetail then
		self:ExitDetail()

		return
	end

	return
end

function InstagramLayer:willExit()
	for iter_39_0, iter_39_1 in ipairs(self.toDownloadList or {}) do
		self.downloadmgr:StopLoader(iter_39_1)
	end

	self.toDownloadList = {}

	self:UnOverlayPanel(self._tf)
	self:ExitDetail()

	for iter_39_2, iter_39_3 in pairs(self.sprites) do
		if not IsNil(iter_39_3) then
			Object.Destroy(iter_39_3)
		end
	end

	self.sprites = nil

	for iter_39_4, iter_39_5 in pairs(self.cards) do
		iter_39_5:Dispose()
	end

	self.cards = {}

	return
end

return InstagramLayer
