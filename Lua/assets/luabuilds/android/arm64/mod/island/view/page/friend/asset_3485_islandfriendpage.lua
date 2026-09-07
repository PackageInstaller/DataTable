local IslandFriendPage = class("IslandFriendPage", import("...base.IslandBasePage"))

IslandFriendPage.EVENT_MSG = "IslandFriendPage:EVENT_MSG"

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

function IslandFriendPage:getUIName()
	return "IslandFriendUI"
end

function IslandFriendPage:OnLoaded()
	self.backBtn = self._tf:Find("top/back")
	self.giftTipTxt = self._tf:Find("top/gift_tip/Text"):GetComponent(typeof(Text))
	self.uiToggleList = UIItemList.New(self._tf:Find("adapt/toggles/content"), self._tf:Find("adapt/toggles/content/tpl"))
	self.mainTr = self._tf:Find("adapt/main")
	self.pages = {
		[var_0_1] = IslandFriendListPage.New(self.mainTr, self.event),
		[var_0_2] = IslandFriendList4GuildPage.New(self.mainTr, self.event),
		[var_0_3] = IslandFriendCodePage.New(self.mainTr, self.event),
		[var_0_4] = IslandFriendSearchPage.New(self.mainTr, self.event),
		[var_0_5] = IslandFriendRequestPage.New(self.mainTr, self.event),
		[var_0_6] = IslandFriendWhiteListPage.New(self.mainTr, self.event),
		[var_0_7] = IslandFriendBlackListPage.New(self.mainTr, self.event),
		[var_0_8] = IslandFriendSettingPage.New(self.mainTr, self.event)
	}

	setText(self._tf:Find("top/title/Text"), i18n("island_btn_label_visit"))

	return
end

function IslandFriendPage:AddListeners()
	self:AddListener(GAME.FRIEND_SEARCH_DONE, self.OnSearch)
	self:AddListener(GAME.ISLAND_REFRESH_INVITECODE_DONE, self.OnRefreshInviteCode)
	self:AddListener(GAME.ISLAND_ACCESS_OP_DONE, self.OnAccessOp)
	self:AddListener(GAME.FRIEND_DELETE_DONE, self.OnDelFriend)
	self:AddListener(IslandFriendPage.EVENT_MSG, self.OnShowMsg)
	self:AddListener(IslandSignInAgency.OTHER_FETCH_CNT_UPDATE, self.OnOtherFetchCntUpdate)
	self:AddListener(NotificationProxy.FRIEND_REQUEST_REMOVED, self.OnRequestChange)
	self:AddListener(NotificationProxy.FRIEND_REQUEST_ADDED, self.OnRequestChange)
	self:AddListener(GAME.FRIEND_SEND_REQUEST_DONE, self.OnAddFriendDone)

	return
end

function IslandFriendPage:RemoveListeners()
	self:RemoveListener(GAME.FRIEND_SEARCH_DONE, self.OnSearch)
	self:RemoveListener(GAME.ISLAND_REFRESH_INVITECODE_DONE, self.OnRefreshInviteCode)
	self:RemoveListener(GAME.ISLAND_ACCESS_OP_DONE, self.OnAccessOp)
	self:RemoveListener(GAME.FRIEND_DELETE_DONE, self.OnDelFriend)
	self:RemoveListener(IslandFriendPage.EVENT_MSG, self.OnShowMsg)
	self:RemoveListener(IslandSignInAgency.OTHER_FETCH_CNT_UPDATE, self.OnOtherFetchCntUpdate)
	self:RemoveListener(NotificationProxy.FRIEND_REQUEST_REMOVED, self.OnRequestChange)
	self:RemoveListener(NotificationProxy.FRIEND_REQUEST_ADDED, self.OnRequestChange)
	self:RemoveListener(GAME.FRIEND_SEND_REQUEST_DONE, self.OnAddFriendDone)

	return
end

function IslandFriendPage:OnAddFriendDone()
	if self.pages[var_0_4] and self.pages[var_0_4]:GetLoaded() and self.pages[var_0_4]:isShowing() then
		self.pages[var_0_4]:HideRequestBox()
	end

	return
end

function IslandFriendPage:OnRequestChange()
	if self.pages[var_0_5] and self.pages[var_0_5]:GetLoaded() and self.pages[var_0_5]:isShowing() then
		self.pages[var_0_5]:Flush()
	end

	self:UpdateTip()

	return
