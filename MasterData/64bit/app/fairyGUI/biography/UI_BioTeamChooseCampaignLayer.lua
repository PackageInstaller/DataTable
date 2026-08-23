local var_0_0 = {}

var_0_0.URL = "ui://kgq5r794qofxibrk"

function var_0_0:__ctor()
	self.m_isHardController = self:getController("isHard")
	self.m_openHardController = self:getController("openHard")
	self.m_lockCtrlController = self:getController("lockCtrl")
	self.m_bg1 = self:getChild("bg1")
	self.m_bg2 = self:getChild("bg2")
	self.m_bg3 = self:getChild("bg3")
	self.m_topBar = self:getChild("topBar")
	self.m_rightInfoGroup = self:getChild("rightInfoGroup")
	self.m_achieveBtn = self:getChild("achieveBtn")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_pageList = self:getChild("pageList")
	self.m_leftCountComp = self:getChild("leftCountComp")
	self.m_simpleBtn = self:getChild("simpleBtn")
	self.m_hardBtn = self:getChild("hardBtn")
	self.m_desperateBtn = self:getChild("desperateBtn")
	self.m_nightmareBtn = self:getChild("nightmareBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
