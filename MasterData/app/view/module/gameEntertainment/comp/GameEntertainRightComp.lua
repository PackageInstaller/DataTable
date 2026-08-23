local var_0_0 = g.core.model.User
local GameEntertainConst = require("app.view.module.gameEntertainment.model.GameEntertainConst")
local GameEntertainRightComp = class("GameEntertainRightComp", require("app.fairyGUI.gameEntertainment.UI_GameEntertainRightComp"))

function GameEntertainRightComp:ctor()
	self.m_beginBtn:addClickListener(handler(self, self._onBeginBtnClick))
	self.m_gameList:setVirtual()
	self.m_gameList:doFairyBatching(false)
	self.m_gameList:setItemRenderer(handler(self, self._onGameListItemRenderer))
	self.m_gameList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onGameListClickItem))

	self._gameListData = {}
	self._curSelectedIndex = 1
end

function GameEntertainRightComp:updateContent(arg_2_1)
	self._data = arg_2_1
	self._childType = self._data.tabType
	self._isSwitchTab = arg_2_1.isSwitchTab
	self._selectData = nil
	self._gameListData = var_0_0.gameEntertainmentData:getGameDataByType(self._childType)

	self:_updateShow()
end

function GameEntertainRightComp:_updateShow()
	self.m_gameList:setNumItems(#self._gameListData)

	if self._isSwitchTab then
		self._curSelectedIndex = 1
	end

	local var_3_0

	if self._curSelectedIndex - 1 >= 0 then
		var_3_0 = self._curSelectedIndex - 1 or 0
	end

	self.m_gameList:setSelectedIndex(var_3_0)
	self.m_gameList:scrollToView(var_3_0)

	self._selectData = self._gameListData[self._curSelectedIndex]

	self.m_gameList:transitionShowCells("enter_scaleOut", 0.03)
	self:_updateLeftCompAndBtn()
end

function GameEntertainRightComp:_updateLeftCompAndBtn()
	self.m_beginBtn:setVisible(false)

	if self._selectData then
		self.m_leftComp:updateGameInfo(self._selectData)
		self.m_beginBtn:setVisible(self._selectData.isUnLock and true or false)
	end
end

function GameEntertainRightComp:_onGameListItemRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateItem(self._gameListData[arg_5_1 + 1])
end

function GameEntertainRightComp:_onGameListClickItem(arg_6_1, arg_6_2)
	local var_6_0 = self.m_gameList:getSelectedIndex()

	if self._curSelectedIndex ~= var_6_0 + 1 then
		self._curSelectedIndex = var_6_0 + 1
		self._selectData = self._gameListData[self._curSelectedIndex]

		self:_updateLeftCompAndBtn()
	end
end

function GameEntertainRightComp:_onBeginBtnClick()
	if self._childType == GameEntertainConst.TabType.TOUCH_GAME then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.touchGame.view.TouchGameLayer").new({
			isRepeatModel = true,
			missionId = self._selectData.gameId,
			gameId = self._selectData.eventInfo.event_value_1
		})))
	elseif self._childType == GameEntertainConst.TabType.PUZZLE_GAME then
		g.core.module.ModuleManager:pushModule(g.view.entrance.PUZZLE_GAME, {
			isRepeatModel = true,
			missionid = self._selectData.gameId,
			level = self._selectData.eventInfo.event_value_1
		})
	end
end

return GameEntertainRightComp
