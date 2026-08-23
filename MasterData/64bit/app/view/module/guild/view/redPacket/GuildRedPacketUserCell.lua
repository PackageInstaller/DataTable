local var_0_0 = g.core.model.User.guildData
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.const.ConstMgr.PARAMETER_CONST
local var_0_3 = g.core.const.ConstMgr.GuildCommonConst
local var_0_4 = g.core.config.redpacket_info
local GuildRedPacketUserCell = class("GuildRedPacketUserCell", require("app.fairyGUI.guild.UI_GuildRedPacketUserCell"))

function GuildRedPacketUserCell:ctor()
	self._data = nil
	self._type = var_0_3.PACKET_LAYER.MEMBER
	self._state = 0
	self._playerState = 0
	self._id = 0
	self._limitId = 0
	self._curCd = 0

	self.m_clickBg:addClickListener(handler(self, self._onPickUpClick))
	self.m_sendBtn:addClickListener(handler(self, self._onSendPacketClick))
	self:addClickListener(handler(self, self._onShowDetailClick))
	self.getSharedTrans(self, "enter_left", "CommonCardCellList", self)
end

function GuildRedPacketUserCell:setViewData(arg_2_1, arg_2_2)
	self:unscheduleUpdate()

	if arg_2_2 == var_0_3.PACKET_LAYER.MEMBER then
		self.m_typeController:setSelectedIndex(0)
	else
		self.m_typeController:setSelectedIndex(1)
	end

	self._type = arg_2_2
	self._data = arg_2_1
	self._id = arg_2_1.id

	local var_2_0 = var_0_4.get(self._data.base_id)

	if var_2_0.get_limit == var_0_2.INGOTS_RED_PACKET_LIMIT then
		self._limitId = 1
	elseif var_2_0.get_limit == var_0_2.GOLD_RED_PACKET_LIMIT then
		self._limitId = 2
	elseif var_2_0.get_limit == var_0_2.DEVOTE_RED_PACKET_LIMIT then
		self._limitId = 3
	end

	self.m_icon:setURL(var_0_1:getIconByTypeValue(var_2_0.type, var_2_0.value, false))
	self.m_rewardComp:setIcon(var_0_1:getIconByTypeValue(var_2_0.type, var_2_0.value, true))

	if arg_2_2 == var_0_3.PACKET_LAYER.MEMBER then
		self:_updatePlayerPacket()
	else
		self._id = arg_2_1.base_id

		self:_updateMinePacket()
	end
end

function GuildRedPacketUserCell:_updatePlayerPacket()
	self._isPlayer = true

	local var_3_0 = var_0_4.get(self._data.base_id)

	self.m_nameTxt:setText(var_3_0.name)
	self.m_curNumText:setText(self._data.pick_size or 0)
	self.m_allNumText:setText(g.core.lang:get(109537, {
		num = var_3_0.limit_people
	}))
	self.m_fullSizeText:setText(g.core.lang:get(109066, {
		num = var_3_0.size
	}))
	self.m_fromPlayerName:setText(g.core.lang:get(109535, {
		name = self._data.from_name
	}))

	local var_3_1 = var_0_0:getGuildMemberByPlayerId(self._data.from_id) or {}

	if var_3_1.user then
		self.m_userIcon:updateAsUser(var_3_1.user)
	else
		self.m_userIcon:updateAsUser({
			id = self._data.from_id,
			name = self._data.from_name,
			base_id = self._data.from_base_id
		})
	end

	if self._data.picked then
		self._state = 1

		self.m_stateController:setSelectedIndex(1)
		self.m_rewardComp:setValue(self._data.point)
	elseif self._data.pick_size < var_3_0.limit_people then
		self.m_stateController:setSelectedIndex(0)

		self._state = 0

		self.m_infoTxt:setText(g.core.lang:get(109528))
	else
		self._state = 3

		self.m_stateController:setSelectedIndex(2)
	end

	self:_setUpdateCd(self._data.due_time)
end

function GuildRedPacketUserCell:_updateMinePacket()
	self.m_icon:setGrayed(false)

	self._state = 0

	local var_4_0 = var_0_4.get(self._data.base_id)

	self.m_fullSizeText:setText(g.core.lang:get(109066, {
		num = var_4_0.size
	}))
	self.m_nameTxt:setText(var_4_0.name)
	self.m_curNumText:setText(self._data.pick_size or 0)
	self.m_allNumText:setText(g.core.lang:get(109537, {
		num = var_4_0.limit_people
	}))
	self.m_userIcon:updateAsSelf()
end

function GuildRedPacketUserCell:_onPickUpClick()
	if self._state == 0 then
		local var_5_0 = g.core.model.User.redPacketData:getPickTime()

		if self._type == 2 and var_5_0[self._limitId] and var_5_0[self._limitId] <= 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(109529))

			return
		end

		self:_onPickRedPacket()
	elseif self._state == 2 then
		g.core.module.ModuleManager:tip(g.core.lang:get(109530))
	elseif self._state == 4 then
		g.core.module.ModuleManager:tip(g.core.lang:get(109531))
	end
end

function GuildRedPacketUserCell:_onSendPacketClick()
	if g.core.model.User.redPacketData:getUseTime() > 0 then
		g.core.network.GameNetProxy:send_C2S_Guild_RedPacket_Use({
			id = self._id
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(109532))
	end
end

function GuildRedPacketUserCell:_onShowDetailClick()
	if self._state == 1 or self._state == 3 then
		self:_showPacketGetInfo()
	end
end

function GuildRedPacketUserCell:_setUpdateCd(arg_8_1)
	self._stillUpdate = true
	self._curCd = arg_8_1
end

function GuildRedPacketUserCell:checkUpdateState()
	if self._stillUpdate and g.core.common.ServerTime:getLeftSeconds(self._curCd) <= 0 then
		self._curCd = 0

		self:dispatchCompEvent("Time_packet_refresh", {
			isPlayer = self._isPlayer,
			id = self._id
		})

		self._stillUpdate = false
	end
end

function GuildRedPacketUserCell:_onPickRedPacket(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	g.core.module.ModuleManager:pushPopup((require("app.view.module.guild.view.redPacket.GuildOpenPacketPop").new({
		id = self._id
	})))
end

function GuildRedPacketUserCell:_showPacketGetInfo()
	local var_11_0 = g.core.model.User.redPacketData:getPacketInfoById(self._id)

	if var_11_0 and var_11_0.base_id and var_11_0.base_id > 0 then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.guild.view.redPacket.GuildRedPacketInfoPop").new({
			id = self._id
		}), {
			touchDisappear = true
		})
	else
		self:dispatchCompEvent("Time_packet_refresh", {
			isPlayer = self._isPlayer,
			id = self._id
		})
	end
end

return GuildRedPacketUserCell
