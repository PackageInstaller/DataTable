local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.const.ConstMgr
local var_0_3 = g.core.network.GameNetProxy
local var_0_4 = g.core.model.User.gveDataMgr
local GveResultPeriodLayer = class("GveResultPeriodLayer", require("app.fairyGUI.gve.UI_GveResultPeriodLayer"), function()
	return fgui.GComponent:create({
		resName = "GveResultPeriodLayer",
		pkgName = "gve",
		isFullScreen = true,
		pkgPath = "ui/gve/gve"
	}, ...)
end)

function GveResultPeriodLayer:ctor()
	self:addBg("bg/gve/bg_rw_jiemianxinxi.jpg", false, nil, 1)

	self._scheduleHandler = nil

	self:_initRegisterUI()
	self.m_enterTransition:play()
	self.m_topBarComp:setResInfoById(var_0_2.HelpConst.HELP_TYPE.GVE_RESULT_LAYER)
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.GVE)
end

function GveResultPeriodLayer:_initRegisterUI()
	self.m_rankBtn:addClickListener(handler(self, self._onClickTeamRankBtn))
	self.m_shopBtn:addClickListener(handler(self, self._onClickShopBtn))
	self.m_finalBossRankBtn:addClickListener(handler(self, self._onClickFinalBossBtn))
end

function GveResultPeriodLayer:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._updateResultPeriod, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GUILD_ALLIANCE_GETSNAPSHOT, self._updateResultPeriod, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_GETBOSSRANK, handler(self, self._updateResultPeriod), self)
	var_0_3:send_C2S_GVE_GetInfo({})
	g.core.network.GameNetProxy:send_C2S_GVE_GetBossRank({
		boss_id = 0,
		page = 1,
		rank_type = var_0_2.GveConst.GVE_RANK_TYPE.ALLIANCE_TOTAL_DAMAGE
	})
	var_0_3:send_C2S_GVE_GetBossFirstKill({})

	self._scheduleHandler = self:newSchedule(handler(self, self._onScheduleUpdate), 1)
end

function GveResultPeriodLayer:_updateResultPeriod()
	self.m_bestTeamComp:updateBestTeamComp()
	self.m_seasonRankComp:updateResultRankInfo()

	local var_5_0 = var_0_4:getBestTeamRankData()

	if var_5_0 then
		local var_5_1 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.ALLIANCE, var_5_0.id)

		if var_5_1 then
			local var_5_2 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, var_5_1.leader_id)

			if var_5_2 then
				self.m_knightPicComp:updateKnight({
					snapshot = var_5_2
				})
				self.m_knightPicComp:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-250 / 2, 0, 250 * 2, 0), 250)
			end
		end
	end
end

function GveResultPeriodLayer:_onClickTeamRankBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.GVE_SEASON_RANK)
end

function GveResultPeriodLayer:_onClickShopBtn()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_StoreMenu)
	g.core.module.ModuleManager:pushModule(g.view.entrance.GVE_SHOP)
end

function GveResultPeriodLayer:_onClickFinalBossBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.gve.view.gveStage.GveBossFinalRankPop").new(), {
		ignoreTouch = false,
		touchDisappear = false
	})
end

function GveResultPeriodLayer:_onScheduleUpdate()
	if g.core.common.ServerTime:getLeftSeconds((var_0_4:getGveExpireEndTime())) < 0 then
		if self._scheduleHandler then
			self:cancelSchedule(self._scheduleHandler)

			self._scheduleHandler = nil
		end

		g.core.module.ModuleManager:popModule()
	end
end

return GveResultPeriodLayer
