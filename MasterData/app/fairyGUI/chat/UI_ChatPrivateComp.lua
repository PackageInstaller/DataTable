local var_0_0 = {}

var_0_0.URL = "ui://v9hfyn87ivlrby2x7"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_nameText = self:getChild("nameText")
	self.m_friendList = self:getChild("friendList")
	self.m_returnBtn = self:getChild("returnBtn")
	self.m_chatList = self:getChild("chatList")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
