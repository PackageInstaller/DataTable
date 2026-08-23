local var_0_0 = {}

var_0_0.URL = "ui://puryq37ktjzg6t"

function var_0_0:__ctor()
	self.m_rankController = self:getController("rank")
	self.m_picBg = self:getChild("picBg")
	self.m_showPic = self:getChild("showPic")
	self.m_userName = self:getChild("userName")
	self.m_effCell = self:getChild("effCell")
	self.m_alliance = self:getChild("alliance")
end

return var_0_0
