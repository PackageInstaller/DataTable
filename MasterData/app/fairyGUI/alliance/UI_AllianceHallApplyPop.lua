local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcrv0qc"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_popPanel = self:getChild("popPanel")
	self.m_applyList = self:getChild("applyList")
	self.m_applySettingBtn = self:getChild("applySettingBtn")
	self.m_minLevel = self:getChild("minLevel")
	self.m_confirmState = self:getChild("confirmState")
	self.m_content = self:getChild("content")
end

var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
