local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.model.User.guildData
local GuildMergeLookSendPop = class("GuildMergeLookSendPop", require("app.fairyGUI.guild.UI_GuildMergeLookSendPop"), function()
	return fgui.GComponent:create({
		resName = "GuildMergeLookSendPop",
		pkgPath = "ui/guild/guild",
		pkgName = "guild"
	}, ...)
end)

function GuildMergeLookSendPop:ctor(arg_2_1)
	self:showAtCenter()

	self._lockTime = 0
	self._targetGid = arg_2_1.targetGid
	self._userList = {}

	self:initView()
end

function GuildMergeLookSendPop:initView()
	self.m_userList:setVirtual()
	self.m_userList:setItemRenderer(handler(self, self._onUserListRenderer))
	self.m_cancelBtn:addClickListener(handler(self, self._onClickCancel))
end

function GuildMergeLookSendPop:_onClickCancel()
	if self.m_isConfirmController:getSelectedIndex() == 1 then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(1257),
			desc = g.core.lang:get(430016),
			onConfirm = handler(self, self._sendCancel)
		}), {
			touchDisappear = true
		})
	else
		self:_sendCancel()
	end
end

function GuildMergeLookSendPop:_sendCancel()
	if not self or not self._targetGid then
		return
	end

	g.core.network.GameNetProxy:send_C2S_Guild_Merge_Cancel({
		target_guild = self._targetGid
	})
end

function GuildMergeLookSendPop:_onUserListRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateSendLookCell(self._userList[arg_6_1 + 1], arg_6_1)
end

function GuildMergeLookSendPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_MERGE_CANCEL, self._onCancelSucc, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_MERGE_NOTIFY, self._onClickClose, self)
	self:updateView()
end

function GuildMergeLookSendPop:updateView()
	local var_8_0 = var_0_1:getMergeData(self._targetGid)

	self._userList = var_8_0.send_members or {}

	self.m_userList:setNumItems(#self._userList)
	self.m_userNum:setText(#self._userList)

	if var_8_0.is_confirm then
		self._lockTime = var_8_0.merge_time + var_0_1:getMergeLockTime()
		self._lockSchedule = self._lockSchedule or self:newSchedule(handler(self, self._onScheduleLockTime), 1)

		self.m_isConfirmController:setSelectedIndex(1)
	else
		self.m_isConfirmController:setSelectedIndex(0)
	end
end

function GuildMergeLookSendPop:_onScheduleLockTime()
	if var_0_0:getTime() >= self._lockTime then
		self.m_timeDesc:setText("")
	else
		self.m_timeDesc:setText(g.core.lang:get(430003, {
			time = var_0_0:getLeftHMSFormat(self._lockTime)
		}))
	end
end

function GuildMergeLookSendPop:_onClickClose()
	if not self._onClose then
		self._onClose = true

		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end
end

function GuildMergeLookSendPop:_onCancelSucc()
	g.core.module.ModuleManager:tip(g.core.lang:get(430010))
	self:newScheduleOnce(handler(self, self._onClickClose), 0.1)
end

return GuildMergeLookSendPop
