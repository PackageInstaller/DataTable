local var_0_0 = g.core.const.ConstMgr
local var_0_1 = g.core.model.User.pubgData
local var_0_2 = g.core.const.ConstMgr.PubgConst
local var_0_3 = g.core.common.ServerTime
local PubgMainLayer = class("PubgMainLayer", require("app.fairyGUI.pubg.UI_PubgMainLayer"), function()
	return fgui.GComponent:create({
		pkgName = "pubg",
		isFullScreen = true,
		pkgPath = "ui/pubg/pubg",
		resName = "PubgMainLayer"
	}, ...)
end)

function PubgMainLayer:ctor(arg_2_1)
	self:_initView()
	self:_initBtn()
	self.m_effBg:addEffectSpine({
		isLoop = true,
		anim = "play",
		name = "eff_ui_pubg_layerBg"
	})
end

function PubgMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_GETINFO, handler(self, self._onRecvGetInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_MATCH, handler(self, self._onRecvMatchBegin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._updateTopPlayer, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._updateTopPlayer, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PUBG_CANCELMATCH, handler(self, self._onReqPubgInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDay, self)
	self:onCheckWeakGuide()
	self:_onReqPubgInfo()
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_Escape)
end

function PubgMainLayer:_onReqPubgInfo()
	g.core.network.GameNetProxy:send_C2S_Pubg_GetInfo({})

	if var_0_1:getCurStage() == var_0_2.GAME_STATE.SHOW and not self._isReqTop3 then
		self._isReqTop3 = true

		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			size = 3,
			id = var_0_2.RANK_TYPE
		})
		self.m_enter1Transition:play()
	else
		self.m_enter0Transition:play()
	end

	g.core.network.GameNetProxy:send_C2S_Pubg_TaskInfo({})

	if #var_0_1:getGameServerList() <= 0 then
		g.core.network.GameNetProxy:send_C2S_Pubg_ServerInfos({})
	end
end

function PubgMainLayer:onCheckWeakGuide()
	local var_5_0 = var_0_1:getCurStage()

	if var_5_0 == var_0_2.GAME_STATE.REGULAR or var_5_0 == var_0_2.GAME_STATE.FINAL then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	end
end

function PubgMainLayer:_initBtn()
	self.m_ruleBtn:addClickListener(handler(self, self._onRuleBtnClick))
	self.m_shopBtn:addClickListener(handler(self, self._onShopBtnClick))
	self.m_rankBtn:addClickListener(handler(self, self._onRankBtnClick))
	self.m_taskBtn:addClickListener(handler(self, self._onTaskBtnClick))
	self.m_fightBtn:addClickListener(handler(self, self._onFightBtnClick))
end

function PubgMainLayer:_initView(arg_7_1)
	self.m_bgLoader = self:addBg("bg/pubg/bg_sihaiqiusheng_zjm.jpg")

	self.m_topBarComp:setResInfoById(var_0_2.MAIN_TOP_BAR_ID)
	self.m_playTimesComp:initView({
		playNum = var_0_2.LEFT_TIME_TYPE,
		getTimesFunc = function()
			return var_0_1:getAttackTimes()
		end,
		refreshEvent = {
			g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM
		}
	})

	local var_7_0, var_7_1 = var_0_1:getStageStartEndTime(var_0_2.GAME_STATE.REGULAR)

	self.m_regularTimeText:setText(var_0_3:getDateMDHFormat(var_7_0) .. "~" .. var_0_3:getDateMDHFormat(var_7_1))

	local var_7_2, var_7_3 = var_0_1:getStageStartEndTime(var_0_2.GAME_STATE.FINAL)

	self.m_finalTimeText:setText(var_0_3:getDateMDHFormat(var_7_2) .. "~" .. var_0_3:getDateMDHFormat(var_7_3))
	self.m_doubleTimeText:setText(var_0_1:getHotTimeDesc())

	self.m_btnEffSpine = self.m_effBtn:addEffectSpine({
		isLoop = true,
		anim = "play",
		name = "eff_ui_pubg_btn"
	})

	g.core.model.User.functionUnlockData:saveUnlockedFunc(var_0_0.FUNCTION_TYPE.PUBG)
	self:_updateView()
end

function PubgMainLayer:_updateView()
	local var_9_0 = var_0_1:getCurStage()

	if var_9_0 == var_0_2.GAME_STATE.REGULAR or var_9_0 == var_0_2.GAME_STATE.FINAL then
		self:_updateGameStateView()
	elseif var_9_0 == var_0_2.GAME_STATE.SHOW then
		self:_updateShowStateView()
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(308618))
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_taskBtn
	})
end

