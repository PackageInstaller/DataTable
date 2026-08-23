local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.model.User
local var_0_3 = g.core.model.User.blazingArenaData
local var_0_4 = g.core.const.ConstMgr
local var_0_5 = g.core.const.ConstMgr.BlazingArenaConst
local var_0_6 = g.core.model.User.mulFormationData
local var_0_7 = g.core.module.ModuleManager
local var_0_8 = g.core.network.GameNetProxy
local var_0_9 = g.core.common.ServerTime
local BattleConst = require("app.view.battle.const.BattleConst")
local BlazingArenaMainLayer = class("BlazingArenaMainLayer", require("app.fairyGUI.blazingArena.UI_BlazingArenaMainLayer"), function()
	return fgui.GComponent:create({
		resName = "BlazingArenaMainLayer",
		pkgPath = "ui/blazingArena/blazingArena",
		isFullScreen = true,
		pkgName = "blazingArena"
	}, ...)
end)

function BlazingArenaMainLayer:ctor()
	self._playerList = {}

	var_0_3:resetHelperDic()
	self:_initBtn()
	self:_initView()
	self:_initListView()
end

function BlazingArenaMainLayer:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_BLAZING_ARENA_GETINFO, self._onS2CGetInfo, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_FORMATION_GET, self._onS2CFormationGet, self)
	var_0_1:addEventListener(var_0_0.EVENT_CROSS_DAY_NOTIFY, self._onCrossDay, self)
	var_0_1:addEventListener(var_0_0.EVENT_QUARTER_MINUTE_NOTIFY, self._updateCurStage, self)
	var_0_1:addEventListener(var_0_0.EVENT_MODULE_EXIT, self._onModuleExit, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_BLAZING_ARENA_SWEEP, self._onS2CSweep, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_BLAZING_ARENA_CHALLENGEBEGIN, self._onChiefArenaChallengeBegin, self)
	var_0_8:send_C2S_BlazingArena_GetInfo({})
	var_0_8:send_C2S_Formation_Get({
		tp = var_0_4.LineUpConst.MulTeamType.BLAZING_ARENA
	})
	self.m_robotHolder:removeChildren()
	self.m_lineupHolder:removeChildren()
	self.m_enterTransition:play(handler(self, self._onEnterAnimFinish))
	self.m_effRoll:addEffectSpine({
		anim = "play",
		name = "eff_ui_blazingArena_roll",
		remove = true,
		isLoop = false
	})
	var_0_1:dispatchEvent(var_0_0.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_borrowRedPointComp
	})
	var_0_1:dispatchEvent(var_0_0.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_shopBtn
	})
	var_0_1:dispatchEvent(var_0_0.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_taskBtn
	})
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_PVP)
end

function BlazingArenaMainLayer:onUnload()
	var_0_1:dispatchEvent(var_0_0.EVENT_TICK_WEAK_GUIDE_FINISH)
end

function BlazingArenaMainLayer:_initBtn()
	self.m_rankBtn:addClickListener(handler(self, self._onRankBtnClick))
	self.m_shopBtn:addClickListener(handler(self, self._onShopBtnClick))
	self.m_taskBtn:addClickListener(handler(self, self._onTaskBtnClick))
	self.m_borrowBtn:addClickListener(handler(self, self._onBorrowBtnClick))
	self.m_lineupHolder:addClickListener(handler(self, self._onLineUpBtnClick))
	self.m_lineUpTouch:addClickListener(handler(self, self._onLineUpBtnClick))
	self.m_serverTipBtn:addClickListener(handler(self, self._onServerTipBtnClick))
	self.m_skipFormation:addClickListener(handler(self, self._onClickSkipFormation))
end

