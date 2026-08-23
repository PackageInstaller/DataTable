local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.model.User.richmanData
local RichmanStealPop = class("RichmanStealPop", require("app.fairyGUI.richman.UI_RichmanStealPop"), function()
	return fgui.GComponent:create({
		resName = "RichmanStealPop",
		pkgPath = "ui/richman/richman",
		pkgName = "richman"
	})
end)

function RichmanStealPop:ctor(arg_2_1)
	self._event = arg_2_1

	self:showAtCenter()
	self.m_playerList:setVirtual()
	self.m_playerList:setItemRenderer(handler(self, self.onPlayerListRenderer))
	self.m_playerList:doFairyBatching(false)
	self.m_pageController:addEventListener(fgui.UIEventType.Changed, handler(self, self.onChangeSelect))
	self.m_closeGraph:addClickListener(handler(self, self._onClosePop))
	self.m_refreshBtn:addClickListener(handler(self, self.onRefreshClick))
end

function RichmanStealPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_MATCHPASSER, self._onUpdateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_ENEMYLIST, self._onUpdateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._onUpdateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GAME_RESUME_FINISH, self.onGameResumeFinish, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_ROBDATA, self.onRobDataCom, self)
	var_0_1:dispatchEvent(var_0_0.EVENT_GUIDE_WAIT)
	self:newScheduleOnce(function()
		var_0_1:dispatchEvent(var_0_0.EVENT_GUIDE_READY)
	end, 0.5)
	self.m_enterTransition:play()
	self:onChangeSelect()
	self:newSchedule(handler(self, self.updateCellTime), 1)
end

function RichmanStealPop:_onUpdateView()
	if self.m_pageController:getSelectedIndex() == 0 then
		self._userNum = var_0_2:getEnemyList()

		self.m_playerList:setNumItems(#self._userNum)

		if not self._isFirstEnter then
			self._isFirstEnter = true

			if #self._userNum <= 0 then
				self.m_pageController:setSelectedIndex(1)
			end
		end
	else
		self._userNum = var_0_2:getPasserList()

		self.m_playerList:setNumItems(#self._userNum)
	end

	self.m_emptyController:setSelectedIndex(#self._userNum > 0 and 0 or 1)
end

function RichmanStealPop:onGameResumeFinish()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function RichmanStealPop:onRefreshClick()
	var_0_2:setRobType(self.m_pageController:getSelectedIndex() == 0 and 2 or 1)

	if not var_0_2:isNeedReqList((self.m_pageController:getSelectedIndex())) then
		g.core.module.ModuleManager:tip(g.core.lang:get(426025))

		return
	end

	g.core.network.GameNetProxy:send_C2S_RichMan_MatchPasser({
		event_id = self._event.unique_id
	})
end

function RichmanStealPop:onChangeSelect()
	var_0_2:setRobType(self.m_pageController:getSelectedIndex() == 0 and 2 or 1)

	local var_8_0 = self.m_pageController:getSelectedIndex()

	if not var_0_2:isNeedReqList(var_8_0) then
		self:_onUpdateView()

		return
	end

	if var_8_0 == 0 then
		g.core.network.GameNetProxy:send_C2S_RichMan_EnemyList({
			event_id = self._event.unique_id
		})
	else
		g.core.network.GameNetProxy:send_C2S_RichMan_MatchPasser({
			event_id = self._event.unique_id
		})
	end
end

function RichmanStealPop:onRobDataCom(arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3.construct then
		if arg_9_3.construct.armistice > g.core.common.ServerTime:getTime() then
			g.core.module.ModuleManager:tip(g.core.lang:get(426015))
			var_0_2:clearRobData()

			return
		end

		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function RichmanStealPop:onPlayerListRenderer(arg_10_1, arg_10_2)
	arg_10_2:updateStealCell(self._userNum[arg_10_1 + 1], self.m_pageController:getSelectedIndex() == 0, self._event.unique_id)
end

function RichmanStealPop:_onClosePop()
	if self._inClose then
		return
	end

	self._inClose = true

	self.m_backTransition:play(handler(self, self._onRemoveSelf))
end

function RichmanStealPop:_onRemoveSelf()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function RichmanStealPop:updateCellTime()
	for iter_13_0, iter_13_1 in ipairs((self.m_playerList:getChildren())) do
		iter_13_1:updateCellTime()
	end
end

return RichmanStealPop
