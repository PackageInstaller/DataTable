local var_0_0 = {}

var_0_0.URL = "ui://fl8ril81jrntz"

function var_0_0:__ctor()
	self.m_isURController = self:getController("isUR")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_title = self:getChild("title")
	self.m_imgLoader = self:getChild("imgLoader")
	self.m_nameComp = self:getChild("nameComp")
	self.m_lvUpEffHolder = self:getChild("lvUpEffHolder")
	self.m_normalState = self:getChild("normalState")
	self.m_attr1 = self:getChild("attr1")
	self.m_attr2 = self:getChild("attr2")
	self.m_attr3 = self:getChild("attr3")
	self.m_attr4 = self:getChild("attr4")
	self.m_attr5 = self:getChild("attr5")
	self.m_closePnl = self:getChild("closePnl")
	self.m_enter_1Transition = self:getTransition("enter_1")
	self.m_back_1Transition = self:getTransition("back_1")
	self.m_back_0Transition = self:getTransition("back_0")
	self.m_enter_0Transition = self:getTransition("enter_0")
end

return var_0_0
