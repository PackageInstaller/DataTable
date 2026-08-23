local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7yx3l35ibjh"

function var_0_0:__ctor()
	self.m_isOkController = self:getController("isOk")
	self.m_searchInfoComp = self:getChild("searchInfoComp")
	self.m_checkList = self:getChild("checkList")
	self.m_checkBtn = self:getChild("checkBtn")
	self.m_outTalkBtn = self:getChild("outTalkBtn")
end

var_0_0.IsOkCtrl = {
	否 = 0,
	是 = 1
}

return var_0_0
