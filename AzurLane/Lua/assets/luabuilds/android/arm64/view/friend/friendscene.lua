local var_0_0 = class("FriendScene", import("..base.BaseUI"))

var_0_0.FRIEND_PAGE = 1
var_0_0.SEARCH_PAGE = 2
var_0_0.REQUEST_PAGE = 3
var_0_0.BLACKLIST_PAGE = 4

function var_0_0.getUIName(arg_1_0)
	return "FriendUI"
end

function var_0_0.setFriendVOs(arg_2_0, arg_2_1)
	arg_2_0.friendVOs = arg_2_1

	return
end

function var_0_0.setPlayer(arg_3_0, arg_3_1)
	arg_3_0.playerVO = arg_3_1

	return
end

function var_0_0.setRequests(arg_4_0, arg_4_1)
	arg_4_0.requestVOs = arg_4_1

	return
end

function var_0_0.setSearchResult(arg_5_0, arg_5_1)
	arg_5_0.searchResultVOs = arg_5_1

	return
end

function var_0_0.removeSearchResult(arg_6_0, arg_6_1)
	arg_6_0:setSearchResult((_.select(arg_6_0.searchResultVOs, function(arg_7_0)
		return arg_7_0.id ~= arg_6_1
	end)))

	return
end

function var_0_0.setBlackList(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0.blackVOs = {}

		for iter_8_0, iter_8_1 in pairs(arg_8_1 or {}) do
			table.insert(arg_8_0.blackVOs, iter_8_1)
		end
	end

	return
end

function var_0_0.init(arg_9_0)
	arg_9_0.pages = arg_9_0._tf:Find("pages")
	arg_9_0.togglesTF = arg_9_0._tf:Find("blur_panel/adapt/left_length/frame/tagRoot")
	arg_9_0.pages = {
		FriendListPage.New(arg_9_0.pages, arg_9_0.event, arg_9_0.contextData),
		FriendSearchPage.New(arg_9_0.pages, arg_9_0.event),
		FriendRequestPage.New(arg_9_0.pages, arg_9_0.event),
		FriendBlackListPage.New(arg_9_0.pages, arg_9_0.event)
	}
	arg_9_0.toggles = {}

	for iter_9_0 = 1, arg_9_0.togglesTF.childCount do
		arg_9_0.toggles[iter_9_0] = arg_9_0.togglesTF:GetChild(iter_9_0 - 1)

		onToggle(arg_9_0, arg_9_0.toggles[iter_9_0], function(arg_10_0)
			if arg_10_0 then
				arg_9_0:switchPage(iter_9_0)
			end

			return
		end, SFX_PANEL)
	end

	arg_9_0.chatTipContainer = arg_9_0.toggles[1]:Find("count")
	arg_9_0.chatTip = arg_9_0.toggles[1]:Find("count/Text"):GetComponent(typeof(Text))
	arg_9_0.listEmptyTF = arg_9_0._tf:Find("empty")

	setActive(arg_9_0.listEmptyTF, false)

	arg_9_0.listEmptyTxt = arg_9_0.listEmptyTF:Find("Text")

	return
end

function var_0_0.didEnter(arg_11_0)
	onButton(arg_11_0, arg_11_0._tf:Find("blur_panel/adapt/top/back_btn"), function()
		arg_11_0:emit(var_0_0.ON_BACK)

		return
	end, SOUND_BACK)

	local var_11_0 = arg_11_0.contextData.initPage or 1

	triggerToggle(arg_11_0.toggles[var_11_0], true)
	arg_11_0:updateRequestTip()

	return
end

function var_0_0.wrapData(arg_13_0)
	return {
		friendVOs = arg_13_0.friendVOs,
		requestVOs = arg_13_0.requestVOs,
		searchResults = arg_13_0.searchResultVOs,
		blackVOs = arg_13_0.blackVOs,
		playerVO = arg_13_0.playerVO
	}
end

function var_0_0.updateEmpty(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = {}
	local var_14_1 = ""

	if arg_14_1 == var_0_0.FRIEND_PAGE then
		var_14_0 = arg_14_2.friendVOs
		var_14_1 = i18n("list_empty_tip_friendui")
	elseif arg_14_1 == var_0_0.SEARCH_PAGE then
		var_14_0 = arg_14_2.searchResults
		var_14_1 = i18n("list_empty_tip_friendui_search")
	elseif arg_14_1 == var_0_0.REQUEST_PAGE then
		var_14_0 = arg_14_2.requestVOs
		var_14_1 = i18n("list_empty_tip_friendui_request")
	elseif arg_14_1 == var_0_0.BLACKLIST_PAGE then
		var_14_0 = arg_14_2.blackVOs
		var_14_1 = i18n("list_empty_tip_friendui_black")
	end

	setActive(arg_14_0.listEmptyTF, not var_14_0 or #var_14_0 <= 0)
	setText(arg_14_0.listEmptyTxt, var_14_1)

	return
end

function var_0_0.switchPage(arg_15_0, arg_15_1)
	if arg_15_0.page then
		arg_15_0.page:ExecuteAction("Hide")
	end

	local var_15_0 = arg_15_0.pages[arg_15_1]
	local var_15_1 = arg_15_0:wrapData()

	arg_15_0.pages[arg_15_1]:ExecuteAction("Show")
	var_15_0:ExecuteAction("UpdateData", var_15_1)

	arg_15_0.page = var_15_0

	arg_15_0:updateEmpty(arg_15_1, var_15_1)

	return
end

function var_0_0.updatePage(arg_16_0, arg_16_1)
	if arg_16_0.page and arg_16_0.pages[arg_16_1] == arg_16_0.page then
		local var_16_0 = arg_16_0:wrapData()

		arg_16_0.page:ExecuteAction("UpdateData", var_16_0)
		arg_16_0:updateEmpty(arg_16_1, var_16_0)
	end

	return
end

function var_0_0.updateChatNotification(arg_17_0, arg_17_1)
	setActive(arg_17_0.chatTipContainer, arg_17_1 > 0)

	arg_17_0.chatTip.text = arg_17_1

	return
end

function var_0_0.updateRequestTip(arg_18_0)
	setActive(arg_18_0.toggles[3]:Find("tip"), #arg_18_0.requestVOs > 0)

	return
end

function var_0_0.closeInfromPanel(arg_19_0)
	if not arg_19_0.pages[3] then
		return
	end

	arg_19_0.pages[3]:closeInfromPanel()

	return
end

function var_0_0.willExit(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0.pages) do
		iter_20_1:Destroy()
	end

	return
end

return var_0_0