function PubgMainLayer:_updateGameStateView()
	self.m_stateController:setSelectedIndex(0)

	local var_10_0 = var_0_1:getCurStage()

	self.m_gameStateController:setSelectedIndex(var_10_0 == var_0_2.GAME_STATE.REGULAR and 0 or 1)
	self.m_playTimesComp:updateView()

	if self.m_btnEffSpine then
		self.m_btnEffSpine:setVisible(var_0_1:getAttackTimes() > 0)
	end

	local var_10_1, var_10_2 = var_0_1:getMyTotalRankAndScore()
	local var_10_3 = var_0_1:getDailyMaxScore()
	local var_10_4 = var_0_1:getDailyMaxRank()

	self.m_rankController:setSelectedIndex(var_10_1 > 0 and 1 or 0)

	if var_10_1 > 0 then
		self.m_curRankText:setText(var_10_1)
		self.m_curScoreText:setText(var_10_2)
	elseif var_10_2 > 0 then
		self.m_curScoreText:setText(var_10_2)
	end

	if var_10_4 > 0 then
		self.m_dailyMaxText:setText(var_10_3 .. "/" .. var_10_4)
	elseif var_10_3 > 0 then
		self.m_dailyMaxText:setText(var_10_3 .. "/" .. g.core.lang:get(430941))
	else
		self.m_dailyMaxText:setText(g.core.lang:get(430942) .. "/" .. g.core.lang:get(430941))
	end

	local var_10_5, var_10_6 = var_0_1:getStageStartEndTime(var_10_0)

	self.m_curGameDateText:setText(var_0_3:getDateMDFormatWithDot(var_10_5) .. "~" .. var_0_3:getDateMDFormatWithDot(var_10_6))
	self.m_curMatchText:setText(g.core.lang:get(430934, {
		num = var_0_1:getCurMatchNum()
	}))
end

function PubgMainLayer:_updateShowStateView()
	self.m_bgLoader:setURL("bg/pubg/bg_shqs_jieshubg.jpg")
	self.m_stateController:setSelectedIndex(1)
	self:_updateTopPlayer()
end

function PubgMainLayer:_updateTopPlayer()
	local var_12_0 = var_0_1:getRankPlayerListByRankType(var_0_2.RANK_TYPE)

	self:_updateTopUserView(var_12_0[1])

	for iter_12_0 = 1, 3 do
		self["m_showComp" .. iter_12_0]:updatePlayerComp(var_12_0[iter_12_0])
	end
end

function PubgMainLayer:_updateTopUserView(arg_13_1)
	if not arg_13_1 then
		return
	end

	local var_13_0 = g.core.model.User.snapShotCacheData:getSnapShot(var_0_0.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_13_1.id)

	if not var_13_0 or self._topUserSpine then
		return
	end

	local var_13_1 = var_13_0.show_knight_id or 0
	local var_13_2, var_13_3

	if var_13_1 < 1 then
		var_13_1 = var_13_0.base_id
		var_13_2 = require("app.view.common.DrawKnight").new
		var_13_3 = {
			isShowBg = true
		}
	end

	var_13_3.resId = g.core.model.User.knightsData:getKnightResInfo({
		knightId = var_13_1,
		skinId = var_13_0.show_knight_dress
	}).painted_id
	self._topUserSpine = require("app.view.common.DrawKnight").new(var_13_3)

	self.m_knightSpineMid:addChild(self._topUserSpine)
	self.m_topUserNameText:setText(var_13_0.name)
end

function PubgMainLayer:_onRecvGetInfo(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	self:_updateView()

	if var_0_1:getCurMatchState() == var_0_2.MATCH_STATE.IN_GAME then
		g.core.module.ModuleManager:pushModule(g.view.entrance.PUBG_MAP_LAYER)
	end
end

function PubgMainLayer:_onRecvMatchBegin(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.pubg.view.PubgMatchingPop").new(), {
		touchDisappear = false
	})
end

function PubgMainLayer:_onCrossDay(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	self:_onReqPubgInfo()
	self:_updateView()
end

function PubgMainLayer:_onRuleBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.pubg.view.PubgRulePop").new(), {
		touchDisappear = true,
		hideContinue = false
	})
end

function PubgMainLayer:_onShopBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = var_0_0.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = var_0_0.ShopConst.SHOP_TYPE.PUBG
	})
end

function PubgMainLayer:_onRankBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.PUBG_RANK_LAYER)
end

function PubgMainLayer:_onTaskBtnClick()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.pubg.view.PubgTaskPop").new()))
end

function PubgMainLayer:_onFightBtnClick()
	if var_0_1:getAttackTimes() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(430933))

		return
	end

	g.core.network.GameNetProxy:send_C2S_Pubg_Match({})
end

return PubgMainLayer
