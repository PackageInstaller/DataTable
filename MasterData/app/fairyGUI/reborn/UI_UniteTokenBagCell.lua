local var_0_0 = {}

var_0_0.URL = "ui://ami25kgyj3e6s"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_bg = self:getChild("bg")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_nameText = self:getChild("nameText")
	self.m_skillBtn = self:getChild("skillBtn")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_level = self:getChild("level")
	self.m_starComp = self:getChild("starComp")
	self.m_lineUp = self:getChild("lineUp")
	self.m_mask = self:getChild("mask")
	self.m_curTxt = self:getChild("curTxt")
	self.m_needTxt = self:getChild("needTxt")
	self.m_process = self:getChild("process")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}

return var_0_0
