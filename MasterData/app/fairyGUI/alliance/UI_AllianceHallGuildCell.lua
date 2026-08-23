local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcqutzp"

function var_0_0:__ctor()
	self.m_gradeController = self:getController("grade")
	self.m_guildIcon = self:getChild("guildIcon")
	self.m_level = self:getChild("level")
	self.m_guildName = self:getChild("guildName")
	self.m_serverName = self:getChild("serverName")
	self.m_memberNum = self:getChild("memberNum")
	self.m_power = self:getChild("power")
	self.m_todayContrib = self:getChild("todayContrib")
	self.m_totalContrib = self:getChild("totalContrib")
end

var_0_0.GradeCtrl = {
	page2 = 2,
	page8 = 8,
	page1 = 1,
	page9 = 9,
	page0 = 0,
	page7 = 7,
	page6 = 6,
	page5 = 5,
	page4 = 4,
	page3 = 3
}

return var_0_0
