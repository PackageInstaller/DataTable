local var_0_0 = g.core.common.Path
local var_0_1 = g.core.config.redpacket_info
local var_0_2 = g.core.const.ConstMgr.PARAMETER_CONST
local var_0_3 = g.core.config.parameter_info
local WorldRedPacketUsePop = class("WorldRedPacketUsePop", require("app.fairyGUI.worldRedPacket.UI_WorldRedPacketUsePop"), function()
	return fgui.GComponent:create({
		resName = "WorldRedPacketUsePop",
		pkgPath = "ui/worldRedPacket/worldRedPacket",
		pkgName = "worldRedPacket"
	}, ...)
end)

function WorldRedPacketUsePop:ctor(arg_2_1)
	self._itemInfo = arg_2_1.itemInfo
	self._baseId = self._itemInfo.item_value
	self._callback = arg_2_1.callback
	self._isAutoGet = true

	self:initView()
	self:showAtCenter()
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_RedpackageOpen)
end

function WorldRedPacketUsePop:initView()
	self.m_useBtn:addClickListener(handler(self, self._onClickUseBtn))
	self.m_autoGetCheck:addClickListener(handler(self, self._onClickAutoGet))
	self.m_autoGetCheck:setSelected(self._isAutoGet)
	self.m_userIcon:updateAsSelf()
	self.m_inputComp:setMaxLength((tonumber(var_0_3.get(var_0_2.WORLD_RED_PACKET_TEXT_LENGTH).parameter)))
	self.m_inputComp:setPrompt(g.core.lang:get(109059))

	local var_3_0 = var_0_1.get(self._baseId)

	self.m_awardIcon:setURL(var_0_0:getIconByTypeValue(var_3_0.type, var_3_0.value))
	self.m_totalNumText:setText(g.core.lang:get(109066, {
		num = var_3_0.size
	}))
	self.m_countText:setText(var_3_0.limit_people)
end

function WorldRedPacketUsePop:_onClickUseBtn()
	g.core.network.GameNetProxy:send_C2S_WorldRedPacket_Add({
		use_item_id = self._itemInfo.id,
		content = self.m_inputComp:getInputStr()
	})
end

function WorldRedPacketUsePop:_onClickAutoGet()
	self._isAutoGet = self.m_autoGetCheck:isSelected()
end

function WorldRedPacketUsePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WORLD_RED_PACKET_ADD, handler(self, self.onS2CUsePacket), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_WORLD_RED_PACKET_AWARD, handler(self, self.onS2CAwardPacket), self)
end

function WorldRedPacketUsePop:onS2CUsePacket(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if not arg_7_4.errorText then
		if self._isAutoGet then
			g.core.network.GameNetProxy:send_C2S_WorldRedPacket_Award({
				id = arg_7_4.data.world_red_packet.id
			})
		else
			g.core.module.ModuleManager:tip(g.core.lang:get(109065))
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		end

		if self._callback then
			self._callback()
		end
	end
end

function WorldRedPacketUsePop:onS2CAwardPacket(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if not arg_8_4.errorAward then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.worldRedPacket.view.WorldRedPacketOpenPop").new(arg_8_4.data)))
	end

	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return WorldRedPacketUsePop
