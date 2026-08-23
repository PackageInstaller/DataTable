local ExplorationGuildBuffPlayerItem = class("ExplorationGuildBuffPlayerItem", require("app.fairyGUI.exploration.UI_ExplorationGuildBuffPlayerItem"))

function ExplorationGuildBuffPlayerItem:ctor()
	return
end

function ExplorationGuildBuffPlayerItem:updatePlayerInfo(arg_2_1, arg_2_2)
	if arg_2_1 then
		self.m_rankBgController:setSelectedIndex(arg_2_2 == 1 and 0 or 1)
		self.m_rankText:setText(arg_2_2)

		local var_2_0 = g.core.model.User.explorationData:getGuildBuffPlayerInfo(arg_2_1)

		if var_2_0 then
			self.m_nameText:setText(var_2_0.name)
			self.m_powerText:setText(var_2_0.fight_value)

			if var_2_0.id == g.core.model.User:getId() then
				self.m_userIcon:updateAsSelf()
			else
				self.m_userIcon:updateAsUser(var_2_0)
			end
		end
	else
		self.m_rankBgController:setSelectedIndex(2)
	end

	if arg_2_2 <= 3 then
		self.m_rankImg:setURL("ui://text_new/txt_rank" .. arg_2_2)
		self.m_rankNumController:setSelectedIndex(0)
	else
		self.m_rankNumController:setSelectedIndex(1)
	end
end

return ExplorationGuildBuffPlayerItem
