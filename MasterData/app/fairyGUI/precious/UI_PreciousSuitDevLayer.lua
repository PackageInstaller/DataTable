local var_0_0 = {}

var_0_0.URL = "ui://671qywx2oefv1n"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_suitList = self:getChild("suitList")
	self.m_suitComp = self:getChild("suitComp")
	self.m_suitNameText = self:getChild("suitNameText")
	self.m_suitNameGroup = self:getChild("suitNameGroup")
	self.m_activeTipsText = self:getChild("activeTipsText")
	self.m_activeBtn = self:getChild("activeBtn")
	self.m_activeGroup = self:getChild("activeGroup")
	self.m_advanceTipsText = self:getChild("advanceTipsText")
	self.m_advanceBtn = self:getChild("advanceBtn")
	self.m_advanceGroup = self:getChild("advanceGroup")
	self.m_maxStarText = self:getChild("maxStarText")
	self.m_maxStarGroup = self:getChild("maxStarGroup")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_devComp = self:getChild("devComp")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
