local var_0_0 = g.core.const.ConstMgr.GuildCommonConst
local GuildHallMainLayer = class("GuildHallMainLayer", require("app.fairyGUI.guild.UI_GuildHallMainLayer"), function()
	return fgui.GComponent:create({
		pkgName = "guild",
		isFullScreen = true,
		pkgPath = "ui/guild/guild",
		resName = "GuildHallMainLayer"
	}, ...)
end)

function GuildHallMainLayer:ctor(arg_2_1)
	self._guildData = {}
	self._memberData = {}
	self._guildCfgInfo = g.core.model.User.guildData:getCfg()
	self._child = nil
	self._sortIndex = -1
	self._sortType = var_0_0.SORT.DOWN
	self._guildType = nil
	self._guildId = nil
	self._enterAnimPlayed = false
	self._isInitAppointComp = false

	self:_init(arg_2_1)

	self.m_enterTransition = self:getView():getTransition("enter")
	self.m_backTransition = self:getView():getTransition("back")

	self.m_enterTransition:play()
	self.m_topBar:setResInfoById(11)
end

function GuildHallMainLayer:_init(arg_3_1)
	self:addBg("bg/guild/bg_jt_juantuanrenwu.jpg")

	if not arg_3_1 then
		return
	end

	if arg_3_1.child then
		self._child = arg_3_1.child

		self.m_placeHolderComp:addChild(arg_3_1.child)
	end

	self.m_memberList:setVirtual()
	self.m_memberList:doFairyBatching(false)
	self.m_memberList:setItemRenderer(handler(self, self._onMemberItemRenderer))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
	self:addListen(self.m_memberList)
	self:addClintEventListener()

	self._guildType = arg_3_1.guildType or var_0_0.guildType.SELF_GUILD
	self._guildId = arg_3_1.guildId
	self._isShowApplyBtn = arg_3_1.isShowApply or false
end

function GuildHallMainLayer:onLoad()
	self:_addNetListener()

	if self._guildId and self._guildType == var_0_0.guildType.OTHER_GUILD then
		g.core.network.GameNetProxy:send_C2S_Guild_GetInfo({
			guild_id = self._guildId
		})
	end
end

function GuildHallMainLayer:addClintEventListener()
	for iter_5_0 = 1, 4 do
		self["m_sortBtn" .. iter_5_0]:addClickListener(handler(self, self._onSortBtnClick))
	end
end

function GuildHallMainLayer:_updateSortBtnState()
	local var_6_0 = self.m_sortController:getSelectedIndex()

	if var_6_0 == self._sortIndex then
		self._sortType = self._sortType == var_0_0.SORT.DOWN and var_0_0.SORT.UP or var_0_0.SORT.DOWN
	else
		self._sortIndex = var_6_0
		self._sortType = var_0_0.SORT.DOWN
	end

	self["m_sortBtn" .. self._sortIndex + 1]:setSort(self._sortType)
end

function GuildHallMainLayer:_onSortBtnClick()
	self:_updateSortBtnState()
	self:_updateGuildBaseInfo()
end

function GuildHallMainLayer:_addNetListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_GETINFO, self._onRcvGetInfo, self)

	if self._guildType == var_0_0.guildType.SELF_GUILD then
		g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_QUIT, self._onRcvQuitGuild, self)
		g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_CONFIRM, self._onRcvConfirm, self)
		g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_MODIFYINFO, self._onRcvModifyInfo, self)
		g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_APPOINT, self._onRcvAppoint, self)
		g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_KICKOUT, self._onRcvKickOut, self)
		g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_NOTIFYLEAVE, self._onRcvNotifyLeave, self)
		g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_IMPEACH, self._onRcvImpeach, self)
		g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_NOTIFYJOIN, self._onRcvNotifyJoin, self)
		g.core.network.GameNetProxy:send_C2S_Guild_GetInfo({})
	end
end

function GuildHallMainLayer:_onRcvGetInfo(arg_9_1, arg_9_2, arg_9_3)
	if self._guildType == var_0_0.guildType.OTHER_GUILD then
		self._memberData = arg_9_3.members
	else
		local var_9_0 = g.core.model.User.guildData:getMyRightInfo()

		self._isLeader = var_9_0.dissolve > 0
		self._isLessLeader = var_9_0.dissolve <= 0 and var_9_0.kick > 0
		self._hasKickRight = var_9_0.kick > 0

		if self._hasKickRight then
			self.m_isShowStateController:setSelectedIndex(1)
		else
			self.m_isShowStateController:setSelectedIndex(0)
		end
	end

	self:_updateHallView()
end

function GuildHallMainLayer:_onRcvModifyInfo(arg_10_1, arg_10_2, arg_10_3)
	self:_updateHallView()
end

function GuildHallMainLayer:_onRcvAppoint()
	g.core.network.GameNetProxy:send_C2S_Guild_GetInfo({})