function BlazingArenaMainLayer:_initView()
	self:addBg("bg/blazingArena/bg_bljt_rukoubg.jpg")
	self.m_topBarComp:setResInfoById(var_0_5.MAIN_TOP_BAR_ID)
	self.m_skipFormation:setSelected(var_0_3:isSkipFormation())
	self.m_knightPicComp:updateKnight({
		scale = 1,
		resId = var_0_2:getAssistantResInfo().painted_id
	})
	self.m_challengesNumComp:initView({
		playNum = var_0_5.LEFT_TIME_TYPE,
		getTimesFunc = function()
			return var_0_3:getAttackTimes()
		end,
		onGetTimes = handler(self, self._onClickBuy),
		refreshEvent = {
			var_0_0.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM
		}
	})

	local var_6_0 = cc.Director:getInstance():getSafeAreaRect()

	if var_6_0.x > 0 then
		self.m_challengeList:setWidth(self.m_challengeList:getWidth() - var_6_0.x)
	end

	self.m_effBorrow:addEffectSpine({
		isLoop = true,
		name = "eff_ui_blazingArena_btn"
	})
	self.m_effArrowLeft:addEffectSpine({
		isLoop = true,
		name = "eff_ui_arena_cutarrow"
	})
	self.m_effArrowright:addEffectSpine({
		isLoop = true,
		name = "eff_ui_arena_cutarrow"
	})
	var_0_1:dispatchEvent(var_0_0.EVENT_GUIDE_WAIT)
	var_0_2.functionUnlockData:saveUnlockedFunc(var_0_4.FUNCTION_TYPE.BLAZING_ARENA)
end

function BlazingArenaMainLayer:_onEnterAnimFinish()
	g.core.common.Scheduler:newScheduleOnce(function()
		var_0_1:dispatchEvent(var_0_0.EVENT_GUIDE_READY)
	end, 0)
end

function BlazingArenaMainLayer:_initListView()
	self.m_challengeList:setVirtual(self)
	self.m_challengeList:doFairyBatching(false)
	self.m_challengeList:setItemRenderer(handler(self, self._onRenderChallengeList))
	self.m_challengeList:addEventListener(fgui.UIEventType.Scroll, handler(self, self._onListScroll))
end

function BlazingArenaMainLayer:_updateView()
	local var_11_0 = var_0_3:getCurRank()

	self.m_myRankText:setText(var_11_0)
	self.m_haveRankController:setSelectedIndex(var_11_0 > 0 and 1 or 0)
	self.m_isLocalController:setSelectedIndex(var_0_3:isLocalServer() and 1 or 0)
	self.m_fightValueText:setText(var_0_3:getCurTeamFightValue())
	self.m_challengesNumComp:updateView()

	if var_0_3:getEnterBattleStatus() then
		self:_playRankUp()
		var_0_3:setEnterBattleStatus(false)
	end

	self:_updateCurStage()
	self:_updatePlayerList()
	self:_updateLineupList()
end

function BlazingArenaMainLayer:_updateCurStage()
	local var_12_0 = var_0_3:isInActivityPlayTime()

	self.m_seasonText:setText(g.core.lang:get(var_12_0 and 431424 or 431425))

	local var_12_1 = var_0_3:getActivityOpenTime()
	local var_12_2 = var_0_3:getActivityShowTime()
	local var_12_3 = var_0_3:getCampaignEntranceCDTime()

	self.m_seasonTimeText:setText((g.core.lang:get(411001, {
		start = self:_getYMDHM((var_0_9:getDateObject(var_12_0 and var_12_1 or var_12_2))),
		endT = self:_getYMDHM((var_0_9:getDateObject(var_12_0 and var_12_3 or var_12_3 - 1)))
	})))
end

function BlazingArenaMainLayer:_getYMDHM(arg_13_1)
	local var_13_0 = {
		arg_13_1.hour,
		arg_13_1.min
	}

	return table.concat({
		arg_13_1.year,
		arg_13_1.month,
		arg_13_1.day
	}, "/") .. " " .. string.format("%02d:%02d", var_13_0[1], var_13_0[2])
