local var_0_0 = {
	ATTACK_BUILDING = 2,
	ATTACK_KEEPER = 1
}
local GuildWarActionInfoPop = class("GuildWarActionInfoPop", require("app.fairyGUI.guildWar.UI_GuildWarActionInfoPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/guildWar/guildWar",
		resName = "GuildWarActionInfoPop",
		pkgName = "guildWar"
	}, ...)
end)

function GuildWarActionInfoPop:ctor()
	self._actionInfoArr = {}

	self.m_infoList:setVirtual()
	self.m_infoList:setItemRenderer(handler(self, self._onInfoListRenderer))
	self:showAtCenter()
end

function GuildWarActionInfoPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_WAR_REPORT_GETINFO, self._onS2CReportGetInfo, self)
	g.core.network.GameNetProxy:send_C2S_GuildWar_Report_GetInfo({})
end

function GuildWarActionInfoPop:_onS2CReportGetInfo()
	self._actionInfoArr = g.core.model.User.guildWarData:getActionInfoArr()

	local var_4_0 = #self._actionInfoArr

	self.m_emptyController:setSelectedIndex(#self._actionInfoArr == 0 and 1 or 0)
	self.m_infoList:setNumItems(var_4_0)
end

function GuildWarActionInfoPop:_onInfoListRenderer(arg_5_1, arg_5_2)
	local var_5_0 = ""

	var_5_0 = self._actionInfoArr[arg_5_1 + 1].report_type == var_0_0.ATTACK_KEEPER and g.core.lang:get(308605, {
		userName = self._actionInfoArr[arg_5_1 + 1].user_name,
		buildName = g.core.lang:get(self._actionInfoArr[arg_5_1 + 1].build_name),
		result = g.core.lang:get(self._actionInfoArr[arg_5_1 + 1].war_result and 308611 or 308612),
		num = self._actionInfoArr[arg_5_1 + 1].rob_score
	}) or self._actionInfoArr[arg_5_1 + 1].report_type == var_0_0.ATTACK_BUILDING and g.core.lang:get(308606, {
		userName = self._actionInfoArr[arg_5_1 + 1].user_name,
		buildName = g.core.lang:get(self._actionInfoArr[arg_5_1 + 1].build_name),
		num = self._actionInfoArr[arg_5_1 + 1].rob_score
	}) or var_5_0

	arg_5_2:updateCell(var_5_0)
end

return GuildWarActionInfoPop
