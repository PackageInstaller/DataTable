local var_0_0 = {}

var_0_0.URL = "ui://npkz19upu6h8r"

function var_0_0:__ctor()
	self.m_bg = self:getChild("bg")
	self.m_sliderBg = self:getChild("sliderBg")
	self.m_slider = self:getChild("slider")
	self.m_resetBtn = self:getChild("resetBtn")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_returnBtn = self:getChild("returnBtn")
	self.m_inTransition = self:getTransition("in")
	self.m_outTransition = self:getTransition("out")
end

return var_0_0
