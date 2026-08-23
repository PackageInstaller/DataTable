local var_0_0 = g.core.model.User.goldSavingData
local GoldSavingConst = require("app.view.module.goldSaving.const.GoldSavingConst")
local GoldSavingPop = class("GoldSavingPop", require("app.fairyGUI.goldSaving.UI_GoldSavingPop"), function()
	return fgui.GComponent:create({
		resName = "GoldSavingPop",
		pkgName = "goldSaving",
		pkgPath = "ui/goldSaving/goldSaving"
	})
end)

function GoldSavingPop:ctor()
	self._updateSchedule = nil
	self._games = {}

	self:setVisible(false)
	self.m_giftList:setVirtual()
	self.m_giftList:setItemRenderer(handler(self, self._onGiftCellRenderer))
	self:showAtCenter()
	self:_initViw()
end

function GoldSavingPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GOLD_SAVING_FLUSH, handler(self, self._onRecGoldSavingFlush), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GOLD_SAVING_PAY, handler(self, self._onRecGoldSavingPay), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GOLD_SAVING_GAMESTART, handler(self, self._onGameStart), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GOLD_SAVING_GAMEOVER, handler(self, self.updateView), self)
	g.core.network.GameNetProxy:send_C2S_GoldSaving_Flush({})
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.GOLD_SAVING)
end

function GoldSavingPop:_initViw()
	self.m_bg:addClickListener(handler(self, self._onCloseView))
end

function GoldSavingPop:_onCloseView()
	self:clearTimer()
	self.m_backTransition:play(function()
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end)
end

function GoldSavingPop:_onRecGoldSavingFlush(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if tolua.isnull(self) then
		return
	end

	self:updateView()
end

function GoldSavingPop:_onRecGoldSavingPay(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	g.core.module.ModuleManager:awardSummary(arg_8_4.awards, false, nil, nil, handler(self, self.updateView))
end

function GoldSavingPop:_onGameCellRenderer(arg_9_1, arg_9_2)
	arg_9_2:updateGoldSavingGame(self._games[arg_9_1 + 1])
end

function GoldSavingPop:_onGiftCellRenderer(arg_10_1, arg_10_2)
	arg_10_2:updateGoldSavingCell({
		giftCfg = self._curGifts[arg_10_1 + 1]
	})
end

function GoldSavingPop:updateView()
	if tolua.isnull(self) then
		return
	end

	local var_11_0

	if not var_0_0:isShowEntrance() then
		self:_onCloseView()

		do return end

		var_11_0 = {}
	end

	var_11_0.name = var_0_0:getTipStr()
	var_11_0.num = var_0_0:getTipCount()

	self.m_tipStr:setTitle((g.core.lang:get(407901, var_11_0)))

	self._curGifts = var_0_0:getCurGifts()

	self.m_giftList:setNumItems(#self._curGifts)

	local var_11_1 = 1

	for iter_11_0, iter_11_1 in ipairs(self._curGifts) do
		if iter_11_1.id == var_0_0:getGiftId() then
			var_11_1 = iter_11_0

			break
		end
	end

	if var_11_1 == 0 then
		var_11_1 = 1
	end

	self.m_giftList:scrollToView(var_11_1 - 1)
	self.m_giftList:transitionShowCells("enter", 0.03, 1)

	self._games = var_0_0:getAllGameIds()

	for iter_11_2 = 1, 7 do
		if self._games[iter_11_2] then
			self["m_gameIcon" .. iter_11_2]:updateGoldSavingGame(self._games[iter_11_2])
		else
			self["m_gameIcon" .. iter_11_2]:setEmpty()
		end
	end

	self.m_scoreTxt:setText((var_0_0:getProgress()))
	self:clearTimer()

	self._updateSchedule = self:newSchedule(handler(self, function()
		self:_updateCountDown()
	end), 1)

	self:_updateCountDown()

	if not self._isPlayed then
		self.m_enterTransition:play()

		self._isPlayed = true
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_SmallGame_WindowOut)
	self:setVisible(true)
	self:checkFingerGuide()
end

function GoldSavingPop:checkFingerGuide()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)

	if #self._games > 0 and not g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.GOLD_SAVING_TICK2) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
			key = "GOLD_SAVING_POP",
			targetBtn = self.m_gameIcon1
		})
		g.core.model.User.guideData:setSaveServerData(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.GOLD_SAVING_TICK2)
	end
end

function GoldSavingPop:_updateCountDown()
	local var_14_0 = (var_0_0:getServerCfgInfo().end_time or 0) - g.core.common.ServerTime:getTime()

	if var_14_0 <= 0 then
		var_14_0 = 0

		self:_onCloseView()

		return
	end

	self.m_timeText:setText((g.core.common.ServerTime:secondToDHMString(var_14_0)))
end

function GoldSavingPop:clearTimer()
	if self._updateSchedule then
		self:cancelSchedule(self._updateSchedule)

		self._updateSchedule = nil
	end
end

function GoldSavingPop:_onGameStart(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	require("app.view.module.goldSaving.const.GoldSavingGameHelper").openGame(g.core.config.gold_saving_game_info.get(arg_16_4.game_id), arg_16_4, (g.core.model.User.goldSavingData:getCurActId()))
end

function GoldSavingPop:onUnload()
	self:clearTimer()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GOLD_SAVING_SHOW_NEW)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
end

return GoldSavingPop