end

function BlazingArenaMainLayer:_onRenderChallengeList(arg_14_1, arg_14_2)
	arg_14_2:updateChallengeCell(self._playerList[arg_14_1 + 1], arg_14_1)
end

function BlazingArenaMainLayer:_updatePlayerList()
	self._playerList = var_0_3:getMatchPlayerList()

	self.m_challengeList:setNumItems(#self._playerList)
end

function BlazingArenaMainLayer:_updateLineupList()
	if self._mulFormationDict then
		self.m_formationLineComp:updateComp(self._mulFormationDict)
	end

	var_0_1:dispatchEvent(var_0_0.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_lineupBtn,
		customData = {
			formationType = var_0_4.LineUpConst.MulTeamType.BLAZING_ARENA
		}
	})
end

function BlazingArenaMainLayer:_onListScroll()
	local var_17_0 = self.m_challengeList:numChildren()
	local var_17_1 = true

	if var_17_0 <= 0 then
		return
	end

	if self.m_challengeList:childIndexToItemIndex(0) == 0 then
		local var_17_2 = self.m_challengeList:globalToLocal((self.m_challengeList:getChildAt(0):localToGlobal(cc.p(0, 0))))

		if var_17_2.x + 50 > 0 then
			var_17_1 = false
		elseif var_17_2.x < 50 then
			var_17_1 = true
		end
	end

	if self.m_effArrowLeft:isVisible() ~= var_17_1 then
		if var_17_1 then
			self.m_effArrowLeft:stopAllFGActions()
			self.m_effArrowLeft:setOpacity(0)
			self.m_effArrowLeft:runFGAction(fgui.FFadeTo:create(1, 255))
		end

		self.m_effArrowLeft:setVisible(var_17_1)
	end

	local var_17_3 = true

	if self.m_challengeList:childIndexToItemIndex(var_17_0 - 1) == #self._playerList - 1 then
		local var_17_4 = self.m_challengeList:getChildAt(var_17_0 - 1)
		local var_17_5 = self.m_challengeList:globalToLocal((var_17_4:localToGlobal(cc.p(var_17_4:getWidth(), 0))))

		if var_17_5.x < self.m_challengeList:getWidth() + 50 then
			var_17_3 = false
		elseif var_17_5.x > self.m_challengeList:getWidth() - 50 then
			var_17_3 = true
		end
	end

	if self.m_effArrowright:isVisible() ~= var_17_3 then
		if var_17_3 then
			self.m_effArrowright:stopAllFGActions()
			self.m_effArrowright:setOpacity(0)
			self.m_effArrowright:runFGAction(fgui.FFadeTo:create(1, 255))
		end

		self.m_effArrowright:setVisible(var_17_3)
	end
end

function BlazingArenaMainLayer:_onRankBtnClick()
	var_0_7:pushPopup(require("app.view.module.blazingArena.view.BlazingArenaRankLayer").new(), {
		ignoreTouch = true
	})
end

function BlazingArenaMainLayer:_onShopBtnClick()
	var_0_7:pushModule(g.view.entrance.SHOP, {
		tabType = var_0_4.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = var_0_4.ShopConst.SHOP_TYPE.BLAZING_ARENA
	})
end

function BlazingArenaMainLayer:_onTaskBtnClick()
	var_0_7:pushPopup(require("app.view.module.blazingArena.view.BlazingArenaTaskPop").new(), {
		touchDisappear = true,
		hideContinue = true
	})
end

function BlazingArenaMainLayer:_onBorrowBtnClick()
	var_0_7:pushPopup(require("app.view.module.blazingArena.view.BlazingArenaBorrowPop").new(), {
		touchDisappear = true,
		hideContinue = true
	})
end

function BlazingArenaMainLayer:_onLineUpBtnClick()
	var_0_7:pushModule(g.view.entrance.BLAZING_ARENA_FORMATION)
end

