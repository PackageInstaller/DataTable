local var_0_0 = {}

var_0_0.URL = "ui://b3ojz34oiurhd"

function var_0_0:__ctor()
	self.m_drawStateController = self:getController("drawState")
	self.m_boxLevelController = self:getController("boxLevel")
	self.m_boxActivationDownEffect = self:getChild("boxActivationDownEffect")
	self.m_boxIcon = self:getChild("boxIcon")
	self.m_value = self:getChild("value")
	self.m_boxRenewEffect = self:getChild("boxRenewEffect")
	self.m_box1IdleEffect = self:getChild("box1IdleEffect")
	self.m_box2IdleEffect = self:getChild("box2IdleEffect")
	self.m_box2OpenEffect = self:getChild("box2OpenEffect")
	self.m_boxActivationUpEffect = self:getChild("boxActivationUpEffect")
	self.m_in_0Transition = self:getTransition("in_0")
	self.m_in_2Transition = self:getTransition("in_2")
end

return var_0_0
