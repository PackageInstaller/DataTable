local PlotReplayReviewLayer = class("PlotReplayReviewLayer", require("app.fairyGUI.plotReplay.UI_PlotReplayReviewLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/plotReplay/plotReplay",
		resName = "PlotReplayReviewLayer",
		pkgName = "plotReplay"
	}, ...)
end)

PlotReplayReviewLayer.STATE_IN_STAGE = 1
PlotReplayReviewLayer.STATE_NOT_STAGE = 0

function PlotReplayReviewLayer:ctor(arg_2_1)
	self:_init()
	self:onUpdateView(arg_2_1)
end

function PlotReplayReviewLayer:_init()
	self.m_stageList:setVirtual()
	self.m_stageList:doFairyBatching(false)
	self.m_stageList:setItemRendererAsync1(handler(self, self._onStageItemRender))
	self.m_stageList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickItem))
	self.m_playBtn:addClickListener(handler(self, self._onPlayBtnClick))
end

function PlotReplayReviewLayer:onUpdateView(arg_4_1)
	self._args = arg_4_1
	self._info = arg_4_1.info
	self._storyList = self._info.storys or {}
	self._type = 1
	self._chapterId = 1
	self._btnList = {}
	self._stageSelectIndex = 1

	if arg_4_1 then
		self._type = arg_4_1.type or self._type
		self._chapterId = arg_4_1.scrollId or self.scrollId
	end

	self._openNum = g.core.model.User.plotReplayReviewData:getChapterStageNumInfo(self._type, self._chapterId)
	self._curSelectIndex = self._type - 1

	self.m_stageList:setNumItems(#self._storyList)
	self.m_stageList:setSelectedIndex(self._stageSelectIndex - 1)
	self:_onClickItem()
end

function PlotReplayReviewLayer:_onStageItemRender(arg_5_1, arg_5_2)
	arg_5_2:updateView({
		index = arg_5_1,
		type = self._type,
		story = self._storyList[arg_5_1 + 1]
	})
end

function PlotReplayReviewLayer:_onClickItem()
	local var_6_0 = self.m_stageList:getSelectedIndex() + 1

	if var_6_0 > self._openNum and self._type ~= 3 then
		g.core.module.ModuleManager:tip(self._storyList[var_6_0 - 1].lockDesc)
		self.m_stageList:setSelectedIndex(self._stageSelectIndex - 1)

		return
	end

	self._stageSelectIndex = var_6_0

	self.m_bigLabel:setIcon((g.core.model.User.storyData:getBackgroundURL(self._storyList[var_6_0].storyId)))
end

function PlotReplayReviewLayer:playExitAnim(arg_7_1)
	self.m_backTransition:play(arg_7_1)
end

function PlotReplayReviewLayer:_resetPage(arg_8_1)
	self._stageSelectIndex = 1
	self._chapterId = arg_8_1
	self._openNum = g.core.model.User.plotReplayReviewData:getChapterStageNumInfo(self._type, self._chapterId)
	self._info = g.core.model.User.plotReplayReviewData:getReplayCellInfo(self._type, self._chapterId)
	self._storyList = self._info.storys or {}

	self.m_stageList:setNumItems(#self._storyList)
	self.m_stageList:setSelectedIndex(self._stageSelectIndex - 1)
	self:_onClickItem()
end

function PlotReplayReviewLayer:_onPlayBtnClick()
	local var_9_0 = self._storyList[self.m_stageList:getSelectedIndex() + 1]

	if var_9_0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_STORY_FORCE_START, false, {
			id = var_9_0.storyId
		})
	end
end

function PlotReplayReviewLayer:playEnterAnim()
	self.m_enterTransition:play()
end

return PlotReplayReviewLayer
