local var_0_0 = {}

var_0_0.URL = "ui://d5b3cu3gz2du2x"

function var_0_0:__ctor()
	self.m_isShowArrowController = self:getController("isShowArrow")
	self.m_isMaxController = self:getController("isMax")
	self.m_desc = self:getChild("desc")
	self.m_curValue = self:getChild("curValue")
	self.m_afterValue = self:getChild("afterValue")
end

return var_0_0
