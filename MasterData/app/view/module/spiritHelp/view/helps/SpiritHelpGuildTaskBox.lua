local var_0_0 = g.core.const.ConstMgr.SpiritHelpConst
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.model.User.guildData
local SpiritHelpGuildTaskBox = class("SpiritHelpGuildTaskBox", require("app.view.module.spiritHelp.view.helps.SpiritHelpDoingBase"))

function SpiritHelpGuildTaskBox:initData()
	self._cellName = "SpiritHelpCell1"
	self._needAddEventList = {
		[var_0_1.EVENT_NET_S2C_GUILD_WORSHIP_GETPROGRESSAWARD_ONEKEY] = handler(self, self._onRevGetAward)
	}
end

function SpiritHelpGuildTaskBox:refreshState()
	self._isTip = false
	self._tipStr = ""

	if not var_0_2:hasGuild() then
		self._state = var_0_0.STATE.LOCK
		self._isTip = true
		self._tipStr = g.core.lang:get(409512)

		return
	end

	if self:getServerState() == var_0_0.SERVER_STATE.NORMAL then
		self._state = var_0_0.STATE.NORMAL
	elseif self:getServerState() == var_0_0.SERVER_STATE.FINISH then
		self._state = var_0_0.STATE.FINISH
	elseif self:getServerState() == var_0_0.SERVER_STATE.LOCK then
		self._state = var_0_0.STATE.LOCK
		self._isTip = true
		self._tipStr = g.core.lang:get(409521)
	end
end

function SpiritHelpGuildTaskBox:doing()
	self:send(function()
		g.core.network.GameNetProxy:send_C2S_GuildWorship_GetProgressAward_OneKey({
			index = {}
		})
	end)

	self._isFinish = true
end

function SpiritHelpGuildTaskBox:_onRevGetAward(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self:addCurDoAward(arg_5_4.awards)
	self:setDoingState(var_0_0.DOING_STATE.SUCCESS)
end

return SpiritHelpGuildTaskBox
