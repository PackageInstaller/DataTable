local var_0_0 = class("IslandFriendPage", import("...base.IslandBasePage"))

var_0_0.EVENT_MSG = "IslandFriendPage:EVENT_MSG"

local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5 = 5
local var_0_6 = 6
local var_0_7 = 7
local var_0_8 = 8

local function var_0_9(arg_1_0)
	return ({
		i18n("island_friend"),
		i18n("island_guild"),
		i18n("island_code"),
		i18n("island_search"),
		i18n("island_request"),
		i18n("island_whiteList"),
		i18n("island_blackList"),
		i18n("island_settings")
	})[arg_1_0]
end

local function var_0_10(arg_2_0)
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

function var_0_0.getUIName(arg_3_0)
	return "IslandFriendUI"
end

function var_0_0.OnLoaded(arg_4_0)
	arg_4_0.backBtn = arg_4_0._tf:Find("top/back")
	arg_4_0.giftTipTxt = arg_4_0._tf:Find("top/gift_tip/Text"):GetComponent(typeof(Text))
	arg_4_0.uiToggleList = UIItemList.New(arg_4_0._tf:Find("adapt/toggles/content"), arg_4_0._tf:Find("adapt/toggles/content/tpl"))
	arg_4_0.mainTr = arg_4_0._tf:Find("adapt/main")
	arg_4_0.pages = {
		[var_0_1] = IslandFriendListPage.New(arg_4_0.mainTr, arg_4_0.event),
		[var_0_2] = IslandFriendList4GuildPage.New(arg_4_0.mainTr, arg_4_0.event),
		[var_0_3] = IslandFriendCodePage.New(arg_4_0.mainTr, arg_4_0.event),
		[var_0_4] = IslandFriendSearchPage.New(arg_4_0.mainTr, arg_4_0.event),
		[var_0_5] = IslandFriendRequestPage.New(arg_4_0.mainTr, arg_4_0.event),
		[var_0_6] = IslandFriendWhiteListPage.New(arg_4_0.mainTr, arg_4_0.event),
		[var_0_7] = IslandFriendBlackListPage.New(arg_4_0.mainTr, arg_4_0.event),
		[var_0_8] = IslandFriendSettingPage.New(arg_4_0.mainTr, arg_4_0.event)
	}

	setText(arg_4_0._tf:Find("top/title/Text"), i18n("island_btn_label_visit"))

	return
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddListener(GAME.FRIEND_SEARCH_DONE, arg_5_0.OnSearch)
	arg_5_0:AddListener(GAME.ISLAND_REFRESH_INVITECODE_DONE, arg_5_0.OnRefreshInviteCode)
	arg_5_0:AddListener(GAME.ISLAND_ACCESS_OP_DONE, arg_5_0.OnAccessOp)
	arg_5_0:AddListener(GAME.FRIEND_DELETE_DONE, arg_5_0.OnDelFriend)
	arg_5_0:AddListener(var_0_0.EVENT_MSG, arg_5_0.OnShowMsg)
	arg_5_0:AddListener(IslandSignInAgency.OTHER_FETCH_CNT_UPDATE, arg_5_0.OnOtherFetchCntUpdate)
	arg_5_0:AddListener(NotificationProxy.FRIEND_REQUEST_REMOVED, arg_5_0.OnRequestChange)
	arg_5_0:AddListener(NotificationProxy.FRIEND_REQUEST_ADDED, arg_5_0.OnRequestChange)
	arg_5_0:AddListener(GAME.FRIEND_SEND_REQUEST_DONE, arg_5_0.OnAddFriendDone)

	return
end

function var_0_0.RemoveListeners(arg_6_0)
	arg_6_0:RemoveListener(GAME.FRIEND_SEARCH_DONE, arg_6_0.OnSearch)
	arg_6_0:RemoveListener(GAME.ISLAND_REFRESH_INVITECODE_DONE, arg_6_0.OnRefreshInviteCode)
	arg_6_0:RemoveListener(GAME.ISLAND_ACCESS_OP_DONE, arg_6_0.OnAccessOp)
	arg_6_0:RemoveListener(GAME.FRIEND_DELETE_DONE, arg_6_0.OnDelFriend)
	arg_6_0:RemoveListener(var_0_0.EVENT_MSG, arg_6_0.OnShowMsg)
	arg_6_0:RemoveListener(IslandSignInAgency.OTHER_FETCH_CNT_UPDATE, arg_6_0.OnOtherFetchCntUpdate)
	arg_6_0:RemoveListener(NotificationProxy.FRIEND_REQUEST_REMOVED, arg_6_0.OnRequestChange)
	arg_6_0:RemoveListener(NotificationProxy.FRIEND_REQUEST_ADDED, arg_6_0.OnRequestChange)
	arg_6_0:RemoveListener(GAME.FRIEND_SEND_REQUEST_DONE, arg_6_0.OnAddFriendDone)

	return
end

function var_0_0.OnAddFriendDone(arg_7_0)
	if arg_7_0.pages[var_0_4] and arg_7_0.pages[var_0_4]:GetLoaded() and arg_7_0.pages[var_0_4]:isShowing() then
		arg_7_0.pages[var_0_4]:HideRequestBox()
	end

	return
end

