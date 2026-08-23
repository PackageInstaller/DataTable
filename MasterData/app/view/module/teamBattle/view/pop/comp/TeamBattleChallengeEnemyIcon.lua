local TeamBattleChallengeEnemyIcon = class("TeamBattleChallengeEnemyIcon", require("app.fairyGUI.teamBattle.UI_TeamBattleChallengeEnemyIcon"))

function TeamBattleChallengeEnemyIcon:updatEnemyIcon(arg_1_1)
	local var_1_0 = require("app.view.module.knight.model.KnightStruct").new(arg_1_1.advance_id)

	var_1_0:addCfgInfo((g.core.config.knight_info.get(arg_1_1.id)))
	self.m_icon:updateIcon({
		struct = var_1_0
	})
	self.m_icon:setStar(var_1_0:getStarLv())
	self.m_hpProg:setPercent({
		max = 100,
		cur = arg_1_1.hp / 10
	})

	if arg_1_1.hp / 10 <= 0 then
		self.m_isDeadController:setSelectedIndex(1)
	else
		self.m_isDeadController:setSelectedIndex(0)
	end
end

return TeamBattleChallengeEnemyIcon
