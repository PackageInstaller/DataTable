local var_0_0 = g.core.model.User.explorationData
local var_0_1 = g.core.config.exploration_game_info
local RedPacketRainConst = require("app.view.module.goldSaving.const.RedPacketRainConst")
local NodePool = require("app.view.module.echoLab.model.pool.NodePool")
local var_0_4 = g.core.module.ModuleManager
local ExplorationRedPacketRainLayer = class("ExplorationRedPacketRainLayer", require("app.fairyGUI.exploration.UI_ExplorationRedPacketRainLayer"), function()
	return fgui.GComponent:create({
		resName = "ExplorationRedPacketRainLayer",
		pkgPath = "ui/exploration/exploration",
		isFullScreen = true,
		pkgName = "exploration"
	}, ...)
end)

function ExplorationRedPacketRainLayer:ctor(arg_2_1)
	self._gameId = arg_2_1.id
	self._uniqueId = arg_2_1.unique_id
	self._redPacketPool = NodePool.new(self.m_redPacketHolder, "exploration", "ExplorationRedPacketRainCell", 30)
	self._gameData = var_0_0:getGameData()
	self._redPacketSequence = self._gameData:getShuffledRedPacket(arg_2_1.id)

	self.m_topBarComp:setTitle(var_0_1.get(arg_2_1.id).event_name)
	self.m_topBarComp:setTopIconGroupVisible(false)

	self._curIndex = 1
	self._redPacketCells = {}

	self:_initView()
	self.m_enterTransition:play()

	self._rainHandler = nil
	self._checkHandler = nil
	self._isShooting = false
	self._isFinish = false
end

function ExplorationRedPacketRainLayer:_initView()
	self.m_bgDi:setURL("bg/exploration/bg_slmj_liuxingyu_1.jpg")
	self.m_bgTop:setURL("bg/exploration/bg_slmj_liuxingyu_2.png")
	self.m_topBarComp:setReturnCallBack(handler(self, self._onPause))
	self.m_topBarComp:setHomeCallBack(handler(self, self._onPause))
end

function ExplorationRedPacketRainLayer:_playRedPacketRain()
	self._gameData:resetGain()

	self._rainHandler = self:newSchedule(handler(self, self._createNewRedPacket), RedPacketRainConst.INTERVAL)
end

function ExplorationRedPacketRainLayer:_createNewRedPacket()
	self._isShooting = true

	local var_5_0 = self._redPacketSequence[self._curIndex]

	if self._redPacketSequence[self._curIndex] then
		local var_5_1 = var_5_0:isBigAward()
		local var_5_2 = self._redPacketPool:takeOutCompInPool()

		var_5_2:removeClickListener(RedPacketRainConst.CLICK_TAG)

		if var_5_1 then
			var_5_2:addClickListener(handler(self, self._onClickBigRedPacket), RedPacketRainConst.CLICK_TAG)
		else
			var_5_2:addClickListener(handler(self, self._onClickRedPacket), RedPacketRainConst.CLICK_TAG)
		end

		var_5_2:updateRedPacketCell(var_5_0, var_5_1 and 1 or math.random(2, 4))
		self.m_redPacketHolder:addChild(var_5_2)

		self._redPacketCells[self._curIndex] = var_5_2

		local var_5_3

		if self._curIndex >= #self._redPacketSequence / 3 then
			var_5_3 = RedPacketRainConst.ACC_DURATION
		end

		if self._curIndex < #self._redPacketSequence then
			var_5_2:playMoveAnim(var_5_3)
		else
			self:newScheduleOnce(function()
				var_5_2:playMoveAnim(var_5_3)
			end, 1.8)
		end

		self._curIndex = self._curIndex + 1
	end

	if self._rainHandler and self._curIndex > #self._redPacketSequence then
		self:cancelSchedule(self._rainHandler)

		self._rainHandler = nil
	end
end

function ExplorationRedPacketRainLayer:_onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function ExplorationRedPacketRainLayer:_onClickRedPacket(arg_8_1)
	local var_8_0 = arg_8_1:getSender()
	local var_8_1 = var_8_0:getRedPacketStruct()

	self._gameData:addAward(var_8_1:getParameterIndex())
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_RED_PACKAGE_SMALL_CLICK)
	var_8_0:playClickAnim(function()
		self._redPacketCells[var_8_1:getIndex()] = nil

		self._redPacketPool:recoveryCompInPool(var_8_0)
	end)
	var_8_0:stopAllFGActions()
	self:_showBonus(var_8_1:getAward(), var_8_0:getPosition())
end

function ExplorationRedPacketRainLayer:_onClickBigRedPacket(arg_10_1)
	local var_10_0 = arg_10_1:getSender()
	local var_10_1 = var_10_0:getRedPacketStruct()

	self._gameData:addAward(var_10_1:getParameterIndex())
	self:_showBonus(var_10_1:getAward(), var_10_0:getPosition())
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_RED_PACKAGE_BIG_CLICK)
	var_10_0:playScaleAnim()

	if var_10_1:isClickNumReachTarget() then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_RED_PACKAGE_BIG_FINAL)
		var_10_0:setTouchable(false)
		var_10_0:stopAllFGActions()
		var_10_0:bigAwardClickFinish(function()
			self._redPacketCells[var_10_1:getIndex()] = nil

			self._redPacketPool:recoveryCompInPool(var_10_0)
		end)
	end
