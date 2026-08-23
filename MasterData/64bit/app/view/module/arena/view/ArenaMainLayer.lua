local var_0_0 = g.core.const.ConstMgr.TaskConst
local var_0_1 = g.core.const.ConstMgr.FUNCTION_TYPE
local ArenaCommon = require("app.view.module.arena.common.ArenaCommon")
local var_0_3 = g.core.const.ConstMgr.SpineConst
local var_0_4 = g.core.common.Goods
local var_0_5 = g.core.const.ConstMgr.ShopConst
local ArenaMainLayer = class("ArenaMainLayer", require("app.fairyGUI.arena.UI_ArenaMainLayer"), function()
	return fgui.GComponent:create({
		pkgName = "arena",
		isFullScreen = true,
		pkgPath = "ui/arena/arena",
		resName = "ArenaMainLayer"
	}, ...)
end)

function ArenaMainLayer:ctor()
	self._newlyCreated = true
	self._challengeNum = 0
	self._enterBattle = false
	self._formation = {}

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	self._inWaitState = true
	self._clickBuy = false

	self:_initView()
	self:_addListenerToBtns()
	self:_initListView()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.ARENA)
end

function ArenaMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ARENA_GETMAININFO, self._onArenaGetMainInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ARENA_CHALLENGEBEGIN, self._onArenaChallengeBegin, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ARENA_ONEKEYCHALLENGE, self._onOneKeyChallenge, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SHOP_SHOPPING, self._onRcvShopping, self)
	self:_initMyInfo()
	self:_updateLineupList()

	if self._enterBattle then
		self._enterBattle = false

		self:_playRankUp()
		g.core.network.GameNetProxy:send_C2S_Arena_GetMainInfo({})
	else
		self:_updateView()
	end

	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_BATTLE_PVP)
	g.core.network.GameNetProxy:send_C2S_GetModuleTaskInfo({
		module_id = var_0_0.MODULE_ID.ARENA
	})
end

function ArenaMainLayer:_initView()
	self:addBg("bg/arena/bg_jjc_zhujiemian.jpg")
	self:_initOneKeyBtn()
	self.m_topBarComp:setResInfoById(29)
	self.m_deployWordLoader:setURL("ui://text_new/txt_jjc_zhenrong")

	local var_4_0 = g.core.model.User.activityLifeTimeCardData:isSubscription()

	self.m_challengesNumComp:initView({
		playNum = 1,
		getTimesFunc = function()
			return g.core.model.User.shopData:getLeftCount(1) or 0
		end,
		fullTime = g.core.const.ConstMgr.ArenaConst.MAX_NUM_CHALLENGES_STORE,
		onGetTimes = handler(self, self._onClickBuy),
		refreshEvent = {
			g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM
		}
	})
	self.m_lineupBtn:addClickListener(handler(self, self._onLineUpClick))
end

function ArenaMainLayer:_initOneKeyBtn()
	local var_6_0 = g.core.common.ModuleUnlock:isModuleUnlock(var_0_1.ARENA_ONEKEY_CHALLANGE)

	self.m_oneKeyBtn:setVisible(var_6_0)
	self.m_arenaWordImg:setVisible(not var_6_0)
end

function ArenaMainLayer:_updateLineupList()
	self._formation = g.core.model.User.knightsData:getFormation()

	self.m_lineupList:setNumItems(#self._formation)
end

function ArenaMainLayer:_addListenerToBtns()
	self.m_rankBtn:addClickListener(handler(self, self._onRankClick))
	self.m_shopBtn:addClickListener(handler(self, self._onShopClick))
	self.m_taskBtn:addClickListener(handler(self, self._onTaskClick))
	self.m_recordBtn:addClickListener(handler(self, self._onRecordClick))
	self.m_oneKeyBtn:addClickListener(handler(self, self._onOneKeyClick))
	self.m_lineUpBgLoader:addClickListener(handler(self, self._onLineUpClick))
end

function ArenaMainLayer:_initMyInfo()
	self.m_knightPicComp:updateKnight({
		scale = 0.9,
		resId = g.core.model.User:getAssistantResInfo().painted_id
	})
	self.m_knightPicComp:setAlphaRect(var_0_3.MASK_TYPE.HORIZON, cc.rect(-300, 0, 400, 0), 200)
	self.m_powerNumText:setText(g.core.model.User:getFightValue())
end

function ArenaMainLayer:_playRankUp()
	local var_10_0 = g.core.battle.BattleShowResult:getLastBattle()

	if var_10_0 and var_10_0.max_rank_awards then
		local var_10_1, var_10_2 = g.core.model.User.arenaData:getRank()

		g.core.module.ModuleManager:pushPopup(require("app.view.module.arena.view.ArenaRankUpPop").new({
			curRank = var_10_1,
			oldRank = var_10_2,
			max_rank_awards = var_10_0.max_rank_awards
		}), {
			ignoreTouch = true
		})
	end
end

function ArenaMainLayer:_updateView()
	self.m_myRankText:setText(g.core.model.User.arenaData:getRank() or g.core.lang:get(302501))
	self.m_challengeListComp:updateView()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_shopBtn
	})

	if self._newlyCreated then
		self._newlyCreated = false

		self.m_enterTransition:play(handler(self, self._onEnterAnimEnd))
		self.m_challengeListComp:playRollAni()
	end
