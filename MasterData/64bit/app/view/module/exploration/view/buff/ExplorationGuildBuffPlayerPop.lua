local var_0_0 = g.core.const.ConstMgr.ExplorationConst
local ExplorationGuildBuffPlayerPop = class("ExplorationGuildBuffPlayerPop", require("app.fairyGUI.exploration.UI_ExplorationGuildBuffPlayerPop"), function()
	return fgui.GComponent:create({
		resName = "ExplorationGuildBuffPlayerPop",
		pkgName = "exploration"
	})
end)

function ExplorationGuildBuffPlayerPop:ctor(arg_2_1)
	self:showAtCenter()

	self._userIdList = arg_2_1 or {}

	self:_initListView()
	self:updateListView()
end

function ExplorationGuildBuffPlayerPop:_initListView()
	self.m_playerList:setVirtual()
	self.m_playerList:setItemRenderer(handler(self, self._onRenderPlayerList))
end

function ExplorationGuildBuffPlayerPop:_onRenderPlayerList(arg_4_1, arg_4_2)
	arg_4_2:updatePlayerInfo(self._userIdList[arg_4_1 + 1], arg_4_1 + 1)
end

function ExplorationGuildBuffPlayerPop:updateListView()
	self.m_playerList:setNumItems(var_0_0.GUILD_BUFF_PLAYER_NUM)
end

return ExplorationGuildBuffPlayerPop
