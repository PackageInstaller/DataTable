local var_0_0 = {}

var_0_0.URL = "ui://iibfqm99k856kk2rg"

function var_0_0:__ctor()
	self.m_isShowRefineLevelController = self:getController("isShowRefineLevel")
	self.m_isShowSelfController = self:getController("isShowSelf")
	self.m_strengthLevel = self:getChild("strengthLevel")
	self.m_refineLevel = self:getChild("refineLevel")
end

var_0_0.IsShowRefineLevelCtrl = {
	是 = 0,
	否 = 1
}
var_0_0.IsShowSelfCtrl = {
	是 = 1,
	否 = 0
}

return var_0_0
