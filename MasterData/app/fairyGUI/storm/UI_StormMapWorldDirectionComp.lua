local var_0_0 = {}

var_0_0.URL = "ui://arku10fqbp0ykk2y2"

function var_0_0:__ctor()
	self.m_posClueController = self:getController("posClue")
	self.m_posBoxController = self:getController("posBox")
	self.m_posMonsterController = self:getController("posMonster")
	self.m_directionIconClue = self:getChild("directionIconClue")
	self.m_directionIconBox = self:getChild("directionIconBox")
	self.m_directionIconMonster = self:getChild("directionIconMonster")
end

return var_0_0
