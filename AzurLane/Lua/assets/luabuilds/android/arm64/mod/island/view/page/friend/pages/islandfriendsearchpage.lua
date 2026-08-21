local var_0_0 = class("IslandFriendSearchPage", import(".IslandFriendListPage"))
local var_0_1 = 10

function var_0_0.getUIName(arg_1_0)
	return "IslandFriendSearchUI"
end

function var_0_0.OnLoaded(arg_2_0)
	var_0_0.super.OnLoaded(arg_2_0)

	arg_2_0.idTxt = arg_2_0._tf:Find("top/id/Text"):GetComponent(typeof(Text))
	arg_2_0.copyBtn = arg_2_0._tf:Find("top/id/copy")
	arg_2_0.saerchBtn = arg_2_0._tf:Find("top/search/copy")
	arg_2_0.refreshBtn = arg_2_0._tf:Find("top/refresh")
	arg_2_0.searchBar = arg_2_0._tf:Find("top/search/input")
	arg_2_0.displays = {}

	setText(arg_2_0._tf:Find("top/id/copy/Text"), i18n("island_btn_label_copy"))
	setText(arg_2_0._tf:Find("top/search/copy/Text"), i18n("island_search"))
	setText(arg_2_0._tf:Find("top/search/input/Text"), i18n("island_input_my_id"))
	setText(arg_2_0._tf:Find("top/id/label"), i18n("island_my_id"))
	setText(arg_2_0._tf:Find("top/refresh/Text"), i18n("island_visit_set_refresh"))

	arg_2_0.requestFriendBox = IslandRequestFriendBox.New(arg_2_0._tf, arg_2_0.event)

	return
end

function var_0_0.OnSearch(arg_3_0, arg_3_1)
	if not arg_3_1.list then
		return
	end

	arg_3_0.displays = arg_3_1.list

	arg_3_0:InitList()

	return
end

function var_0_0.CreateCard(arg_4_0, arg_4_1)
	return IslandFriendSearchCard.New(arg_4_1)
end

function var_0_0.OnInitItem(arg_5_0, arg_5_1)
	var_0_0.super.OnInitItem(arg_5_0, arg_5_1)
	onButton(arg_5_0, arg_5_0.cards[arg_5_1].addBtn, function()
		arg_5_0.requestFriendBox:ExecuteAction("Show", var_0.player.id)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.InitMoreBtns(arg_7_0, arg_7_1)
	onButton(arg_7_0, arg_7_0.whiteBtn, function()
		arg_7_0:emit(IslandMediator.ADD_WHITE_LIST, arg_7_1.id)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.blackBtn, function()
		arg_7_0:emit(IslandMediator.ADD_BLACK_LIST, arg_7_1.id)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.GetData(arg_10_0, arg_10_1)
	arg_10_1(arg_10_0.displays)

	return
end

function var_0_0.OnInit(arg_11_0)
	var_0_0.super.OnInit(arg_11_0)

	arg_11_0.player = getProxy(PlayerProxy):getRawData()
	arg_11_0.idTxt.text = arg_11_0.player.id

	onButton(arg_11_0, arg_11_0.copyBtn, function()
		UniPasteBoard.SetClipBoardString(arg_11_0.player.id)
		pg.TipsMgr.GetInstance():ShowTips(i18n("friend_id_copy_ok"))

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.saerchBtn, function()
		local var_13_0 = pg.TimeMgr.GetInstance():GetServerTime()

		if arg_11_0.waitTimer and arg_11_0.waitTimer - var_13_0 > 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("friend_searchFriend_wait_time", arg_11_0.waitTimer - var_13_0))

			return
		end

		arg_11_0.waitTimer = var_13_0 + var_0_1

		local var_13_1 = getInputText(arg_11_0.searchBar)

		if not var_13_1 or var_13_1 == "" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("friend_inpout_key_tip"))

			return
		end

		arg_11_0:emit(IslandMediator.SEARCH_FRIEND, SearchFriendCommand.SEARCH_TYPE_FRIEND, var_13_1)

		return
	end, SFX_PANEL)
	onButton(arg_11_0, arg_11_0.refreshBtn, function()
		local var_14_0 = pg.TimeMgr.GetInstance():GetServerTime()

		if arg_11_0.waitTimer and arg_11_0.waitTimer - var_14_0 > 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("friend_searchFriend_wait_time", arg_11_0.waitTimer - var_14_0))

			return
		end

		arg_11_0.waitTimer = var_14_0 + var_0_1

		arg_11_0:emit(IslandMediator.SEARCH_FRIEND, SearchFriendCommand.SEARCH_TYPE_LIST, "")

		return
	end, SFX_PANEL)
	arg_11_0:emit(IslandMediator.SEARCH_FRIEND, SearchFriendCommand.SEARCH_TYPE_LIST, "")

	return
end

function var_0_0.HideRequestBox(arg_15_0)
	arg_15_0.requestFriendBox:ExecuteAction("Hide")

	return
end

function var_0_0.OnDestroy(arg_16_0)
	var_0_0.super.OnDestroy(arg_16_0)

	if arg_16_0.requestFriendBox then
		arg_16_0.requestFriendBox:Destroy()

		arg_16_0.requestFriendBox = nil
	end

	return
end

return var_0_0
