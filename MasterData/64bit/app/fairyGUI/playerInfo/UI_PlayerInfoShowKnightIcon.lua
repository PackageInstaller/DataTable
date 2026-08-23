local var_0_0 = {}

var_0_0.URL = "ui://1hwemy6ugc0k1r"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_knightIcon = self:getChild("knightIcon")
end

var_0_0.IsEmptyCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
