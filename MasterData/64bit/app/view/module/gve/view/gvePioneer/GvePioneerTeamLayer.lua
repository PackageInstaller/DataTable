local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.network.GameNetProxy
local BaseConfirmPop = require("app.view.base.pop.BaseConfirmPop")
local var_0_4 = g.core.const.ConstMgr
local var_0_5 = g.core.model.User.gveDataMgr
local var_0_6 = g.core.model.User.gveDataMgr:getGveData()
local GvePioneerTeamLayer = class("GvePioneerTeamLayer", require("app.fairyGUI.gve.UI_GvePioneerTeamLayer"), function()
	return fgui.GComponent:create({
		resName = "GvePioneerTeamLayer",
		pkgName = "gve",
		isFullScreen = true,
		pkgPath = "ui/gve/gve"
	}, ...)
end)

function GvePioneerTeamLayer:ctor()
	var_0_6 = var_0_5:getGveData()

	self:addBg("bg/gve/bg_rw_jiemianxinxi.jpg", false, nil, 1)

	self._matchPlayerList = {}
	self._matchGuildList = {}

	self:_initRegisterUI()
	self.m_enterTransition:play()
end

function GvePioneerTeamLayer:_initRegisterUI()
	self.m_guildList:setVirtual()
	self.m_guildList:setItemRenderer(handler(self, self._onMatchGuildItemRender))
	self.m_playerList:setVirtual()
	self.m_playerList:doFairyBatching(false)
	self.m_playerList:setItemRenderer(handler(self, self._onMathPlayerItemRender))
	self.m_seasonRankBtn:addClickListener(handler(self, self._onClickSeasonRankBtn))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabCtrlChanged))
	self.m_topBarComp:setResInfoById(var_0_4.HelpConst.HELP_TYPE.GVE_PIONEER_LAYER)
end

function GvePioneerTeamLayer:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._onS2CGetUserListInfo, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_G_VE_USERLIST, handler(self, self._onS2CGetUserListInfo), self)
	var_0_2:send_C2S_GVE_UserList({})
end

function GvePioneerTeamLayer:_onS2CGetGuildListInfo()
	self._matchGuildList = g.core.model.User.allianceData:getAllianceGuilds()

	if self._matchGuildList then
		self.m_guildList:setNumItems(#self._matchGuildList)
		self.m_guildList:transitionShowCells("enter_left", 0.03)
	else
		self.m_guildTab:setVisible(false)
		self.m_tabController:setSelectedIndex(1)
	end
end

function GvePioneerTeamLayer:_onS2CGetUserListInfo()
	self._matchPlayerList = var_0_5:getMatchPlayerList()

	if self._matchPlayerList then
		self.m_playerList:setNumItems(#self._matchPlayerList)
		self.m_playerList:transitionShowCells("enter_left", 0.03)
	end

	local var_6_0 = var_0_5:isHasHalidomJob()

	if var_6_0 then
		self.m_selectJobComp:getChild("selectBtn"):setTitle(g.core.lang:get(309146))
	end

	self.m_hasHalidomJobController:setSelectedIndex(var_6_0 and 1 or 0)
	self.m_tabController:setSelectedIndex(1)
end

function GvePioneerTeamLayer:_onMatchGuildItemRender(arg_7_1, arg_7_2)
	if self._matchGuildList[arg_7_1 + 1] then
		arg_7_2:upateMatchGuildCell(self._matchGuildList[arg_7_1 + 1])
		arg_7_2:setCtrlState("bg", {
			index = arg_7_1 % 2 ~= 0 and 1 or 0
		})
	end
end

function GvePioneerTeamLayer:_onMathPlayerItemRender(arg_8_1, arg_8_2)
	if self._matchPlayerList[arg_8_1 + 1] then
		arg_8_2:updateMatchPlayerCell(self._matchPlayerList[arg_8_1 + 1])
		arg_8_2:setCtrlState("bg", {
			index = arg_8_1 % 2 ~= 0 and 1 or 0
		})
	end
end

function GvePioneerTeamLayer:receiveCompEvent(arg_9_1, arg_9_2)
	if arg_9_1 == "S2C_GET_TEAMINFO_UPDATE" then
		self:_refreshGveSeasonRankView()
		self:_checkPlayerIsBelongGuildTeam()
	elseif arg_9_1 == "SELECT_HALIDOM_JOB" then
		self._matchPlayerList = var_0_5:getMatchPlayerByJob(arg_9_2.tag)

		local var_9_0 = #self._matchPlayerList

		if self._matchPlayerList then
			self.m_playerList:setNumItems(var_9_0)
			self.m_playerList:transitionShowCells("enter_left", 0.03)
		end

		self.m_isEmptyController:setSelectedIndex(var_9_0 > 0 and 0 or 1)
	end
end

function GvePioneerTeamLayer:_onClickSeasonRankBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.GVE_SEASON_RANK)
end

function GvePioneerTeamLayer:_checkPlayerIsBelongGuildTeam()
	if self.m_tabController:getSelectedIndex() ~= 0 then
		return
	end

	if var_0_5:isBelongGuildTeam() and var_0_5:isCurSeasonOpenConfirmPop() then
		g.core.module.ModuleManager:pushPopup(BaseConfirmPop.new({
			singleButton = true,
			title = g.core.lang:get(1257),
			desc = g.core.lang:get(309134),
			onCheck = function(arg_12_0)
				var_0_5:setCurSeasonNoConfirmPop(arg_12_0)
			end,
			tip = {
				txt = g.core.lang:get(309133)
			}
		}))
	end
end

function GvePioneerTeamLayer:_onTabCtrlChanged()
	if self.m_tabController:getSelectedIndex() == 1 then
		self.m_playerList:setNumItems(#self._matchPlayerList)
		self.m_playerList:transitionShowCells("enter_left", 0.03)
	else
		self.m_guildList:setNumItems(#self._matchGuildList)
		self.m_guildList:transitionShowCells("enter_left", 0.03)
	end
end

return GvePioneerTeamLayer
