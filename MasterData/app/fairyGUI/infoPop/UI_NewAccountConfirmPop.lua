local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnu8om1v5dsra"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_showCheckController = self:getController("showCheck")
	self.m_titleTypeController = self:getController("titleType")
	self.m_popPanel = self:getChild("popPanel")
	self.m_accountText = self:getChild("accountText")
	self.m_copyAccountBtn = self:getChild("copyAccountBtn")
	self.m_codeText = self:getChild("codeText")
	self.m_copyCodeBtn = self:getChild("copyCodeBtn")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_content = self:getChild("content")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowCheckCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.TitleTypeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
