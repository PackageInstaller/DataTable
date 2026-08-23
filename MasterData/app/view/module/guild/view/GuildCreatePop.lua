local var_0_0 = g.core.config.guild_icon_info
local var_0_1 = g.core.const.ConstMgr.GuildCommonConst
local var_0_2 = cc.p(4, 57)
local GuildCreatePop = class("GuildCreatePop", require("app.fairyGUI.guild.UI_GuildCreatePop"), function()
	return fgui.GComponent:create({
		resName = "GuildCreatePop",
		pkgPath = "ui/guild/guild",
		pkgName = "guild"
	}, ...)
end)

function GuildCreatePop:ctor(arg_2_1)
	if arg_2_1 then
		self._isSetting = arg_2_1.setting or false
	end

	if arg_2_1 then
		self._curGuildIconId = arg_2_1.curSingId or 1
	end

	self.m_touchComp:addClickListener(handler(self, self._hideGuildList))
	self.m_showIconBtn:addClickListener(handler(self, self._showGuildIconList))
	self.m_touchComp:setSize(display.width, display.height)
	self:showAtCenter()
	self:_initView()
	self.m_diwenLoader:setURL("pic/base_new/quality/bg_itemsdiwen_1.png")
	self:addListen(self.m_guildSignList)
end

function GuildCreatePop:_initView()
	self.m_createComp:setSignId(self._curGuildIconId)
	self:_setSignPic()

	if self._isSetting then
		self.m_popPanel:setTitle(g.core.lang:get(109567))
		self.m_createComp:updateView(var_0_1.createType.SETTING_GUILD)
	else
		self.m_createComp:updateView(var_0_1.createType.CREATE_GUILD)
	end
end

function GuildCreatePop:_setSignPic()
	self.m_guildLogo:setURL((g.core.common.Path:getGuildSignOrFrameById(var_0_0.get(self._curGuildIconId).res or 5)))
end

function GuildCreatePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_CREATE, handler(self, self._onRcvCreateGuild), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_MODIFYINFO, handler(self, self._onChangeInfoSuccess), self)

	if self._isSetting then
		self.m_createComp:updateView(var_0_1.createType.SETTING_GUILD)
	else
		self.m_createComp:updateView(var_0_1.createType.CREATE_GUILD)
	end
end

function GuildCreatePop:_onRcvCreateGuild()
	g.core.module.ModuleManager:tip(g.core.lang:get(109524, {
		name = g.core.model.User.guildData:getGuildData().name
	}))
	g.core.module.ModuleManager:popModule()
	g.core.module.ModuleManager:replaceModule(g.view.entrance.GUILD_MAIN)
end

function GuildCreatePop:_onChangeInfoSuccess()
	g.core.module.ModuleManager:tip(g.core.lang:get(109566))
	g.core.module.ModuleManager:popModule()
end

function GuildCreatePop:_showGuildIconList()
	if not false then
		self.m_guildSignList:setPosition(var_0_2)
		self.m_showGuildListController:setSelectedIndex(1)
		self.m_guildSignList:updateView({
			id = self._curGuildIconId
		})
	end
end

function GuildCreatePop:_hideGuildList()
	if self.m_showGuildListController:getSelectedIndex() == 1 then
		self.m_showGuildListController:setSelectedIndex(0)
	end
end

function GuildCreatePop:receiveCompEvent(arg_10_1, arg_10_2)
	if not arg_10_1 then
		return
	end

	if arg_10_1 == "GuildSignList_select" then
		self.m_showGuildListController:setSelectedIndex(0)

		if arg_10_2 then
			self._curGuildIconId = arg_10_2.iconId or 0
		end

		self.m_createComp:setSignId(self._curGuildIconId)
		self:_setSignPic()
	end
end

return GuildCreatePop
