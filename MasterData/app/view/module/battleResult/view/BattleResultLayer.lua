local var_0_0 = g.core.const.ConstMgr.SpineConst
local var_0_1 = g.core.const.ConstMgr.ShopConst
local KnightVoiceCommon = require("app.view.module.knight.common.KnightVoiceCommon")
local DebugCommon = require("app.view.module.debug.common.DebugCommon")
local var_0_4 = g.core.model.User.fogNightmareData
local var_0_6 = g.core.model.User.shopData
local var_0_7 = g.core.const.ConstMgr.BattleResultConst
local BattleResultLayer = class("BattleResultLayer", function(arg_1_0, arg_1_1)
	local var_1_0 = fgui.GComponent:create(arg_1_0, arg_1_1)

	var_1_0:setName("BattleResultLayer")

	return var_1_0
end)

BattleResultLayer.isPreBattleWin = false

function BattleResultLayer:ctor(arg_2_1, arg_2_2)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CLEAR_COUNT)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_START)
	g.core.common.Setting:saveFirstData()
	self:setSize(display.width, display.height)
	self:setOpaque(true)
	self:addClickListener(handler(self, self._onTouchBegin))

	self._executeIndex = 0
	self._isWaiting = false
	self._resultParams = arg_2_2
	self._curStateAnimPlaying = false
	self._pageCount = 1
	self._pageList = arg_2_2.pages or {}
	self._knightId = arg_2_2.knight_id
	self._skin = arg_2_2.knight_skin
	self._forbidTouch = arg_2_2.forbidTouch
	self._canAuto = false

	if not arg_2_2.pages then
		for iter_2_0 = 1, self:getView():getController("page"):getPageCount() do
			self._pageList[iter_2_0] = iter_2_0 - 1
		end
	end

	self:_checkComps()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
	self:_initView()
end

function BattleResultLayer:_onExitBattleResultShow(arg_3_1, arg_3_2)
	self._exitCallParam = arg_3_2

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_END)
	self:finishExitAnim()
end

function BattleResultLayer:addContinueDescComp()
	local var_4_0 = fgui.UIPackage:createObject("base_new", "BaseContinueText")

	self:addChild(var_4_0)
	var_4_0:setPivot(0.5, 0.5, true)
	var_4_0:setPosition(display.cx, display.height - 50)
	var_4_0:getTransition("show"):play()

	self.m_txtContinue = var_4_0

	self.m_txtContinue:setVisible(false)
end

function BattleResultLayer:onLoad()
	self:resetBattleTimeScale()

	if not self._notifyFailed then
		self._notifyFailed = true

		self:_checkBattleFailedGuide(self._resultParams)
	end

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_EXIT_BATTLE_RESULT_SHOW, self._onExitBattleResultShow, self)

	if self._isPlayTrans then
		return
	end

	self._isPlayTrans = true

	g.core.model.User.themeData:setTurnCardResetGame(false)

	local var_5_0 = self:getView():getTransition(self._resultParams.isWin and "victory" or "defeat")

	if var_5_0 then
		var_5_0:setHook("complete", handler(self, self._onTransComplete))
		var_5_0:play()
	else
		self:_addKnight()
		self:_checkPlayNow()
		self:_execute()
	end

	self._lastBgm = g.core.sound.SoundManager:getCurBgm()
	self._showTalkComp = false

	if self._resultParams.isWin ~= false then
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RESULT_WIN)

		local var_5_1 = self._knightId or g.core.model.User.knightsData:getMainKnight():getAdvanceId()
		local var_5_2 = g.core.model.User.knightsData:getKnight({
			advance_id = var_5_1
		})

		KnightVoiceCommon.playVoice({
			voiceType = "win_sound",
			knight = var_5_2
		})

		local var_5_3 = self:getChild("talkComp")

		if var_5_3 then
			local var_5_4 = KnightVoiceCommon.getVoiceLinesStr(var_5_2:getVoiceResInfo(), "win_lines")

			var_5_3:setTitle(var_5_4)

			self._showTalkComp = var_5_4 and var_5_4 ~= ""
		end

		g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_BATTLE_WIN)
	else
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.RESULT_FAIL)

		local var_5_5 = g.core.model.User.knightsData:getLineUpList()

		KnightVoiceCommon.playVoice({
			voiceType = "lose_sound",
			knight = var_5_5[math.random(1, #var_5_5)]
		})
		g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_BATTLE_FAIL)
	end

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_BACK, handler(self, self._onResetLeave), self)

	local BattleConst = require("app.view.battle.const.BattleConst")
	local var_5_7 = g.core.battle.BattleProxy:getType()

	if var_5_7 == BattleConst.TYPE_SPIRE_NORMAL or var_5_7 == BattleConst.TYPE_SPIRE_BOSS then
		if config.DEBUG_VERSION and require("app.view.module.debug.common.DebugCommon").getDebugGlobalValueByKey("spire_tower_auto") then
			self:newScheduleOnce(handler(self, function(arg_6_0)
				arg_6_0:_continue()
			end), 1)
		end
	end
