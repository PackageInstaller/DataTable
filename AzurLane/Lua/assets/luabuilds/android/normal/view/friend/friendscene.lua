class = var_0_10000

local var_0_0 = "FriendScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.FRIEND_PAGE = 1
var_0_1.SEARCH_PAGE = 2
var_0_1.REQUEST_PAGE = 3
var_0_1.BLACKLIST_PAGE = 4

function var_0_1.getUIName(arg_1_0)
	return "FriendUI"
end

function var_0_1.setFriendVOs(arg_2_0, arg_2_1)
	arg_2_0.friendVOs = arg_2_1

	return
end

function var_0_1.setPlayer(arg_3_0, arg_3_1)
	arg_3_0.playerVO = arg_3_1

	return
end

function var_0_1.setRequests(arg_4_0, arg_4_1)
	arg_4_0.requestVOs = arg_4_1

	return
end

function var_0_1.setSearchResult(arg_5_0, arg_5_1)
	arg_5_0.searchResultVOs = arg_5_1

	return
end

function var_0_1.removeSearchResult(arg_6_0, arg_6_1)
	_ = var_1_10002

	local var_6_0 = var_1_10002.select(arg_6_0.searchResultVOs, function(arg_7_0)
		return arg_7_0.id ~= arg_6_1
	end)

	arg_6_0:setSearchResult(var_6_0)

	return
end