end

function ArenaMainLayer:_onEnterAnimEnd()
	if self._inWaitState then
		self._inWaitState = false

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end
end

function ArenaMainLayer:_initListView()
	self.m_lineupList:setVirtual()
	self.m_lineupList:setItemRenderer(handler(self, self._onLineupList))
end

function ArenaMainLayer:_onLineupList(arg_14_1, arg_14_2)
	arg_14_2:updateComp(arg_14_1 + 1, (self._formation[arg_14_1 + 1] and self._formation[arg_14_1 + 1] ~= 0 or nil) and {
		sid = self._formation[arg_14_1 + 1]
	})
end

function ArenaMainLayer:_onArenaGetMainInfo(arg_15_1, arg_15_2, arg_15_3)
	self:_updateView()
end

function ArenaMainLayer:_onArenaChallengeBegin(arg_16_1, arg_16_2, arg_16_3)
	self._enterBattle = true

	local BattleConst = require("app.view.battle.const.BattleConst")

	g.core.battle.BattleProxy:enterBattle({
		cloudLoading = true,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		type = BattleConst.TYPE_ARENA,
		battle_id = arg_16_3.battle_id,
		battleType = BattleConst.BATTLE_TYPE.PVP,
		bgm = g.core.const.ConstMgr.SoundConst.BGM.MUSIC_BATTLE_PVP_B
	})
end

function ArenaMainLayer:_onOneKeyChallenge(arg_17_1, arg_17_2, arg_17_3)
	g.core.network.GameNetProxy:send_C2S_GetModuleTaskInfo({
		module_id = var_0_0.MODULE_ID.ARENA
	})
end

function ArenaMainLayer:_onLineUpClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION)
end

function ArenaMainLayer:_onRankClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.arena.view.ArenaRankLayer").new(), {
		ignoreTouch = true
	})
end

function ArenaMainLayer:_onShopClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.ARENA
	})
end

function ArenaMainLayer:_onTaskClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.arena.view.ArenaTaskPop").new(), {
		hideContinue = true,
		touchDisappear = true
	})
end

function ArenaMainLayer:_onRecordClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.arena.view.ArenaRecordLayer").new(), {
		ignoreTouch = true
	})
end

function ArenaMainLayer:_onOneKeyClick()
	if ArenaCommon.checkLeftCount() then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.arena.view.ArenaOneKeyPop").new()))
	else
		self._clickBuy = false
	end
end

function ArenaMainLayer:_onClickBuy()
	g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseUseBuyPop").new({
		type = var_0_4.TYPE_ITEM,
		value = var_0_4.ITEM.TYPE_ARENA_TOKEN,
		shopId = var_0_5.SHOP_ITEM_ID.ARENA_TOKEN
	}), {
		touchDisappear = true
	})

	self._clickBuy = true
end

function ArenaMainLayer:onUnload()
	if self._inWaitState then
		self._inWaitState = false

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end
end

function ArenaMainLayer:_onRcvShopping(arg_26_1, arg_26_2, arg_26_3)
	if not self.m_oneKeyBtn:isVisible() or self._clickBuy then
		return
	end

	local var_26_0 = arg_26_3.awards

	if arg_26_3.awards and var_26_0[1] and var_26_0[1].type == 3 and var_26_0[1].value == 16 then
		self:newScheduleOnce(handler(self, self._onOneKeyClick), 0.5)
	end
end

function ArenaMainLayer:receiveCompEvent(arg_27_1, arg_27_2)
	if arg_27_1 == "continueOneKey" then
		self:newScheduleOnce(handler(self, self._onOneKeyClick), 0.5)

		return true
	end
end

return ArenaMainLayer