function var_0_0.OnRequestChange(arg_8_0)
	if arg_8_0.pages[var_0_5] and arg_8_0.pages[var_0_5]:GetLoaded() and arg_8_0.pages[var_0_5]:isShowing() then
		arg_8_0.pages[var_0_5]:Flush()
	end

	arg_8_0:UpdateTip()

	return
end

function var_0_0.OnOtherFetchCntUpdate(arg_9_0)
	arg_9_0:UpdateGiftTxt()

	return
end

function var_0_0.OnDelFriend(arg_10_0)
	if arg_10_0.pages[var_0_1] and arg_10_0.pages[var_0_1]:GetLoaded() and arg_10_0.pages[var_0_1]:isShowing() then
		arg_10_0.pages[var_0_1]:Flush()
	end

	return
end

function var_0_0.OnAccessOp(arg_11_0)
	if arg_11_0.pages[var_0_6] and arg_11_0.pages[var_0_6]:GetLoaded() and arg_11_0.pages[var_0_6]:isShowing() then
		arg_11_0.pages[var_0_6]:Flush()
	end

	if arg_11_0.pages[var_0_7] and var_11_0:GetLoaded() and var_11_0:isShowing() then
		var_11_0:Flush()
	end

	if arg_11_0.pages[var_0_4] and var_11_1:GetLoaded() and var_11_1:isShowing() then
		var_11_1:Flush()
	end

	return
end

function var_0_0.OnRefreshInviteCode(arg_12_0)
	if arg_12_0.pages[var_0_8] and arg_12_0.pages[var_0_8]:GetLoaded() and arg_12_0.pages[var_0_8]:isShowing() then
		arg_12_0.pages[var_0_8]:OnRefreshInviteCode()
	end

	return
end

function var_0_0.OnSearch(arg_13_0, arg_13_1)
	if arg_13_0.pages[var_0_4] and arg_13_0.pages[var_0_4]:GetLoaded() and arg_13_0.pages[var_0_4]:isShowing() then
		arg_13_0.pages[var_0_4]:OnSearch(arg_13_1)
	end

	return
end

function var_0_0.OnShowMsg(arg_14_0, arg_14_1)
	arg_14_0:ShowMsgBox({
		content = arg_14_1,
		type = IslandMsgBox.TYPE_WHITOUT_BTN
	})

	return
end

function var_0_0.OnInit(arg_15_0)
	onButton(arg_15_0, arg_15_0._tf:Find("top/title/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.island_help_friends.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_15_0, arg_15_0.backBtn, function()
		arg_15_0:Hide()

		return
	end, SFX_PANEL)

	arg_15_0.toggles = {}

	arg_15_0.uiToggleList:make(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			onToggle(arg_15_0, arg_18_2, function(arg_19_0)
				if arg_19_0 then
					arg_15_0:SwitchPage(arg_18_1 + 1)
				end

				return
			end, SF_PANEL)
			setText(arg_18_2:Find("unsel"), var_0_9(arg_18_1 + 1))
			setText(arg_18_2:Find("sel/content/Text"), var_0_9(arg_18_1 + 1))
			setImageSprite(arg_18_2:Find("sel/content/Image"), GetSpriteFromAtlas("ui/IslandFriendUI_atlas", var_0_10(arg_18_1 + 1)), true)
			table.insert(arg_15_0.toggles, arg_18_2)
		end

		return
	end)
	arg_15_0.uiToggleList:align(#arg_15_0.pages)
	arg_15_0:UpdateTip()

	return
end

function var_0_0.UpdateTip(arg_20_0)
	local var_20_0 = getProxy(NotificationProxy)

	setActive(arg_20_0.toggles[var_0_5]:Find("tip"), var_20_0:getRequestCount() > 0)

	return
end

function var_0_0.SwitchPage(arg_21_0, arg_21_1)
	if arg_21_0.page then
		arg_21_0.page:ExecuteAction("Hide")

		arg_21_0.page = nil
	end

	local var_21_0 = arg_21_0.pages[arg_21_1]

	arg_21_0.pages[arg_21_1]:ExecuteAction("Show")

	arg_21_0.page = var_21_0

	return
end

function var_0_0.OnShow(arg_22_0)
	arg_22_0:UpdateGiftTxt()
	triggerToggle(arg_22_0.toggles[var_0_1], true)
	arg_22_0:BlurPanel()

	return
end

function var_0_0.UpdateGiftTxt(arg_23_0)
	local var_23_0 = getProxy(IslandProxy):GetIsland():GetSignInAgency()

	arg_23_0.giftTipTxt.text = i18n("island_git_cnt_tip") .. var_23_0:GetLeftOtherFetchCnt() .. "/" .. var_23_0:GetMaxOtheFetchcnt()

	return
end

function var_0_0.OnHide(arg_24_0)
	arg_24_0:UnBlurPanel()

	return
end

function var_0_0.OnDisable(arg_25_0)
	arg_25_0:OnHide()

	return
end

function var_0_0.OnDestroy(arg_26_0)
	arg_26_0:UnBlurPanel()

	for iter_26_0, iter_26_1 in ipairs(arg_26_0.pages) do
		iter_26_1:Destroy()
	end

	arg_26_0.pages = nil

	return
end

return var_0_0
