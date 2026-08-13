class = var_0_10000

local var_0_0 = "FriendSearchPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))
local var_0_2 = 10

function var_0_1.getUIName(arg_1_0)
	return "FriendSearchUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.addPanel = var_1.Find(var_2_0, "add_panel")

	local var_2_1 = arg_2_0.addPanel

	arg_2_0.searchPanel = var_1.Find(var_2_1, "search_panel")

	local var_2_2 = arg_2_0.searchPanel

	arg_2_0.searchBar = var_1.Find(var_2_2, "InputField")

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0

	findTF = var_1_10003

	var_1_10001(var_3_0, var_1_10003(arg_3_0.searchPanel, "copy_btn"), function()
		UniPasteBoard = var_2_10000

		var_2_10000.SetClipBoardString(arg_3_0.playerVO.id)

		pg = var_0

		local var_4_0 = var_0.TipsMgr.GetInstance()
		local var_4_1 = var_0.ShowTips

		i18n = var_2_10002

		var_4_1(var_4_0, var_2_10002("friend_id_copy_ok"))

		return
	end)

	onButton = var_1_10001

	local var_3_1 = arg_3_0

	findTF = var_3

	var_1_10001(var_3_1, var_3(arg_3_0.searchPanel, "search_btn"), function()
		pg = var_2_10000

		local var_5_0 = var_2_10000.TimeMgr.GetInstance()
		local var_5_1 = var_0.GetServerTime(var_5_0)

		if arg_3_0.waitTimer and arg_3_0.waitTimer - var_5_1 > 0 then
			pg = var_1

			local var_5_2 = var_1.TipsMgr.GetInstance()
			local var_5_3 = var_1.ShowTips

			i18n = var_2_10003

			var_5_3(var_5_2, var_2_10003("friend_searchFriend_wait_time", arg_3_0.waitTimer - var_5_1))

			return
		end

		local var_5_4 = arg_3_0

		var_5_4.waitTimer = var_5_1 + var_0_2
		getInputText = var_5_4

		if not var_5_4(arg_3_0.searchBar) or var_1 == "" then
			pg = var_2

			local var_5_5 = var_2.TipsMgr.GetInstance()
			local var_5_6 = var_2.ShowTips

			i18n = var_2_10004

			var_5_6(var_5_5, var_2_10004("friend_inpout_key_tip"))

			return
		end

		arg_3_0.keyWord = var_1

		local var_5_7 = arg_3_0
		local var_5_8 = var_2.emit

		FriendMediator = var_2_10004

		var_5_8(var_5_7, var_2_10004.SEARCH_FRIEND, 3, var_1)

		return
	end)

	onButton = var_1_10001

	local var_3_2 = arg_3_0

	findTF = var_3

	var_1_10001(var_3_2, var_3(arg_3_0.searchPanel, "refresh_btn"), function()
		pg = var_2_10000

		local var_6_0 = var_2_10000.TimeMgr.GetInstance()
		local var_6_1 = var_0.GetServerTime(var_6_0)

		if arg_3_0.waitTimer1 and arg_3_0.waitTimer1 - var_6_1 > 0 then
			pg = var_1

			local var_6_2 = var_1.TipsMgr.GetInstance()
			local var_6_3 = var_1.ShowTips

			i18n = var_2_10003

			var_6_3(var_6_2, var_2_10003("friend_searchFriend_wait_time", arg_3_0.waitTimer1 - var_6_1))

			return
		end

		arg_3_0.waitTimer1 = var_6_1 + var_0_2

		local var_6_4 = arg_3_0.keyWord
		local var_6_5 = arg_3_0
		local var_6_6 = var_2.emit

		FriendMediator = var_2_10004

		var_6_6(var_6_5, var_2_10004.SEARCH_FRIEND, 1, var_6_4)

		return
	end)

	return
end