end

function BattleResultLayer:resetBattleTimeScale()
	local var_7_0 = DebugCommon.getDebugGlobalValueByKey("game_time_scale")

	if var_7_0 and type(var_7_0) == "number" then
		cc.Director:getInstance():getScheduler():setTimeScale(var_7_0)
	else
		cc.Director:getInstance():getScheduler():setTimeScale(1)
	end
end

function BattleResultLayer:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
	g.core.sound.SoundManager:playMusic(self._lastBgm)

	if not g.core.model.User.storyData:isInStory() then
		KnightVoiceCommon.stopVoice()
	end

	if self._curStateAnimPlaying and self._resultParams.continueEvent then
		g.core.event.EventManager:dispatchEvent(self._resultParams.continueEvent, false, self._resultParams)
	end

	if self._resultParams.isWushTowerResult then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.WUSH_TOWER_BATTLE_RESULT_EXIT)
	end

	if self:getChild("resetComp") ~= nil then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.FOG_NIGHTMARE_BATTLE_RESULT_EXIT)
	end
end

function BattleResultLayer:_onTransComplete()
	self:getChild("lineup"):setAlpha(0)
	self:getChild("linedown"):setAlpha(0)
	self:getChild("linemd"):setAlpha(0)
	self:_addKnight()
	self:_checkPlayNow()
	self:_execute()
end

function BattleResultLayer:receiveCompEvent(arg_10_1)
	if arg_10_1 == "BattleResult_continue" then
		self:_execute()
	elseif arg_10_1 == "BattleResult_auto_continue" then
		self:_execute()

		if self._isWaiting then
			self:_continue()

			self._isWaiting = false
		end
	elseif arg_10_1 == "BattleResult_end" then
		self:_continue()
	elseif arg_10_1 == "reset_turn_card" then
		g.core.model.User.themeData:setTurnCardResetGame(true)
		self:_continue()
	elseif arg_10_1 == "reset_gem_eliminate" then
		g.core.model.User.themeData:setGemEliminateResetGame(true)
		self:_continue()
	elseif arg_10_1 == "reset_guess" then
		g.core.model.User.themeData:setGuessResetGame(true)
		self:_continue()
	elseif arg_10_1 == "rest_puzzle_game" then
		g.core.model.User.themeData:setThemePuzzleResetGame(true)
		self:_continue()
	elseif arg_10_1 == "BattleResult_giveUp" then
		self._forbidTouch = false

		self:onBattleShowFinish()
	elseif arg_10_1 == "teamBattle_confirm" then
		self._forbidTouch = false

		self:_continue()
	elseif arg_10_1 == "maskHide" then
		self._forbidTouch = false

		self:_continue()
		self:newScheduleOnce(handler(self, self.onBattleShowFinish), 1.2)
	end
end

function BattleResultLayer:_addBlackBg()
	local var_11_0 = fgui.GGraph:create()

	var_11_0:drawRect(display.width, display.height, 0, cc.c4f(0, 0, 0, 1), cc.c4f(0, 0, 0, 1))
	var_11_0:setAlpha(0.8)
	self:addChildAt(var_11_0, 0)
end

function BattleResultLayer:checkSummaryBtnVisible()
	local var_12_0 = self:getChild("summaryBtn")

	if var_12_0 and self._resultParams and (self._resultParams.isSkip or self._resultParams.isWushTowerSkipBattle) then
		var_12_0:setVisible(false)
	end
end

