local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9ouc78i"

function var_0_0:__ctor()
	self.m_is_showController = self:getController("is_show")
	self.m_Comp_select = self:getChild("Comp_select")
	self.m_Btn_show = self:getChild("Btn_show")
	self.m_List_drop = self:getChild("List_drop")
end

var_0_0.Is_showCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
