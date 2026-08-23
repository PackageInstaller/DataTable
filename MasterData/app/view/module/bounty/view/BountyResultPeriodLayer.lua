local BountyResultPeriodLayer = class("BountyResultPeriodLayer", require("app.fairyGUI.bounty.UI_BountyResultPeriodLayer"), function()
	return fgui.GComponent:create({
		resName = "BountyResultPeriodLayer",
		pkgPath = "ui/bounty/bounty",
		isFullScreen = true,
		pkgName = "bounty"
	}, ...)
end)

function BountyResultPeriodLayer:ctor()
	self:addBg("bg/gve/bg_rw_jiemianxinxi.jpg", false, nil, 1)

	self._scheduleHandler = nil

	self:_initRegisterUI()
	self.m_enterTransition:play()
	self.m_topBarComp:setResInfoById(328)
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.BOUNTY)
end

function BountyResultPeriodLayer:_initRegisterUI()
	self.m_rankBtn:addClickListener(handler(self, self._onClickTeamRankBtn))
	self.m_shopBtn:addClickListener(handler(self, self._onClickShopBtn))
	self.m_pointBtn:addClickListener(handler(self, self._onClickPointBtn))
	self.m_shareBtn:addClickListener(handler(self, self._onClickShareBtn))
end

function BountyResultPeriodLayer:onLoad()
	self._scheduleHandler = self:newSchedule(handler(self, self._onScheduleUpdate), 1)

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, handler(self, self._updateResultPeriod), self)
	self:_updateResultPeriod()
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.Music_GuiwangBoss)
end

function BountyResultPeriodLayer:_updateResultPeriod()
	local var_5_0, var_5_1 = g.core.model.User.bountyData:getRankListAndMyRank(5)

	if not var_5_0 or not var_5_0[1] then
		self.m_isEmptyController:setSelectedIndex(1)

		return
	end

	self.m_isEmptyController:setSelectedIndex(0)

	self._rankData = var_5_0

	self.m_bestTeamComp:updateBestTeamComp(var_5_0[1])
	self.m_seasonRankComp:updateResultRankInfo(var_5_0, var_5_1)

	local var_5_2 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.GUILD, var_5_0[1].guild_id)

	if var_5_2 and var_5_2.leader_show_knight_id then
		self.m_knightPicComp:updateKnight({
			baseId = var_5_2.leader_base_id
		})
		self.m_knightPicComp:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-250 / 2, 0, 250 * 2, 0), 250)
	end

	local var_5_4 = g.core.model.User.bountyData:canGetShareReward()

	self.m_shareBtn:setVisible(var_5_4)
	self.m_shareRedPointComp:setVisible(var_5_4)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_pointBtn
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_shareRedPointComp
	})
end

function BountyResultPeriodLayer:_onClickTeamRankBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.bounty.view.pop.BountyRankPop").new()))
end

function BountyResultPeriodLayer:_onClickShopBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHOP, {
		tabType = g.core.const.ConstMgr.ShopConst.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = g.core.const.ConstMgr.ShopConst.SHOP_TYPE.BOUNTY
	})
end

function BountyResultPeriodLayer:_onClickPointBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.bounty.view.BountyDailyPointPop").new()))
end

function BountyResultPeriodLayer:_onClickShareBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.BOUNTY_SHARE, {
		hideOther = true
	})
end

function BountyResultPeriodLayer:_onScheduleUpdate()
	if g.core.common.ServerTime:getLeftSeconds((g.core.model.User.bountyData:getActivityExpireTime())) < 0 then
		if self._scheduleHandler then
			self:cancelSchedule(self._scheduleHandler)

			self._scheduleHandler = nil
		end

		g.core.module.ModuleManager:popModule()
	end
end

return BountyResultPeriodLayer
