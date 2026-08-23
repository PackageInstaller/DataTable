local var_0_0 = {}

var_0_0.URL = "ui://q8j59504n6sm1y"

function var_0_0:__ctor()
	self.m_isBossController = self:getController("isBoss")
	self.m_spineNode = self:getChild("spineNode")
	self.m_title = self:getChild("title")
	self.m_effLoop = self:getChild("effLoop")
	self.m_effPlay = self:getChild("effPlay")
	self.m_fadeNameTransition = self:getTransition("fadeName")
	self.m_bossInTransition = self:getTransition("bossIn")
end

var_0_0.IsBossCtrl = {
	normal = 0,
	boss = 1
}

return var_0_0
