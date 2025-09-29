-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/search/SearchFragmentView.lua

module("logic.extensions.friend.view.search.SearchFragmentView", package.seeall)

local M = class("SearchFragmentView", StaticFragmentView)

M.Mode = {
	Apply = 1,
	Search = 2
}

function M:ctor(...)
	M.super.ctor(self, ...)

	self._mode = M.Mode.Apply
	self._relationType = GameEnum.RelationTypeEnum.BeApply
end

function M:buildUI()
	self._tipsPosGo = self:getGo("friend_main_view_2094539140")
	self._normalGo = self:getGo("friend_main_view_1621062872")
	self._emptyGo = self:getGo("friend_main_view_50794878")

	local scrollGo = self:getGo("friend_main_view_-1927989127")

	self._loopList = LoopListHelper.New(scrollGo)

	self._loopList:InitListView(0, self._updateCell, self)

	self._inputField = self:getInput("friend_main_view_1250850531")
	self._btnSearch = self:getBtn("friend_main_view_1611507487")
	self._btnPaste = self:getBtn("friend_main_view_1492186691")
	self._btnEmpty = self:getBtn("friend_main_view_7705971")
	self._btnAllRefuse = self:getBtn("friend_main_view_137899134")
	self._btnAllAgree = self:getBtn("friend_main_view_-1278726329")
end

function M:destroyUI()
	return
end

function M:_bindEvents()
	self._inputField:AddOnValueChanged(self._onInputValueChange, self)
	self._inputField:AddOnEndEdit(self._onInputValueChangeEnd, self)
	self._btnSearch:AddClickListener(self._onClickBtnSearch, self)
	self._btnPaste:AddClickListener(self._onClickBtnPaste, self)
	self._btnEmpty:AddClickListener(self._onClickBtnEmpty, self)
	self._btnAllRefuse:AddClickListener(self._onClickBtnAllRefuse, self)
	self._btnAllAgree:AddClickListener(self._onClickBtnAllAgree, self)
	GlobalDispatcher:addEventListener(EventType.UPDATE_FRIEND_APPLY_LIST, self._refreshApply, self)
	GlobalDispatcher:addEventListener(EventType.UPDATE_SEARCH_RESULT, self._onSearchResult, self)
	GlobalDispatcher:addEventListener(EventType.FRIEND_APPLY_SUCCESS, self._onApplySuccess, self)
	GlobalDispatcher:addEventListener(EventType.FRIEND_AGREE_APPLY_SUCCESS, self._refreshApply, self)
	GlobalDispatcher:addEventListener(EventType.FRIEND_REFUSE_APPLY_SUCCESS, self._refreshApply, self)
	GlobalDispatcher:addEventListener(EventType.FRIEND_BLOCK_SUCCESS, self._refreshApply, self)
end

function M:_unbindEvents()
	self._inputField:RemoveOnValueChanged()
	self._inputField:RemoveOnEndEdit()
	self._btnSearch:RemoveClickListener()
	self._btnPaste:RemoveClickListener()
	self._btnEmpty:RemoveClickListener()
	self._btnAllRefuse:RemoveClickListener()
	self._btnAllAgree:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.UPDATE_FRIEND_APPLY_LIST, self._refreshApply, self)
	GlobalDispatcher:removeEventListener(EventType.UPDATE_SEARCH_RESULT, self._onSearchResult, self)
	GlobalDispatcher:removeEventListener(EventType.FRIEND_APPLY_SUCCESS, self._onApplySuccess, self)
	GlobalDispatcher:removeEventListener(EventType.FRIEND_AGREE_APPLY_SUCCESS, self._refreshApply, self)
	GlobalDispatcher:removeEventListener(EventType.FRIEND_REFUSE_APPLY_SUCCESS, self._refreshApply, self)
	GlobalDispatcher:removeEventListener(EventType.FRIEND_BLOCK_SUCCESS, self._refreshApply, self)
end

function M:onEnter()
	self:_bindEvents()
	FriendModel.instance:clearSearchResult()
	self._inputField:SetText("")
	self:_setMode(M.Mode.Apply)
	self:_refreshApply()
	FriendAgent.instance:sendGetUserListRequest(self._relationType)
	FriendAgent.instance:sendGetUserListRequest(GameEnum.RelationTypeEnum.Block)
