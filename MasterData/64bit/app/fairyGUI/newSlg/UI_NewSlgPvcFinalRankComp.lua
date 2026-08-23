local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9jt0v69"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_typeController = self:getController("type")
	self.m_rankList = self:getChild("rankList")
end

var_0_0.IsEmptyCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.TypeCtrl = {
	normal = 0,
	reward = 1
}

return var_0_0
