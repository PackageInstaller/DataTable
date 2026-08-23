local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcr8f52j"

function var_0_0:__ctor()
	self.m_gradeController = self:getController("grade")
	self.m_guildPic = self:getChild("guildPic")
	self.m_level = self:getChild("level")
	self.m_guildName = self:getChild("guildName")
	self.m_guildServer = self:getChild("guildServer")
	self.m_guildPower = self:getChild("guildPower")
	self.m_guildMember = self:getChild("guildMember")
	self.m_guildToday = self:getChild("guildToday")
	self.m_guildTotal = self:getChild("guildTotal")
end

var_0_0.GradeCtrl = {
	page1 = 1,
	page2 = 2,
	page8 = 8,
	page9 = 9,
	page5 = 5,
	page4 = 4,
	page3 = 3,
	page7 = 7,
	page6 = 6,
	page0 = 0
}

return var_0_0
