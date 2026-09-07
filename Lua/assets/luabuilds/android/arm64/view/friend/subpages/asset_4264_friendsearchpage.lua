local FriendSearchPage = class("FriendSearchPage", import("...base.BaseSubView"))
local var_0_1 = 10

function FriendSearchPage:getUIName()
	return "FriendSearchUI"
end

function FriendSearchPage:OnLoaded()
	self.addPanel = self._tf:Find("add_panel")
	self.searchPanel = self.addPanel:Find("search_panel")
	self.searchBar = self.searchPanel:Find("InputField")

	return
end

function FriendSearchPage:OnInit()
	onButton(self, findTF(self.searchPanel, "copy_btn"), function()
		UniPasteBoard.SetClipBoardString(self.playerVO.id)
		pg.TipsMgr.GetInstance():ShowTips(i18n("friend_id_copy_ok"))

		return
	end)
	onButton(self, findTF(self.searchPanel, "search_btn"), function()
		local var_5_0 = pg.TimeMgr.GetInstance():GetServerTime()

		if self.waitTimer and self.waitTimer - var_5_0 > 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("friend_searchFriend_wait_time", self.waitTimer - var_5_0))

			return
		end

		self.waitTimer = var_5_0 + var_0_1

		local var_5_1 = getInputText(self.searchBar)

		if not var_5_1 or var_5_1 == "" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("friend_inpout_key_tip"))

			return
		end

		self.keyWord = var_5_1

		self:emit(FriendMediator.SEARCH_FRIEND, 3, var_5_1)

		return
	end)
	onButton(self, findTF(self.searchPanel, "refresh_btn"), function()
		local var_6_0 = pg.TimeMgr.GetInstance():GetServerTime()

		if self.waitTimer1 and self.waitTimer1 - var_6_0 > 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("friend_searchFriend_wait_time", self.waitTimer1 - var_6_0))

			return
		end

		self.waitTimer1 = var_6_0 + var_0_1

		self:emit(FriendMediator.SEARCH_FRIEND, 1, self.keyWord)

		return
	end)

	return
end

function FriendSearchPage:UpdateData(arg_7_1)
	self.searchFriendVOs = arg_7_1.searchResults or {}
	self.playerVO = arg_7_1.playerVO

	if not self.isInit then
		self.isInit = true

		self:initAddPage()
		self:emit(FriendMediator.SEARCH_FRIEND, 1)
	else
		self:sortSearchResult()
	end

	return
end

function FriendSearchPage:sortSearchResult()
	self.addRect:SetTotalCount(#self.searchFriendVOs, -1)

	return
end

function FriendSearchPage:initAddPage()
	self.searchItems = {}

	setText(self.searchPanel:Find("self_id_bg/Text"), self.playerVO.id)

	self.addRect = self.addPanel:Find("mask/view"):GetComponent("LScrollRect")

	function self.addRect.onInitItem(arg_10_0)
		self:onInitItem(arg_10_0)

		return
	end

	function self.addRect.onUpdateItem(arg_11_0, arg_11_1)
		self:onUpdateItem(arg_11_0, arg_11_1)

		return
	end

	return
end

function FriendSearchPage:onInitItem(arg_12_1)
	local var_12_0 = FriendSearchCard.New(arg_12_1)

	onButton(self, var_12_0.addBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			yesText = "text_apply",
			hideNo = true,
			type = MSGBOX_TYPE_INPUT,
			placeholder = i18n("friend_request_msg_placeholder"),
			title = i18n("friend_request_msg_title"),
			onYes = function(arg_14_0)
				self:emit(FriendMediator.ADD_FRIEND, var_12_0.friendVO.id, arg_14_0)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, var_12_0.resumeBtn, function()
		self:emit(FriendMediator.OPEN_RESUME, var_12_0.friendVO.id)

		return
	end, SFX_PANEL)

	self.searchItems[arg_12_1] = var_12_0

	return
end

function FriendSearchPage:onUpdateItem(arg_16_1, arg_16_2)
	if not self.searchItems[arg_16_2] then
		self:onInitItem(arg_16_2)
	end

	self.searchItems[arg_16_2]:update(self.searchFriendVOs[arg_16_1 + 1])

	return
end

function FriendSearchPage:OnDestroy()
	for iter_17_0, iter_17_1 in pairs(self.searchItems or {}) do
		iter_17_1:dispose()
	end

	return
end

return FriendSearchPage
