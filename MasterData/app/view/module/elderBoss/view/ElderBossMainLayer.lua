local var_0_0 = g.core.common.Goods
local var_0_1 = g.core.const.ConstMgr
local var_0_2 = g.core.const.ConstMgr.ElderBossConst
local var_0_3 = g.core.model.User.elderBossData
local ElderBossMainLayer = class("ElderBossMainLayer", require("app.fairyGUI.elderBoss.UI_ElderBossMainLayer"), function()
	return fgui.GComponent:create({
		resName = "ElderBossMainLayer",
		pkgPath = "ui/elderBoss/elderBoss",
		isFullScreen = true,
		pkgName = "elderBoss"
	}, ...)
end)

function ElderBossMainLayer:ctor()
	self:addBg("bg/elderBoss/bg_ljqs_kzjd.jpg")
	self:_initView()
	self:_initBtn()
end

function ElderBossMainLayer:_initView()
	self.m_topBarComp:setResInfoById(var_0_2.ELDER_GAME_STAGE_TOP_ID)
	self.m_playTimeComp:initView({
		playNum = g.core.const.ConstMgr.ShopConst.PLAY_TYPE.ELDER_BOSS_NUM,
		getTimesFunc = function()
			return var_0_3:getChallengeNum()
		end,
		onGetTimes = function()
			g.core.module.ModuleManager:pushPopup(require("app.view.module.elderBoss.view.ElderUseBuyPop").new({
				type = var_0_0.TYPE_ITEM,
				value = var_0_0.ITEM.TYPE_ELDER_PLAY_NUM,
				shopId = g.core.const.ConstMgr.ShopConst.SHOP_SCORE.ELDER_BOSS_NUM
			}), {
				touchDisappear = true
			})
		end,
		refreshEvent = {
			g.core.event.enum.EVENT_NET_S2C_FLUSH_COMMON_PLAY_NUM
		}
	})
	self.m_enterTransition:play()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.ELDER_BOSS)
end

function ElderBossMainLayer:_initBtn()
	self.m_shopBtn:addClickListener(handler(self, self._onShopBtnClick))
	self.m_reportBtn:addClickListener(handler(self, self._onReportBtnClick))
	self.m_rankBtn:addClickListener(handler(self, self._onRankBtnClick))
	self.m_awardBtn:addClickListener(handler(self, self._onAwardBtnClick))
	self.m_formationBtn:addClickListener(handler(self, self._onClickFormationBtn))
end

function ElderBossMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onRcvCommonRankList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ELDER_BOSS_ENTER, handler(self, self._onS2CElderBossEnter), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onUpdateUserInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ELDER_BOSS_CHALLENGEBEGIN, handler(self, self._onS2CElderBossChallengeBegin), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ELDER_BOSS_CHALLENGEFINISH, handler(self, self._onS2CElderBossChallengeFinish), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ELDER_BOSS_CHALLENGENOTIFY, handler(self, self._updateMainView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	g.core.network.GameNetProxy:send_C2S_ElderBoss_Enter({})

	self._cdSchedule = self._cdSchedule or self:newSchedule(handler(self, self._updateCDTime), 1)
	self._hitSchedule = self._hitSchedule or self:newSchedule(handler(self, self._updateHitTime), 2)

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_awardBtn
	})
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_CRITICALDECAY)
end

function ElderBossMainLayer:_onS2CElderBossEnter()
	if tolua.isnull(self) then
		return
	end

	self:_updateMainView()
end

function ElderBossMainLayer:_updateMainView()
	self.m_honnorRankComp:onSelectTab()
	self.m_infoComp:updateElderBossUserInfo()
	self.m_bossHpComp:updateBossHpInfo()
	self.m_activityTimeComp:updateActivityTime()
	self.m_mapComp:updateMapInfo()

	if var_0_3:isBossDead() then
		self.m_deadStateComp:updateBossKilledInfo()
		self.m_mapComp:playBossDeadAction()
		self.m_bossStateController:setSelectedIndex(1)
	else
		self.m_battleStateComp:updateFightingComp()
		self.m_bossStateController:setSelectedIndex(0)
	end
