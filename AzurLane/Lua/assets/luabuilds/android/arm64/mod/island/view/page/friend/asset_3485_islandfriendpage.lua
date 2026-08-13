class = var_0_10000

local var_0_0 = "IslandFriendPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

var_0_1.EVENT_MSG = "IslandFriendPage:EVENT_MSG"

local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4
local var_0_6 = 5
local var_0_7 = 6
local var_0_8 = 7
local var_0_9 = 8

local function var_0_10(arg_1_0)
	local var_1_0 = {}

	i18n = var_1_10002
	var_1_0[1] = var_1_10002("island_friend")
	i18n = var_2
	var_1_0[2] = var_2("island_guild")
	i18n = var_2
	var_1_0[3] = var_2("island_code")
	i18n = var_2
	var_1_0[4] = var_2("island_search")
	i18n = var_2
	var_1_0[5] = var_2("island_request")
	i18n = var_2
	var_1_0[6] = var_2("island_whiteList")
	i18n = var_2
	var_1_0[7] = var_2("island_blackList")
	i18n = var_2
	var_1_0[8] = var_2("island_settings")

	return var_1_0[arg_1_0]
end

local function var_0_11(arg_2_0)
	return ({
		"tag_friend",
		"tag_guild",
		"tag_code",
		"tag_search",
		"tag_request",
		"tag_white",
		"tag_black",
		"tag_settings"
	})[arg_2_0]
end

function var_0_1.getUIName(arg_3_0)
	return "IslandFriendUI"
end

