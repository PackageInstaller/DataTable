local var_0_0 = g.core.const.ConstMgr.GuildWarConst
local var_0_1 = g.core.common.ServerTime
local var_0_2 = g.core.model.User.guildWarData
local var_0_3 = g.core.module.ModuleManager
local GuildWarResultStageMainComp = class("GuildWarResultStageMainComp", require("app.fairyGUI.guildWar.UI_GuildWarResultStageMainComp"))
local var_0_5 = 3

function GuildWarResultStageMainComp:ctor(arg_1_1)
	self._stage = arg_1_1

	self:initView()
end

function GuildWarResultStageMainComp:initView()
	self.m_actionBtn:addClickListener(handler(self, self._onClickActionBtn))
	self.m_seasonRankBtn:addClickListener(handler(self, self._onClickSeasonRankBtn))
	self.m_fightRankBtn:addClickListener(handler(self, self._onClickFightRankBtn))
	self.m_shopBtn:addClickListener(handler(self, self._onClickShop))
	self.m_shareComp:setVisibleEx(true)
	self.m_shareComp:setShowAwardState(0)
	self.m_shareComp:setCallback(handler(self, self._onShareClick))
	self.m_chatComp:setCurChannel(g.core.const.ConstMgr.ChatConst.GUILD_WAR)
end

function GuildWarResultStageMainComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self.updateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, self.updateView, self)
end

function GuildWarResultStageMainComp:_onClickShop()
	g.core.module.ModuleManager:pushModule(g.view.entrance.GUILE_WAR_SHOP)
end

function GuildWarResultStageMainComp:updateComp()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_actionBtn
	})
	self:updateView()
end

function GuildWarResultStageMainComp:updateView()
	local var_6_0 = var_0_2:getWarNumNow()

	self.m_fightIndexText:setText(var_6_0)
	self.m_titleComp:setStateText(g.core.lang:get(308633, {
		num = var_6_0,
		max = var_0_2:getMaxWarNum()
	}))
	self.m_rankComp:updateView()

	local var_6_1 = var_0_2:getAllGuildStructArr()

	table.sort(var_6_1, var_0_2:getGuildStructSortFunc())

	local var_6_2 = var_6_1[1] and var_6_1[1]:getTodayTotalScore() or 0

	for iter_6_0 = 1, var_0_5 do
		if var_6_1[iter_6_0] then
			self["m_showGuild" .. iter_6_0]:setVisible(true)
			self["m_showGuild" .. iter_6_0]:updateComp(var_6_1[iter_6_0], var_6_2)
		else
			self["m_showGuild" .. iter_6_0]:setVisible(false)
		end
	end

	local var_6_3 = false

	for iter_6_1, iter_6_2 in pairs((var_0_2:getFightResultBadgeList())) do
		if iter_6_2.value and iter_6_2.value > 0 then
			var_6_3 = true

			break
		end
	end

	if var_6_3 then
		self.m_badgeComp:updateBadgeFightView()
		self.m_isShowBadgeCompController:setSelectedIndex(1)
	else
		self.m_isShowBadgeCompController:setSelectedIndex(0)
	end
end

function GuildWarResultStageMainComp:onCD()
	local var_7_0 = var_0_2:getStartEndTime(var_0_0.StageType.SEASON_RESULT) - var_0_1:getTime()

	if var_7_0 > 0 then
		self.m_titleComp:setTimeText(g.core.lang:get(308634, {
			time = var_0_1:getActivityLeftTime(var_7_0)
		}))
	end
end

function GuildWarResultStageMainComp:playEnterAni()
	self.m_enterTransition:play()
end

function GuildWarResultStageMainComp:_onClickActionBtn()
	var_0_3:pushPopup(require("app.view.module.guildWar.view.pop.GuildWarTaskPop").new(), {
		touchDisappear = false,
		ignoreTouch = false
	})
end

function GuildWarResultStageMainComp:_onClickSeasonRankBtn()
	var_0_3:pushPopup(require("app.view.module.guildWar.view.pop.GuildWarSeasonRankPop").new(), {
		touchDisappear = false,
		ignoreTouch = false
	})
end

function GuildWarResultStageMainComp:_onClickFightRankBtn()
	var_0_3:pushPopup(require("app.view.module.guildWar.view.pop.GuildWarFightRankPop").new(), {
		touchDisappear = false,
		ignoreTouch = false
	})
end

function GuildWarResultStageMainComp:_onShareClick()
	self.m_rankComp:setShareView()
	self.m_shareComp:setVisible(false)

	self._bgLoader = self._bgLoader or self:addBg("bg/guildWar/bg_jtzf_kaizhan.jpg")

	self._bgLoader:setVisible(true)

	local var_12_0 = cc.utils:captureNode(self)

	var_12_0:saveToFile(g.core.model.User.ShareData:getShotPath())
	var_12_0:release()
	self.m_rankComp:resetShareView()
	self.m_shareComp:setVisible(true)
	self._bgLoader:setVisible(false)
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHARE_LAYER, {
		shareType = g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_16
	})
end

return GuildWarResultStageMainComp
