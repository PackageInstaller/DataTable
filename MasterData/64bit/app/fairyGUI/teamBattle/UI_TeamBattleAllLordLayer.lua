local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lkxd09r"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_allUserComp = self:getChild("allUserComp")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
	self.m_leftOutTransition = self:getTransition("leftOut")
	self.m_rightOutTransition = self:getTransition("rightOut")
end

var_0_0.IsEmptyCtrl = {
	normal = 0,
	empty = 1
}

return var_0_0
