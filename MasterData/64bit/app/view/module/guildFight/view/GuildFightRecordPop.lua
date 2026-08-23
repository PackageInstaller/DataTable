local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.model.User.GuildFightData
local GuildFightRecordPop = class("GuildFightRecordPop", require("app.fairyGUI.guildFight.UI_GuildFightRecordPop"), function()
	return fgui.GComponent:create({
		resName = "GuildFightRecordPop",
		pkgName = "guildFight",
		pkgPath = "ui/guildFight/guildFight"
	}, ...)
end)

function GuildFightRecordPop:ctor(arg_2_1)
	self:showAtCenter()

	if arg_2_1 then
		self._index = arg_2_1.index or nil
	end

	self._logData = {}

	self.m_logList:setVirtual()
	self.m_logList:setItemRendererAsync(handler(self, self._onLogRenderer))
end

function GuildFightRecordPop:onLoad()
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_GUILD_BATTLE_GETRECORDS, self._onRvcUpdateLog, self)
	g.core.network.GameNetProxy:send_C2S_GuildBattle_GetRecords({})
end

function GuildFightRecordPop:_onRvcUpdateLog()
	local var_4_0 = var_0_3:getLogData()

	self._logData = self._index and self:_getLogData(var_4_0) or var_4_0

	self.m_isEmptyController:setSelectedIndex(#self._logData == 0 and 1 or 0)
	self.m_logList:setNumItems(#self._logData)
end

function GuildFightRecordPop:_getLogData(arg_5_1)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		if iter_5_1.id == self._index then
			table.insert(var_5_0, iter_5_1)
		end
	end

	return var_5_0
end

function GuildFightRecordPop:_onLogRenderer(arg_6_1, arg_6_2)
	arg_6_2:setText(self._logData[arg_6_1 + 1].text or "", true)
end

return GuildFightRecordPop
