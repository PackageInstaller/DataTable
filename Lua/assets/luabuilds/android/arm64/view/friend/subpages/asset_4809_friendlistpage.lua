local FriendListPage = class("FriendListPage", import("...base.BaseSubView"))

function FriendListPage:getUIName()
	return "FriendListUI"
end

function FriendListPage:OnLoaded()
	self.friendPanel = self._tf:Find("friend_panel")
	self.friendTopTF = self._tf:Find("friend_view_top")
	self.friendCountTF = self.friendTopTF:Find("friend_count/Text")
	self.friendIndexBtn = self.friendTopTF:Find("index_button")
	self.friendSortBtn = self.friendTopTF:Find("sort_button")
	self.sortImgAsc = self.friendSortBtn:Find("asc")
	self.sortImgDec = self.friendSortBtn:Find("desc")
	self.sortPanel = self._tf:Find("friend_sort_panel")

	return
end

function FriendListPage:OnInit()
	self.dec = false
	self.sortdata = {}

	onButton(self, self.friendSortBtn, function()
		self.dec = not self.dec
		self.contextData.sortData = {
			data = self.sortdata,
			dec = self.dec
		}

		self:sortFriends()

		return
	end, SFX_PANEL)
	onButton(self, self.friendIndexBtn, function()
		self:openFriendsSortPanel()

		return
	end, SFX_PANEL)

	return
end

function FriendListPage:UpdateData(arg_6_1)
	self.friendVOs = arg_6_1.friendVOs or {}

	if not self.isInit then
		self.isInit = true

		self:initFriendsPage()
		self:initFriendsSortPanel()
	else
		self:sortFriends()
	end

	self:updateFriendCount()

	return
end

function FriendListPage:initFriendsPage()
	self.friendItems = {}
	self.friendRect = self.friendPanel:Find("mask/view"):GetComponent("LScrollRect")

	function self.friendRect.onInitItem(arg_8_0)
		self:onInitItem(arg_8_0)

		return
	end

	function self.friendRect.onUpdateItem(arg_9_0, arg_9_1)
		self:onUpdateItem(arg_9_0, arg_9_1)

		return
	end

	return
end

function FriendListPage:onInitItem(arg_10_1)
	local var_10_0 = FriendListCard.New(arg_10_1)

	onButton(self, var_10_0.occuptBtn, function()
		self:emit(FriendMediator.OPEN_CHATROOM, var_10_0.friendVO)

		return
	end, SFX_PANEL)
	onButton(self, var_10_0.deleteBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("remove_friend_tip"),
			onYes = function()
				self:emit(FriendMediator.DELETE_FRIEND, var_10_0.friendVO.id)

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, var_10_0.resumeBtn, function()
		self:emit(FriendMediator.OPEN_RESUME, var_10_0.friendVO.id)

		return
	end, SFX_PANEL)
	onButton(self, var_10_0.backYardBtn, function()
		self:emit(FriendMediator.VISIT_BACKYARD, var_10_0.friendVO.id)

		return
	end, SFX_PANEL)

	self.friendItems[arg_10_1] = var_10_0

	return
end

function FriendListPage:onUpdateItem(arg_16_1, arg_16_2)
	if not self.friendItems[arg_16_2] then
		self:onInitItem(arg_16_2)
	end

	self.friendItems[arg_16_2]:update(self.friendVOs[arg_16_1 + 1])

	return
end

function FriendListPage:sortFriends()
	if self.contextData.sortData then
		self.contextData.sortData.data.func(self.friendVOs, self.dec)
		setImageSprite(self.friendIndexBtn:Find("icon"), GetSpriteFromAtlas("ui/friendsui_atlas", self.contextData.sortData.data.spr), true)
		setActive(self.sortImgAsc, self.dec)
		setActive(self.sortImgDec, not self.dec)
	end

	self.friendRect:SetTotalCount(#self.friendVOs, -1)

	return
end

function FriendListPage:updateFriendCount()
	setText(self.friendCountTF, #self.friendVOs .. "/" .. MAX_FRIEND_COUNT)

	return
end

function FriendListPage:initFriendsSortPanel()
	local var_19_0 = self.sortPanel:Find("mask/content")
	local var_19_1 = self:getTpl("tpl", var_19_0)

	self.friendSortCfg = require("view.friend.FriendSortCfg")

	for iter_19_0, iter_19_1 in ipairs(self.friendSortCfg.SORT_TAG) do
		local var_19_2 = cloneTplTo(var_19_1, var_19_0)
		local var_19_3 = var_19_2:Find("arr")

		setImageSprite(var_19_2:Find("Image"), GetSpriteFromAtlas("ui/friendsui_atlas", iter_19_1.spr), true)
		onToggle(self, var_19_2, function(arg_20_0)
			if arg_20_0 then
				self.sortdata = iter_19_1
				self.contextData.sortData = {
					data = self.sortdata,
					dec = self.dec
				}

				self:sortFriends()
				triggerButton(self.sortPanel)
			end

			return
		end, SFX_PANEL)

		if iter_19_0 == 1 then
			triggerToggle(var_19_2, true)
		end
	end

	onButton(self, self.sortPanel, function()
		self:closeFriendsSortPanel()

		return
	end, SFX_PANEL)

	return
end

function FriendListPage:openFriendsSortPanel()
	if self.contextData.sortData then
		setImageSprite(self.sortPanel:Find("index_button/icon"), GetSpriteFromAtlas("ui/friendsui_atlas", self.contextData.sortData.data.spr), true)
	end

	setActive(self.sortPanel, true)

	return
end

function FriendListPage:closeFriendsSortPanel()
	setActive(self.sortPanel, false)

	return
end

function FriendListPage:OnDestroy()
	for iter_24_0, iter_24_1 in pairs(self.friendItems or {}) do
		iter_24_1:dispose()
	end

	return
end

return FriendListPage
