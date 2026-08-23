local var_0_0 = {}

var_0_0.URL = "ui://fl8ril81w7z33a"

function var_0_0:__ctor()
	self.m_attName = self:getChild("attName")
	self.m_firstAttValue = self:getChild("firstAttValue")
	self.m_txt_leftInTransition = self:getTransition("txt_leftIn")
	self.m_txt_downInTransition = self:getTransition("txt_downIn")
end

return var_0_0
