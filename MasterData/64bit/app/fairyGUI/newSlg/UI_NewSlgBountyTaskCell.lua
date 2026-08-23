local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9rvr168mo"

function var_0_0:__ctor()
	self.m_getRewardController = self:getController("getReward")
	self.m_typeController = self:getController("type")
	self.m_Img_bg = self:getChild("Img_bg")
	self.m_eff = self:getChild("eff")
	self.m_Txt_normal_en = self:getChild("Txt_normal_en")
	self.m_Txt_normal = self:getChild("Txt_normal")
	self.m_Img_title_bg = self:getChild("Img_title_bg")
	self.m_Txt_title = self:getChild("Txt_title")
	self.m_Btn_refresh = self:getChild("Btn_refresh")
	self.m_Comp_txt = self:getChild("Comp_txt")
	self.m_Comp_desc = self:getChild("Comp_desc")
	self.m_Txt_target = self:getChild("Txt_target")
	self.m_Txt_time = self:getChild("Txt_time")
	self.m_List_item = self:getChild("List_item")
	self.m_Btn_get = self:getChild("Btn_get")
	self.m_Comp_txtMark = self:getChild("Comp_txtMark")
	self.m_refreshTransition = self:getTransition("refresh")
end

var_0_0.GetRewardCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.TypeCtrl = {
	困难 = 1,
	普通 = 0
}

return var_0_0
