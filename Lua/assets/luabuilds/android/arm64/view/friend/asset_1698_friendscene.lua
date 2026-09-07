local FriendScene = class("FriendScene", import("..base.BaseUI"))

FriendScene.FRIEND_PAGE = 1
FriendScene.SEARCH_PAGE = 2
FriendScene.REQUEST_PAGE = 3
FriendScene.BLACKLIST_PAGE = 4

function FriendScene:getUIName()
	return "FriendUI"
end

function FriendScene:setFriendVOs(arg_2_1)
	self.friendVOs = arg_2_1

	return
end

function FriendScene:setPlayer(arg_3_1)
	self.playerVO = arg_3_1

	return
end

function FriendScene:setRequests(arg_4_1)
	self.requestVOs = arg_4_1

	return
end

function FriendScene:setSearchResult(arg_5_1)
	self.searchResultVOs = arg_5_1

	return
end

function FriendScene:removeSearchResult(arg_6_1)
	self:setSearchResult((_.select(self.searchResultVOs, function(arg_7_0)
		return arg_7_0.id ~= arg_6_1
	end)))

	return
end

function FriendScene:setBlackList(arg_8_1)
	if arg_8_1 then
		self.blackVOs = {}

		for iter_8_0, iter_8_1 in pairs(arg_8_1 or {}) do
			table.insert(self.blackVOs, iter_8_1)
		end
	end

	return
end

function FriendScene:init()
	self.pages = self._tf:Find("pages")
	self.togglesTF = self._tf:Find("blur_panel/adapt/left_length/frame/tagRoot")
	self.pages = {
		FriendListPage.New(self.pages, self.event, self.contextData),
		FriendSearchPage.New(self.pages, self.event),
		FriendRequestPage.New(self.pages, self.event),
		FriendBlackListPage.New(self.pages, self.event)
	}
	self.toggles = {}

	for iter_9_0 = 1, self.togglesTF.childCount do
		self.toggles[iter_9_0] = self.togglesTF:GetChild(iter_9_0 - 1)

		onToggle(self, self.toggles[iter_9_0], function(arg_10_0)
			if arg_10_0 then
				self:switchPage(iter_9_0)
			end

			return
		end, SFX_PANEL)
	end

	self.chatTipContainer = self.toggles[1]:Find("count")
	self.chatTip = self.toggles[1]:Find("count/Text"):GetComponent(typeof(Text))
	self.listEmptyTF = self._tf:Find("empty")

	setActive(self.listEmptyTF, false)

	self.listEmptyTxt = self.listEmptyTF:Find("Text")

	return
end

function FriendScene:didEnter()
	onButton(self, self._tf:Find("blur_panel/adapt/top/back_btn"), function()
		self:emit(FriendScene.ON_BACK)

		return
	end, SOUND_BACK)
	triggerToggle(self.toggles[self.contextData.initPage or 1], true)
	self:updateRequestTip()

	return
end

function FriendScene:wrapData()
	return {
		friendVOs = self.friendVOs,
		requestVOs = self.requestVOs,
		searchResults = self.searchResultVOs,
		blackVOs = self.blackVOs,
		playerVO = self.playerVO
	}
end

function FriendScene:updateEmpty(arg_14_1, arg_14_2)
	local var_14_0 = {}
	local var_14_1 = ""

	if arg_14_1 == FriendScene.FRIEND_PAGE then
		var_14_0 = arg_14_2.friendVOs
		var_14_1 = i18n("list_empty_tip_friendui")
	elseif arg_14_1 == FriendScene.SEARCH_PAGE then
		var_14_0 = arg_14_2.searchResults
		var_14_1 = i18n("list_empty_tip_friendui_search")
	elseif arg_14_1 == FriendScene.REQUEST_PAGE then
		var_14_0 = arg_14_2.requestVOs
		var_14_1 = i18n("list_empty_tip_friendui_request")
	elseif arg_14_1 == FriendScene.BLACKLIST_PAGE then
		var_14_0 = arg_14_2.blackVOs
		var_14_1 = i18n("list_empty_tip_friendui_black")
	end

	setActive(self.listEmptyTF, not var_14_0 or #var_14_0 <= 0)
	setText(self.listEmptyTxt, var_14_1)

	return
end

function FriendScene:switchPage(arg_15_1)
	if self.page then
		self.page:ExecuteAction("Hide")
	end

	local var_15_0 = self.pages[arg_15_1]
	local var_15_1 = self:wrapData()

	self.pages[arg_15_1]:ExecuteAction("Show")
	var_15_0:ExecuteAction("UpdateData", var_15_1)

	self.page = var_15_0

	self:updateEmpty(arg_15_1, var_15_1)

	return
end

function FriendScene:updatePage(arg_16_1)
	if self.page and self.pages[arg_16_1] == self.page then
		local var_16_0 = self:wrapData()

		self.page:ExecuteAction("UpdateData", var_16_0)
		self:updateEmpty(arg_16_1, var_16_0)
	end

	return
end

function FriendScene:updateChatNotification(arg_17_1)
	setActive(self.chatTipContainer, arg_17_1 > 0)

	self.chatTip.text = arg_17_1

	return
end

function FriendScene:updateRequestTip()
	setActive(self.toggles[3]:Find("tip"), #self.requestVOs > 0)

	return
end

function FriendScene:closeInfromPanel()
	if not self.pages[3] then
		return
	end

	self.pages[3]:closeInfromPanel()

	return
end

function FriendScene:willExit()
	for iter_20_0, iter_20_1 in ipairs(self.pages) do
		iter_20_1:Destroy()
	end

	return
end

return FriendScene