end

function ExplorationRedPacketRainLayer:_showBonus(arg_12_1, arg_12_2)
	local var_12_0 = fgui.UIPackage:createObject("exploration", "ExplorationRedPacketRainBonusCell")

	var_12_0:updateView(arg_12_1)
	self:addChild(var_12_0)
	var_12_0:setPosition(cc.p(arg_12_2.x + 50, arg_12_2.y))
	var_12_0:playBonusAnim()
end

function ExplorationRedPacketRainLayer:_checkRedPacketOnScreen()
	if not self._isShooting then
		return
	end

	local var_13_0 = false

	for iter_13_0, iter_13_1 in pairs(self._redPacketCells) do
		if iter_13_1:isDestination() then
			self._redPacketCells[iter_13_0] = nil

			self._redPacketPool:recoveryCompInPool(iter_13_1)
		end
	end

	for iter_13_2, iter_13_3 in pairs(self._redPacketCells) do
		if iter_13_3 then
			var_13_0 = true
		end
	end

	if not var_13_0 and self._curIndex >= #self._redPacketSequence then
		self._isFinish = true

		self:cancelSchedule(self._checkHandler)

		self._checkHandler = nil

		self:_sendC2SExplorationPackageGameOver()
	end
end

function ExplorationRedPacketRainLayer:_sendC2SExplorationPackageGameOver()
	local var_14_0 = self._gameData:getGainDict()
	local var_14_1 = {}

	for iter_14_0 = 1, 4 do
		var_14_1[iter_14_0] = var_14_0[iter_14_0] or 0
	end

	g.core.network.GameNetProxy:send_C2S_Exploration_EventProcess({
		unique_id = self._uniqueId,
		params = var_14_1
	})
end

function ExplorationRedPacketRainLayer:_startCountdown()
	self._rainHandler = self._rainHandler or self:newSchedule(handler(self, self._createNewRedPacket), RedPacketRainConst.INTERVAL)

	self:_startAllAction()
end

function ExplorationRedPacketRainLayer:_stopCountdown()
	if self._rainHandler then
		self:cancelSchedule(self._rainHandler)

		self._rainHandler = nil
	end

	self:_stopAllAction()

	self._isShooting = false
end

function ExplorationRedPacketRainLayer:_onPause()
	self:_stopCountdown()

	local var_17_0

	if self._isFinish then
		do return end

		var_17_0 = require("app.view.base.pop.BaseConfirmPop").new
	end

	var_0_4:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(407915),
		onCancel = handler(self, self._startCountdown),
		onConfirm = handler(self, self._onClose),
		desc = g.core.lang:get(407921)
	}), {
		touchDisappear = true
	})
end

function ExplorationRedPacketRainLayer:_stopAllAction()
	for iter_18_0, iter_18_1 in pairs(self._redPacketCells) do
		iter_18_1:stopAllFGActions()
	end
end

function ExplorationRedPacketRainLayer:_startAllAction()
	for iter_19_0, iter_19_1 in pairs(self._redPacketCells) do
		iter_19_1:playMoveAnim()
	end
end

function ExplorationRedPacketRainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EXPLORATION_EVENTPROCESS, handler(self, self.onExplorationProcess), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_EXPLORATION_EVENTPROCESS_FAILED, handler(self, self.onGameStageFinish), self)

	if not self._isStart then
		self:explorationGameStart()
	else
		if self._rainHandler then
			self:cancelSchedule(self._rainHandler)

			self._rainHandler = nil
		end

		if self._checkHandler then
			self:cancelSchedule(self._checkHandler)

			self._checkHandler = nil
		end

		self._rainHandler = self:newSchedule(handler(self, self._createNewRedPacket), RedPacketRainConst.INTERVAL)
		self._checkHandler = self:newSchedule(handler(self, self._checkRedPacketOnScreen), 0.1)
	end
end

function ExplorationRedPacketRainLayer:onGameStageFinish()
	var_0_4:tip(g.core.lang:get(420691))
	var_0_4:switchModuleIntelligent(g.view.entrance.HOME)
end

function ExplorationRedPacketRainLayer:onUnload()
	if self._rainHandler then
		self:cancelSchedule(self._rainHandler)

		self._rainHandler = nil
	end

	if self._checkHandler then
		self:cancelSchedule(self._checkHandler)

		self._checkHandler = nil
	end
end

function ExplorationRedPacketRainLayer:explorationGameStart()
	self._isStart = true

	var_0_4:pushPopup(require("app.view.module.exploration.view.game.ExplorationRedPacketRainCountDownPop").new({
		callBack = handler(self, self._playRedPacketRain)
	}), {
		blackOpacity = 1,
		ignoreTouch = true,
		touchDisappear = false
	})

	self._checkHandler = self:newSchedule(handler(self, self._checkRedPacketOnScreen), 0.1)
end

function ExplorationRedPacketRainLayer:onExplorationProcess(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	if arg_24_4 and arg_24_4.awards then
		local var_24_0 = g.core.utils.Tools.mergeAwardList(arg_24_4.awards)

		self:newScheduleOnce(function()
			var_0_4:awardSummary(var_24_0, nil, nil, g.core.lang:get(300001), handler(self, self._onClose))
		end, 1)
	else
		self:_onClose()
	end
end

return ExplorationRedPacketRainLayer
