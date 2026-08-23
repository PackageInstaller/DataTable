local var_0_0 = {}

var_0_0.URL = "ui://05rqz4hsk27h4a"

function var_0_0:__ctor()
	self.m_isActivateController = self:getController("isActivate")
	self.m_petNumController = self:getController("petNum")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_title = self:getChild("title")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_groupName = self:getChild("groupName")
	self.m_bigQualityLoader = self:getChild("bigQualityLoader")
	self.m_singleIcon = self:getChild("singleIcon")
	self.m_leftIcon = self:getChild("leftIcon")
	self.m_rightIcon = self:getChild("rightIcon")
	self.m_attr1 = self:getChild("attr1")
	self.m_attr2 = self:getChild("attr2")
	self.m_attr3 = self:getChild("attr3")
	self.m_attr4 = self:getChild("attr4")
	self.m_attr5 = self:getChild("attr5")
	self.m_attr6 = self:getChild("attr6")
	self.m_enter_1Transition = self:getTransition("enter_1")
	self.m_back_1Transition = self:getTransition("back_1")
	self.m_enter_0Transition = self:getTransition("enter_0")
	self.m_back_0Transition = self:getTransition("back_0")
end

return var_0_0
