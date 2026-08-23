local var_0_0 = g.core.model.User.guildWarData
local var_0_1 = g.core.module.ModuleManager
local var_0_2 = 3
local GuildWarSeasonResultStageMainComp = class("GuildWarSeasonResultStageMainComp", require("app.fairyGUI.guildWar.UI_GuildWarSeasonResultStageMainComp"))

function GuildWarSeasonResultStageMainComp:ctor(arg_1_1)
	self._stage = arg_1_1
	self._bgLoader = nil

	self:initView()
end

function GuildWarSeasonResultStageMainComp:initView()
	self.m_actionBtn:addClickListener(handler(self, self._onClickActionBtn))
	self.m_seasonRankBtn:addClickListener(handler(self, self._onClickSeasonRankBtn))
	self.m_shopBtn:addClickListener(handler(self, self._onClickShop))
	self.m_shareComp:setVisibleEx(true)
	self.m_shareComp:setShowAwardState(0)
	self.m_shareComp:setCallback(handler(self, self._onShareClick))
	self.m_titleComp:setStateText(g.core.lang:get(308653))
end

function GuildWarSeasonResultStageMainComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._onS2CRankList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, self._onS2CRankList, self)
end

function GuildWarSeasonResultStageMainComp:_onS2CRankList(arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_3 then
		return
	end

	self:updateView()
end

function GuildWarSeasonResultStageMainComp:updateComp()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_actionBtn
	})
	self:updateView()
end

function GuildWarSeasonResultStageMainComp:_onClickShop()
	g.core.module.ModuleManager:pushModule(g.view.entrance.GUILE_WAR_SHOP)
end

function GuildWarSeasonResultStageMainComp:updateView()
	self.m_rankComp:updateView()

	local var_7_0, var_7_1 = var_0_0:getFightRankList((var_0_0:getCurFightingGroup()))

	if var_7_0 == nil then
		-- block empty
	else
		for iter_7_0 = 1, var_0_2 do
			if var_7_0[iter_7_0] then
				self["m_showComp" .. iter_7_0]:updateComp(var_7_0[iter_7_0])
			else
				self["m_showComp" .. iter_7_0]:setVisible(false)
			end
		end

		local var_7_2 = false

		for iter_7_1, iter_7_2 in pairs((var_0_0:getSeasonResultBadgeList())) do
			if iter_7_2.value and iter_7_2.value > 0 and iter_7_2.guild then
				var_7_2 = true

				break
			end
		end

		if var_7_2 then
			self.m_badgeComp:updateBadgeSeasonView()
			self.m_isShowBadgeCompController:setSelectedIndex(1)
		else
			self.m_isShowBadgeCompController:setSelectedIndex(0)
		end
	end
end

function GuildWarSeasonResultStageMainComp:onCD()
	return
end

function GuildWarSeasonResultStageMainComp:playEnterAni()
	self.m_enterTransition:play()
end

function GuildWarSeasonResultStageMainComp:_onClickActionBtn()
	var_0_1:pushPopup(require("app.view.module.guildWar.view.pop.GuildWarTaskPop").new(), {
		touchDisappear = false,
		ignoreTouch = false
	})
end

function GuildWarSeasonResultStageMainComp:_onClickSeasonRankBtn()
	var_0_1:pushPopup(require("app.view.module.guildWar.view.pop.GuildWarSeasonRankPop").new(), {
		touchDisappear = false,
		ignoreTouch = false
	})
end

function GuildWarSeasonResultStageMainComp:_onShareClick()
	self.m_rankComp:setShareView()
	self.m_shareComp:setVisible(false)

	self._bgLoader = self._bgLoader or self:addBg("bg/guildWar/bg_jtzf_kaohe.jpg")

	self._bgLoader:setVisible(true)

	local var_12_0 = cc.utils:captureNode(self)

	var_12_0:saveToFile(g.core.model.User.ShareData:getShotPath())
	var_12_0:release()
	self._bgLoader:setVisible(false)
	self.m_rankComp:resetShareView()
	self.m_shareComp:setVisible(true)
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHARE_LAYER, {
		shareType = g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_17
	})
end

return GuildWarSeasonResultStageMainComp
