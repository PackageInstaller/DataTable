local var_0_0 = {}

var_0_0.URL = "ui://i8uevo9vl5qqam"

function var_0_0:__ctor()
	self.m_subTitleController = self:getController("subTitle")
	self.m_stateController = self:getController("state")
	self.m_sizeController = self:getController("size")
	self.m_subTxt = self:getChild("subTxt")
	self.m_circle = self:getChild("circle")
end

return var_0_0
