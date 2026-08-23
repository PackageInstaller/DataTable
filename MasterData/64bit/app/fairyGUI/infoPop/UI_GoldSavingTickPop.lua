local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnhhihlgicgt"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_titleTxt = self:getChild("titleTxt")
	self.m_goBtn = self:getChild("goBtn")
	self.m_cancelBtn = self:getChild("cancelBtn")
	self.m_checkBtn = self:getChild("checkBtn")
end

var_0_0.TypeCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
