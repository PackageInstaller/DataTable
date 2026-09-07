local IslandFriendSearchPage = class("IslandFriendSearchPage", import(".IslandFriendListPage"))
local var_0_1 = 10

function IslandFriendSearchPage:getUIName()
	return "IslandFriendSearchUI"
end

function IslandFriendSearchPage:OnLoaded()
	IslandFriendSearchPage.super.OnLoaded(self)

	self.idTxt = self._tf:Find("top/id/Text"):GetComponent(typeof(Text))
	self.copyBtn = self._tf:Find("top/id/copy")
	self.saerchBtn = self._tf:Find("top/search/copy")
	self.refreshBtn = self._tf:Find("top/refresh")
	self.searchBar = self._tf:Find("top/search/input")
	self.displays = {}

	setText(self._tf:Find("top/id/copy/Text"), i18n("island_btn_label_copy"))
	setText(self._tf:Find("top/search/copy/Text"), i18n("island_search"))
	setText(self._tf:Find("top/search/input/Text"), i18n("island_input_my_id"))
	setText(self._tf:Find("top/id/label"), i18n("island_my_id"))
	setText(self._tf:Find("top/refresh/Text"), i18n("island_visit_set_refresh"))

	self.requestFriendBox = IslandRequestFriendBox.New(self._tf, self.event)

	return
end

function IslandFriendSearchPage:OnSearch(arg_3_1)
	if not arg_3_1.list then
		return
	end

	self.displays = arg_3_1.list

	self:InitList()

	return
end

function IslandFriendSearchPage:CreateCard(arg_4_1)
	return IslandFriendSearchCard.New(arg_4_1)
end

function IslandFriendSearchPage:OnInitItem(arg_5_1)
	IslandFriendSearchPage.super.OnInitItem(self, arg_5_1)

	local var_5_0 = self.cards[arg_5_1]

	onButton(self, self.cards[arg_5_1].addBtn, function()
		self.requestFriendBox:ExecuteAction("Show", var_5_0.player.id)

		return
	end, SFX_PANEL)

	return
end

function IslandFriendSearchPage:InitMoreBtns(arg_7_1)
	onButton(self, self.whiteBtn, function()
		self:emit(IslandMediator.ADD_WHITE_LIST, arg_7_1.id)

		return
	end, SFX_PANEL)
	onButton(self, self.blackBtn, function()
		self:emit(IslandMediator.ADD_BLACK_LIST, arg_7_1.id)

		return
	end, SFX_PANEL)

	return
end

function IslandFriendSearchPage:GetData(arg_10_1)
	arg_10_1(self.displays)

	return
end

function IslandFriendSearchPage:OnInit()
	IslandFriendSearchPage.super.OnInit(self)

	self.player = getProxy(PlayerProxy):getRawData()
	self.idTxt.text = self.player.id

	onButton(self, self.copyBtn, function()
		UniPasteBoard.SetClipBoardString(self.player.id)
		pg.TipsMgr.GetInstance():ShowTips(i18n("friend_id_copy_ok"))

		return
	end, SFX_PANEL)
	onButton(self, self.saerchBtn, function()
		local var_13_0 = pg.TimeMgr.GetInstance():GetServerTime()

		if self.waitTimer and self.waitTimer - var_13_0 > 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("friend_searchFriend_wait_time", self.waitTimer - var_13_0))

			return
		end

		self.waitTimer = var_13_0 + var_0_1

		local var_13_1 = getInputText(self.searchBar)

		if not var_13_1 or var_13_1 == "" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("friend_inpout_key_tip"))

			return
		end

		self:emit(IslandMediator.SEARCH_FRIEND, SearchFriendCommand.SEARCH_TYPE_FRIEND, var_13_1)

		return
	end, SFX_PANEL)
	onButton(self, self.refreshBtn, function()
		local var_14_0 = pg.TimeMgr.GetInstance():GetServerTime()

		if self.waitTimer and self.waitTimer - var_14_0 > 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("friend_searchFriend_wait_time", self.waitTimer - var_14_0))

			return
		end

		self.waitTimer = var_14_0 + var_0_1

		self:emit(IslandMediator.SEARCH_FRIEND, SearchFriendCommand.SEARCH_TYPE_LIST, "")

		return
	end, SFX_PANEL)
	self:emit(IslandMediator.SEARCH_FRIEND, SearchFriendCommand.SEARCH_TYPE_LIST, "")

	return
end

function IslandFriendSearchPage:HideRequestBox()
	self.requestFriendBox:ExecuteAction("Hide")

	return
end

function IslandFriendSearchPage:OnDestroy()
	IslandFriendSearchPage.super.OnDestroy(self)

	if self.requestFriendBox then
		self.requestFriendBox:Destroy()

		self.requestFriendBox = nil
	end

	return
end

return IslandFriendSearchPage