end

function IslandFriendPage:OnOtherFetchCntUpdate()
	self:UpdateGiftTxt()

	return
end

function IslandFriendPage:OnDelFriend()
	if self.pages[var_0_1] and self.pages[var_0_1]:GetLoaded() and self.pages[var_0_1]:isShowing() then
		self.pages[var_0_1]:Flush()
	end

	return
end

function IslandFriendPage:OnAccessOp()
	if self.pages[var_0_6] and self.pages[var_0_6]:GetLoaded() and self.pages[var_0_6]:isShowing() then
		self.pages[var_0_6]:Flush()
	end

	local var_11_0 = self.pages[var_0_7]

	if self.pages[var_0_7] and var_11_0:GetLoaded() and var_11_0:isShowing() then
		var_11_0:Flush()
	end

	local var_11_1 = self.pages[var_0_4]

	if self.pages[var_0_4] and var_11_1:GetLoaded() and var_11_1:isShowing() then
		var_11_1:Flush()
	end

	return
end

function IslandFriendPage:OnRefreshInviteCode()
	if self.pages[var_0_8] and self.pages[var_0_8]:GetLoaded() and self.pages[var_0_8]:isShowing() then
		self.pages[var_0_8]:OnRefreshInviteCode()
	end

	return
end

function IslandFriendPage:OnSearch(arg_13_1)
	if self.pages[var_0_4] and self.pages[var_0_4]:GetLoaded() and self.pages[var_0_4]:isShowing() then
		self.pages[var_0_4]:OnSearch(arg_13_1)
	end

	return
end

function IslandFriendPage:OnShowMsg(arg_14_1)
	self:ShowMsgBox({
		content = arg_14_1,
		type = IslandMsgBox.TYPE_WHITOUT_BTN
	})

	return
end

function IslandFriendPage:OnInit()
	onButton(self, self._tf:Find("top/title/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.island_help_friends.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.backBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	self.toggles = {}

	self.uiToggleList:make(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			onToggle(self, arg_18_2, function(arg_19_0)
				if arg_19_0 then
					self:SwitchPage(arg_18_1 + 1)
				end

				return
			end, SF_PANEL)
			setText(arg_18_2:Find("unsel"), var_0_9(arg_18_1 + 1))
			setText(arg_18_2:Find("sel/content/Text"), var_0_9(arg_18_1 + 1))
			setImageSprite(arg_18_2:Find("sel/content/Image"), GetSpriteFromAtlas("ui/IslandFriendUI_atlas", var_0_10(arg_18_1 + 1)), true)
			table.insert(self.toggles, arg_18_2)
		end

		return
	end)
	self.uiToggleList:align(#self.pages)
	self:UpdateTip()

	return
end

function IslandFriendPage:UpdateTip()
	setActive(self.toggles[var_0_5]:Find("tip"), getProxy(NotificationProxy):getRequestCount() > 0)

	return
end

function IslandFriendPage:SwitchPage(arg_21_1)
	if self.page then
		self.page:ExecuteAction("Hide")

		self.page = nil
	end

	local var_21_0 = self.pages[arg_21_1]

	self.pages[arg_21_1]:ExecuteAction("Show")

	self.page = var_21_0

	return
end

function IslandFriendPage:OnShow()
	self:UpdateGiftTxt()
	triggerToggle(self.toggles[var_0_1], true)
	self:BlurPanel()

	return
end

function IslandFriendPage:UpdateGiftTxt()
	local var_23_0 = getProxy(IslandProxy):GetIsland():GetSignInAgency()

	self.giftTipTxt.text = i18n("island_git_cnt_tip") .. var_23_0:GetLeftOtherFetchCnt() .. "/" .. var_23_0:GetMaxOtheFetchcnt()

	return
end

function IslandFriendPage:OnHide()
	self:UnBlurPanel()

	return
end

function IslandFriendPage:OnDisable()
	self:OnHide()

	return
end

function IslandFriendPage:OnDestroy()
	self:UnBlurPanel()

	for iter_26_0, iter_26_1 in ipairs(self.pages) do
		iter_26_1:Destroy()
	end

	self.pages = nil

	return
end

return IslandFriendPage