end

function GuildHallMainLayer:_onRcvKickOut(arg_12_1, arg_12_2, arg_12_3)
	self:_updateHallView()
end

function GuildHallMainLayer:_updateHallView()
	self:_updateGuildData()
	self:_updateGuildBaseInfo()
end

function GuildHallMainLayer:_onRcvQuitGuild()
	g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
end

function GuildHallMainLayer:_onRcvConfirm(arg_15_1, arg_15_2, arg_15_3)
	self:_updateGuildData()
	self:_updateGuildBaseInfo()
end

function GuildHallMainLayer:_updateGuildData()
	if self._guildType == var_0_0.guildType.SELF_GUILD then
		self._memberData = g.core.model.User.guildData:getMemberData()
	end
end

function GuildHallMainLayer:_updateGuildBaseInfo()
	self._memberData = g.core.model.User.guildData:getSortMemberData(self._sortIndex, self._sortType, self._memberData)

	self._child:updateView({
		isShowApplyBtn = self._isShowApplyBtn
	})
	self.m_memberList:setNumItems(#self._memberData)

	if not self._enterAnimPlayed then
		self.m_memberList:transitionShowCells("listCrossbandAUiRightIn", 0.04)

		self._enterAnimPlayed = true
	end
end

function GuildHallMainLayer:_onRcvImpeach(arg_18_1, arg_18_2, arg_18_3)
	g.core.module.ModuleManager:tip(g.core.lang:get(109546))
	g.core.network.GameNetProxy:send_C2S_Guild_GetInfo({})
end

function GuildHallMainLayer:_onRcvNotifyLeave(arg_19_1, arg_19_2, arg_19_3)
	if arg_19_3.type == g.core.const.ConstMgr.GuildCommonConst.LeaveType.REMOVE then
		g.core.module.ModuleManager:tip(g.core.lang:get(109547))
	elseif arg_19_3.type == g.core.const.ConstMgr.GuildCommonConst.LeaveType.DISSOLVE then
		g.core.module.ModuleManager:tip(g.core.lang:get(109548))
	elseif arg_19_3.type == g.core.const.ConstMgr.GuildCommonConst.LeaveType.MERGE then
		g.core.module.ModuleManager:tip(g.core.lang:get(430013))
	end

	g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
end

function GuildHallMainLayer:_onMemberItemRenderer(arg_20_1, arg_20_2)
	arg_20_2:updateInfo(arg_20_1, self._memberData[arg_20_1 + 1], self._guildType == var_0_0.guildType.OTHER_GUILD, self._isLeader, self._isLessLeader, self._hasKickRight)
end

function GuildHallMainLayer:_onRcvNotifyJoin()
	g.core.network.GameNetProxy:send_C2S_Guild_GetInfo({})
end

function GuildHallMainLayer:receiveCompEvent(arg_22_1, arg_22_2)
	if arg_22_1 == "Guild_appointment_operation" then
		local var_22_0 = arg_22_2.playerInfo

		if not arg_22_2.playerInfo then
			return
		end

		local var_22_1 = 109581

		self._operateType = 0

		if arg_22_2.position == 1 then
			var_22_1 = 109637
			self._operateType = 1
		elseif arg_22_2.position == 2 then
			var_22_1 = 109582
			self._operateType = 2
		end

		local var_22_2 = var_22_0.user.id

		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(109574),
			desc = g.core.lang:get(var_22_1, {
				name = var_22_0.user.name
			}),
			onConfirm = function()
				g.core.network.GameNetProxy:send_C2S_Guild_Appoint({
					member_id = var_22_2,
					position = arg_22_2.position
				})
			end
		}))
	elseif arg_22_1 == "AppointBtn_click" then
		self.m_appointComp:setPosition(arg_22_2.clickWorldPos)
		self.m_appointComp:setVisible(true)

		if not self._isInitAppointComp then
			self._isInitAppointComp = true
			self._menuComp = fgui.UIPackage:createObject("guild", "GuildLeaderMenuComp")

			self.m_appointComp:addChild(self._menuComp)
		end

		self._menuComp:updateView(arg_22_2.playerInfo, self._isLeader)
	end
end

function GuildHallMainLayer:_onTouchEnd()
	if self.m_appointComp and self.m_appointComp:isVisible() then
		self.m_appointComp:setVisible(false)
	end
end

function GuildHallMainLayer:_isSelfLeader()
	if g.core.model.User.guildData:getMyRightInfo().dissolve > 0 then
		return true
	end

	return false
end

function GuildHallMainLayer:_isSelfLessLeader()
	local var_26_0 = g.core.model.User.guildData:getMyRightInfo()

	if var_26_0.dissolve <= 0 and var_26_0.kick > 0 then
		return true
	end

	return false
end

return GuildHallMainLayer
