local var_0_0 = g.core.event.EventManager
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.model.User.allianceData
local var_0_3 = g.core.const.ConstMgr.AllianceConst
local var_0_4 = g.core.model.User.snapShotCacheData
local var_0_5 = g.core.const.ConstMgr.SnapShotCacheConst
local AllianceHallInvitePop = class("AllianceHallInvitePop", require("app.fairyGUI.alliance.UI_AllianceHallInvitePop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/alliance/alliance",
		resName = "AllianceHallInvitePop",
		pkgName = "alliance"
	})
end)

function AllianceHallInvitePop:ctor()
	self:showAtCenter()

	self._guildList = {}
	self._showGuildList = {}
	self._cachedGuildList = {}
	self._showGuildMaxNum = var_0_2:getParams(var_0_3.PARAMETER.INVITE_GUILD_SHOW_MAX)

	self.m_isEmptyController:setSelectedIndex(1)
	self.m_guildList:setVirtual()
	self.m_guildList:setItemRenderer(handler(self, self._onRenderGuildList))
	self.m_searchBtn:addClickListener(handler(self, self._onClickSearchBtn))
	self.m_refreshBtn:addClickListener(handler(self, self._onClickRefreshBtn))
	self.m_recruitBtn:addClickListener(handler(self, self._onClickRecruitBtn))
	self.m_isOnlyController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onCheckChanged))
	self.m_clearBtn:addClickListener(handler(self, self._onClickClearBtn))
	self.m_searchInput:addEventListener(fgui.UIEventType.Submit, handler(self, self._onTextChanged))
end

function AllianceHallInvitePop:onLoad()
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_GUILD_ALLIANCE_INVITELIST, self._onS2CGetInviteList, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_GUILD_ALLIANCE_INVITE, self._onS2CAllianceInvite, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_GUILD_ALLIANCE_CANCELINVITE, self._onS2CAllianceCancelInvite, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_GUILD_ALLIANCE_GUILDLIST, self._onS2CGuildList, self)
	var_0_0:addEventListener(var_0_1.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, self._onS2CGuildSnapShot, self)
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_GuildList({})
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_InviteList({})
end

function AllianceHallInvitePop:_initView()
	self.m_isEmptyController:setSelectedIndex(1)
end

function AllianceHallInvitePop:_updateView()
	return
end

function AllianceHallInvitePop:_updateGuildList()
	self.m_isEmptyController:setSelectedIndex(#self._showGuildList > 0 and 0 or 1)
	self.m_guildList:setNumItems(#self._showGuildList)
end

function AllianceHallInvitePop:_onRenderGuildList(arg_7_1, arg_7_2)
	arg_7_2:updateInviteCell(self._showGuildList[arg_7_1 + 1])
end

function AllianceHallInvitePop:_getShowGuildList(arg_8_1)
	self._showGuildList = {}

	if self.m_isOnlyController:getSelectedIndex() == 1 then
		self:_getInvitedGuildList()

		return
	end

	if arg_8_1 then
		for iter_8_0 = #self._guildList, 2, -1 do
			local var_8_0 = math.random(iter_8_0)

			self._guildList[iter_8_0], self._guildList[var_8_0] = self._guildList[var_8_0], self._guildList[iter_8_0]
		end
	end

	while 1 <= math.min(#self._guildList, self._showGuildMaxNum) do
		if not self._guildList[1] then
			break
		end

		table.insert(self._showGuildList, self._guildList[1])
	end
end

function AllianceHallInvitePop:_getInvitedGuildList()
	for iter_9_0, iter_9_1 in ipairs(self._guildList) do
		if var_0_2:getAllianceInviteByGuildId(iter_9_1) then
			table.insert(self._showGuildList, iter_9_1)
		end
	end
end

function AllianceHallInvitePop:_onClickSearchBtn()
	local var_10_0 = self.m_searchInput:getText()

	if not g.core.common.GlobalFunc.isGuildNameValid(var_10_0) then
		return
	end

	g.core.network.GameNetProxy:send_C2S_GuildAlliance_GuildList({
		name = var_10_0
	})
end

function AllianceHallInvitePop:_searchTargetGuild(arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(self._guildList) do
		local var_11_1 = var_0_4:getSnapShot(var_0_5.SNAP_SHOT_KEY.GUILD, iter_11_1)

		if var_11_1 and string.find(var_11_1.name, arg_11_1) ~= nil then
			table.insert(var_11_0, iter_11_1)
		end
	end

	return #var_11_0 > 0, var_11_0
end

function AllianceHallInvitePop:_onClickRefreshBtn()
	self.m_isOnlyController:setSelectedIndex(0)
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_GuildList({})
end

function AllianceHallInvitePop:_onClickRecruitBtn()
	local var_13_0 = fgui.UIPackage:createObject("alliance", "AllianceHallSendMsgComp")

	var_13_0:updateView()
	var_0_4:getSnapShot(var_0_5.SNAP_SHOT_KEY.ALLIANCE, var_0_2:getAllianceId())

	local var_13_1 = require("app.view.base.infoPop.BaseChatCallPop").new({
		title = g.core.lang:get(428597),
		childComp = var_13_0,
		funcId = g.core.const.ConstMgr.FUNCTION_TYPE.ALLIANCE,
		allianceId = var_0_2:getAllianceId()
	})

	var_13_1:showBtnNumber(2)
	g.core.module.ModuleManager:pushPopup(var_13_1)
end

function AllianceHallInvitePop:_onClickClearBtn()
	self.m_searchInput:setText("")
	self.m_searchInput:setPrompt(g.core.lang:get(428552))
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_GuildList({})
end

function AllianceHallInvitePop:_onTextChanged()
	local var_15_0 = self.m_searchInput:getText()

	self.m_clearBtn:setVisible(var_15_0 ~= "")

	if var_15_0 == "" then
		self.m_searchInput:setPrompt(g.core.lang:get(428552))
	end
end

function AllianceHallInvitePop:_onCheckChanged()
	if self.m_isOnlyController:getSelectedIndex() == 1 then
		self._cachedGuildList = clone(self._showGuildList)

		self:_getShowGuildList()
	else
		self._showGuildList = self._cachedGuildList
		self._cachedGuildList = {}
	end

	self:_updateGuildList()
end

function AllianceHallInvitePop:_onS2CGetInviteList()
	self:_updateGuildList()
end

function AllianceHallInvitePop:_onS2CAllianceInvite()
	g.core.module.ModuleManager:tip(g.core.lang:get(428601))
	self:_updateGuildList()
end

function AllianceHallInvitePop:_onS2CAllianceCancelInvite()
	g.core.module.ModuleManager:tip(g.core.lang:get(428602))
	self:_updateGuildList()
end

function AllianceHallInvitePop:_onS2CGuildList()
	self._guildList = var_0_2:getCanInviteGuildList()

	self:_getShowGuildList(true)
	self:_updateGuildList()
end

function AllianceHallInvitePop:_onS2CGuildSnapShot()
	self:_updateGuildList()
end

function AllianceHallInvitePop:_isGuildShow(arg_22_1)
	return true
end

return AllianceHallInvitePop
