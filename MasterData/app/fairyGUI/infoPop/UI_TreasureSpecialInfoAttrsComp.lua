local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnbtr9gibyy"

function var_0_0:__ctor()
	self.m_isHasAttrController = self:getController("isHasAttr")
	self.m_titleComp = self:getChild("titleComp")
	self.m_attsList = self:getChild("attsList")
	self.m_emptyText = self:getChild("emptyText")
	self.m_attrsLevelDescTxt = self:getChild("attrsLevelDescTxt")
end

var_0_0.IsHasAttrCtrl = {
	有 = 0,
	无 = 1
}

return var_0_0
