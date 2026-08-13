class = var_0_10000

local var_0_0 = "IslandFriendSearchPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandFriendListPage"))
local var_0_2 = 10

function var_0_1.getUIName(arg_1_0)
	return "IslandFriendSearchUI"
end

function var_0_1.OnLoaded(arg_2_0)
	var_0_1.super.OnLoaded(arg_2_0)

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "top/id/Text")
	local var_2_2 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.idTxt = var_2_2(var_2_1, var_4(var_1_10006))

	local var_2_3 = arg_2_0._tf

	arg_2_0.copyBtn = var_1.Find(var_2_3, "top/id/copy")

	local var_2_4 = arg_2_0._tf

	arg_2_0.saerchBtn = var_1.Find(var_2_4, "top/search/copy")

	local var_2_5 = arg_2_0._tf

	arg_2_0.refreshBtn = var_1.Find(var_2_5, "top/refresh")

	local var_2_6 = arg_2_0._tf

	arg_2_0.searchBar = var_1.Find(var_2_6, "top/search/input")
	arg_2_0.displays = {}
	setText = var_1

	local var_2_7 = arg_2_0._tf
	local var_2_8 = var_3.Find(var_2_7, "top/id/copy/Text")

	i18n = var_4

	var_1(var_2_8, var_4("island_btn_label_copy"))

	setText = var_1

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_3.Find(var_2_9, "top/search/copy/Text")

	i18n = var_4

	var_1(var_2_10, var_4("island_search"))

	setText = var_1

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_3.Find(var_2_11, "top/search/input/Text")

	i18n = var_4

	var_1(var_2_12, var_4("island_input_my_id"))

	setText = var_1

	local var_2_13 = arg_2_0._tf
	local var_2_14 = var_3.Find(var_2_13, "top/id/label")

	i18n = var_4

	var_1(var_2_14, var_4("island_my_id"))

	setText = var_1

	local var_2_15 = arg_2_0._tf
	local var_2_16 = var_3.Find(var_2_15, "top/refresh/Text")

	i18n = var_4

	var_1(var_2_16, var_4("island_visit_set_refresh"))

	IslandRequestFriendBox = var_1
	arg_2_0.requestFriendBox = var_1.New(arg_2_0._tf, arg_2_0.event)

	return
end

function var_0_1.OnSearch(arg_3_0, arg_3_1)
	if not arg_3_1.list then
		return
	end

	arg_3_0.displays = arg_3_1.list

	arg_3_0:InitList()

	return
end

function var_0_1.CreateCard(arg_4_0, arg_4_1)
	IslandFriendSearchCard = var_1_10002

	return var_1_10002.New(arg_4_1)
end

function var_0_1.OnInitItem(arg_5_0, arg_5_1)
	var_0_1.super.OnInitItem(arg_5_0, arg_5_1)

	local var_5_0 = arg_5_0.cards[arg_5_1]

	onButton = var_1_10003

	local var_5_1 = arg_5_0
	local var_5_2 = var_5_0.addBtn

	local function var_5_3()
		local var_6_0 = arg_5_0.requestFriendBox

		var_0.ExecuteAction(var_6_0, "Show", var_5_0.player.id)

		return
	end

	SFX_PANEL = var_1_10008

	var_1_10003(var_5_1, var_5_2, var_5_3, var_1_10008)

	return
end

function var_0_1.InitMoreBtns(arg_7_0, arg_7_1)
	onButton = var_1_10002

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.whiteBtn

	local function var_7_2()
		local var_8_0 = arg_7_0
		local var_8_1 = var_0.emit

		IslandMediator = var_2_10003

		var_8_1(var_8_0, var_2_10003.ADD_WHITE_LIST, arg_7_1.id)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_7_0, var_7_1, var_7_2, var_1_10007)

	onButton = var_1_10002

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.blackBtn

	local function var_7_5()
		local var_9_0 = arg_7_0
		local var_9_1 = var_0.emit

		IslandMediator = var_2_10003

		var_9_1(var_9_0, var_2_10003.ADD_BLACK_LIST, arg_7_1.id)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10002(var_7_3, var_7_4, var_7_5, var_1_10007)

	return
end

function var_0_1.GetData(arg_10_0, arg_10_1)
	arg_10_1(arg_10_0.displays)

	return
end

