local var_0_0 = class("FriendSearchPage", import("...base.BaseSubView"))
local var_0_1 = 10

function var_0_0.getUIName(arg_1_0)
	return "FriendSearchUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.addPanel = arg_2_0._tf:Find("add_panel")
	arg_2_0.searchPanel = arg_2_0.addPanel:Find("search_panel")
	arg_2_0.searchBar = arg_2_0.searchPanel:Find("InputField")

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, findTF(arg_3_0.searchPanel, "copy_btn"), function()
		UniPasteBoard.SetClipBoardString(arg_3_0.playerVO.id)
		pg.TipsMgr.GetInstance():ShowTips(i18n("friend_id_copy_ok"))

		return
	end)
	onButton(arg_3_0, findTF(arg_3_0.searchPanel, "search_btn"), function()
		local var_5_0 = pg.TimeMgr.GetInstance():GetServerTime()

		if arg_3_0.waitTimer and arg_3_0.waitTimer - var_5_0 > 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("friend_searchFriend_wait_time", arg_3_0.waitTimer - var_5_0))

			return
		end

		arg_3_0.waitTimer = var_5_0 + var_0_1

		local var_5_1 = getInputText(arg_3_0.searchBar)

		if not var_5_1 or var_5_1 == "" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("friend_inpout_key_tip"))

			return
		end

		arg_3_0.keyWord = var_5_1

		arg_3_0:emit(FriendMediator.SEARCH_FRIEND, 3, var_5_1)

		return
	end)
	onButton(arg_3_0, findTF(arg_3_0.searchPanel, "refresh_btn"), function()
		local var_6_0 = pg.TimeMgr.GetInstance():GetServerTime()

		if arg_3_0.waitTimer1 and arg_3_0.waitTimer1 - var_6_0 > 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("friend_searchFriend_wait_time", arg_3_0.waitTimer1 - var_6_0))

			return
		end

		arg_3_0.waitTimer1 = var_6_0 + var_0_1

		arg_3_0:emit(FriendMediator.SEARCH_FRIEND, 1, arg_3_0.keyWord)

		return
	end)

	return
end

function var_0_0.UpdateData(arg_7_0, arg_7_1)
	arg_7_0.searchFriendVOs = arg_7_1.searchResults or {}
	arg_7_0.playerVO = arg_7_1.playerVO

	if not arg_7_0.isInit then
		arg_7_0.isInit = true

		arg_7_0:initAddPage()
		arg_7_0:emit(FriendMediator.SEARCH_FRIEND, 1)
	else
		arg_7_0:sortSearchResult()
	end

	return
end

function var_0_0.sortSearchResult(arg_8_0)
	arg_8_0.addRect:SetTotalCount(#arg_8_0.searchFriendVOs, -1)

	return
end

function var_0_0.initAddPage(arg_9_0)
	arg_9_0.searchItems = {}

	setText(arg_9_0.searchPanel:Find("self_id_bg/Text"), arg_9_0.playerVO.id)

	arg_9_0.addRect = arg_9_0.addPanel:Find("mask/view"):GetComponent("LScrollRect")

	function arg_9_0.addRect.onInitItem(arg_10_0)
		arg_9_0:onInitItem(arg_10_0)

		return
	end

	function arg_9_0.addRect.onUpdateItem(arg_11_0, arg_11_1)
		arg_9_0:onUpdateItem(arg_11_0, arg_11_1)

		return
	end

	return
end

function var_0_0.onInitItem(arg_12_0, arg_12_1)
	local var_12_0 = FriendSearchCard.New(arg_12_1)

	onButton(arg_12_0, var_12_0.addBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			yesText = "text_apply",
			hideNo = true,
			type = MSGBOX_TYPE_INPUT,
			placeholder = i18n("friend_request_msg_placeholder"),
			title = i18n("friend_request_msg_title"),
			onYes = function(arg_14_0)
				arg_12_0:emit(FriendMediator.ADD_FRIEND, var_12_0.friendVO.id, arg_14_0)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(arg_12_0, var_12_0.resumeBtn, function()
		arg_12_0:emit(FriendMediator.OPEN_RESUME, var_12_0.friendVO.id)

		return
	end, SFX_PANEL)

	arg_12_0.searchItems[arg_12_1] = var_12_0

	return
end

function var_0_0.onUpdateItem(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_0.searchItems[arg_16_2] then
		arg_16_0:onInitItem(arg_16_2)
	end

	arg_16_0.searchItems[arg_16_2]:update(arg_16_0.searchFriendVOs[arg_16_1 + 1])

	return
end

function var_0_0.OnDestroy(arg_17_0)
	local var_17_0 = arg_17_0.searchItems or {}

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		iter_17_1:dispose()
	end

	return
end

return var_0_0
