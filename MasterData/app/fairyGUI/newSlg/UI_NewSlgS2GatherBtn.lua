local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9mr6k96964"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isGrayController = self:getController("isGray")
	self.m_holder = self:getChild("holder")
end

var_0_0.StateCtrl = {
	page2 = 2,
	page8 = 8,
	page1 = 1,
	page9 = 9,
	page0 = 0,
	page10 = 10,
	page7 = 7,
	page6 = 6,
	page5 = 5,
	page4 = 4,
	page3 = 3
}
var_0_0.IsGrayCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
