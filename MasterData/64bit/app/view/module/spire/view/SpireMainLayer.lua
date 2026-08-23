local var_0_0 = g.core.const.ConstMgr.SpireConst
local var_0_1 = g.core.model.User.spireData
local var_0_2 = g.core.const.ConstMgr
local SpireMainLayer = class("SpireMainLayer", require("app.fairyGUI.spire.UI_SpireMainLayer"), function()
	return fgui.GComponent:create({
		pkgName = "spire",
		isFullScreen = true,
		pkgPath = "ui/spire/spire",
		resName = "SpireMainLayer"
	}, ...)
end)

function SpireMainLayer:ctor(arg_2_1)
	self._reqFType = nil

	self:_initView()
	self:_initBtn()
end

function SpireMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SPIRE_GETINFO, handler(self, self._onRecvGetInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self.updateView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_QUARTER_MINUTE_NOTIFY, handler(self, self.updateIdleState), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FORMATION_GET, handler(self, self._enterChallengeLayer), self)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_collectBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_spireItem1,
		customData = {
			index = 1
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_spireItem2,
		customData = {
			index = 2
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_spireItem3,
		customData = {
			index = 3
		}
	})
	g.core.network.GameNetProxy:send_C2S_Spire_GetInfo({})
	self.m_enterTransition:play(handler(self, self.updateView))
	self.m_getBoxTransition:play(-1, 0)
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_PVE)
end

function SpireMainLayer:_initBtn()
	for iter_4_0 = 1, 3 do
		self["m_spireItem" .. iter_4_0]:addClickListener(handler(self, function()
			self:_onTowerDeatailClick(iter_4_0)
		end))
	end

	self.m_bossClickLoader:addClickListener(handler(self, self._onBossClick))
	self.m_shopBtn:addClickListener(handler(self, self._onShopBtnClick))
	self.m_rankBtn:addClickListener(handler(self, self._onRankBtnClick))
	self.m_collectBtn:addClickListener(handler(self, self._onCollectBtnClick))
	self.m_matchServerBtn:addClickListener(handler(self, self._onMatchServerBtnClick))
end

function SpireMainLayer:_initView(arg_6_1)
	self:addBg("bg/spire/bg_shmc_zhujiem.jpg")
	self.m_topBarComp:setResInfoById(var_0_0.MAIN_TOP_BAR_ID)
	self.m_timeText:setText(g.core.lang:get(432008) .. g.core.lang:get(411001, {
		start = g.core.common.ServerTime:getDateMDHMFormat((var_0_1:getActivityOpenTime())),
		endT = g.core.common.ServerTime:getDateMDHMFormat(var_0_1:getActivityEndTime() - 1)
	}))
	self.m_isCrossController:setSelectedIndex(var_0_1:isCrossGame() and 1 or 0)
	self.m_bgEff:addEffectSpine({
		name = "eff_ui_spire_mainbg",
		anim = "play",
		isLoop = true
	})
	self.m_titleEff:addEffectSpine({
		name = "eff_ui_spire_maintitle",
		anim = "play",
		isLoop = true
	})
	self.m_bannerEff:addEffectSpine({
		name = "eff_ui_spire_mainbanner",
		anim = "play",
		isLoop = true
	})

	self.m_collectEffect = self.m_collectEffLoader:addEffectSpine({
		name = "eff_ui_spire_box",
		anim = "play",
		isLoop = true
	})

	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.SPIRE)
end

function SpireMainLayer:updateView()
	if not var_0_1:isActivityOpen() then
		g.core.module.ModuleManager:tip(g.core.lang:get(308618))
		g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end

	local var_7_0 = var_0_1:getSpireTowerList()

	for iter_7_0 = 1, #var_7_0 do
		self["m_spireItem" .. iter_7_0]:updateTowerInfo(var_7_0[iter_7_0])
	end

	local var_7_1 = var_0_1:getBossTower()

	self.m_canBossController:setSelectedIndex(var_7_1:isPass(true) and 1 or 0)
	self.m_haveRankController:setSelectedIndex(var_7_1:isPass(true) and 1 or 0)
	self:updateIdleState()

	local var_7_2 = var_0_1:getBossTower():getMaxFloor():getBossStage()

	self.m_bossNameText:setText(var_7_2:getCfg().name)
	self.m_bossComp:setIcon(g.core.common.Path:getRoleHeadIcon((var_7_2:getShowSpineId())))

	local var_7_3 = var_0_1:getCurStage()

	if var_7_3 ~= var_0_0.STAGE.SHOW_RESULT and var_7_3 ~= var_0_0.STAGE.NOT_OPEN then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	end
end

