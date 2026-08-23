local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9k1jb969k3"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_redLine2 = self:getChild("redLine2")
	self.m_detailList = self:getChild("detailList")
	self.m_limitStr = self:getChild("limitStr")
end

var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
