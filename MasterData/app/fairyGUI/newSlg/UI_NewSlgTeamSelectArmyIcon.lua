local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9i4n13a"

function var_0_0:__ctor()
	self.m_is_recController = self:getController("is_rec")
	self.m_is_selController = self:getController("is_sel")
	self.m_Comp_icon = self:getChild("Comp_icon")
	self.m_Btn_check = self:getChild("Btn_check")
	self.m_Img_rec = self:getChild("Img_rec")
end

var_0_0.Is_recCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_selCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
