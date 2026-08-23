local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9gyy86q"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_Txt_desc = self:getChild("Txt_desc")
	self.m_Txt_countDown = self:getChild("Txt_countDown")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
