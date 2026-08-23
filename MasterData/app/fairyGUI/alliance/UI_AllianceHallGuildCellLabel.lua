local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcmq562g"

function var_0_0:__ctor()
	self.m_isRedController = self:getController("isRed")
	self.m_numTxt = self:getChild("numTxt")
end

var_0_0.IsRedCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