function var_0_1.OnInit(arg_11_0)
	var_0_1.super.OnInit(arg_11_0)

	getProxy = var_1
	PlayerProxy = var_3

	local var_11_0 = var_1(var_3)

	arg_11_0.player = var_1.getRawData(var_11_0)

	local var_11_1 = arg_11_0.idTxt

	var_11_1.text = arg_11_0.player.id
	onButton = var_11_1

	local var_11_2 = arg_11_0
	local var_11_3 = arg_11_0.copyBtn

	local function var_11_4()
		UniPasteBoard = var_2_10000

		var_2_10000.SetClipBoardString(arg_11_0.player.id)

		pg = var_0

		local var_12_0 = var_0.TipsMgr.GetInstance()
		local var_12_1 = var_0.ShowTips

		i18n = var_2_10003

		var_12_1(var_12_0, var_2_10003("friend_id_copy_ok"))

		return
	end

	SFX_PANEL = var_1_10006

	var_11_1(var_11_2, var_11_3, var_11_4, var_1_10006)

	onButton = var_11_1

	local var_11_5 = arg_11_0
	local var_11_6 = arg_11_0.saerchBtn

	local function var_11_7()
		pg = var_2_10000

		local var_13_0 = var_2_10000.TimeMgr.GetInstance()
		local var_13_1 = var_0.GetServerTime(var_13_0)

		if arg_11_0.waitTimer and arg_11_0.waitTimer - var_13_1 > 0 then
			pg = var_1

			local var_13_2 = var_1.TipsMgr.GetInstance()
			local var_13_3 = var_1.ShowTips

			i18n = var_2_10004

			var_13_3(var_13_2, var_2_10004("friend_searchFriend_wait_time", arg_11_0.waitTimer - var_13_1))

			return
		end

		local var_13_4 = arg_11_0

		var_13_4.waitTimer = var_13_1 + var_0_2
		getInputText = var_13_4

		if not var_13_4(arg_11_0.searchBar) or var_1 == "" then
			pg = var_2

			local var_13_5 = var_2.TipsMgr.GetInstance()
			local var_13_6 = var_2.ShowTips

			i18n = var_2_10005

			var_13_6(var_13_5, var_2_10005("friend_inpout_key_tip"))

			return
		end

		local var_13_7 = arg_11_0
		local var_13_8 = var_2.emit

		IslandMediator = var_2_10005

		local var_13_9 = var_2_10005.SEARCH_FRIEND

		SearchFriendCommand = var_2_10006

		var_13_8(var_13_7, var_13_9, var_2_10006.SEARCH_TYPE_FRIEND, var_1)

		return
	end

	SFX_PANEL = var_1_10006

	var_11_1(var_11_5, var_11_6, var_11_7, var_1_10006)

	onButton = var_11_1

	local var_11_8 = arg_11_0
	local var_11_9 = arg_11_0.refreshBtn

	local function var_11_10()
		pg = var_2_10000

		local var_14_0 = var_2_10000.TimeMgr.GetInstance()
		local var_14_1 = var_0.GetServerTime(var_14_0)

		if arg_11_0.waitTimer and arg_11_0.waitTimer - var_14_1 > 0 then
			pg = var_1

			local var_14_2 = var_1.TipsMgr.GetInstance()
			local var_14_3 = var_1.ShowTips

			i18n = var_2_10004

			var_14_3(var_14_2, var_2_10004("friend_searchFriend_wait_time", arg_11_0.waitTimer - var_14_1))

			return
		end

		arg_11_0.waitTimer = var_14_1 + var_0_2

		local var_14_4 = arg_11_0
		local var_14_5 = var_1.emit

		IslandMediator = var_2_10004

		local var_14_6 = var_2_10004.SEARCH_FRIEND

		SearchFriendCommand = var_2_10005

		var_14_5(var_14_4, var_14_6, var_2_10005.SEARCH_TYPE_LIST, "")

		return
	end

	SFX_PANEL = var_1_10006

	var_11_1(var_11_8, var_11_9, var_11_10, var_1_10006)

	local var_11_11 = arg_11_0
	local var_11_12 = arg_11_0.emit

	IslandMediator = var_11_9

	local var_11_13 = var_11_9.SEARCH_FRIEND

	SearchFriendCommand = var_11_10

	var_11_12(var_11_11, var_11_13, var_11_10.SEARCH_TYPE_LIST, "")

	return
end

function var_0_1.HideRequestBox(arg_15_0)
	local var_15_0 = arg_15_0.requestFriendBox

	var_1.ExecuteAction(var_15_0, "Hide")

	return
end

function var_0_1.OnDestroy(arg_16_0)
	var_0_1.super.OnDestroy(arg_16_0)

	if arg_16_0.requestFriendBox then
		local var_16_0 = arg_16_0.requestFriendBox

		var_1.Destroy(var_16_0)

		arg_16_0.requestFriendBox = nil
	end

	return
end

return var_0_1
