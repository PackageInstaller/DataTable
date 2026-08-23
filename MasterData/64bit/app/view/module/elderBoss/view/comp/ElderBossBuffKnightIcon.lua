local ElderBossBuffKnightIcon = class("ElderBossBuffKnightIcon", require("app.fairyGUI.elderBoss.UI_ElderBossBuffKnightIcon"))

function ElderBossBuffKnightIcon:updateIcon(arg_1_1)
	self.m_knightIcon:updateIcon({
		struct = arg_1_1
	})

	local var_1_0 = arg_1_1:getInfo()

	if var_1_0 then
		if var_1_0.fight_value > 0 then
			self.m_fightGroup:setVisible(true)
			self.m_fightValueTxt:setText(var_1_0.fight_value)
		else
			self.m_fightGroup:setVisible(false)
		end
	else
		self.m_fightGroup:setVisible(false)
	end

	self.m_isOwnerController:setSelectedIndex(arg_1_1:isOwn() and 1 or 0)
end

return ElderBossBuffKnightIcon
