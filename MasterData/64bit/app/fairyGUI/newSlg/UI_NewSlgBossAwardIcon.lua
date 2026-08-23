local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9qgls68da"

function var_0_0:__ctor()
	self.m_is_speController = self:getController("is_spe")
	self.m_Comp_icon = self:getChild("Comp_icon")
end

var_0_0.Is_speCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
