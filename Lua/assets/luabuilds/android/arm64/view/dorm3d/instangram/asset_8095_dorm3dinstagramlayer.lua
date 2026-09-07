local Dorm3dInstagramLayer = class("Dorm3dInstagramLayer", import("view.base.BaseUI"))

function Dorm3dInstagramLayer:getUIName()
	return "Dorm3dInstagramUI"
end

function Dorm3dInstagramLayer:GetInstagramList()
	assert(self.contextData.apartmentGroupId, "groupId can not be nil")

	return getProxy(Dorm3dInsProxy):GetInstagramList(self.contextData.apartmentGroupId)
end

function Dorm3dInstagramLayer:init()
	self.listTF = self._tf:Find("list")
	self.mainTF = self._tf:Find("main")
	self.closeBtn = self._tf:Find("closeBtn")
	self.noMsgTF = self._tf:Find("list/bg/no_msg")
	self.scrollBarTF = self._tf:Find("list/bg/scroll_bar")
	self.list = self._tf:Find("list/bg/scrollrect"):GetComponent("LScrollRect")
	self.mainBg = self._tf:Find("main/left_panel/bg")
	self.imageTF = self._tf:Find("main/left_panel/mask/Image"):GetComponent(typeof(Image))
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

	setText(self._tf:Find("main_bg/Text"), i18n("dorm3d_privatechat_topics"))
	setText(self.noMsgTF:Find("Text"), i18n("dorm3d_ins_no_msg"))
	self:OverlayPanel(self._tf)

	return
end

function Dorm3dInstagramLayer:didEnter()
	setActive(self.listTF, true)
	setActive(self.mainTF, false)
	onButton(self, self.closeBtn, function()
		if self.inDetail then
			self:ExitDetail()

			return
		end

		self:emit(Dorm3dInstagramLayer.ON_CLOSE)

		return
	end, SFX_PANEL)

	self.cards = {}

	function self.list.onInitItem(arg_6_0)
		self:OnInitItem(arg_6_0)

		return
	end

	function self.list.onUpdateItem(arg_7_0, arg_7_1)
		self:OnUpdateItem(arg_7_0, arg_7_1)

		return
	end

	self:InitCards()

	return
end

function Dorm3dInstagramLayer:OnInitItem(arg_8_1)
	local var_8_0 = Dorm3dInstagramCard.New(arg_8_1)

	onButton(self, var_8_0._go, function()
		if var_8_0.instagram:IsLock() then
			return
		end

		self:EnterDetail(var_8_0.instagram)

		return
	end, SFX_PANEL)

	self.cards[arg_8_1] = var_8_0

	return
end

function Dorm3dInstagramLayer:OnUpdateItem(arg_10_1, arg_10_2)
	local var_10_0 = self.cards[arg_10_2]

	if not self.cards[arg_10_2] then
		var_10_0 = Dorm3dInstagramCard.New(arg_10_2)
		self.cards[arg_10_2] = var_10_0
	end

	var_10_0:Update(self.display[arg_10_1 + 1])

	return
end

