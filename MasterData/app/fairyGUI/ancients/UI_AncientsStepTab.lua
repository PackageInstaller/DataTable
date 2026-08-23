local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2o6df3t"

function var_0_0:__ctor()
	self.m_num_stateController = self:getController("num_state")
	self.m_show_tipController = self:getController("show_tip")
	self.m_not_fullController = self:getController("not_full")
	self.m_img3 = self:getChild("img3")
	self.m_img1 = self:getChild("img1")
	self.m_img2 = self:getChild("img2")
	self.m_Txt_num = self:getChild("Txt_num")
	self.m_Txt_num1 = self:getChild("Txt_num1")
	self.m_Txt_desc = self:getChild("Txt_desc")
	self.m_Eff_tip = self:getChild("Eff_tip")
	self.m_ComRedPoint = self:getChild("ComRedPoint")
end

var_0_0.Num_stateCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Show_tipCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Not_fullCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
