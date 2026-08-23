local GuildFightConst = require("app.view.module.guildFight.const.GuildFightConst")
local GuildFightChariotBattleComp = class("GuildFightChariotBattleComp", require("app.fairyGUI.guildFight.UI_GuildFightChariotBattleComp"))

function GuildFightChariotBattleComp:ctor(arg_1_1)
	self._chariotData = nil
end

function GuildFightChariotBattleComp:updateComp(arg_2_1)
	self._chariotData = arg_2_1.data

	if self._chariotData then
		for iter_2_0, iter_2_1 in ipairs(self._chariotData) do
			if self["m_knightPlayer" .. iter_2_0] then
				self["m_knightPlayer" .. iter_2_0]:updatePlayer({
					data = self._chariotData[iter_2_0],
					index = iter_2_0
				})
			end
		end

		local var_2_0 = {
			user = g.core.model.User:getUserData()
		}

		var_2_0.left = 100

		self.m_knightMe:updatePlayer({
			data = var_2_0
		})
	end
end

function GuildFightChariotBattleComp:getPlayerList()
	return {
		[0] = self.m_knightMe,
		self.m_knightPlayer1,
		self.m_knightPlayer2,
		self.m_knightPlayer3
	}
end

return GuildFightChariotBattleComp
