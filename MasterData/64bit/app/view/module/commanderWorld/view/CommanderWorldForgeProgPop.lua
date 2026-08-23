local var_0_0 = g.core.model.User.commanderWorldData
local CommanderWorldForgeProgPop = class("CommanderWorldForgeProgPop", require("app.fairyGUI.commanderWorld.UI_CommanderWorldForgeProgPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/commanderWorld/commanderWorld",
		resName = "CommanderWorldForgeProgPop",
		pkgName = "commanderWorld"
	}, ...)
end)

function CommanderWorldForgeProgPop:ctor()
	self:showAtCenter()

	self._myGuildScore = 0
	self._myGuildLevel = 0
	self._guildLevelInfo = {}

	self.m_forgeProgList:setVirtual()
	self.m_forgeProgList:setItemRenderer(handler(self, self._onRenderForgeProg))
	self:_updateView()
end

function CommanderWorldForgeProgPop:_updateView()
	self._myGuildScore = var_0_0:getMyGuildScore()
	self._myGuildLevel = var_0_0:getMyGuildLevel()

	self.m_forgeProgTxt:setText(g.core.lang:get(410310) .. self._myGuildScore)

	self._guildLevelInfo = var_0_0:getGuildLevelInfo()

	self.m_forgeProgList:setNumItems(#self._guildLevelInfo)
end

function CommanderWorldForgeProgPop:_onRenderForgeProg(arg_4_1, arg_4_2)
	local var_4_0 = 0

	if self._myGuildLevel == arg_4_1 then
		var_4_0 = 1
	elseif arg_4_1 > self._myGuildLevel then
		var_4_0 = 2
	end

	arg_4_2:updateForgeProgCell(self._guildLevelInfo[arg_4_1 + 1], self._guildLevelInfo[arg_4_1].score, self._guildLevelInfo[arg_4_1].hasGotReward, self._myGuildScore, var_4_0)
end

return CommanderWorldForgeProgPop
