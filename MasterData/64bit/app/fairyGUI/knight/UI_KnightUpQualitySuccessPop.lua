local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivf2tvfu"

function var_0_0:__ctor()
	self.m_skillPosController = self:getController("skillPos")
	self.m_bgComp = self:getChild("bgComp")
	self.m_englishText = self:getChild("englishText")
	self.m_preQuality = self:getChild("preQuality")
	self.m_curQuality = self:getChild("curQuality")
	self.m_effuptop = self:getChild("effuptop")
	self.m_attr1 = self:getChild("attr1")
	self.m_attr2 = self:getChild("attr2")
	self.m_attr3 = self:getChild("attr3")
	self.m_attr4 = self:getChild("attr4")
	self.m_effPlaceHolder = self:getChild("effPlaceHolder")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.SkillPosCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