function var_0_1.setBlackList(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0.blackVOs = {}
		pairs = var_2

		for iter_8_0, iter_8_1 in var_2(arg_8_1 or {}) do
			table = var_1_10007

			var_1_10007.insert(arg_8_0.blackVOs, iter_8_1)
		end
	end

	return
end

function var_0_1.init(arg_9_0)
	local var_9_0 = arg_9_0._tf

	arg_9_0.pages = var_1.Find(var_9_0, "pages")

	local var_9_1 = arg_9_0._tf

	arg_9_0.togglesTF = var_1.Find(var_9_1, "blur_panel/adapt/left_length/frame/tagRoot")

	local var_9_2 = {}

	FriendListPage = var_9_1
	var_9_2[1] = var_9_1.New(arg_9_0.pages, arg_9_0.event, arg_9_0.contextData)
	FriendSearchPage = var_2
	var_9_2[2] = var_2.New(arg_9_0.pages, arg_9_0.event)
	FriendRequestPage = var_2
	var_9_2[3] = var_2.New(arg_9_0.pages, arg_9_0.event)
	FriendBlackListPage = var_2
	var_9_2[4] = var_2.New(arg_9_0.pages, arg_9_0.event)
	arg_9_0.pages = var_9_2
	arg_9_0.toggles = {}

	for iter_9_0 = 1, arg_9_0.togglesTF.childCount do
		local var_9_3 = arg_9_0.toggles
		local var_9_4 = arg_9_0.togglesTF

		var_9_3[iter_9_0] = var_6.GetChild(var_9_4, iter_9_0 - 1)
		onToggle = var_9_3

		local var_9_5 = arg_9_0
		local var_9_6 = arg_9_0.toggles[iter_9_0]

		local function var_9_7(arg_10_0)
			if arg_10_0 then
				local var_10_0 = arg_9_0

				var_1.switchPage(var_10_0, iter_9_0)
			end

			return
		end

		SFX_PANEL = var_1_10009

		var_9_3(var_9_5, var_9_6, var_9_7, var_1_10009)
	end

	local var_9_8 = arg_9_0.toggles[1]

	arg_9_0.chatTipContainer = var_1.Find(var_9_8, "count")

	local var_9_9 = arg_9_0.toggles[1]
	local var_9_10 = var_1.Find(var_9_9, "count/Text")
	local var_9_11 = var_1.GetComponent

	typeof = var_3
	Text = iter_9_0
	arg_9_0.chatTip = var_9_11(var_9_10, var_3(iter_9_0))

	local var_9_12 = arg_9_0._tf

	arg_9_0.listEmptyTF = var_1.Find(var_9_12, "empty")
	setActive = var_1

	var_1(arg_9_0.listEmptyTF, false)

	local var_9_13 = arg_9_0.listEmptyTF

	arg_9_0.listEmptyTxt = var_1.Find(var_9_13, "Text")

	return
end

function var_0_1.didEnter(arg_11_0)
	onButton = var_1_10001

	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0._tf
	local var_11_2 = var_3.Find(var_11_1, "blur_panel/adapt/top/back_btn")

	local function var_11_3()
		local var_12_0 = arg_11_0

		var_0.emit(var_12_0, var_0_1.ON_BACK)

		return
	end

	SOUND_BACK = var_5

	var_1_10001(var_11_0, var_11_2, var_11_3, var_5)

	local var_11_4

	if not arg_11_0.contextData.initPage then
		var_11_4 = 1
	end

	triggerToggle = var_11_0

	var_11_0(arg_11_0.toggles[var_11_4], true)
	arg_11_0:updateRequestTip()

	return
end

function var_0_1.wrapData(arg_13_0)
	return {
		friendVOs = arg_13_0.friendVOs,
		requestVOs = arg_13_0.requestVOs,
		searchResults = arg_13_0.searchResultVOs,
		blackVOs = arg_13_0.blackVOs,
		playerVO = arg_13_0.playerVO
	}
end

function var_0_1.updateEmpty(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = {}
	local var_14_1 = ""

	if arg_14_1 == var_0_1.FRIEND_PAGE then
		var_14_0 = arg_14_2.friendVOs
		i18n = var_5
		var_14_1 = var_5("list_empty_tip_friendui")
	elseif arg_14_1 == var_0_1.SEARCH_PAGE then
		var_14_0 = arg_14_2.searchResults
		i18n = var_5
		var_14_1 = var_5("list_empty_tip_friendui_search")
	elseif arg_14_1 == var_0_1.REQUEST_PAGE then
		var_14_0 = arg_14_2.requestVOs
		i18n = var_5
		var_14_1 = var_5("list_empty_tip_friendui_request")
	elseif arg_14_1 == var_0_1.BLACKLIST_PAGE then
		var_14_0 = arg_14_2.blackVOs
		i18n = var_5
		var_14_1 = var_5("list_empty_tip_friendui_black")
	end

	setActive = var_5

	var_5(arg_14_0.listEmptyTF, not var_14_0 or #var_14_0 <= 0)

	setText = var_5

	var_5(arg_14_0.listEmptyTxt, var_14_1)

	return
end

function var_0_1.switchPage(arg_15_0, arg_15_1)
	if arg_15_0.page then
		local var_15_0 = arg_15_0.page

		var_2.ExecuteAction(var_15_0, "Hide")
	end

	local var_15_1 = arg_15_0.pages[arg_15_1]
	local var_15_2 = arg_15_0:wrapData()

	var_15_1:ExecuteAction("Show")
	var_15_1:ExecuteAction("UpdateData", var_15_2)

	arg_15_0.page = var_15_1

	arg_15_0:updateEmpty(arg_15_1, var_15_2)

	return
end

function var_0_1.updatePage(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.pages[arg_16_1]

	if arg_16_0.page and var_16_0 == arg_16_0.page then
		local var_16_1 = arg_16_0:wrapData()
		local var_16_2 = arg_16_0.page

		var_4.ExecuteAction(var_16_2, "UpdateData", var_16_1)
		arg_16_0:updateEmpty(arg_16_1, var_16_1)
	end

	return
end

function var_0_1.updateChatNotification(arg_17_0, arg_17_1)
	setActive = var_1_10002

	var_1_10002(arg_17_0.chatTipContainer, arg_17_1 > 0)

	arg_17_0.chatTip.text = arg_17_1

	return
end

function var_0_1.updateRequestTip(arg_18_0)
	setActive = var_1_10001

	local var_18_0 = arg_18_0.toggles[3]

	var_1_10001(var_2.Find(var_18_0, "tip"), #arg_18_0.requestVOs > 0)

	return
end

function var_0_1.closeInfromPanel(arg_19_0)
	if not arg_19_0.pages[3] then
		return
	end

	local var_19_0 = arg_19_0.pages[3]

	var_1.closeInfromPanel(var_19_0)

	return
end

function var_0_1.willExit(arg_20_0)
	ipairs = var_1_10001

	for iter_20_0, iter_20_1 in var_1_10001(arg_20_0.pages) do
		iter_20_1:Destroy()
	end

	return
end

return var_0_1
