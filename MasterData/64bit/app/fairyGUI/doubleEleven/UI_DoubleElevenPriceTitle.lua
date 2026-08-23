local var_0_0 = {}

var_0_0.URL = "ui://vtqfjjaif2dob"

function var_0_0:__ctor()
	self.m_colorController = self:getController("color")
	self.m_diamond = self:getChild("diamond")
end

var_0_0.ColorCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
