local var_0_0 = g.core.model.User.guildData
local GuildMainPageCfg = require("app.view.module.guild.const.GuildMainPageCfg")
local GuildMainLayer = class("GuildMainLayer", require("app.fairyGUI.guild.UI_GuildMainLayer"), function()
	return fgui.GComponent:create({
		pkgName = "guild",
		isFullScreen = true,
		pkgPath = "ui/guild/guild",
		resName = "GuildMainLayer"
	}, ...)
end)

function GuildMainLayer:ctor()
	self.m_landComp:init()
	self.m_landComp:setUserActionOperate("fun_tag_", GuildMainPageCfg)
	self.m_redPacketBtn:addClickListener(handler(self, self._onRedPacketBtnClick))
	self.m_rankBtn:addClickListener(handler(self, self._onRankBtnClick))

	self.m_enterTransition = self:getView():getTransition("enter")
	self.m_backTransition = self:getView():getTransition("back")

	self.m_topBar:setResInfoById(9)
	self.m_leftBtn:addClickListener(handler(self, self._onLeftBtnClick))
	self.m_rightBtn:addClickListener(handler(self, self._onRightBtnClick))
	self.m_leftBtn:setVisible(false)
	self.m_rightBtn:setVisible(false)
	self.m_leftBtn:setRedPointStyle(0)
	self.m_rightBtn:setRedPointStyle(0)

	self.m_leftBtnCtrl = self.m_leftBtn:getController("direction")
	self.m_rightBtnCtrl = self.m_rightBtn:getController("direction")

	self:playEnterAnim()
end

function GuildMainLayer:onLoad()
	self:_addListener()
	self:_onGuildInfoUpdate()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPacketBtn
	})
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_ARMY)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 1)
end

function GuildMainLayer:_onGuildInfoUpdate()
	self:_onInfoUpdate()
	self.m_landComp:updateRed()
	self.m_isLowActiveController:setSelectedIndex(var_0_0:isShowLowActive() and 1 or 0)
end

function GuildMainLayer:_onInfoUpdate()
	self._guildData = var_0_0:getGuildData()

	if not next(self._guildData) then
		return
	end

	self.m_guildNameTxt:setText(self._guildData.name)
	self.m_guildLevelTxt:setText(g.core.lang:get(109501, {
		level = self._guildData.level
	}))
	self.m_guildIcon:setURL((g.core.common.Path:getGuildSignOrFrameById(self._guildData.icon)))
end

function GuildMainLayer:_addListener()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_GETINFO, self._onGuildInfoUpdate, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_NOTIFYLEAVE, self._onRcvNotifyLeave, self)
	g.core.network.GameNetProxy:send_C2S_Guild_GetInfo({})
end

function GuildMainLayer:_onRcvNotifyLeave(arg_8_1, arg_8_2, arg_8_3)
	if arg_8_3.type == g.core.const.ConstMgr.GuildCommonConst.LeaveType.REMOVE then
		g.core.module.ModuleManager:tip(g.core.lang:get(109547))
	elseif arg_8_3.type == g.core.const.ConstMgr.GuildCommonConst.LeaveType.DISSOLVE then
		g.core.module.ModuleManager:tip(g.core.lang:get(109548))
	elseif arg_8_3.type == g.core.const.ConstMgr.GuildCommonConst.LeaveType.MERGE then
		g.core.module.ModuleManager:tip(g.core.lang:get(430013))
	end

	g.core.module.ModuleManager:switchModuleIntelligent(g.view.entrance.HOME)
end

function GuildMainLayer:_onRedPacketBtnClick()
	if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.GUILD_RED_PACKAET) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.GUILD_RED_PACKET)
	end
end

function GuildMainLayer:_onRankBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.GUILD_RANK)
end

function GuildMainLayer:_onLeftBtnClick()
	self.m_landComp:moveMap(1)
end

function GuildMainLayer:_onRightBtnClick()
	self.m_landComp:moveMap(2)
end

function GuildMainLayer:receiveCompEvent(arg_13_1, arg_13_2)
	if arg_13_1 == "Guid_show_red_point" then
		local var_13_0 = arg_13_2.leftStyle ~= nil and arg_13_2.leftStyle > 0

		self.m_leftBtn:setVisible(arg_13_2.leftStyle ~= nil and arg_13_2.leftStyle > 0)

		if var_13_0 then
			if arg_13_2.leftStyle == 1 then
				self.m_leftBtnCtrl:setSelectedIndex(0)
			elseif arg_13_2.leftStyle == 2 then
				self.m_leftBtnCtrl:setSelectedIndex(1)
			end

			self.m_leftBtn:setRedPointStyle(arg_13_2.leftStyle)
		end

		local var_13_1 = arg_13_2.rightStyle ~= nil and arg_13_2.rightStyle > 0

		self.m_rightBtn:setVisible(arg_13_2.rightStyle ~= nil and arg_13_2.rightStyle > 0)

		if var_13_1 then
			if arg_13_2.rightStyle == 1 then
				self.m_rightBtnCtrl:setSelectedIndex(2)
			elseif arg_13_2.rightStyle == 2 then
				self.m_rightBtnCtrl:setSelectedIndex(3)
			end

			self.m_rightBtn:setRedPointStyle(arg_13_2.rightStyle)
		end
	end
end

function GuildMainLayer:playSelfEnterAnim()
	self._waitState = true

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	self.m_enterTransition:play(handler(self, self._onSelfEnterFinish))
end

function GuildMainLayer:_onSelfEnterFinish()
	if self._waitState then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end
end

function GuildMainLayer:onUnload()
	if self._waitState then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end
end

return GuildMainLayer
