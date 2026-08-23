local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2mxgy1o"

function var_0_0:__ctor()
	self.m_need_checkController = self:getController("need_check")
	self.m_soul_typeController = self:getController("soul_type")
	self.m_target_typeController = self:getController("target_type")
	self.m_is_settingController = self:getController("is_setting")
	self.m_ComPopPanel = self:getChild("ComPopPanel")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_Btn_checkWithout = self:getChild("Btn_checkWithout")
	self.m_Btn_check = self:getChild("Btn_check")
	self.m_subAddNumComp = self:getChild("subAddNumComp")
	self.m_group5 = self:getChild("group5")
	self.m_Btn_target1 = self:getChild("Btn_target1")
	self.m_Btn_target2 = self:getChild("Btn_target2")
	self.m_Btn_target3 = self:getChild("Btn_target3")
	self.m_Btn_target4 = self:getChild("Btn_target4")
	self.m_Btn_create = self:getChild("Btn_create")
	self.m_Btn_setting = self:getChild("Btn_setting")
	self.m_Txt_settingName = self:getChild("Txt_settingName")
end

var_0_0.Need_checkCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Soul_typeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.Target_typeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}
var_0_0.Is_settingCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