function BattleResultLayer:_checkComps()
	self._curPageComps = {}
	self._curPagePlayNowComps = {}

	self:setCtrlState("page", {
		index = self._pageList[self._pageCount]
	})
	self:checkSummaryBtnVisible()

	if self._pageCount == 1 then
		self._waitCount = self._waitCount or 0
		self._waitCount = self._waitCount + 1

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

		if self._resultParams.isWin or self._resultParams.noLose then
			local var_13_0 = self:getView():getTransition("comEnter")

			if var_13_0 then
				var_13_0:play(handler(self, self._onCurStateAnimEnd))

				self._curStateAnimPlaying = true
			end
		else
			local var_13_1 = self:getView():getTransition("failEnter")

			if var_13_1 then
				self._failed = true

				var_13_1:play(handler(self, self._onCurStateAnimEnd))

				self._curStateAnimPlaying = true
			end
		end
	elseif self._pageCount == 2 then
		self._waitCount = self._waitCount or 0
		self._waitCount = self._waitCount + 1

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

		local var_13_2 = self:getView():getTransition("switch")

		if var_13_2 then
			var_13_2:play(handler(self, self._onCurStateAnimEnd))

			self._curStateAnimPlaying = true
		else
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

			self._waitCount = self._waitCount - 1
		end
	else
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end

	local var_13_3 = self:getView()
	local var_13_4 = self:getChild("talkComp")

	if var_13_4 then
		var_13_4:setVisible(self._showTalkComp)
	end

	for iter_13_0 = 1, var_13_3:numChildren() do
		local var_13_5 = var_13_3:getChildAt(iter_13_0 - 1)

		if tolua.type(var_13_5) ~= "fgui.GGroup" and var_13_5:isVisibleActually() then
			if var_13_5.isPlayNow and var_13_5:isPlayNow() then
				table.insert(self._curPagePlayNowComps, var_13_5)
			else
				table.insert(self._curPageComps, var_13_5)
			end
		end
	end
end

function BattleResultLayer:_onCurStateAnimEnd()
	self._canAuto = true

	if not g.core.battle.BattleProxy:isHaveBattleScene() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_SHOW, false, {
			battleScene = true
		})
	end

	self._curStateAnimPlaying = false

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)

	if self._failed then
		self._failed = false

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	end

	self._waitCount = self._waitCount - 1

	if self._isWaiting then
		-- block empty
	end

	self:checkSummaryBtnVisible()
end

function BattleResultLayer:_initView()
	local var_15_0 = self:getChild("bgComp")
	local var_15_1 = self:getChild("winComp")
	local var_15_2 = self:getChild("levelComp")
	local var_15_3 = self:getChild("summaryBtn")
	local var_15_4 = self:getChild("rewardComp")
	local var_15_5 = self:getChild("damageComp")
	local var_15_6 = self:getChild("autoComp")
	local var_15_7 = self:getChild("recordComp")
	local var_15_8 = self:getChild("failComp")
	local var_15_9 = self:getChild("danGradingComp")
	local var_15_10 = self:getChild("btnRetry")
	local var_15_11 = self:getChild("resetComp")

	if var_15_10 then
		var_15_10:addClickListener(handler(self, self._retry))
	end

	if var_15_11 then
		local var_15_12 = false

		self._knightList = var_0_4:getFormationData():getBattleFormation()
		self._battleList = self._knightList:getKnightPosList()

		local var_15_13 = 0
		local var_15_14 = 0

		for iter_15_0, iter_15_1 in pairs(self._battleList) do
			if self._resultParams.content.kn_hps_after[iter_15_0] == 0 then
				var_15_12 = true
			end

			var_15_13 = var_15_13 + self._resultParams.content.kn_hps_after[iter_15_0]
			var_15_14 = var_15_14 + 1
		end

		if var_15_13 / (1000 * var_15_14) * 1000 <= g.core.config.parameter_info.get(20055).parameter then
			var_15_12 = true
		end

		local var_15_15 = self:getController("showResetBtn")

		if var_15_12 then
			var_15_15:setSelectedIndex(1)
			var_15_11:getChild("numTxt"):setText(g.core.lang:get(500151, {
				num = var_0_6:getLeftCount(var_0_1.PLAY_TYPE.FOG_NIGHTMARE_RESET)
			}))
			var_15_11:getChild("resetBtn"):addClickListener(handler(self, self._reset))

			if self._resultParams.content then
				if not g.core.model.User.guideData:isTickedCache("fog_floor_result_" .. (self._resultParams.content.floor or 0)) then
					g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
						key = "GUIDE_CHECK_FOG_BATTLE_FINISH",
						targetBtn = var_15_11:getChild("resetBtn")
					})
				end
			end
		else
			var_15_15:setSelectedIndex(0)
		end
	end

	if self._resultParams.isWin then
		if var_15_0 then
			var_15_0:update(self._resultParams)
		end

		if var_15_1 then
			var_15_1:update(self._resultParams)
		end

		if var_15_2 then
			var_15_2:update(self._resultParams)
		end

		if var_15_3 then
			var_15_3:update(self._resultParams)
		end

		if var_15_4 then
			var_15_4:update(self._resultParams)
		end

		if var_15_5 then
			var_15_5:update(self._resultParams)
		end

		if var_15_6 then
			var_15_6:update(self._resultParams)
		end
	elseif self._resultParams == false and var_15_8 then
		var_15_8:update(self._resultParams)
	end

	if var_15_9 then
		var_15_9:update(self._resultParams)
	end

	if var_15_7 then
		var_15_7:update(self._resultParams)

		local var_15_17 = self:getChild("failedTipBg")

		if var_15_17 then
			local var_15_18 = self:getChild("n61")
			local var_15_19 = self:getChild("n64")

			if var_15_18 and var_15_19 then
				local var_15_20 = var_15_18:getSize()
				local var_15_21 = var_15_17:getSize()

				var_15_21.height = var_15_20.height + var_15_19:getSize().height + 20

				var_15_17:setSize(var_15_21)

				local var_15_22 = var_15_18:getPosition()

				var_15_22.y = var_15_22.y + var_15_20.height + 5

				var_15_19:setPosition(var_15_22)
			end
		end
	end
