local var_0_0 = {}

var_0_0.URL = "ui://3ggec6qrspr9kk303"

function var_0_0:__ctor()
	self.m_numTypeController = self:getController("numType")
	self.m_numLable = self:getChild("numLable")
	self.m_curNum = self:getChild("curNum")
end

var_0_0.NumTypeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
