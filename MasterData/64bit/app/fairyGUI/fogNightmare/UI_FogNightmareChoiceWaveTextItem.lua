local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88ocvg89rrt9"

function var_0_0:__ctor()
	self.m_hasChildCompController = self:getController("hasChildComp")
	self.m_list = self:getChild("list")
	self.m_childNode = self:getChild("childNode")
end

var_0_0.HasChildCompCtrl = {
	normal = 0,
	has = 1
}

return var_0_0
