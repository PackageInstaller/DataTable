local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9whs8u2o"

function var_0_0:__ctor()
	self.m_oddController = self:getController("odd")
	self.m_descTxt = self:getChild("descTxt")
	self.m_indexTxt = self:getChild("indexTxt")
end

var_0_0.OddCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
