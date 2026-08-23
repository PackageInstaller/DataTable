local var_0_0 = g.core.model.User.worldRedPacketData
local var_0_1 = g.core.config.parameter_info
local var_0_2 = g.core.config.redpacket_info
local var_0_3 = g.core.common.Goods
local WorldRedPacketShowPop = class("WorldRedPacketShowPop", require("app.fairyGUI.worldRedPacket.UI_WorldRedPacketShowPop"), function()
	return fgui.GComponent:create({
		resName = "WorldRedPacketShowPop",
		pkgName = "worldRedPacket",
		pkgPath = "ui/worldRedPacket/worldRedPacket"
	}, ...)
end)

function WorldRedPacketShowPop:ctor(arg_2_1)
	self._packetData = arg_2_1.world_red_packet
	self._userList = arg_2_1.pick_users or {}
	self._awardNumList = arg_2_1.distribute or {}
	self._maxAwardNum = 0
	self._packInfo = var_0_2.get(self._packetData.base_id)
	self._awardGood = var_0_3:convert({
		type = self._packInfo.type,
		value = self._packInfo.value,
		size = self._packInfo.size
	})

	self:initView()
	self:showAtCenter()
	self.m_enterTransition:play()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_RedpackageOpen)
end

function WorldRedPacketShowPop:initView()
	self.m_gotList:setVirtual()
	self.m_gotList:setItemRenderer(handler(self, self._onRenderGotList))
	self.m_userIcon:updateAsUser(self._packetData.from_user)
	self.m_userNameText:setText(self._packetData.from_user.name)
	self.m_sendText:setText(var_0_0:getPacketSendText(self._packetData.id))
	self.m_awardIcon:setURL(self._awardGood.icon_mini)
	self.m_totalNumText:setText(self._packInfo.size)
	self.m_isUserSelfController:setSelectedIndex(var_0_0:isSelfPacket(self._packetData.id) and 1 or 0)
	self.m_gotCountText:setText(g.core.lang:get(109060, {
		curNum = self._packetData.pick_num,
		totalNum = self._packInfo.limit_people
	}))

	if self._packetData.self_pick_point and self._packetData.self_pick_point > 0 then
		self.m_getNumText:setText(self._packetData.self_pick_point)
		self.m_getIcon:setURL(self._awardGood.icon)

		local var_3_0 = tonumber(var_0_1.get(self._packInfo.get_limit).parameter)

		self.m_userGetNumText:setText(g.core.lang:get(200523, {
			curNum = math.min(var_3_0, var_3_0 - var_0_0:getLeftCount(self._packInfo.get_limit)),
			totalNum = var_3_0
		}))
		self.m_hasGetController:setSelectedIndex(1)
	else
		if self._packetData.pick_num >= self._packInfo.limit_people then
			self.m_tipText:setText(g.core.lang:get(109067))
		else
			self.m_tipText:setText(g.core.lang:get(109062))
		end

		self.m_hasGetController:setSelectedIndex(0)
	end
end

function WorldRedPacketShowPop:_onRenderGotList(arg_4_1, arg_4_2)
	arg_4_2:updateCell(self._awardGood, self._userList[arg_4_1 + 1], self._awardNumList[arg_4_1 + 1], self._packetData.pick_num >= self._packInfo.limit_people and self._maxAwardNum == self._awardNumList[arg_4_1 + 1] or false)
end

function WorldRedPacketShowPop:onLoad()
	for iter_5_0, iter_5_1 in ipairs(self._awardNumList) do
		self._maxAwardNum = math.max(iter_5_1, self._maxAwardNum)
	end

	self.m_gotList:setNumItems(#self._userList)
end

function WorldRedPacketShowPop:_onClickClose()
	if not self._isClose then
		self._isClose = true

		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

return WorldRedPacketShowPop
