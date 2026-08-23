local var_0_0 = g.core.config.richman_game_info
local var_0_1 = g.core.config.richman_event_info
local var_0_2 = g.core.model.User.richmanData
local RichmanTurnCardGameLayer = class("RichmanTurnCardGameLayer", require("app.fairyGUI.richman.UI_RichmanTurnCardGameLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/richman/richman",
		resName = "RichmanTurnCardGameLayer",
		pkgName = "richman"
	}, ...)
end)

function RichmanTurnCardGameLayer:ctor(arg_2_1)
	self._uniqueId = arg_2_1.unique_id
	self._eventCfg = var_0_1.get(arg_2_1.id)
	self._gameId = self._eventCfg.event_value1
	self._curAward = nil
	self._tipHandler = nil
	self._turnAnimEnd = false
	self._gameData = var_0_2:getGameData()

	self._gameData:setTurnCardGameId(self._gameId)
	self._gameData:onTurnCardGameStart(arg_2_1)
	self:_initData()
	self:_initView()
	self:addListen(self.m_rightComp)
	self.m_topBarComp:setTitle(var_0_0.get(self._gameId).event_name)
	self.m_topBarComp:setResInfoById(308)
	self.m_topBarComp:setTopIconGroupVisible(false)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallGame_CardWindow)
end

function RichmanTurnCardGameLayer:_initData()
	self._rewardDict = self._gameData:getRewardDict()
	self._cardStatus = {
		{
			0,
			0,
			0
		},
		{
			0,
			0,
			0
		},
		{
			0,
			0,
			0
		}
	}
end

function RichmanTurnCardGameLayer:_initView()
	self.m_bgDi:setURL("bg/richman/bg_dfw_game2.jpg")

	for iter_4_0 = 1, 3 do
		self["m_leftCell" .. iter_4_0]:updateLeftCell(self._rewardDict[iter_4_0], iter_4_0)
	end
end

function RichmanTurnCardGameLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_EVENTPROCESS, handler(self, self.onExplorationEventProcess), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_RICHMAN_EVENTPROCESS_FAILED, handler(self, self.onGameStageFinish), self)
	self.m_enterTransition:play()
end

function RichmanTurnCardGameLayer:onGameStageFinish()
	g.core.module.ModuleManager:tip(g.core.lang:get(426006))
	g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
end

function RichmanTurnCardGameLayer:onExplorationEventProcess(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_4 and arg_7_4.awards then
		self._curAward = arg_7_4.awards
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(1149))
		self:_onClose()

		return
	end

	if self._turnAnimEnd then
		self:_onFinishAnim()
	end
end

function RichmanTurnCardGameLayer:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "turn_card" then
		self.m_handHolder:removeChildren()

		if self._tipHandler then
			self:cancelSchedule(self._tipHandler)

			self._tipHandler = nil
		end

		local var_8_0 = arg_8_2.index

		if self._gameData:isLastCard(arg_8_2.index) then
			self:setTouchable(false)
			self:newScheduleOnce(function()
				local var_9_0 = self._gameData:getRewardId()

				g.core.network.GameNetProxy:send_C2S_RichMan_EventProcess({
					unique_id = self._uniqueId
				})
				self["m_leftCell" .. var_9_0]:playFinishAnim(var_9_0, handler(self, self._onFinishAnim))
			end, 2)
		end

		local var_8_1 = self._gameData:getCardTypeByIndex(var_8_0)
		local var_8_2 = self:_getNextIconIndexByType(var_8_1)

		self._cardStatus[var_8_1][var_8_2] = 1

		self:newScheduleOnce(function()
			self["m_leftCell" .. var_8_1]:updateCellStatus(var_8_2 - 1, var_8_1)
		end, 1)
	end
end

function RichmanTurnCardGameLayer:_onFinishAnim()
	if self._curAward then
		self._curAward = nil

		g.core.module.ModuleManager:awardSummary(clone(self._curAward), nil, nil, g.core.lang:get(300001), handler(self, self._onClose))
	else
		self._turnAnimEnd = true
	end
end

function RichmanTurnCardGameLayer:_onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function RichmanTurnCardGameLayer:_getNextIconIndexByType(arg_13_1)
	for iter_13_0 = 1, 3 do
		if self._cardStatus[arg_13_1][iter_13_0] == 0 then
			return iter_13_0
		end
	end
end

return RichmanTurnCardGameLayer
