-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryHistoryViewComponent.lua

module("logic.extensions.story.view.StoryHistoryViewComponent", package.seeall)

local M = class("StoryHistoryViewComponent", ViewComponent)

function M:buildUI()
	self._historyObj = self:getGo("story_main_view_498561239")
	self._btnClose = self:getBtn("story_main_view_1875930441")
	self._dialogRootGo = self:getGo("story_main_view_-233468769")
	self._normalOptGo = self:getGo("story_main_view_-719354965")
	self._attrOptGo = self:getGo("story_main_view_1795691225")
	self._loopListHelper = LoopListHelper.New(self:getGo("story_main_view_237475292"))

	self._loopListHelper:InitListView(0, self._updateHistoryData, self)
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._clickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self:registerLocalNotify(StoryNotifyName.ShowHistoy, self._onShow, self)
end

function M:_onShow(evt)
	self._hasNormalOpt = self._normalOptGo.activeSelf
	self._hasAttrOpt = self._attrOptGo.activeSelf

	self:setVisible(true)
end

function M:setVisible(visible)
	if self._delayTween then
		self._delayTween:Kill(false)
	end

	self._delayTween = nil

	goutil.setActive(self._historyObj, visible)
	goutil.setActive(self._dialogRootGo, not visible)

	if self._hasNormalOpt then
		goutil.setActive(self._normalOptGo, not visible)
	end

	if self._hasAttrOpt then
		goutil.setActive(self._attrOptGo, not visible)
	end

	if visible then
		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_window_history_open)

		local maxCount = #StoryModel.instance:getHistory()

		self._curSelectIndex = maxCount

		self._loopListHelper:SetListItemCount(maxCount, false)

		self._delayTween = DoTweenUtil.DelayedCall(0, function()
			self._loopListHelper:MoveToItemIndex(maxCount - 1)
		end)
	else
		self._loopListHelper:ClearCells()

		self._curSelectIndex = nil
	end
end

function M:_updateHistoryData(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopListHelper:NewListViewItem("story_historycell")
	local historyList = StoryModel.instance:getHistory()
	local historyData = historyList[curIndex]
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, StoryHistoryItem)

	shower:setHistoryCell(historyData, curIndex)
	shower:setClickCallBack(self._clickHistoryItem, self)
	shower:setSelectState(self._curSelectIndex == curIndex)

	return item
end

function M:_clickHistoryItem(index, storyIndex, playVoice)
	self._curSelectIndex = index

	StoryDispatcher:dispatchEvent(StoryNotifyName.OnSelectHistory, index, storyIndex, playVoice)
end

function M:_clickClose()
	self:setVisible(false)
	CriwareAudioFacade.instance:stopVoice()
end

function M:onExit()
	if self._delayTween then
		self._delayTween:Kill(false)
	end

	self._delayTween = nil

	self:unregisterLocalNotify(StoryNotifyName.ShowHistoy, self._onShow, self)

	self._hasNormalOpt = false
	self._hasAttrOpt = false
end

function M:destroyUI()
	self._loopListHelper:Dispose()

	self._loopListHelper = nil
end

function M:destroyUI()
	return
end

function M:_onClickCloseHistory()
	goutil.setActive(self.go_dialog, true)
	goutil.setActive(self.go_rtBtnList, true)
	goutil.setActive(self.memory_panel, false)
end

return M
