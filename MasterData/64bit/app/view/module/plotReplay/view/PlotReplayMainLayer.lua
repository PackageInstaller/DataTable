local PlotReplayMainLayer = class("PlotReplayMainLayer", require("app.fairyGUI.plotReplay.UI_PlotReplayMainLayer"), function()
	return fgui.GComponent:create({
		resName = "PlotReplayMainLayer",
		pkgName = "plotReplay",
		isFullScreen = true,
		pkgPath = "ui/plotReplay/plotReplay"
	}, ...)
end)

PlotReplayMainLayer.STATE_IN_STAGE = 1
PlotReplayMainLayer.STATE_NOT_STAGE = 0

local var_0_1 = g.core.model.User.plotReplayReviewData

function PlotReplayMainLayer:ctor()
	self._stageState = PlotReplayMainLayer.STATE_NOT_STAGE
	self._curSelectIndex = 1
	self._cellClickIdx = 1
	self._btnList = {}
	self._curShowNum = 0
	self._pageState = 0
	self._listPos = self.m_stageList:getPosition()
	self._listOutTrans = self:getSharedTrans("listReplayUiDownOut01", "PlotReplayList", self.m_stageList)

	self:_init()
	self:addBg("bg/illustration/bg_cls_huiyiliebiao.jpg")
end

function PlotReplayMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_STORY_COMPLETION_AWARD, handler(self, self._onRcvProfileAward), self)
	g.core.network.GameNetProxy:send_C2S_ThemePV_GetInfo({})
	g.core.network.GameNetProxy:send_C2S_StoryCompletion_GetInfo({})
	self:_onTabCompChanged()
end

function PlotReplayMainLayer:_init()
	var_0_1:updateUnlockData()
	self.m_tabStateController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabCompChanged))
	self.m_stageList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onCellItemClick))
	self.m_topBar:setResInfoById(2)
	self.m_stageList:setVirtual()
	self.m_stageList:doFairyBatching(false)
	self.m_stageList:setItemRenderer(handler(self, self._onStageItemRender))

	self._changePage = false

	self.m_tabStateController:setSelectedIndex(1)
	self.m_tabStateController:setSelectedIndex(0)

	for iter_4_0 = 1, 2 do
		if self["m_tabBtn" .. iter_4_0] then
			self["m_tabBtn" .. iter_4_0]:addClickListener(handler(self, self._onTabBtnClick))
		end
	end

	self.m_tabBtn4:setVisible((var_0_1:getReplayCellNum(3) or 0) > 0)
	self.m_tabBtn3:setVisible(g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.DAILY_PROFILE))
end

function PlotReplayMainLayer:_onRcvProfileAward(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_4.awards then
		g.core.module.ModuleManager:awardSummary(arg_5_4.awards)
	end
end

function PlotReplayMainLayer:_onTabCompChanged()
	self:_onMainPagePlayAnim()
end

function PlotReplayMainLayer:_onMainPagePlayAnim()
	self:_playShowAnim()
end

function PlotReplayMainLayer:_playShowAnim()
	self.m_stageList:setPosition(self._listPos)
	self.m_stageList:setAlpha(1)

	self._scheduleAnimId = nil
	self._curSelectIndex = self.m_tabStateController:getSelectedIndex() + 1

	if self._curSelectIndex <= 3 then
		self._curShowNum = var_0_1:getReplayCellNum(self._curSelectIndex)

		self.m_stageList:setNumItems(self._curShowNum)
		self.m_stageList:scrollToView(self._cellClickIdx, false)
		self.m_stageList:transitionShowCells("listIconUiScaleIn", 0.1)
		self.m_stageList:setTouchable(true)
	else
		local var_8_0 = var_0_1:getFirstAwardProfile()
		local var_8_1 = 1

		if var_8_0 then
			g.core.model.User.plotReplayReviewData:setProfileSelectedId(var_8_0.id)

			var_8_1 = var_8_0.type
		end

		self.m_profileComp:updateView(var_8_1)
	end
end

function PlotReplayMainLayer:_onTabBtnClick()
	return
end

function PlotReplayMainLayer:_onCellItemClick(arg_10_1)
	local var_10_0 = arg_10_1:getDataValue()

	self._cellClickIdx = var_10_0

	local var_10_1 = var_0_1:getReplayCellInfo(self._curSelectIndex, var_10_0 + 1)

	if var_10_1.openStageNum == 0 and not (g.core.common.Storage:load("ignorePlotReview.json", false) or {}).open then
		return
	end

	local var_10_2 = {}

	var_10_2.type = var_10_1.themeType or self._curSelectIndex
	var_10_2.scrollId = var_10_0 + 1
	var_10_2.info = var_10_1

	g.core.module.ModuleManager:pushModule(g.view.entrance.PLOT_REPLAY_REPLAY, var_10_2)
end

function PlotReplayMainLayer:_onStageItemRender(arg_11_1, arg_11_2)
	local var_11_0 = var_0_1:getReplayCellInfo(self._curSelectIndex, arg_11_1 + 1)
	local var_11_1, var_11_2 = var_0_1:getChapterStageNumInfo(self._curSelectIndex, arg_11_1 + 1)
	local var_11_3 = {
		index = arg_11_1
	}

	var_11_3.type = var_11_0.themeType or self._curSelectIndex
	var_11_3.info = var_11_0
	var_11_3.allNum = var_11_2
	var_11_3.curNum = var_11_1 or 0

	arg_11_2:updateView(var_11_3)
end

function PlotReplayMainLayer:changePageState(arg_12_1)
	self._pageState = arg_12_1

	if arg_12_1 == 1 then
		self.m_placeHolderComp:setVisible(true)
		self.m_stageList:setVisible(false)

		self._changePage = false

		self._childPage:playEnterAnim()
	else
		self.m_placeHolderComp:setVisible(false)
		self.m_stageList:setVisible(true)
	end
end

function PlotReplayMainLayer:onUnload()
	if self._scheduleAnimId then
		g.core.common.Scheduler:cancelSchedule(self._scheduleAnimId)

		self._scheduleAnimId = nil
	end
end

return PlotReplayMainLayer
