local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9h09fj"

function var_0_0:__ctor()
	self.m_Btn_scale = self:getChild("Btn_scale")
	self.m_slider = self:getChild("slider")
	self.m_Btn_add = self:getChild("Btn_add")
	self.m_Btn_sub = self:getChild("Btn_sub")
	self.m_openTransition = self:getTransition("open")
	self.m_closeTransition = self:getTransition("close")
end

return var_0_0