end

function BattleResultLayer:_retry()
	if self._resultParams.retryFunc then
		g.core.module.ModuleManager:popComponent()
		self._resultParams.retryFunc()
	end
end

function BattleResultLayer:_reset()
	local var_17_0 = g.core.model.User.fogNightmareData:getTowerData():getCurrentFloorNum()
	local var_17_1 = g.core.model.User.fogNightmareData:getTowerData():getFloorStruct(var_17_0):getSelectedStage()[1]

	g.core.network.GameNetProxy:send_C2S_Fog_Back({
		type = 2,
		floor = var_17_0,
		stage = var_17_1:getStageId(),
		wave = var_17_1:getSelectWave()
	})
end

function BattleResultLayer:_addKnight()
	local var_18_0 = self:getChild("knightComp")

	if var_18_0 and (self._resultParams.isWin or self._resultParams.noLose) then
		local var_18_1 = self._knightId

		if not self._knightId or var_18_1 == 0 then
			var_18_1 = g.core.model.User.knightsData:getMainKnight():getResInfo().painted_id
		end

		local var_18_2

		if self:getChild("resetComp") ~= nil and self._knightId then
			for iter_18_0, iter_18_1 in pairs((g.core.model.User.fogNightmareData:getFormationData():getBattleFormation():getKnightPosList())) do
				if self._knightId == iter_18_1:getAdvanceId() then
					var_18_2 = iter_18_1

					break
				end
			end
		else
			var_18_2 = g.core.model.User.knightsData:getKnight({
				advance_id = var_18_1
			})
		end

		local var_18_3 = var_18_2 and var_18_2:getResInfo().painted_id or var_18_1

		if self._skin and self._skin > 0 then
			var_18_3 = self._skin
		end

		local var_18_4 = fgui.UIPackage:createObject("base_new", "BaseKnightPicComp")

		var_18_4:updateKnight({
			resId = var_18_3
		})
		var_18_4:setAlphaRect(var_0_0.MASK_TYPE.HORIZON, cc.rect(-300, 0, 500, 0), 200)
		var_18_4:setPosition(400, 0)
		var_18_0:addChild(var_18_4)
		var_18_4:runFGAction((fgui.FSequence:create({
			fgui.FEaseCubicActionOut:create(fgui.FMoveBy:create(1, {
				x = -400,
				y = 0
			}))
		})))
	end
end

function BattleResultLayer:_checkPlayNow()
	for iter_19_0 = 1, #self._curPagePlayNowComps do
		self._curPagePlayNowComps[iter_19_0]:setVisible(true)

		if self._curPagePlayNowComps[iter_19_0].play then
			self._curPagePlayNowComps[iter_19_0]:play(self._pageCount - 1)
		end
	end
end

function BattleResultLayer:_execute()
	local var_20_1 = true

	repeat
		self._executeIndex = self._executeIndex + 1

		if self._curPageComps[self._executeIndex] then
			self._curPageComps[self._executeIndex]:setVisible(true)

			if self._curPageComps[self._executeIndex].update then
				self._curPageComps[self._executeIndex]:update(self._resultParams)
			end

			var_20_1 = self._curPageComps[self._executeIndex].play and self._curPageComps[self._executeIndex]:play(self._pageCount - 1) or false

			if var_20_1 and self._executeIndex == #self._curPageComps then
				self:_wait()
			end
		else
			self:_wait()

			break
		end
	until var_20_1
