local AuctionGameMainEmojiLayer = class("AuctionGameMainEmojiLayer", import("view.base.BaseUI"))

function AuctionGameMainEmojiLayer:getUIName()
	return "AuctionGameMainEmojiUI"
end

function AuctionGameMainEmojiLayer:init()
	onButton(self, self.uiCloseBtn, function()
		self:closeView()

		return
	end, SOUND_BACK)
	onButton(self, self.uiSwitchBtn, function()
		self:emit(AuctionGameMainEmojiMediator.ON_CLICK_EMOJI_SWITCH, self.switchOn)

		return
	end, SFX_PANEL)

	self.uiScrollView = LuaList.New(self, handler(self, self.IndexItem), self.uiList, AuctionGameMainEmojiListItem)

	self.uiScrollView:SetPageChangeHandler(handler(self, self.OnPageChange))

	self.dotItemList = {}

	setText(self.uiSwitchText, i18n("auction_block_emoji"))

	return
end

function AuctionGameMainEmojiLayer:didEnter()
	self:GetEmojiList()

	self.pageIndex = 1

	for iter_5_0 = 1, #self.emojiList do
		self.dotItemList[iter_5_0] = AuctionGameMainEmojiDotItem.New(Instantiate(self.uiDotItem, self.uiDotParent), self)
	end

	self:OnPageChange(self.pageIndex)
	self.uiScrollView:StartScroll(#self.emojiList)
	self:OnRefreshSwitchEmojiBtn()

	return
end

function AuctionGameMainEmojiLayer:OnPageChange(arg_6_1)
	self.pageIndex = arg_6_1

	for iter_6_0 = 1, #self.emojiList do
		self.dotItemList[iter_6_0]:didEnter(iter_6_0 == arg_6_1)
	end

	return
end

function AuctionGameMainEmojiLayer:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:didEnter(self.emojiList[arg_7_1])

	return
end

function AuctionGameMainEmojiLayer:GetEmojiList()
	self.emojiList = {}

	local var_8_0 = {}
	local var_8_1 = getProxy(EmojiProxy)

	for iter_8_0, iter_8_1 in ipairs(pg.emoji_template.get_id_list_by_auction[1]) do
		table.insert(var_8_0, iter_8_1)
	end

	for iter_8_2, iter_8_3 in ipairs(var_8_0) do
		local var_8_2 = math.ceil(iter_8_2 / 8)

		self.emojiList[var_8_2] = self.emojiList[var_8_2] or {}

		table.insert(self.emojiList[var_8_2], iter_8_3)
	end

	return
end

function AuctionGameMainEmojiLayer:OnRefreshSwitchEmojiBtn()
	setActive(self.uiSelectedGo, getProxy(AuctionGameProxy):GetSwitchEmojiFlag() == 1)

	return
end

function AuctionGameMainEmojiLayer:willExit()
	self.uiScrollView:Dispose()

	self.uiScrollView = nil

	for iter_10_0, iter_10_1 in ipairs(self.dotItemList) do
		iter_10_1:willExit()
	end

	self.dotItemList = nil

	return
end

return AuctionGameMainEmojiLayer