end

function M:onExit()
	self:_unbindEvents()
end

function M:_setMode(mode)
	self._mode = mode
end

function M:_getMode()
	return self._mode
end

function M:_onSearchResult(_, needShowTips)
	local searchResult = FriendModel.instance:getSearchResult()

	if #searchResult == 0 and needShowTips then
		FloatWordMgr.instance:show(lang("tip_not_search_player"))
		self:_setMode(M.Mode.Apply)
		self:_refreshApply()
	else
		self:_setMode(M.Mode.Search)
		self:_refreshSearchResult(searchResult)
	end
end

function M:_onApplySuccess()
	local searchResult = FriendModel.instance:getSearchResult()

	self:_refreshSearchResult(searchResult)
end

function M:_refreshSearchResult(searchResult)
	if self:_getMode() ~= M.Mode.Search then
		return
	end

	self._moList = searchResult

	self:_refreshView()
end

function M:_refreshApply()
	if self:_getMode() ~= M.Mode.Apply then
		return
	end

	self._moList = FriendModel.instance:getMoList(self._relationType)

	self:_refreshView()
end

function M:_refreshView()
	local itemCount = #self._moList

	self._loopList:SetListItemCount(itemCount)
	self._loopList:RefreshAllShownItem()
	self._emptyGo:SetActive(itemCount == 0)
	self._normalGo:SetActive(itemCount > 0)
	self._btnAllAgree.gameObject:SetActive(self:_getMode() == M.Mode.Apply and itemCount > 0)
	self._btnAllRefuse.gameObject:SetActive(self:_getMode() == M.Mode.Apply and itemCount > 0)
end

function M:_updateCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopList:NewListViewItem("friend_item")
	local itemView = Astral.LuaComponentContainer.Add(item.gameObject, SearchItemCell)

	itemView:setTipsPosGo(self._tipsPosGo)

	local mo = self._moList[curIndex]

	itemView:updateData(mo)

	return item
end

function M:_onInputValueChange()
	local inputText = self._inputField:GetText()

	self._btnPaste.gameObject:SetActive(string.nilorempty(inputText))
	self._btnEmpty.gameObject:SetActive(not string.nilorempty(inputText))
end

function M:_onInputValueChangeEnd()
	if string.nilorempty(self._inputField:GetText()) and self:_getMode() ~= M.Mode.Apply then
		self:_setMode(M.Mode.Apply)
		self:_refreshApply()
		GlobalDispatcher:dispatchEvent(EventType.FRIEND_SEARCH_CLEAR)
	end
end

function M:_onClickBtnEmpty()
	self._inputField:SetText("")

	if self:_getMode() ~= M.Mode.Apply then
		self:_setMode(M.Mode.Apply)
		self:_refreshApply()
		GlobalDispatcher:dispatchEvent(EventType.FRIEND_SEARCH_CLEAR)
	end
end

function M:_onClickBtnPaste()
	self._inputField:SetText(TextUtils.GetClipboard())
end

function M:_onClickBtnSearch()
	if string.nilorempty(self._inputField:GetText()) then
		return
	end

	FriendAgent.instance:sendSearchUserRequest(self._inputField:GetText(), 0)
end

function M:_onClickBtnAllAgree()
	local cur = FriendModel.instance:getUserCountByType(GameEnum.RelationTypeEnum.Friend)
	local max = ConstConfig.instance:getNumValueByKey("MaxFriendNum")

	if max <= cur then
		FloatWordMgr.instance:show("您的好友已满，无法添加")

		return
	end

	local userIdList = {}

	for _, friendMo in ipairs(self._moList) do
		table.insert(userIdList, friendMo:getUserId())
	end

	FriendAgent.instance:sendAgreeApplyRequest(userIdList)
end

function M:_onClickBtnAllRefuse()
	local userIdList = {}

	for _, friendMo in ipairs(self._moList) do
		table.insert(userIdList, friendMo:getUserId())
	end

	FriendAgent.instance:sendRefuseApplyRequest(userIdList)
end

return M
