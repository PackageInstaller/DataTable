local var_0_0 = g.core.model.User.teamBattleData
local TeamBattleBuffIcon = class("TeamBattleBuffIcon", require("app.fairyGUI.teamBattle.UI_TeamBattleBuffIcon"))

function TeamBattleBuffIcon:updateBuffIcon(arg_1_1)
	local var_1_0 = var_0_0:getMapData():getBuffInfo(arg_1_1)

	self.m_bgLoader:setURL(g.core.common.Path:getTeamBattleBuffIconQuality(var_1_0.quality + 1))
	self.m_iconLoader:setURL(g.core.common.Path:getThemeExplorePowerPic(var_1_0.image))
end

return TeamBattleBuffIcon
