-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/boccacciochapter/view/BoccaccioChapterStoryView.lua

module("logic.extensions.boccacciochapter.view.BoccaccioChapterStoryView", package.seeall)

local BoccaccioChapterStoryView = class("BoccaccioChapterStoryView", ViewComponent)

function BoccaccioChapterStoryView:ctor()
	BoccaccioChapterStoryView.super.ctor(self)
end

function BoccaccioChapterStoryView:unbindEvents()
	BoccaccioChapterStoryView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function BoccaccioChapterStoryView:bindEvents()
	BoccaccioChapterStoryView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function BoccaccioChapterStoryView:buildUI()
	BoccaccioChapterStoryView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local cellGo = self:getGo("com/cell")
	local tableviewGo = self:getGo("com/tableview")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function BoccaccioChapterStoryView:onExit()
	BoccaccioChapterStoryView.super.onExit(self)
	self._tableview:dispose()
end

function BoccaccioChapterStoryView:onEnter()
	BoccaccioChapterStoryView.super.onEnter(self)

	self._unLockIdMap = {}
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 580001
	end

	local subMo = BoccaccioChapterController.instance:getSubMo(self._activityId)

	if subMo then
		local hasUnlockPlotIds = subMo:getHasUnlockPlotIds() or {}

		for _, plotId in pairs(hasUnlockPlotIds) do
			self._unLockIdMap[plotId] = true
		end
	end

	self._storyCfgs = BoccaccioChapterConfig.instance:getPlotDatas(self._activityId) or {}

	self._tableview:reloadData(self._storyCfgs)
end

function BoccaccioChapterStoryView:_onClickStroy(plotId)
	local isUnlock = self._unLockIdMap[plotId]

	if isUnlock then
		local cfg = self._storyCfgs[plotId]

		GlobalDispatcher:dispatch(GlobalNotify.PushStory, cfg.storyId, StoryModel.StoryType.SCCopy)
	else
		FloatWordMgr.instance:show("此剧情未解锁，不可观看")
	end
end

function BoccaccioChapterStoryView:_updateCell(view, cell, data)
	local txtTitle = goutil.findChildTextComponent(cell.gameObject, "txtTitle")
	local btn = goutil.findChild(cell.gameObject, "btn")

	txtTitle.text = data.title

	GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickStroy, self, data.plotId))

	local goLock = goutil.findChild(cell.gameObject, "lock")

	goutil.setActive(goLock, not self._unLockIdMap[data.plotId])
end

function BoccaccioChapterStoryView:_clearCell(cell)
	local btn = goutil.findChild(cell.gameObject, "btn")

	GameUtil.rmClickHandler(btn)
end

return BoccaccioChapterStoryView
