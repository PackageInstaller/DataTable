local var_0_0 = {}

var_0_0.URL = "ui://99hn3059lz1jkk33z"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_itemIcon = self:getChild("itemIcon")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
