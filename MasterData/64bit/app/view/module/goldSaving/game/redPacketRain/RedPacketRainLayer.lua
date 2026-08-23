local var_0_0 = g.core.model.User.redPacketRainData
local RedPacketRainConst = require("app.view.module.goldSaving.const.RedPacketRainConst")
local NodePool = require("app.view.module.echoLab.model.pool.NodePool")
local var_0_3 = g.core.module.ModuleManager
local RedPacketRainLayer = class("RedPacketRainLayer", require("app.fairyGUI.goldSaving.UI_RedPacketRainLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/goldSaving/goldSaving",
		resName = "RedPacketRainLayer",
		pkgName = "goldSaving",
		isFullScreen = true
	}, ...)
end)

function RedPacketRainLayer:ctor(arg_2_1)
	self._gameId = arg_2_1.cfg.id
	self._curActId = arg_2_1.actId
	self._redPacketPool = NodePool.new(self.m_redPacketHolder, "goldSaving", "RedPacketRainCell", 30)
	self._redPacketSequence = var_0_0:getShuffledRedPacket(arg_2_1.cfg.id)

	self.m_topBarComp:setTitle(arg_2_1.cfg.event_name)
	self.m_topBarComp:setResInfoById(309)
	self.m_topBarComp:setTopIconGroupVisible(false)

	self._curIndex = 1
	self._redPacketCells = {}

	self:_initView()

	self._rainHandler = nil
	self._checkHandler = nil
	self._isShooting = false
	self._isFinish = false
end

function RedPacketRainLayer:_initView()
	self:addBg("bg/goldSaving/bg_sj_game2.jpg")
	self.m_topBarComp:setReturnCallBack(handler(self, self._onPause))
	self.m_topBarComp:setHomeCallBack(handler(self, self._onPause))
end

function RedPacketRainLayer:_playRedPacketRain()
	var_0_0:resetGain()

	self._rainHandler = self:newSchedule(handler(self, self._createNewRedPacket), RedPacketRainConst.INTERVAL)
end

function RedPacketRainLayer:_createNewRedPacket()
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

function RedPacketRainLayer:_onClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function RedPacketRainLayer:_onClickRedPacket(arg_8_1)
	local var_8_0 = arg_8_1:getSender()
	local var_8_1 = var_8_0:getRedPacketStruct()

	var_0_0:addAward(var_8_1:getParameterIndex())
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_RED_PACKAGE_SMALL_CLICK)
	var_8_0:playClickAnim(function()
		self._redPacketCells[var_8_1:getIndex()] = nil

		self._redPacketPool:recoveryCompInPool(var_8_0)
	end)
	var_8_0:stopAllFGActions()
	self:_showBonus(var_8_1:getAward(), var_8_0:getPosition())
end

function RedPacketRainLayer:_onClickBigRedPacket(arg_10_1)
	local var_10_0 = arg_10_1:getSender()
	local var_10_1 = var_10_0:getRedPacketStruct()

	var_0_0:addAward(var_10_1:getParameterIndex())
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

function RedPacketRainLayer:_showBonus(arg_12_1, arg_12_2)
	local var_12_0 = fgui.UIPackage:createObject("goldSaving", "RedPacketRainBonusCell")

	var_12_0:updateView(arg_12_1)
	self:addChild(var_12_0)
	var_12_0:setPosition(cc.p(arg_12_2.x + 50, arg_12_2.y))
	var_12_0:playBonusAnim()
end

function RedPacketRainLayer:_checkRedPacketOnScreen()
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

		self:_sendC2SGoldSavingGameOver()
	end
end

function RedPacketRainLayer:_sendC2SGoldSavingGameOver()
	local var_14_0 = var_0_0:getGainDict()
	local var_14_1 = {}

	for iter_14_0 = 1, 4 do
		var_14_1[iter_14_0] = var_14_0[iter_14_0] or 0
	end

	g.core.network.GameNetProxy:send_C2S_GoldSaving_GameOver({
		game_id = self._gameId,
		params = var_14_1
	})
	self:_checkActId()
end

function RedPacketRainLayer:_startCountdown()
	self._rainHandler = self._rainHandler or self:newSchedule(handler(self, self._createNewRedPacket), RedPacketRainConst.INTERVAL)

	self:_startAllAction()
end

function RedPacketRainLayer:_stopCountdown()
	if self._rainHandler then
		self:cancelSchedule(self._rainHandler)

		self._rainHandler = nil
	end

	self:_stopAllAction()

	self._isShooting = false
end

function RedPacketRainLayer:_onPause()
	self:_stopCountdown()

	local var_17_0

	if self._isFinish then
		do return end

		var_17_0 = require("app.view.base.pop.BaseConfirmPop").new
	end

	var_0_3:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(407915),
		onCancel = handler(self, self._startCountdown),
		onConfirm = handler(self, self._onClose),
		desc = g.core.lang:get(407921)
	}), {
		touchDisappear = true
	})
end

function RedPacketRainLayer:_stopAllAction()
	for iter_18_0, iter_18_1 in pairs(self._redPacketCells) do
		iter_18_1:stopAllFGActions()
	end
end

function RedPacketRainLayer:_startAllAction()
	for iter_19_0, iter_19_1 in pairs(self._redPacketCells) do
		iter_19_1:playMoveAnim()
	end
end

function RedPacketRainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GOLD_SAVING_GAMEOVER, handler(self, self._onS2CGoldSavingGameOver), self)

	if not self._isStart then
		self:_onS2CGoldSavingGameStart()
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

function RedPacketRainLayer:onUnload()
	if self._rainHandler then
		self:cancelSchedule(self._rainHandler)

		self._rainHandler = nil
	end

	if self._checkHandler then
		self:cancelSchedule(self._checkHandler)

		self._checkHandler = nil
	end
end

function RedPacketRainLayer:_onS2CGoldSavingGameStart()
	self._isStart = true

	var_0_3:pushPopup(require("app.view.module.goldSaving.game.redPacketRain.RedPacketRainCountDownPop").new({
		callBack = handler(self, self._playRedPacketRain)
	}), {
		ignoreTouch = true,
		blackOpacity = 1,
		touchDisappear = false
	})

	self._checkHandler = self:newSchedule(handler(self, self._checkRedPacketOnScreen), 0.1)
end

function RedPacketRainLayer:_onS2CGoldSavingGameOver(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if arg_23_4 and arg_23_4.awards then
		local var_23_0 = g.core.utils.Tools.mergeAwardList(arg_23_4.awards)

		self:newScheduleOnce(function()
			var_0_3:awardSummary(var_23_0, nil, nil, g.core.lang:get(300001), handler(self, self._onClose))
		end, 1)
	else
		self:_onClose()
	end
end

function RedPacketRainLayer:_checkActId()
	if self._curActId ~= nil and g.core.model.User.goldSavingData:getCurActId() ~= self._curActId then
		g.core.module.ModuleManager:tip(g.core.lang:get(307029))
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

return RedPacketRainLayer
