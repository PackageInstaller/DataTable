local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9jgu4969in"

function var_0_0:__ctor()
	self.m_talentTypeController = self:getController("talentType")
	self.m_isSelectedController = self:getController("isSelected")
	self.m_isActiveController = self:getController("isActive")
	self.m_effDi = self:getChild("effDi")
	self.m_icon = self:getChild("icon")
	self.m_eff = self:getChild("eff")
	self.m_descStr = self:getChild("descStr")
end

var_0_0.TalentTypeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.IsSelectedCtrl = {
	page0 = 2,
	page1 = 3
}
var_0_0.IsActiveCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