function Dorm3dInstagramLayer:InitCards()
	self.display = {}

	for iter_11_0, iter_11_1 in ipairs((self:GetInstagramList())) do
		if not iter_11_1:IsLock() and iter_11_1:CanShow() then
			table.insert(self.display, iter_11_1)
		end
	end

	table.sort(self.display, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_12_0:LockState()
		local var_12_1 = arg_12_1:LockState()

		if var_12_0 == var_12_1 then
			return var_12_1 < var_12_0
		else
			return arg_12_0.id > arg_12_1.id
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

function Dorm3dInstagramLayer:EnterDetail(arg_13_1)
	self.contextData.instagram = arg_13_1

	self:InitDetailPage()

	self.inDetail = true

	setActive(self.listTF, false)
	setActive(self.mainTF, true)
	scrollTo(self.scroll, 0, 1)

	return
end

function Dorm3dInstagramLayer:ExitDetail()
	self:emit(Dorm3dInstagramMediator.ON_EXIT, self.contextData.instagram.id)

	self.contextData.instagram = nil
	self.inDetail = false

	setActive(self.listTF, true)
	setActive(self.mainTF, false)
	self:ClosePlayerCommentPanel()

	return
end

function Dorm3dInstagramLayer:MarkRead(arg_15_1)
	if arg_15_1 and not arg_15_1:IsRead() then
		self:emit(Dorm3dInstagramMediator.ON_READ, arg_15_1.id)
	end

	return
end

function Dorm3dInstagramLayer:InitDetailPage()
	self:MarkRead(self.contextData.instagram)

	self.pushTimeTxt.text = self.contextData.instagram:GetPushTime()

	LoadSpriteAsync("Dorm3dIns/" .. self.contextData.instagram:GetPicture(), function(arg_17_0)
		setImageSprite(self.imageTF, arg_17_0, false)

		return
	end)

	local var_16_0 = self.contextData.instagram:GetBackground()

	if var_16_0 and var_16_0 ~= "" then
		LoadSpriteAsync("Dorm3dIns/" .. var_16_0, function(arg_18_0)
			setImageSprite(self.mainBg, arg_18_0, false)

			return
		end)
	end

	setImageSprite(self.iconTF, LoadSprite("qicon/" .. self.contextData.instagram:GetIcon()), false)

	self.nameTxt.text = self.contextData.instagram:GetName()
	self.contentTxt.text = self.contextData.instagram:GetText()

	onToggle(self, self.commentPanel, function(arg_19_0)
		if arg_19_0 then
			self:OpenPlayerCommentPanel()
		else
			self:ClosePlayerCommentPanel()
		end

		return
	end, SFX_PANEL)
	self:UpdateLikeBtn()
	self:UpdateShareBtn()
	self:UpdateCommentList()

	return
end

function Dorm3dInstagramLayer:UpdateShareBtn()
	local var_20_0 = self.contextData.instagram

	onButton(self, self.planeTF, function()
		self:emit(Dorm3dInstagramMediator.ON_SHARE, var_20_0.id)

		return
	end, SFX_PANEL)

	return
end

function Dorm3dInstagramLayer:UpdateLikeBtn()
	local var_22_0 = self.contextData.instagram

	if not self.contextData.instagram then
		return
	end

	local var_22_1 = self.contextData.instagram:IsGood()

	if not var_22_1 then
		onButton(self, self.likeBtn, function()
			self:emit(Dorm3dInstagramMediator.ON_LIKE, var_22_0.id)

			return
		end, SFX_PANEL)
	else
		removeOnButton(self.likeBtn)
	end

	setActive(self.likeBtn:Find("heart"), var_22_1)

	self.likeBtn:GetComponent(typeof(Image)).enabled = not var_22_1

	return
end

function Dorm3dInstagramLayer:OnLikeInstagram()
	if not self.contextData.instagram then
		return
	end

	self:UpdateLikeBtn()

	for iter_24_0, iter_24_1 in pairs(self.cards) do
		if iter_24_1.instagram.id == self.contextData.instagram.id then
			iter_24_1:Update(self.contextData.instagram)

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

function Dorm3dInstagramLayer:UpdateCommentList()
	if not self.contextData.instagram then
		return
	end

	local var_32_0 = _.select(self.contextData.instagram:GetReplyedList(), function(arg_33_0)
		return arg_33_0:CanShow()
	end)

	table.sort(var_32_0, function(arg_34_0, arg_34_1)
		return arg_34_0.time < arg_34_1.time
	end)
	self.commentList:make(function(arg_35_0, arg_35_1, arg_35_2)
		if arg_35_0 == UIItemList.EventUpdate then
			var_0_1(self, arg_35_2, var_32_0[arg_35_1 + 1])
			var_0_3(self, arg_35_2, var_32_0[arg_35_1 + 1])
		end

		return
	end)
	setActive(self.centerTF, false)
	setActive(self.centerTF, true)
	Canvas.ForceUpdateCanvases()
	self.commentList:align(#var_32_0)

	return
end

function Dorm3dInstagramLayer:OpenPlayerCommentPanel()
	local var_36_0 = self.contextData.instagram

	if not self.contextData.instagram:ExistAnyReplyable() then
		return
	end

	setActive(self.optionalPanel, true)

	local var_36_1 = self.contextData.instagram:GetReplyableList()

	self.commentPanel:GetComponent(typeof(Image)).enabled = true
	self.commentPanel.sizeDelta = Vector2(0, #var_36_1 * 14 + 60)

	local var_36_2 = UIItemList.New(self.optionalPanel, self.optionalPanel:Find("option1"))

	var_36_2:make(function(arg_37_0, arg_37_1, arg_37_2)
		if arg_37_0 == UIItemList.EventUpdate then
			local var_37_0 = var_36_1[arg_37_1 + 1].id
			local var_37_1 = var_36_1[arg_37_1 + 1].index

			setText(arg_37_2:Find("Text"), HXSet.hxLan((var_36_1[arg_37_1 + 1]:GetText())))
			onButton(self, arg_37_2, function()
				self:emit(Dorm3dInstagramMediator.ON_DISCUSS, var_36_0.id, var_37_0, var_37_1)
				self:ClosePlayerCommentPanel()

				return
			end, SFX_PANEL)
		end

		return
	end)
	var_36_2:align(#var_36_1)

	return
end

function Dorm3dInstagramLayer:ClosePlayerCommentPanel()
	self.commentPanel:GetComponent(typeof(Image)).enabled = false
	self.commentPanel.sizeDelta = Vector2(0, 0)

	setActive(self.optionalPanel, false)

	return
end

function Dorm3dInstagramLayer:onBackPressed()
	if self.inDetail then
		self:ExitDetail()

		return
	end

	Dorm3dInstagramLayer.super.onBackPressed(self)

	return
end

function Dorm3dInstagramLayer:willExit()
	if self.inDetail then
		self:ExitDetail()
	end

	for iter_41_0, iter_41_1 in pairs(self.cards) do
		iter_41_1:Dispose()
	end

	self.cards = {}

	return
end

return Dorm3dInstagramLayer
