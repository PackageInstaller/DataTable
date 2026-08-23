local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o3jb96947"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_Comp_place = self:getChild("Comp_place")
	self.m_Comp_place2 = self:getChild("Comp_place2")
end

var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
