local GuildDungeonClearAwardPop = class("GuildDungeonClearAwardPop", require("app.fairyGUI.guildDungeon.UI_GuildDungeonClearAwardPop"), function()
	return fgui.GComponent:create({
		resName = "GuildDungeonClearAwardPop",
		pkgPath = "ui/guildDungeon/guildDungeon",
		pkgName = "guildDungeon"
	})
end)
local var_0_1 = g.core.model.User.guildDungeonData

function GuildDungeonClearAwardPop:ctor()
	self._awardList = nil
	self._stateData = var_0_1:getClearAwardState()
	self._rebirth = var_0_1:getRebirth()

	self:_initUI()
end

function GuildDungeonClearAwardPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_GETFINISHAWARD, self._onRcvGetFinishAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_DUNGEON_GETINFO, self._onRcvGetInfo, self)
	self:_updateAwardList()
end

function GuildDungeonClearAwardPop:_onRcvGetInfo()
	self._stateData = var_0_1:getClearAwardState()

	self:_updateAwardList()
end

function GuildDungeonClearAwardPop:_initUI()
	self:showAtCenter()
	self.m_popPanel:setTitle(g.core.lang:get(306001, {
		num = self._rebirth
	}))
	self.m_awardList:setVirtual(self)
	self.m_awardList:setItemRenderer(handler(self, self._onAwardItemRenderer))
end

function GuildDungeonClearAwardPop:_onAwardItemRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateCell({
		data = self._stateData[arg_6_1 + 1]
	})
end

function GuildDungeonClearAwardPop:_onRcvGetFinishAward(arg_7_1, arg_7_2, arg_7_3)
	g.core.module.ModuleManager:awardSummary(arg_7_3.awards)

	self._stateData = var_0_1:getClearAwardState()

	self:_updateAwardList()
end

function GuildDungeonClearAwardPop:_updateAwardList()
	self.m_awardList:setNumItems(#self._stateData)
end

return GuildDungeonClearAwardPop
