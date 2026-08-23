local var_0_0 = g.core.const.ConstMgr.GuildCommonConst
local GuildRedPacketLayer = class("GuildRedPacketLayer", require("app.fairyGUI.guild.UI_GuildRedPacketLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/guild/guild",
		resName = "GuildRedPacketLayer",
		pkgName = "guild"
	}, ...)
end)

function GuildRedPacketLayer:ctor()
	self:addBg("bg/guild/bg_jt_juantuanrenwu.jpg")

	self._selectIndex = 1

	self.m_redPacketList:setVirtual()
	self.m_redPacketList:setItemProvider(handler(self, self._setListItemProvider))
	self.m_redPacketList:setItemRenderer(handler(self, self._onRedPacketRenderer))
	self:addListen(self.m_redPacketList)
	g.core.network.GameNetProxy:send_C2S_Guild_RedPacket_Info({})
	self.m_selectController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSelectedTabChange))

	self.m_enterTransition = self:getView():getTransition("enter")
	self.m_backTransition = self:getView():getTransition("back")

	self.m_topBar:setResInfoById(12)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_tab3
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_tab1,
		customData = {
			type = 1
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_tab2,
		customData = {
			type = 2
		}
	})
	self.m_enterTransition:play()
end

function GuildRedPacketLayer:onLoad()
	self:scheduleUpdate(1)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_REDPACKET_INFO, handler(self, self._updateView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_REDPACKET_PICK, handler(self, self._onPickPacketSuc), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_REDPACKET_USE, handler(self, self._onUsePacketSuc), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_REDPACKET_FLUSH, handler(self, self._onPacketFlush), self)
end

function GuildRedPacketLayer:_onSelectedTabChange()
	local var_4_0 = self.m_selectController:getSelectedIndex() + 1

	if var_4_0 ~= self._selectIndex then
		self._selectIndex = var_4_0

		self:_updateView()
	end
end

function GuildRedPacketLayer:_updateView()
	self._curList = g.core.model.User.redPacketData:getCurList(self._selectIndex)

	if self._selectIndex == var_0_0.PACKET_LAYER.GUILD then
		self.m_descTxt:setText(g.core.lang:get(109538))
	elseif self._selectIndex == var_0_0.PACKET_LAYER.MEMBER then
		self.m_descTxt:setText(g.core.lang:get(109539, {
			num = g.core.model.User.redPacketData:getPickTime()[1],
			fullNum = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.INGOTS_RED_PACKET_LIMIT).parameter
		}))
	else
		local var_5_0 = {}

		var_5_0.num = g.core.model.User.redPacketData:getUseTime()
		var_5_0.fullNum = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.RED_ENVELOPES_LIMIT).parameter

		self.m_descTxt:setText(g.core.lang:get(109540, var_5_0))
	end

	if #self._curList == 0 then
		self.m_hasRedPacketController:setSelectedIndex(1)
	else
		self.m_hasRedPacketController:setSelectedIndex(0)
		self.m_redPacketList:setNumItems(#self._curList)
		self.m_redPacketList:transitionShowCells("enter_left", 0.03)
	end
end

function GuildRedPacketLayer:_onPickPacketSuc()
	g.core.network.GameNetProxy:send_C2S_Guild_RedPacket_Info({})
end

function GuildRedPacketLayer:_onUsePacketSuc(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self:_updateView()

	if g.core.model.User.redPacketData:getPickTime()[1] > 0 then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.guild.view.redPacket.GuildOpenPacketPop").new({
			id = arg_7_4.rp.id
		})))
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(109634))
	end
end

function GuildRedPacketLayer:_onRedPacketRenderer(arg_8_1, arg_8_2)
	if not self._curList[arg_8_1 + 1] then
		return
	end

	arg_8_2:setViewData(self._curList[arg_8_1 + 1], self._selectIndex)
end

function GuildRedPacketLayer:_setListItemProvider(arg_9_1)
	if self._selectIndex == var_0_0.PACKET_LAYER.GUILD then
		return "ui://guild/GuildRedPacketGuildCell"
	else
		return "ui://guild/GuildRedPacketUserCell"
	end
end

function GuildRedPacketLayer:_onPacketFlush()
	self:_updateView()
end

function GuildRedPacketLayer:receiveCompEvent(arg_11_1)
	local var_11_0 = {
		...
	}

	if arg_11_1 == "Time_packet_refresh" then
		if var_11_0[1].isPlayer then
			for iter_11_0, iter_11_1 in pairs(self._curList) do
				if iter_11_1.id == var_11_0[1].id then
					table.remove(self._curList, iter_11_0)
					g.core.model.User.redPacketData:removeRedPacket(iter_11_1.id)

					break
				end
			end
		end

		self.m_redPacketList:setNumItems(#self._curList)
	end
end

function GuildRedPacketLayer:onScheduleUpdate()
	local var_12_0 = self.m_redPacketList:getChildren()

	if #var_12_0 > 0 then
		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			if iter_12_1.checkUpdateState then
				iter_12_1:checkUpdateState()
			end
		end
	end
end

function GuildRedPacketLayer:onUnload()
	self:unscheduleUpdate()
end

function GuildRedPacketLayer:getOneKeyReward()
	if g.core.model.User.redPacketData:isHasGuildRedPacket() then
		g.core.network.GameNetProxy:send_C2S_Guild_RedPacket_Pick_OneKey({})
	end
end

return GuildRedPacketLayer