end

function BattleResultLayer:_wait()
	self._isWaiting = true

	if not self._curStateAnimPlaying then
		-- block empty
	end
end

function BattleResultLayer:_continue()
	if #self._pageList > self._pageCount then
		self._pageCount = self._pageCount + 1

		self:_checkComps()
		self:_checkPlayNow()

		self._executeIndex = 0

		self:_execute()
	else
		self:onBattleShowFinish()
	end
end

function BattleResultLayer:doAutoAction()
	if not self._canAuto then
		return true
	end

	if self._resultParams then
		BattleResultLayer.isPreBattleWin = self._resultParams.isWin
	end

	self:_continue()

	return BattleResultLayer.isPreBattleWin
end

function BattleResultLayer:onBattleShowFinish()
	if self._inShowFinish then
		return
	end

	self._inShowFinish = true

	local var_24_0 = self:getView():getTransition("back")

	self:setTouchable(false)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_END)

	if var_24_0 then
		self._curStateAnimPlaying = true

		var_24_0:play(handler(self, self.finishExitAnim))
	else
		self:finishExitAnim()
	end
end

function BattleResultLayer:finishExitAnim()
	self._curStateAnimPlaying = false

	local var_25_0 = self._exitCallParam
	local var_25_1 = self._resultParams

	if g.core.battle.BattleProxy:isHaveBattleScene() then
		self:dispatchCompEvent("BattleResult_finish")
	else
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end

	if self._waitCount and self._waitCount > 0 then
		for iter_25_0 = 1, self._waitCount do
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
		end
	end

	if var_25_1 and var_25_1.cardAwards and var_25_1.cardAwards.drops then
		if var_25_1.cardType then
			if var_25_1.cardType == var_0_7.CARD_TYPE.BIO_TEAM then
				g.core.module.ModuleManager:pushModule(g.view.entrance.BATTLE_BIO_TEAM_SEL_CARD, var_25_1)
			elseif var_25_1.cardType == var_0_7.CARD_TYPE.ARENA then
				g.core.module.ModuleManager:pushModule(g.view.entrance.BATTLE_ARENA_SELCARD, var_25_1)
			elseif var_25_1.cardType == var_0_7.CARD_TYPE.BLAZING_ARENA then
				g.core.module.ModuleManager:pushModule(g.view.entrance.BATTLE_ARENA_SELCARD, var_25_1)
			end
		else
			g.core.module.ModuleManager:pushModule(g.view.entrance.BATTLE_SELCARD, var_25_1.cardAwards)
		end
	else
		g.core.battle.BattleProxy:exitBattle()
	end

	if var_25_1.continueEvent then
		g.core.event.EventManager:dispatchEvent(var_25_1.continueEvent, false, var_25_1)
	end

	if var_25_0 then
		g.view.entrance.ModuleGotoProxy:gotoModuleByParams({
			popToRoot = false,
			srcRouteId = var_25_0.srcId
		})
	end

	if g.core.model.User.themeData:getTurnCardResetGame() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_THEME_RESET_TURN_CARD_GAME)
	elseif g.core.model.User.themeData:getGemEliminateResetGame() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_THEME_RESET_GEM_ELIMINATE_GAME)
	elseif g.core.model.User.themeData:getThemePuzzleResetGame() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_THEME_RESET_PUZZLE_GAME)
	elseif g.core.model.User.themeData:getGuessResetGame() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_THEME_RESET_GUESS_GAME)
	end
end

function BattleResultLayer:_onTouchBegin()
	if self._isWaiting and not self._curStateAnimPlaying and not self._forbidTouch then
		self:_continue()

		self._isWaiting = false
	end
end

function BattleResultLayer:_onResetLeave()
	g.core.model.User.fogNightmareData:setIsEnterFormation(true)
	self:_continue()

	self._isWaiting = false
end

function BattleResultLayer:onCancelCallback()
	return
end

function BattleResultLayer:_checkBattleFailedGuide(arg_29_1)
	if arg_29_1 and not arg_29_1.isWin and not arg_29_1.noLose then
		local var_29_0 = g.core.common.Storage:load("battle_fail_count.json") or {
			count = 0
		}

		var_29_0.count = var_29_0.count + 1

		g.core.common.Storage:save("battle_fail_count.json", var_29_0)
	end
end

return BattleResultLayer
