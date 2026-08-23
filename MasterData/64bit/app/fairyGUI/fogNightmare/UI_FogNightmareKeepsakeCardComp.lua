local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oj8cxf3"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_isSelectController = self:getController("isSelect")
	self.m_detailController = self:getController("detail")
	self.m_hasSuitController = self:getController("hasSuit")
	self.m_powerStateController = self:getController("powerState")
	self.m_effSelect = self:getChild("effSelect")
	self.m_keepsakeIcon = self:getChild("keepsakeIcon")
	self.m_name = self:getChild("name")
	self.m_des = self:getChild("des")
	self.m_power = self:getChild("power")
	self.m_baseIcon = self:getChild("baseIcon")
	self.m_btnDetail = self:getChild("btnDetail")
	self.m_txtLv = self:getChild("txtLv")
	self.m_attrList = self:getChild("attrList")
	self.m_desList = self:getChild("desList")
	self.m_suitBgIcon = self:getChild("suitBgIcon")
	self.m_suitIcon = self:getChild("suitIcon")
	self.m_suitNameText = self:getChild("suitNameText")
	self.m_stateComp = self:getChild("stateComp")
	self.m_switchTransition = self:getTransition("switch")
	self.m_flyTransition = self:getTransition("fly")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.IsSelectCtrl = {
	page0 = 0,
	page2 = 3,
	page1 = 1
}
var_0_0.DetailCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasSuitCtrl = {
	none = 0,
	has = 1
}
var_0_0.PowerStateCtrl = {
	up = 2,
	down = 1,
	normal = 0
}

return var_0_0