function var_0_1.OnLoaded(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.backBtn = var_1.Find(var_4_0, "top/back")

	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_1.Find(var_4_1, "top/gift_tip/Text")
	local var_4_3 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_4_0.giftTipTxt = var_4_3(var_4_2, var_4(var_1_10006))
	UIItemList = var_1

	local var_4_4 = var_1.New
	local var_4_5 = arg_4_0._tf
	local var_4_6 = var_3.Find(var_4_5, "adapt/toggles/content")
	local var_4_7 = arg_4_0._tf

	arg_4_0.uiToggleList = var_4_4(var_4_6, var_4.Find(var_4_7, "adapt/toggles/content/tpl"))

	local var_4_8 = arg_4_0._tf

	arg_4_0.mainTr = var_1.Find(var_4_8, "adapt/main")

	local var_4_9 = {}
	local var_4_10 = var_0_2

	IslandFriendListPage = var_4_8
	var_4_9[var_4_10] = var_4_8.New(arg_4_0.mainTr, arg_4_0.event)

	local var_4_11 = var_0_3

	IslandFriendList4GuildPage = var_3
	var_4_9[var_4_11] = var_3.New(arg_4_0.mainTr, arg_4_0.event)

	local var_4_12 = var_0_4

	IslandFriendCodePage = var_3
	var_4_9[var_4_12] = var_3.New(arg_4_0.mainTr, arg_4_0.event)

	local var_4_13 = var_0_5

	IslandFriendSearchPage = var_3
	var_4_9[var_4_13] = var_3.New(arg_4_0.mainTr, arg_4_0.event)

	local var_4_14 = var_0_6

	IslandFriendRequestPage = var_3
	var_4_9[var_4_14] = var_3.New(arg_4_0.mainTr, arg_4_0.event)

	local var_4_15 = var_0_7

	IslandFriendWhiteListPage = var_3
	var_4_9[var_4_15] = var_3.New(arg_4_0.mainTr, arg_4_0.event)

	local var_4_16 = var_0_8

	IslandFriendBlackListPage = var_3
	var_4_9[var_4_16] = var_3.New(arg_4_0.mainTr, arg_4_0.event)

	local var_4_17 = var_0_9

	IslandFriendSettingPage = var_3
	var_4_9[var_4_17] = var_3.New(arg_4_0.mainTr, arg_4_0.event)
	arg_4_0.pages = var_4_9
	setText = var_4_9

	local var_4_18 = arg_4_0._tf
	local var_4_19 = var_3.Find(var_4_18, "top/title/Text")

	i18n = var_4

	var_4_9(var_4_19, var_4("island_btn_label_visit"))

	return
end

function var_0_1.AddListeners(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.AddListener

	GAME = var_1_10004

	var_5_1(var_5_0, var_1_10004.FRIEND_SEARCH_DONE, arg_5_0.OnSearch)

	local var_5_2 = arg_5_0
	local var_5_3 = arg_5_0.AddListener

	GAME = var_4

	var_5_3(var_5_2, var_4.ISLAND_REFRESH_INVITECODE_DONE, arg_5_0.OnRefreshInviteCode)

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.AddListener

	GAME = var_4

	var_5_5(var_5_4, var_4.ISLAND_ACCESS_OP_DONE, arg_5_0.OnAccessOp)

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.AddListener

	GAME = var_4

	var_5_7(var_5_6, var_4.FRIEND_DELETE_DONE, arg_5_0.OnDelFriend)
	arg_5_0:AddListener(var_0_1.EVENT_MSG, arg_5_0.OnShowMsg)

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0.AddListener

	IslandSignInAgency = var_4

	var_5_9(var_5_8, var_4.OTHER_FETCH_CNT_UPDATE, arg_5_0.OnOtherFetchCntUpdate)

	local var_5_10 = arg_5_0
	local var_5_11 = arg_5_0.AddListener

	NotificationProxy = var_4

	var_5_11(var_5_10, var_4.FRIEND_REQUEST_REMOVED, arg_5_0.OnRequestChange)

	local var_5_12 = arg_5_0
	local var_5_13 = arg_5_0.AddListener

	NotificationProxy = var_4

	var_5_13(var_5_12, var_4.FRIEND_REQUEST_ADDED, arg_5_0.OnRequestChange)

	local var_5_14 = arg_5_0
	local var_5_15 = arg_5_0.AddListener

	GAME = var_4

	var_5_15(var_5_14, var_4.FRIEND_SEND_REQUEST_DONE, arg_5_0.OnAddFriendDone)

	return
end

function var_0_1.RemoveListeners(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.RemoveListener

	GAME = var_1_10004

	var_6_1(var_6_0, var_1_10004.FRIEND_SEARCH_DONE, arg_6_0.OnSearch)

	local var_6_2 = arg_6_0
	local var_6_3 = arg_6_0.RemoveListener

	GAME = var_4

	var_6_3(var_6_2, var_4.ISLAND_REFRESH_INVITECODE_DONE, arg_6_0.OnRefreshInviteCode)

	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0.RemoveListener

	GAME = var_4

	var_6_5(var_6_4, var_4.ISLAND_ACCESS_OP_DONE, arg_6_0.OnAccessOp)

	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0.RemoveListener

	GAME = var_4

	var_6_7(var_6_6, var_4.FRIEND_DELETE_DONE, arg_6_0.OnDelFriend)
	arg_6_0:RemoveListener(var_0_1.EVENT_MSG, arg_6_0.OnShowMsg)

	local var_6_8 = arg_6_0
	local var_6_9 = arg_6_0.RemoveListener

	IslandSignInAgency = var_4

	var_6_9(var_6_8, var_4.OTHER_FETCH_CNT_UPDATE, arg_6_0.OnOtherFetchCntUpdate)

	local var_6_10 = arg_6_0
	local var_6_11 = arg_6_0.RemoveListener

	NotificationProxy = var_4

	var_6_11(var_6_10, var_4.FRIEND_REQUEST_REMOVED, arg_6_0.OnRequestChange)

	local var_6_12 = arg_6_0
	local var_6_13 = arg_6_0.RemoveListener

	NotificationProxy = var_4

	var_6_13(var_6_12, var_4.FRIEND_REQUEST_ADDED, arg_6_0.OnRequestChange)

	local var_6_14 = arg_6_0
	local var_6_15 = arg_6_0.RemoveListener

	GAME = var_4

	var_6_15(var_6_14, var_4.FRIEND_SEND_REQUEST_DONE, arg_6_0.OnAddFriendDone)

	return
end

function var_0_1.OnAddFriendDone(arg_7_0)
	if arg_7_0.pages[var_0_5] and var_1:GetLoaded() and var_1:isShowing() then
		var_1:HideRequestBox()
	end

	return
end

function var_0_1.OnRequestChange(arg_8_0)
	if arg_8_0.pages[var_0_6] and var_1:GetLoaded() and var_1:isShowing() then
		var_1:Flush()
	end

	arg_8_0:UpdateTip()

	return
end

function var_0_1.OnOtherFetchCntUpdate(arg_9_0)
	arg_9_0:UpdateGiftTxt()

	return
end

function var_0_1.OnDelFriend(arg_10_0)
	if arg_10_0.pages[var_0_2] and var_1:GetLoaded() and var_1:isShowing() then
		var_1:Flush()
	end

	return
end

function var_0_1.OnAccessOp(arg_11_0)
	if arg_11_0.pages[var_0_7] and var_1:GetLoaded() and var_1:isShowing() then
		var_1:Flush()
	end

	if arg_11_0.pages[var_0_8] and var_2:GetLoaded() and var_2:isShowing() then
		var_2:Flush()
	end

	if arg_11_0.pages[var_0_5] and var_3:GetLoaded() and var_3:isShowing() then
		var_3:Flush()
	end

	return
end

function var_0_1.OnRefreshInviteCode(arg_12_0)
	if arg_12_0.pages[var_0_9] and var_1:GetLoaded() and var_1:isShowing() then
		var_1:OnRefreshInviteCode()
	end

	return
end

function var_0_1.OnSearch(arg_13_0, arg_13_1)
	if arg_13_0.pages[var_0_5] and var_2:GetLoaded() and var_2:isShowing() then
		var_2:OnSearch(arg_13_1)
	end

	return
end

function var_0_1.OnShowMsg(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.ShowMsgBox
	local var_14_2 = {
		content = arg_14_1
	}

	IslandMsgBox = var_1_10006
	var_14_2.type = var_1_10006.TYPE_WHITOUT_BTN

	var_14_1(var_14_0, var_14_2)

	return
end

function var_0_1.OnInit(arg_15_0)
	onButton = var_1_10001

	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0._tf
	local var_15_2 = var_4.Find(var_15_1, "top/title/help")

	local function var_15_3()
		pg = var_2_10000

		local var_16_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_16_1 = var_0.ShowMsgBox
		local var_16_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_16_2.type = var_2_10004
		pg = var_2_10004
		var_16_2.helps = var_2_10004.gametip.island_help_friends.tip

		var_16_1(var_16_0, var_16_2)

		return
	end

	SFX_PANEL = var_15_1

	var_1_10001(var_15_0, var_15_2, var_15_3, var_15_1)

	onButton = var_1_10001

	local var_15_4 = arg_15_0
	local var_15_5 = arg_15_0.backBtn

	local function var_15_6()
		local var_17_0 = arg_15_0

		var_0.Hide(var_17_0)

		return
	end

	SFX_PANEL = var_15_1

	var_1_10001(var_15_4, var_15_5, var_15_6, var_15_1)

	arg_15_0.toggles = {}

	local var_15_7 = arg_15_0.uiToggleList

	var_1.make(var_15_7, function(arg_18_0, arg_18_1, arg_18_2)
		UIItemList = var_2_10003

		if arg_18_0 == var_2_10003.EventUpdate then
			onToggle = var_3

			local var_18_0 = arg_15_0
			local var_18_1 = arg_18_2

			local function var_18_2(arg_19_0)
				if arg_19_0 then
					local var_19_0 = arg_15_0

					var_1.SwitchPage(var_19_0, arg_18_1 + 1)
				end

				return
			end

			SF_PANEL = var_2_10008

			var_3(var_18_0, var_18_1, var_18_2, var_2_10008)

			setText = var_3

			var_3(arg_18_2:Find("unsel"), var_0_10(arg_18_1 + 1))

			setText = var_3

			var_3(arg_18_2:Find("sel/content/Text"), var_0_10(arg_18_1 + 1))

			GetSpriteFromAtlas = var_3

			local var_18_3 = var_3("ui/IslandFriendUI_atlas", var_0_11(arg_18_1 + 1))

			setImageSprite = var_2_10004

			var_2_10004(arg_18_2:Find("sel/content/Image"), var_18_3, true)

			table = var_2_10004

			var_2_10004.insert(arg_15_0.toggles, arg_18_2)
		end

		return
	end)

	local var_15_8 = arg_15_0.uiToggleList

	var_1.align(var_15_8, #arg_15_0.pages)
	arg_15_0:UpdateTip()

	return
end

function var_0_1.UpdateTip(arg_20_0)
	local var_20_0 = arg_20_0.toggles[var_0_6]

	setActive = var_2

	local var_20_1 = var_20_0:Find("tip")

	getProxy = var_1_10005
	NotificationProxy = var_7

	local var_20_2 = var_1_10005(var_7)

	var_2(var_20_1, var_5.getRequestCount(var_20_2) > 0)

	return
end

function var_0_1.SwitchPage(arg_21_0, arg_21_1)
	if arg_21_0.page then
		local var_21_0 = arg_21_0.page

		var_2.ExecuteAction(var_21_0, "Hide")

		arg_21_0.page = nil
	end

	local var_21_1 = arg_21_0.pages[arg_21_1]

	var_2.ExecuteAction(var_21_1, "Show")

	arg_21_0.page = var_2

	return
end

function var_0_1.OnShow(arg_22_0)
	arg_22_0:UpdateGiftTxt()

	triggerToggle = var_1

	var_1(arg_22_0.toggles[var_0_2], true)
	arg_22_0:BlurPanel()

	return
end

function var_0_1.UpdateGiftTxt(arg_23_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_23_0 = var_1_10001(var_1_10003)
	local var_23_1 = var_1.GetIsland(var_23_0)
	local var_23_2 = var_1.GetSignInAgency(var_23_1)
	local var_23_3 = var_1.GetLeftOtherFetchCnt(var_23_2)
	local var_23_4 = var_1
	local var_23_5 = var_1.GetMaxOtheFetchcnt(var_23_4)
	local var_23_6 = arg_23_0.giftTipTxt

	i18n = var_23_4
	var_23_6.text = var_23_4("island_git_cnt_tip") .. var_23_3 .. "/" .. var_23_5

	return
end

function var_0_1.OnHide(arg_24_0)
	arg_24_0:UnBlurPanel()

	return
end

function var_0_1.OnDisable(arg_25_0)
	arg_25_0:OnHide()

	return
end

function var_0_1.OnDestroy(arg_26_0)
	arg_26_0:UnBlurPanel()

	ipairs = var_1

	for iter_26_0, iter_26_1 in var_1(arg_26_0.pages) do
		iter_26_1:Destroy()
	end

	arg_26_0.pages = nil

	return
end

return var_0_1
