local var_0_0 = class("AuctionGameMainEmojiLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "AuctionGameMainEmojiUI"
end

function var_0_0.init(arg_2_0)
	onButton(arg_2_0, arg_2_0.uiCloseBtn, function()
		arg_2_0:closeView()

		return
	end, SOUND_BACK)
	onButton(arg_2_0, arg_2_0.uiSwitchBtn, function()
		arg_2_0:emit(AuctionGameMainEmojiMediator.ON_CLICK_EMOJI_SWITCH, arg_2_0.switchOn)

		return
	end, SFX_PANEL)

	arg_2_0.uiScrollView = LuaList.New(arg_2_0, handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.uiList, AuctionGameMainEmojiListItem)

	arg_2_0.uiScrollView:SetPageChangeHandler(handler(arg_2_0, arg_2_0.OnPageChange))

	arg_2_0.dotItemList = {}

	setText(arg_2_0.uiSwitchText, i18n("auction_block_emoji"))

	return
end

function var_0_0.didEnter(arg_5_0)
	arg_5_0:GetEmojiList()

	arg_5_0.pageIndex = 1

	for iter_5_0 = 1, #arg_5_0.emojiList do
		arg_5_0.dotItemList[iter_5_0] = AuctionGameMainEmojiDotItem.New(Instantiate(arg_5_0.uiDotItem, arg_5_0.uiDotParent), arg_5_0)
	end

	arg_5_0:OnPageChange(arg_5_0.pageIndex)
	arg_5_0.uiScrollView:StartScroll(#arg_5_0.emojiList)
	arg_5_0:OnRefreshSwitchEmojiBtn()

	return
end

function var_0_0.OnPageChange(arg_6_0, arg_6_1)
	arg_6_0.pageIndex = arg_6_1

	for iter_6_0 = 1, #arg_6_0.emojiList do
		arg_6_0.dotItemList[iter_6_0]:didEnter(iter_6_0 == arg_6_1)
	end

	return
end

function var_0_0.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:didEnter(arg_7_0.emojiList[arg_7_1])

	return
end

function var_0_0.GetEmojiList(arg_8_0)
	arg_8_0.emojiList = {}

	local var_8_0 = getProxy(EmojiProxy)

	for iter_8_0, iter_8_1 in ipairs(pg.emoji_template.get_id_list_by_auction[1]) do
		table.insert({}, iter_8_1)
	end

	for iter_8_2, iter_8_3 in ipairs({}) do
		local var_8_1 = math.ceil(iter_8_2 / 8)

		arg_8_0.emojiList[var_8_1] = arg_8_0.emojiList[var_8_1] or {}

		table.insert(arg_8_0.emojiList[var_8_1], iter_8_3)
	end

	return
end

function var_0_0.OnRefreshSwitchEmojiBtn(arg_9_0)
	local var_9_0 = getProxy(AuctionGameProxy)

	setActive(arg_9_0.uiSelectedGo, var_9_0:GetSwitchEmojiFlag() == 1)

	return
end

function var_0_0.willExit(arg_10_0)
	arg_10_0.uiScrollView:Dispose()

	arg_10_0.uiScrollView = nil

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.dotItemList) do
		iter_10_1:willExit()
	end

	arg_10_0.dotItemList = nil

	return
end

return var_0_0
