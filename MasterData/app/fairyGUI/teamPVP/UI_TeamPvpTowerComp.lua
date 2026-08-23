local var_0_0 = {}

var_0_0.URL = "ui://akds0szapw12i"

function var_0_0:__ctor()
	self.m_isShowHpController = self:getController("isShowHp")
	self.m_buildPos1 = self:getChild("buildPos1")
	self.m_hpBar = self:getChild("hpBar")
end

return var_0_0
