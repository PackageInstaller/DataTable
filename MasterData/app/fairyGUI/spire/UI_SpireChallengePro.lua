local var_0_0 = {}

var_0_0.URL = "ui://q8j59504n6sm1z"

function var_0_0:__ctor()
	self.m_hasBossController = self:getController("hasBoss")
	self.m_pro = self:getChild("pro")
	self.m_tag1 = self:getChild("tag1")
	self.m_tag2 = self:getChild("tag2")
	self.m_tag3 = self:getChild("tag3")
	self.m_tag4 = self:getChild("tag4")
	self.m_tag5 = self:getChild("tag5")
	self.m_tag6 = self:getChild("tag6")
	self.m_tag7 = self:getChild("tag7")
	self.m_tag8 = self:getChild("tag8")
	self.m_tag9 = self:getChild("tag9")
	self.m_tag10 = self:getChild("tag10")
	self.m_tagBoss = self:getChild("tagBoss")
	self.m_arrow = self:getChild("arrow")
	self.m_flushNode = self:getChild("flushNode")
	self.m_proMoveTransition = self:getTransition("proMove")
end

var_0_0.HasBossCtrl = {
	boss = 1,
	normal = 0
}

return var_0_0
