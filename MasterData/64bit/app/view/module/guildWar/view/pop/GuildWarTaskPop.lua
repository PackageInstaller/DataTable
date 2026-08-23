local var_0_0 = g.core.model.User.guildWarData
local GuildWarTaskPop = class("GuildWarTaskPop", require("app.fairyGUI.guildWar.UI_GuildWarTaskPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/guildWar/guildWar",
		resName = "GuildWarTaskPop",
		pkgName = "guildWar"
	}, ...)
end)

function GuildWarTaskPop:ctor()
	self:showAtCenter()
	self.m_rewardItemList:setVirtual()
	self.m_rewardItemList:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_rewardItemList:doFairyBatching(false)
end

function GuildWarTaskPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_WAR_ACHIEVES_GETINFO, self.onAchieveGetInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_WAR_ACHIEVES_AWARD, self.onAchieveAward, self)
	g.core.network.GameNetProxy:send_C2S_GuildWar_Achieves_GetInfo({})
end

function GuildWarTaskPop:onAchieveGetInfo(arg_4_1, arg_4_2, arg_4_3)
	self:_updateView()
end

function GuildWarTaskPop:onAchieveAward(arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_3 then
		return
	end

	g.core.module.ModuleManager:awardSummary(arg_5_3.awards or {})
	self:_updateView()
end

function GuildWarTaskPop:_updateView()
	self._achieveList = var_0_0:getAchieveList()

	table.sort(self._achieveList, (var_0_0:getSortAchieveFunc()))
	self.m_rewardItemList:setNumItems(#self._achieveList)
end

function GuildWarTaskPop:_onItemRenderer(arg_7_1, arg_7_2)
	arg_7_2:updateCell(self._achieveList[arg_7_1 + 1])
end

return GuildWarTaskPop
