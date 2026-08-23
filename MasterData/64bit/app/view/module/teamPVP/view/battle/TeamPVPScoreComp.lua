local var_0_0 = g.core.model.User.teamPvpData
local var_0_1 = g.core.const.ConstMgr.TeamPvpConst
local TeamPVPScoreComp = class("TeamPVPScoreComp", require("app.fairyGUI.teamPVP.UI_TeamPVPScoreComp"))

function TeamPVPScoreComp:ctor()
	self._blueScore = 0
	self._redScore = 0
end

function TeamPVPScoreComp:updateScore()
	self._mapId = var_0_0:getMapId()

	if self._mapId == var_0_1.MAP_TYPE.DESERT then
		self.m_blueScoreTxt:setText(0)
		self.m_redScoreTxt:setText(0)
	else
		self.m_blueScoreTxt:setText(self._blueScore)
		self.m_redScoreTxt:setText(self._redScore)
	end

	if self._mapId == var_0_1.MAP_TYPE.SNOW or self._mapId == var_0_1.MAP_TYPE.SEA then
		self.m_isFoodController:setSelectedIndex(0)
	else
		self.m_isFoodController:setSelectedIndex(1)
	end
end

function TeamPVPScoreComp:updateMorale(arg_3_1, arg_3_2)
	self.m_blueScoreTxt:setText(arg_3_1)
	self.m_redScoreTxt:setText(arg_3_2)
end

function TeamPVPScoreComp:playScoreChange(arg_4_1, arg_4_2)
	if arg_4_1 then
		self.m_blueScoreTxt:setText(arg_4_2)
	else
		self.m_redScoreTxt:setText(arg_4_2)
	end
end

function TeamPVPScoreComp:blueScoreAdd()
	self._blueScore = self._blueScore + 1

	self:updateScore()
end

function TeamPVPScoreComp:redScoreAdd()
	self._redScore = self._redScore + 1

	self:updateScore()
end

return TeamPVPScoreComp
