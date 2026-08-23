local var_0_0 = g.core.model.User.guildData
local GuildLeaderMenuComp = class("GuildLeaderMenuComp", require("app.fairyGUI.guild.UI_GuildLeaderMenuComp"))

function GuildLeaderMenuComp:ctor()
	self._menuData = {}
	self._playInfo = nil

	self.m_leaderBtn:addClickListener(handler(self, self._onAppointmentLeaderClick))
	self.m_lessLeaderBtn:addClickListener(handler(self, self._onAppointmentLessLeaderClick))
	self.m_removeJobBtn:addClickListener(handler(self, self._onRemoveJobClick))
	self.m_kickOutBtn:addClickListener(handler(self, self._onKickOutClick))
end

function GuildLeaderMenuComp:updateView(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	self.m_jobTypeController:setSelectedIndex(0)

	if arg_2_1 then
		if arg_2_2 then
			if arg_2_1.position > 2 then
				self.m_jobTypeController:setSelectedIndex(1)
			end
		else
			self.m_jobTypeController:setSelectedIndex(2)
		end
	end

	self._playerInfo = arg_2_1
end

function GuildLeaderMenuComp:_onAppointmentLeaderClick()
	self:dispatchCompEvent("Guild_appointment_operation", {
		position = 1,
		playerInfo = self._playerInfo
	})
end

function GuildLeaderMenuComp:_onAppointmentLessLeaderClick()
	self:dispatchCompEvent("Guild_appointment_operation", {
		position = 2,
		playerInfo = self._playerInfo
	})
end

function GuildLeaderMenuComp:_onRemoveJobClick()
	self:dispatchCompEvent("Guild_appointment_operation", {
		position = 4,
		playerInfo = self._playerInfo
	})
end

function GuildLeaderMenuComp:_onKickOutClick()
	local var_6_0 = self._playerInfo.user.id
	local var_6_1

	if var_0_0:isLockUser(self._playerInfo.user.id) then
		g.core.module.ModuleManager:tip(g.core.lang:get(430012))

		do return end

		var_6_1 = require("app.view.base.pop.BaseConfirmPop").new
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
		title = g.core.lang:get(109573),
		desc = g.core.lang:get(109572, {
			name = self._playerInfo.user.name
		}),
		onConfirm = function()
			local var_7_0, var_7_1 = g.core.model.User.guildData:getCanPlayerExitGuildOrAlliance()

			if not var_7_0 then
				g.core.module.ModuleManager:tip(var_7_1)

				return
			end

			g.core.network.GameNetProxy:send_C2S_Guild_KickOut({
				kick_id = var_6_0
			})
		end
	}))
end

return GuildLeaderMenuComp