function SpireMainLayer:updateIdleState()
	if not var_0_1:isActivityInSeason() then
		self.m_canCollectController:setSelectedIndex(0)
		self.m_collectEffect:setVisible(false)

		return
	end

	local var_8_0 = g.core.common.ServerTime:getTime()
	local var_8_1 = var_0_1:getIdleStartTime()
	local var_8_2, var_8_3 = var_0_1:calculateIdleAwardList()
	local var_8_4 = false

	if var_8_1 > 0 then
		if var_8_0 >= var_8_1 + g.core.config.spire_parameter_info.get(var_0_0.PARAMETER_IDS.IDLE_TIME_MAX).parameter then
			var_8_4 = true

			self.m_canCollectController:setSelectedIndex(2)
		elseif var_8_0 >= var_8_1 + g.core.config.spire_parameter_info.get(var_0_0.PARAMETER_IDS.IDLE_NOT_SHOW_TIME).parameter and #var_8_3 > 0 then
			var_8_4 = true

			self.m_canCollectController:setSelectedIndex(1)
		else
			self.m_canCollectController:setSelectedIndex(0)
		end
	else
		self.m_canCollectController:setSelectedIndex(0)
	end

	self.m_collectEffect:setVisible(var_8_4)
end

function SpireMainLayer:_onRecvGetInfo(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self:updateView()
end

function SpireMainLayer:_onTowerDeatailClick(arg_10_1)
	local var_10_0 = var_0_1:getSpireTowerList()[arg_10_1]
	local var_10_1 = var_10_0:getCfg()

	if not var_0_1:isActivityOpen() then
		g.core.module.ModuleManager:tip(g.core.lang:get(308618))

		return
	end

	if var_0_1:getCurStage() == var_0_0.STAGE.SHOW_RESULT then
		g.core.module.ModuleManager:tip(g.core.lang:get(432035))

		return
	end

	local var_10_2 = var_0_1:getActivityOpenTime()

	if not var_10_0:isUnlockByTime(var_10_2) then
		g.core.module.ModuleManager:tip(g.core.lang:get(432027, {
			time = g.core.common.ServerTime:getDateMDFormat((g.core.common.ServerTime:getNextNDayZeroTime(var_10_2, var_10_1.unlock)))
		}))

		return
	end

	local var_10_3, var_10_4 = var_0_1:isPreTowerPass(var_10_1.type)

	if not var_10_3 then
		g.core.module.ModuleManager:tip(g.core.lang:get(432031, {
			name = var_10_4.name
		}))

		return
	end

	if var_10_0:isPass() then
		g.core.module.ModuleManager:tip(g.core.lang:get(432015))

		return
	end

	if var_0_1:isTowerEnterByIndex(var_10_1.type) then
		self:_onEnterChallengeLayer(var_10_0)
	else
		g.core.module.ModuleManager:pushModule(g.view.entrance.SPIRE_DETAIL_LAYER, var_10_0)
	end
end

function SpireMainLayer:_onEnterChallengeLayer(arg_11_1)
	local var_11_0 = arg_11_1:getMulFormationType()

	self._reqFType = var_11_0

	if not var_0_1:isReqFormation(var_11_0) then
		g.core.network.GameNetProxy:send_C2S_Formation_Get({
			tp = var_11_0
		})
	else
		self:_enterChallengeLayer()
	end
end

function SpireMainLayer:_enterChallengeLayer()
	var_0_1:formationRequested(self._reqFType)

	local var_12_0

	for iter_12_0, iter_12_1 in pairs((var_0_1:getSpireTowerList())) do
		if iter_12_1:getMulFormationType() == self._reqFType then
			var_12_0 = iter_12_1

			break
		end
	end

	if var_12_0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_MODULE_ENTER_PLAY_TRANSITION, false, {
			toRight = false,
			callback = function()
				g.core.module.ModuleManager:pushModule(g.view.entrance.SPIRE_CHALLENGE_LAYER, var_12_0)
			end
		})
	end
end

function SpireMainLayer:_onBossClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SPIRE_BOSS_DETAIL_POP, (var_0_1:getBossTower():getMaxFloor():getBossStage()))
end

function SpireMainLayer:_onShopBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = var_0_2.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = var_0_2.ShopConst.SHOP_TYPE.SPIRE
	})
end

function SpireMainLayer:_onRankBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SPIRE_RANK_LAYER)
end

function SpireMainLayer:_onCollectBtnClick()
	local var_17_0 = var_0_1:getCurStage()

	if var_17_0 == var_0_0.STAGE.SHOW_RESULT or var_17_0 == var_0_0.STAGE.NOT_OPEN then
		g.core.module.ModuleManager:tip(g.core.lang:get(308618))

		return
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EvilCastle_Box)
	g.core.module.ModuleManager:pushModule(g.view.entrance.SPIRE_COLLECT_LAYER)
end

function SpireMainLayer:_onMatchServerBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.spire.view.SpireMatchServerPop").new(), {
		hideContinue = true,
		touchDisappear = true
	})
end

return SpireMainLayer