function var_0_1.UpdateData(arg_7_0, arg_7_1)
	local var_7_0

	if not arg_7_1.searchResults then
		var_7_0 = {}
	end

	arg_7_0.searchFriendVOs = var_7_0
	arg_7_0.playerVO = arg_7_1.playerVO

	if not arg_7_0.isInit then
		arg_7_0.isInit = true

		arg_7_0:initAddPage()

		local var_7_1 = arg_7_0
		local var_7_2 = arg_7_0.emit

		FriendMediator = var_1_10004

		var_7_2(var_7_1, var_1_10004.SEARCH_FRIEND, 1)
	else
		arg_7_0:sortSearchResult()
	end

	return
end

function var_0_1.sortSearchResult(arg_8_0)
	local var_8_0 = arg_8_0.addRect

	var_1.SetTotalCount(var_8_0, #arg_8_0.searchFriendVOs, -1)

	return
end

function var_0_1.initAddPage(arg_9_0)
	arg_9_0.searchItems = {}
	setText = var_1

	local var_9_0 = arg_9_0.searchPanel

	var_1(var_2.Find(var_9_0, "self_id_bg/Text"), arg_9_0.playerVO.id)

	local var_9_1 = arg_9_0.addPanel
	local var_9_2 = var_1.Find(var_9_1, "mask/view")

	arg_9_0.addRect = var_1.GetComponent(var_9_2, "LScrollRect")

	function arg_9_0.addRect.onInitItem(arg_10_0)
		local var_10_0 = arg_9_0

		var_1.onInitItem(var_10_0, arg_10_0)

		return
	end

	function arg_9_0.addRect.onUpdateItem(arg_11_0, arg_11_1)
		local var_11_0 = arg_9_0

		var_2.onUpdateItem(var_11_0, arg_11_0, arg_11_1)

		return
	end

	return
end

function var_0_1.onInitItem(arg_12_0, arg_12_1)
	FriendSearchCard = var_1_10002

	local var_12_0 = var_1_10002.New(arg_12_1)

	onButton = var_3

	local var_12_1 = arg_12_0
	local var_12_2 = var_12_0.addBtn

	local function var_12_3()
		pg = var_2_10000

		local var_13_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_13_1 = var_0.ShowMsgBox
		local var_13_2 = {
			yesText = "text_apply",
			hideNo = true
		}

		MSGBOX_TYPE_INPUT = var_2_10003
		var_13_2.type = var_2_10003
		i18n = var_2_10003
		var_13_2.placeholder = var_2_10003("friend_request_msg_placeholder")
		i18n = var_3
		var_13_2.title = var_3("friend_request_msg_title")

		function var_13_2.onYes(arg_14_0)
			local var_14_0 = arg_12_0
			local var_14_1 = var_1.emit

			FriendMediator = var_3_10003

			var_14_1(var_14_0, var_3_10003.ADD_FRIEND, var_12_0.friendVO.id, arg_14_0)

			return
		end

		var_13_1(var_13_0, var_13_2)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_12_1, var_12_2, var_12_3, var_1_10007)

	onButton = var_3

	local var_12_4 = arg_12_0
	local var_12_5 = var_12_0.resumeBtn

	local function var_12_6()
		local var_15_0 = arg_12_0
		local var_15_1 = var_0.emit

		FriendMediator = var_2_10002

		var_15_1(var_15_0, var_2_10002.OPEN_RESUME, var_12_0.friendVO.id)

		return
	end

	SFX_PANEL = var_1_10007

	var_3(var_12_4, var_12_5, var_12_6, var_1_10007)

	arg_12_0.searchItems[arg_12_1] = var_12_0

	return
end

function var_0_1.onUpdateItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0

	if not arg_16_0.searchItems[arg_16_2] then
		arg_16_0:onInitItem(arg_16_2)

		var_16_0 = arg_16_0.searchItems[arg_16_2]
	end

	local var_16_1 = arg_16_0.searchFriendVOs[arg_16_1 + 1]

	var_16_0:update(var_16_1)

	return
end

function var_0_1.OnDestroy(arg_17_0)
	pairs = var_1_10001

	local var_17_0

	if not arg_17_0.searchItems then
		var_17_0 = {}
	end

	for iter_17_0, iter_17_1 in var_1_10001(var_17_0) do
		iter_17_1:dispose()
	end

	return
end

return var_0_1
