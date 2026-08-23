local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.model.User.guildData
local var_0_2 = g.core.const.ConstMgr.AllianceConst
local var_0_3 = g.core.model.User.allianceData
local AllianceCreateLayer = class("AllianceCreateLayer", require("app.fairyGUI.alliance.UI_AllianceCreateLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/alliance/alliance",
		resName = "AllianceCreateLayer",
		pkgName = "alliance"
	}, ...)
end)

function AllianceCreateLayer:ctor()
	self._joinSchedule = nil
	self._lastRefreshTime = 0
	self._joinList = {}
	self._originList = {}

	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.ALLIANCE)
	self:initView()
end

function AllianceCreateLayer:initView()
	self:addBg("bg/guild/bg_jt_juantuanrenwu.jpg")
	self.m_topBar:setResInfoById(337)
	self.m_inputComp:setMaxLength(var_0_3:getParams(var_0_2.PARAMETER.NAME_LEN))
	self.m_showCanJoin:addClickListener(handler(self, self._onCheckShowCanJoin))
	self.m_showCanJoin:setSelected(var_0_3:isOnlyShowCanJoin())
	self.m_seekGuildBtn:addClickListener(handler(self, self._onClickSeekGuildBtn))
	self.m_applyListBtn:addClickListener(handler(self, self._onClickApplyListBtn))
	self.m_invitationListBtn:addClickListener(handler(self, self._onClickInvitationListBtn))
	self.m_createBtn:addClickListener(handler(self, self._onClickCreateBtn))
	self.m_refreshBtn:addClickListener(handler(self, self._onClickRefreshBtn))
	self.m_joinList:setVirtual()
	self.m_joinList:setItemRenderer(handler(self, self._onRenderJoinList))
	self.m_inputComp:setShowClearBtn(true, handler(self, self._onClickClearBtn))
end

function AllianceCreateLayer:_onClickClearBtn()
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_SearchList({
		name = ""
	})
end

function AllianceCreateLayer:_onClickCreateBtn()
	if not var_0_3:canJoinAlliance() then
		g.core.module.ModuleManager:tip(g.core.lang:get(428528, {
			time = g.core.common.ServerTime:getCountDownBySecond(var_0_3:geCanJoinAllianceTime())
		}))

		return
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.alliance.view.pop.AllianceCreatePop").new(), {
		touchDisappear = true
	})
end

function AllianceCreateLayer:_onClickRefreshBtn()
	local var_6_0 = g.core.common.ServerTime:getTime()

	if var_6_0 - self._lastRefreshTime < 5 then
		g.core.module.ModuleManager:tip(g.core.lang:get(428510))

		return
	end

	self._lastRefreshTime = var_6_0

	g.core.network.GameNetProxy:send_C2S_GuildAlliance_SearchList({
		name = ""
	})
end

function AllianceCreateLayer:_onClickSeekGuildBtn()
	if self.m_inputComp:judgeLegal(false) then
		g.core.network.GameNetProxy:send_C2S_GuildAlliance_SearchList({
			name = self.m_inputComp:getInputStr()
		})
	else
		self:_onClickRefreshBtn()
	end
end

function AllianceCreateLayer:_onCheckShowCanJoin()
	var_0_3:setOnlyShowCanJoin(self.m_showCanJoin:isSelected())
	self:_updateJoinList()
end

function AllianceCreateLayer:_onClickApplyListBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.alliance.view.pop.AllianceGuildApplyListPop").new(), {
		touchDisappear = true
	})
end

function AllianceCreateLayer:_onClickInvitationListBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.alliance.view.pop.AllianceGuildInviteListPop").new(), {
		touchDisappear = true
	})
end

function AllianceCreateLayer:_onRenderJoinList(arg_11_1, arg_11_2)
	arg_11_2:updateAllianceCell(self._joinList[arg_11_1 + 1])
end

function AllianceCreateLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_GETINFO, handler(self, self._onGetInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_SEARCHLIST, handler(self, self._onGetSearchList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_NOTICESTATE, handler(self, self._onNoticeState), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_SUGGEST, handler(self, self._onSuggest), self)
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_GetInfo({})
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_SearchList({
		name = ""
	})
	self.m_showStateController:setSelectedIndex(var_0_1:isLeader() and 0 or 1)
end

function AllianceCreateLayer:_onGetInfo()
	if g.core.model.User.guildData:isLeader() and not var_0_3:canJoinAlliance() then
		self:_updateJoinTime()
		self.m_joinCD:setVisible(true)

		self._joinSchedule = self._joinSchedule or self:newSchedule(handler(self, self._updateJoinTime), 1)
	else
		self.m_joinCD:setVisible(false)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_invitationListBtn
	})
end

function AllianceCreateLayer:_updateJoinTime()
	local var_14_0 = var_0_3:geCanJoinAllianceTime()

	if var_14_0 <= 0 then
		self.m_joinCD:setVisible(false)
		self:cancelJoinSchedule()

		return
	end

	self.m_joinCD:setText(g.core.lang:get(428530, {
		time = var_0_0:getCountDownBySecond(var_14_0)
	}))
end

function AllianceCreateLayer:cancelJoinSchedule()
	if self._joinSchedule then
		self:cancelSchedule(self._joinSchedule)

		self._joinSchedule = nil
	end
end

function AllianceCreateLayer:_onSuggest()
	self:_updateJoinList()
end

function AllianceCreateLayer:_onGetSearchList(arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	self._originList = arg_17_4.alliances or {}

	self:_updateJoinList()
end

function AllianceCreateLayer:_onNoticeState(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if var_0_3:hasAlliance() then
		g.core.module.ModuleManager:popAllPopup()
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		g.core.module.ModuleManager:pushModule(g.view.entrance.ALLIANCE)
	end
end

function AllianceCreateLayer:_updateJoinList()
	local var_19_0 = var_0_3:isOnlyShowCanJoin()
	local var_19_1 = g.core.model.User.guildData:getGuildLevel()

	self._joinList = {}

	for iter_19_0, iter_19_1 in ipairs(self._originList) do
		if var_19_0 then
			if var_19_1 >= iter_19_1.apply_level and #iter_19_1.guild_ids < var_0_3:getAllianceGuildMaxNumByLv(iter_19_1.level) then
				table.insert(self._joinList, iter_19_1)
			end
		else
			table.insert(self._joinList, iter_19_1)
		end
	end

	self:sortAllianceList()

	if #self._joinList > 0 then
		self.m_joinList:setNumItems(#self._joinList)
		self.m_isEmptyController:setSelectedIndex(0)
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end
end

function AllianceCreateLayer:sortAllianceList()
	table.sort(self._joinList, function(arg_21_0, arg_21_1)
		local var_21_0 = #arg_21_0.guild_ids
		local var_21_1 = #arg_21_1.guild_ids

		if #arg_21_0.guild_ids < var_0_3:getAllianceGuildMaxNum(arg_21_0.level) and var_21_1 < var_0_3:getAllianceGuildMaxNum(arg_21_1.level) then
			if arg_21_0.fight_value ~= arg_21_1.fight_value then
				return arg_21_1.fight_value < arg_21_0.fight_value
			end

			if arg_21_0.level ~= arg_21_1.level then
				return arg_21_1.level < arg_21_0.level
			end

			if var_21_0 ~= var_21_1 then
				return var_21_1 < var_21_0
			end

			if arg_21_0.apply_level ~= arg_21_1.apply_level then
				return arg_21_0.apply_level < arg_21_1.apply_level
			end

			return arg_21_0.id < arg_21_1.id
		else
			return var_21_0 < var_21_1
		end
	end)
end

return AllianceCreateLayer
