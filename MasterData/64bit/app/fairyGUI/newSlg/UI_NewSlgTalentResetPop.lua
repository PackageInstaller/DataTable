local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9zonn969l3"

function var_0_0:__ctor()
	self.m_isAllController = self:getController("isAll")
	self.m_popPanel = self:getChild("popPanel")
	self.m_resTip = self:getChild("resTip")
	self.m_cancelBtn = self:getChild("cancelBtn")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_content = self:getChild("content")
end

var_0_0.IsAllCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
