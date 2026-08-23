local var_0_0 = g.core.config.redpacket_info
local GuildRedPacketInfoPop = class("GuildRedPacketInfoPop", require("app.fairyGUI.guild.UI_GuildRedPacketInfoPop"), function()
	return fgui.GComponent:create({
		resName = "GuildRedPacketInfoPop",
		pkgPath = "ui/guild/guild",
		pkgName = "guild"
	}, ...)
end)

function GuildRedPacketInfoPop:ctor(arg_2_1)
	self:showAtCenter()

	self._id = arg_2_1.id
	self._detailList = nil
	self._luckyIndex = 0
	self._url = ""
	self._hasLuck = false

	local var_2_0 = var_0_0.get(g.core.model.User.redPacketData:getPacketInfoById(self._id).base_id)

	self._url = g.core.common.Path:getIconByTypeValue(var_2_0.type, var_2_0.value, true)
	self.m_enterTransition = self:getView():getTransition("enter")
	self.m_backTransition = self:getView():getTransition("back")

	self.m_enterTransition:play()
	self:_initView()
end

function GuildRedPacketInfoPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_REDPACKET_DETAIL, handler(self, self._onPacketDetail), self)
	g.core.network.GameNetProxy:send_C2S_Guild_RedPacket_Detail({
		id = self._id
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.OPEN_REDPACKAGE_GET_POP)
end

function GuildRedPacketInfoPop:_initView()
	self.m_getPlayerList:setVirtual()
	self.m_getPlayerList:setItemRenderer(handler(self, self._onPlayerListRenderer))
end

function GuildRedPacketInfoPop:_onPacketDetail()
	local var_5_0 = g.core.model.User.redPacketData:getPacketInfoById(self._id)
	local var_5_1 = var_0_0.get(var_5_0.base_id)

	self.m_numberComp:setFontSize(50)
	self.m_numberComp:setValue(var_5_0.pick_size, var_5_1.limit_people)

	self._detailList = g.core.model.User.redPacketData:getDetailList()
	self._luckyIndex = 0

	for iter_5_0, iter_5_1 in ipairs(self._detailList) do
		local var_5_2

		if 0 < iter_5_1.distribute then
			self._luckyIndex = iter_5_0
			var_5_2 = iter_5_1.distribute
		end
	end

	if #self._detailList >= var_5_1.limit_people then
		self._hasLuck = true
	end

	self.m_getPlayerList:setNumItems(#self._detailList)

	local var_5_3 = g.core.common.Path:getIconByTypeValue(var_5_1.type, var_5_1.value, true)

	self.m_rewardComp:setIcon(var_5_3)

	self._url = var_5_3

	if var_5_0.picked then
		self.m_rewardComp:setValue(var_5_0.point)
		self.m_stateController:setSelectedIndex(0)
	else
		self.m_stateController:setSelectedIndex(1)
	end
end

function GuildRedPacketInfoPop:_onPlayerListRenderer(arg_6_1, arg_6_2)
	arg_6_2:setViewData(self._id, self._detailList[arg_6_1 + 1], (self._hasLuck or nil) and arg_6_1 + 1 == self._luckyIndex, self._url)
end

function GuildRedPacketInfoPop:uniqueStyleOutTrans(arg_7_1)
	self.m_backTransition:play(function()
		arg_7_1()
	end)
end

return GuildRedPacketInfoPop
