local var_0_0 = {}

var_0_0.URL = "ui://gntkqnnjrk6j22"

function var_0_0:__ctor()
	self.m_iconTypeController = self:getController("iconType")
	self.m_knightLoader = self:getChild("knightLoader")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_knightNameTxt = self:getChild("knightNameTxt")
	self.m_unOpenLoader = self:getChild("unOpenLoader")
end

var_0_0.IconTypeCtrl = {
	拥有 = 0,
	未开放 = 2,
	未拥有 = 1
}

return var_0_0
