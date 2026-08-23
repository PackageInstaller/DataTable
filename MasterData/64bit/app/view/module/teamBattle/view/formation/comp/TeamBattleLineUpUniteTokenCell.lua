local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User.uniteTokenData
local var_0_2 = g.core.model.User.teamBattleData
local TeamBattleLineupUniteTokenCell = class("TeamBattleLineupUniteTokenCell", require("app.fairyGUI.teamBattle.UI_TeamBattleLineupUniteTokenCell"))

function TeamBattleLineupUniteTokenCell:ctor()
	self._formationData = var_0_2:getFormationData()

	self.getSharedTrans(self, "enter_right", "CommonShortCellList", self)
end

function TeamBattleLineupUniteTokenCell:updateCell(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1:getSkillId()

	self.m_skillIcon:updateIcon({
		skillId = var_2_0
	})
	self.m_nameText:setText(arg_2_1:getName())
	self.m_featureText:setText(g.core.config.skill_range_info.get(var_0_1:getTokenBaseInfo(var_2_0).skillInfo.cfg.skill_range_info).name)
	self.m_qualityBgLoader:setURL((var_0_0:getFormationUniteTokenBg((arg_2_1:getQuality()))))

	if self._formationData:isUniteTokenLineup((arg_2_1:getServerId())) then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

return TeamBattleLineupUniteTokenCell
