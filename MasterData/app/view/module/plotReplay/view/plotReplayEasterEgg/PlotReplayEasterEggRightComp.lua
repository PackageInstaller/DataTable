local var_0_0 = g.core.model.User.easterEggData
local PlotReplayEasterEggRightComp = class("PlotReplayEasterEggRightComp", require("app.fairyGUI.plotReplay.UI_PlotReplayEasterEggRightComp"))

function PlotReplayEasterEggRightComp:ctor()
	self.m_beginBtn:addClickListener(handler(self, self._onBeginBtnClick))
	self.m_gameList:setVirtual()
	self.m_gameList:doFairyBatching(false)
	self.m_gameList:setItemRenderer(handler(self, self._onGameListItemRenderer))
	self.m_gameList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onGameListClickItem))
	self.m_enterTransition:play()

	self._easterEggList = {}
	self._curSelectedIndex = 1
end

function PlotReplayEasterEggRightComp:updateContent(arg_2_1)
	self._data = arg_2_1
	self._childType = self._data.tabType
	self._isSwitchTab = arg_2_1.isSwitchTab
	self._selectData = nil
	self._easterEggList = var_0_0:getAllEggDataList()

	self:_updateShow()
end

function PlotReplayEasterEggRightComp:_updateShow()
	self.m_gameList:setNumItems(#self._easterEggList)

	if self._isSwitchTab then
		self._curSelectedIndex = 1
	end

	local var_3_0

	if self._curSelectedIndex - 1 >= 0 then
		var_3_0 = self._curSelectedIndex - 1 or 0
	end

	self.m_gameList:setSelectedIndex(var_3_0)
	self.m_gameList:scrollToView(var_3_0)

	self._selectData = self._easterEggList[self._curSelectedIndex]

	self.m_gameList:transitionShowCells("enter_scaleOut", 0.03)
	self:_updateLeftCompAndBtn()
end

function PlotReplayEasterEggRightComp:_updateLeftCompAndBtn()
	self.m_beginBtn:setVisible(false)

	if self._selectData then
		self.m_leftComp:updateGameInfo(self._selectData)
		self.m_beginBtn:setVisible(self._selectData.isUnlock and true or false)
	end
end

function PlotReplayEasterEggRightComp:_onGameListItemRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateItem(self._easterEggList[arg_5_1 + 1])
end

function PlotReplayEasterEggRightComp:_onGameListClickItem(arg_6_1, arg_6_2)
	local var_6_0 = self.m_gameList:getSelectedIndex()

	if self._curSelectedIndex ~= var_6_0 + 1 then
		self._curSelectedIndex = var_6_0 + 1
		self._selectData = self._easterEggList[self._curSelectedIndex]

		self:_updateLeftCompAndBtn()
	end
end

function PlotReplayEasterEggRightComp:_onBeginBtnClick()
	local var_7_0

	if not self._selectData then
		do return end

		var_7_0 = {
			eggId = self._selectData.cfg.id
		}
	end

	var_7_0.interactionId = self._selectData.cfg.interaction_id

	g.core.module.ModuleManager:pushModule(g.view.entrance.EASTEREGG_LAYER, var_7_0)
end

return PlotReplayEasterEggRightComp
