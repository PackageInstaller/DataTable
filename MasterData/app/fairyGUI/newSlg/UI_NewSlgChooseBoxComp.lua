local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9fetm68ta"

function var_0_0:__ctor()
	self.m_showListController = self:getController("showList")
	self.m_btn = self:getChild("btn")
	self.m_list = self:getChild("list")
end

var_0_0.ShowListCtrl = {
	hide = 0,
	show = 1
}

return var_0_0