function BlazingArenaMainLayer:_onServerTipBtnClick()
	var_0_7:pushPopup(require("app.view.module.blazingArena.view.BlazingArenaMatchServerPop").new(), {
		touchDisappear = true,
		hideContinue = true
	})
end

function BlazingArenaMainLayer:_onClickSkipFormation()
	var_0_3:setSkipFormation(self.m_skipFormation:isSelected())
end

function BlazingArenaMainLayer:_playRankUp()
	if var_0_3:getLastMaxRank() > var_0_3:getCurRank() then
		var_0_3:saveLastRank()
		var_0_7:pushPopup(require("app.view.module.blazingArena.view.BlazingArenaRankUpPop").new({
			curRank = var_0_3:getCurRank(),
			break_awards = var_0_3:getBreakAwards()
		}), {
			ignoreTouch = true
		})
	end
end

function BlazingArenaMainLayer:_onClickBuy()
	var_0_7:pushPopup(require("app.view.base.infoPop.BaseUseBuyPop").new({
		type = g.core.common.Goods.TYPE_ITEM,
		value = g.core.common.Goods.ITEM.TYPE_BLAZING_ARENA_TOKEN,
		shopId = var_0_4.ShopConst.SHOP_ITEM_ID.BLAZING_ARENA_TOKEN
	}), {
		touchDisappear = true
	})
end

function BlazingArenaMainLayer:_onS2CGetInfo(arg_27_1, arg_27_2, arg_27_3)
	self:_updateView()
end

function BlazingArenaMainLayer:_onS2CFormationGet()
	self._mulFormationDict = var_0_6:getFormationStructDict()

	var_0_1:dispatchEvent(var_0_0.MUL_CHANGE_ALL, false)
	self.m_fightValueText:setText(var_0_3:getCurTeamFightValue())
	self:_updateLineupList()
	self:newScheduleOnce(function()
		local var_29_0 = var_0_3:getAllExpiredMember()

		if #var_29_0.typeList > 0 then
			for iter_29_0 = 1, #var_29_0.typeList do
				var_0_3:doTakeOffHelpMembers(var_29_0.typeList[iter_29_0], var_29_0.itemList[iter_29_0])
			end

			g.core.module.ModuleManager:tip(g.core.lang:get(431421))
		end
	end, 0.5)
	g.core.common.Scheduler:newScheduleOnce(function()
		var_0_1:dispatchEvent(var_0_0.EVENT_WEAK_GUIDE_READY)
	end, 0)
end

function BlazingArenaMainLayer:_onCrossDay(arg_31_1, arg_31_2, arg_31_3)
	var_0_3:resetHelperDic()
	var_0_8:send_C2S_BlazingArena_GetInfo({})
	var_0_8:send_C2S_Formation_Get({
		tp = var_0_4.LineUpConst.MulTeamType.BLAZING_ARENA
	})
end

function BlazingArenaMainLayer:_onModuleExit()
	var_0_1:dispatchEvent(var_0_0.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_borrowRedPointComp
	})
end

function BlazingArenaMainLayer:_onS2CSweep(arg_33_1, arg_33_2, arg_33_3)
	g.core.module.ModuleManager:awardSummary((var_0_3:getSweepAwards()))
end

function BlazingArenaMainLayer:_onChiefArenaChallengeBegin(arg_34_1, arg_34_2, arg_34_3)
	if arg_34_3.ret == 3426 or arg_34_3.ret == 3429 then
		return
	end

	g.core.battle.BattleProxy:enterBattle({
		cloudLoading = true,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		type = BattleConst.TYPE_BLAZING_ARENA,
		battle_id = arg_34_3.battle_id,
		battleType = BattleConst.BATTLE_TYPE.PVP,
		bgm = g.core.const.ConstMgr.SoundConst.BGM.MUSIC_BATTLE_PVP_B
	})
end

return BlazingArenaMainLayer
