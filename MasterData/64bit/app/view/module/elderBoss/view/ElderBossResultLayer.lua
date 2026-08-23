local var_0_0 = g.core.const.ConstMgr.ElderBossConst
local var_0_1 = g.core.model.User.elderBossData
local CommonKnight = require("app.view.common.CommonKnight")
local ElderBossResultLayer = class("ElderBossResultLayer", require("app.fairyGUI.elderBoss.UI_ElderBossResultLayer"), function()
	return fgui.GComponent:create({
		pkgName = "elderBoss",
		isFullScreen = true,
		pkgPath = "ui/elderBoss/elderBoss",
		resName = "ElderBossResultLayer"
	}, ...)
end)

function ElderBossResultLayer:ctor()
	self:addBg("bg/elderBoss/bg_ljqs_kzjd.jpg")
	self:_initView()
	self:_initBtn()
end

function ElderBossResultLayer:_initView()
	self.m_topBarComp:setResInfoById(var_0_0.RESULT_STAGE_TOP_ID)
	self.m_enterTransition:play()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.ELDER_BOSS)
end

function ElderBossResultLayer:_initBtn()
	self.m_shopBtn:addClickListener(handler(self, self._onShopBtnClick))
	self.m_reportBtn:addClickListener(handler(self, self._onReportBtnClick))
	self.m_rankBtn:addClickListener(handler(self, self._onRankBtnClick))
	self.m_awardBtn:addClickListener(handler(self, self._onAwardBtnClick))
	self.m_bossInfoComp:addClickListener(handler(self, self._onClickBossInfoComp))
end

function ElderBossResultLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._onUpdateResultSnapInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ELDER_BOSS_ENTER, handler(self, self._onS2CElderBossEnter), self)

	if var_0_1:getBossId() > 0 then
		g.core.network.GameNetProxy:send_C2S_ElderBoss_Enter({})
	else
		self:_onS2CElderBossEnter()
	end

	self._cdSchedule = self._cdSchedule or self:newSchedule(handler(self, self._updateCDTime), 1)

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_awardBtn
	})
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_CRITICALDECAY)
end

function ElderBossResultLayer:_updateCDTime()
	if var_0_1:getCurStage() == g.core.const.ConstMgr.ElderBossConst.STAGE.GAME then
		if self._cdSchedule then
			self:cancelSchedule(self._cdSchedule)

			self._cdSchedule = nil
		end

		local var_6_0 = g.view.entrance.ELDERBOSS_CHOOSE_BUFF_LAYER

		self:newScheduleOnce(function()
			g.core.module.ModuleManager:replaceModuleRoot(var_6_0)
		end, 0)
	end
end

function ElderBossResultLayer:_onUpdateResultSnapInfo()
	self.m_rankComp:updateResultRank()
end

function ElderBossResultLayer:_onS2CElderBossEnter()
	local var_9_0 = var_0_1:getBossId()
	local var_9_1 = var_9_0 > 0 and g.core.config.elder_boss_info.get(var_9_0) or g.core.config.elder_boss_info.get((var_9_0 + 1 > g.core.config.elder_boss_info.indexOf((g.core.config.elder_boss_info.getLength())).id or nil) and 1)

	if var_9_1 then
		local var_9_3 = var_0_1:getMonsterInfoByTeamId(var_9_1.monster_team_id)

		if var_9_3 or not self._bossSpine then
			self._bossSpine = CommonKnight.new({
				resId = var_9_3.res_id
			})

			self.m_bossPlaceComp:removeChildren()
			self.m_bossPlaceComp:addChild(self._bossSpine)
		end

		self.m_bossInfoComp:updateBossInfo(var_9_1)
		self.m_rankComp:updateResultRank()
	end
end

function ElderBossResultLayer:_onClickBossInfoComp()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.elderBoss.view.ElderBossPreviewPop").new()))
end

function ElderBossResultLayer:_onShopBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.ELDER_BOSS
	})
end

function ElderBossResultLayer:_onReportBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.elderBoss.view.ElderBattleReportPop").new(), {
		withoutAni = true
	})
end

function ElderBossResultLayer:_onRankBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.ELDERBOSS_RANK_LAYER)
end

function ElderBossResultLayer:_onAwardBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.elderBoss.view.ElderTaskPop").new(), {
		withoutAni = true
	})
end

return ElderBossResultLayer
