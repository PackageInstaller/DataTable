local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88ojop9fz"

function var_0_0:__ctor()
	self.m_isShowNextController = self:getController("isShowNext")
	self.m_isUseFormationController = self:getController("isUseFormation")
	self.m_effectNode = self:getChild("effectNode")
	self.m_teamIndexText = self:getChild("teamIndexText")
	self.m_teamIndexNumText = self:getChild("teamIndexNumText")
	self.m_effectArrow = self:getChild("effectArrow")
	self.m_effectTabPlay = self:getChild("effectTabPlay")
end

var_0_0.IsShowNextCtrl = {
	show = 1,
	normal = 0
}
var_0_0.IsUseFormationCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