end

function ElderBossMainLayer:_onCrossDayUpdate()
	g.core.network.GameNetProxy:send_C2S_ElderBoss_Enter({})
end

function ElderBossMainLayer:_onRcvCommonRankList(arg_11_1, arg_11_2, arg_11_3)
	if arg_11_3 then
		self._rankData = arg_11_3

		self.m_honnorRankComp:updateRankCell(self._rankData)
	end
end

function ElderBossMainLayer:_onUpdateUserInfo()
	self.m_honnorRankComp:updateRankCell(self._rankData)
	self.m_mapComp:updateMapInfo()
	self.m_deadStateComp:updateBossLuckyUser()
end

function ElderBossMainLayer:_updateHitTime()
	if self.m_bossStateController:getSelectedIndex() == 0 then
		self.m_battleStateComp:updateHitInfo()
	end
end

function ElderBossMainLayer:_updateCDTime()
	self.m_activityTimeComp:updateActivityTime()

	if var_0_3:getCurStage() == var_0_2.STAGE.SHOW_RESULT then
		self:cancleLayerSchedule()
		self:newScheduleOnce(function()
			g.core.module.ModuleManager:replaceModuleRoot(g.view.entrance.ELDERBOSS_RESULT_LAYER)
		end, 0)
	end
end

function ElderBossMainLayer:receiveCompEvent(arg_16_1)
	if arg_16_1 == "ON_CLICK_FIGHT_BOSS" then
		var_0_3:setOldMaxHonor(var_0_3:getMaxHonor())
		self.m_mapComp:playMainRoleAttackAction()
		self:_sendEnterBattle()
	elseif arg_16_1 == "COUNT_DOWN_BOSS_REBORN_TIME" then
		self:_updateMainView()
	end
end

function ElderBossMainLayer:_sendEnterBattle()
	if not var_0_3:isBossDead() and not self._clickOnce then
		g.core.network.GameNetProxy:send_C2S_ElderBoss_ChallengeBegin({})

		self._clickOnce = true
	end
end

function ElderBossMainLayer:_onS2CElderBossChallengeBegin(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local BattleConst = require("app.view.battle.const.BattleConst")

	g.core.battle.BattleProxy:enterBattle({
		soundType = 5,
		canSkip = true,
		battle_id = arg_18_4.battle_id,
		type = BattleConst.TYPE_ELDER_BOSS,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		battleType = BattleConst.BATTLE_TYPE.PVP
	})

	self._clickOnce = false
end

function ElderBossMainLayer:_onS2CElderBossChallengeFinish()
	self:_updateMainView()
end

function ElderBossMainLayer:_onShopBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = var_0_1.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = var_0_1.ShopConst.SHOP_TYPE.ELDER_BOSS
	})
end

function ElderBossMainLayer:_onReportBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.elderBoss.view.ElderBattleReportPop").new(), {
		withoutAni = true
	})
end

function ElderBossMainLayer:_onRankBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.ELDERBOSS_RANK_LAYER)
end

function ElderBossMainLayer:_onAwardBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.elderBoss.view.ElderTaskPop").new(), {
		withoutAni = true
	})
end

function ElderBossMainLayer:_onClickFormationBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION)
end

function ElderBossMainLayer:onRemoved()
	g.core.network.GameNetProxy:send_C2S_ElderBoss_Exit({})
end

function ElderBossMainLayer:cancleLayerSchedule()
	if self._cdSchedule then
		self:cancelSchedule(self._cdSchedule)

		self._cdSchedule = nil
	end

	if self._hitSchedule then
		self:cancelSchedule(self._hitSchedule)

		self._hitSchedule = nil
	end
end

function ElderBossMainLayer:onUnload()
	self:cancleLayerSchedule()
end

return ElderBossMainLayer
