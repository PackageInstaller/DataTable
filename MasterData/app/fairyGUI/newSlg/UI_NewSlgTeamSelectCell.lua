local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9l84a1p"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_lightController = self:getController("light")
	self.m_stateController = self:getController("state")
	self.m_hasElemController = self:getController("hasElem")
	self.m_elemBtn = self:getChild("elemBtn")
	self.m_elemIcon = self:getChild("elemIcon")
	self.m_elemProTxt = self:getChild("elemProTxt")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_Loader_view = self:getChild("Loader_view")
	self.m_Txt_rule = self:getChild("Txt_rule")
	self.m_Comp_army = self:getChild("Comp_army")
	self.m_Comp_icon1 = self:getChild("Comp_icon1")
	self.m_Comp_icon2 = self:getChild("Comp_icon2")
	self.m_Comp_icon3 = self:getChild("Comp_icon3")
	self.m_Comp_icon4 = self:getChild("Comp_icon4")
	self.m_Comp_icon5 = self:getChild("Comp_icon5")
	self.m_Comp_icon6 = self:getChild("Comp_icon6")
	self.m_Txt_pro = self:getChild("Txt_pro")
	self.m_Btn_check = self:getChild("Btn_check")
	self.m_Btn_restrain = self:getChild("Btn_restrain")
	self.m_Txt_unlock = self:getChild("Txt_unlock")
	self.m_Comp_pro = self:getChild("Comp_pro")
	self.m_Txt_desc = self:getChild("Txt_desc")
	self.m_Img_rec = self:getChild("Img_rec")
	self.m_Comp_status = self:getChild("Comp_status")
	self.m_btnGoHome = self:getChild("btnGoHome")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.LightCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}
var_0_0.HasElemCtrl = {
	elem = 1,
	normal = 0
}

return var_0_0
