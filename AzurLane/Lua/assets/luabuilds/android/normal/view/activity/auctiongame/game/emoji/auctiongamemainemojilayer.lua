class = var_0_10000

local var_0_0 = "AuctionGameMainEmojiLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AuctionGameMainEmojiUI"
end

function var_0_1.init(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.uiCloseBtn

	local function var_2_2()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10005)

	onButton = var_1_10001

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.uiSwitchBtn

	local function var_2_5()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		AuctionGameMainEmojiMediator = var_2_10002

		var_4_1(var_4_0, var_2_10002.ON_CLICK_EMOJI_SWITCH, arg_2_0.switchOn)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_3, var_2_4, var_2_5, var_1_10005)

	LuaList = var_1_10001

	local var_2_6 = var_1_10001.New
	local var_2_7 = arg_2_0

	handler = var_2_4

	local var_2_8 = var_2_4(arg_2_0, arg_2_0.IndexItem)
	local var_2_9 = arg_2_0.uiList

	AuctionGameMainEmojiListItem = var_5
	arg_2_0.uiScrollView = var_2_6(var_2_7, var_2_8, var_2_9, var_5)

	local var_2_10 = arg_2_0.uiScrollView
	local var_2_11 = var_1.SetPageChangeHandler

	handler = var_2_8

	var_2_11(var_2_10, var_2_8(arg_2_0, arg_2_0.OnPageChange))

	arg_2_0.dotItemList = {}
	setText = var_1

	local var_2_12 = arg_2_0.uiSwitchText

	i18n = var_3

	var_1(var_2_12, var_3("auction_block_emoji"))

	return
end

function var_0_1.didEnter(arg_5_0)
	arg_5_0:GetEmojiList()

	arg_5_0.pageIndex = 1

	for iter_5_0 = 1, #arg_5_0.emojiList do
		local var_5_0 = arg_5_0.dotItemList

		AuctionGameMainEmojiDotItem = var_1_10006
		var_1_10006 = var_1_10006.New
		Instantiate = var_1_10007
		var_5_0[iter_5_0] = var_1_10006(var_1_10007(arg_5_0.uiDotItem, arg_5_0.uiDotParent), arg_5_0)
	end

	arg_5_0:OnPageChange(arg_5_0.pageIndex)

	local var_5_1 = arg_5_0.uiScrollView

	var_1.StartScroll(var_5_1, #arg_5_0.emojiList)
	arg_5_0:OnRefreshSwitchEmojiBtn()

	return
end

function var_0_1.OnPageChange(arg_6_0, arg_6_1)
	arg_6_0.pageIndex = arg_6_1

	for iter_6_0 = 1, #arg_6_0.emojiList do
		local var_6_0 = arg_6_0.dotItemList[iter_6_0]

		var_6.didEnter(var_6_0, iter_6_0 == arg_6_1)
	end

	return
end

function var_0_1.IndexItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:didEnter(arg_7_0.emojiList[arg_7_1])

	return
end

function var_0_1.GetEmojiList(arg_8_0)
	arg_8_0.emojiList = {}

	local var_8_0 = {}

	getProxy = var_1_10002
	EmojiProxy = var_1_10003

	local var_8_1 = var_1_10002(var_1_10003)

	ipairs = var_1_10003
	pg = var_1_10004

	for iter_8_0, iter_8_1 in var_1_10003(var_1_10004.emoji_template.get_id_list_by_auction[1]) do
		table = var_1_10008

		var_1_10008.insert(var_8_0, iter_8_1)
	end

	ipairs = var_3

	for iter_8_2, iter_8_3 in var_3(var_8_0) do
		math = var_1_10008
		var_1_10008 = var_1_10008.ceil(iter_8_2 / 8)

		local var_8_2 = arg_8_0.emojiList
		local var_8_3

		if not arg_8_0.emojiList[var_1_10008] then
			var_8_3 = {}
		end

		var_8_2[var_1_10008] = var_8_3
		table = var_8_2

		var_8_2.insert(arg_8_0.emojiList[var_1_10008], iter_8_3)
	end

	return
end

function var_0_1.OnRefreshSwitchEmojiBtn(arg_9_0)
	getProxy = var_1_10001
	AuctionGameProxy = var_1_10002

	local var_9_0 = var_1_10001(var_1_10002)
	local var_9_1 = var_1.GetSwitchEmojiFlag(var_9_0)

	setActive = var_9_0

	var_9_0(arg_9_0.uiSelectedGo, var_9_1 == 1)

	return
end

function var_0_1.willExit(arg_10_0)
	local var_10_0 = arg_10_0.uiScrollView

	var_1.Dispose(var_10_0)

	arg_10_0.uiScrollView = nil
	ipairs = var_1

	for iter_10_0, iter_10_1 in var_1(arg_10_0.dotItemList) do
		iter_10_1:willExit()
	end

	arg_10_0.dotItemList = nil

	return
end

return var_0_1
