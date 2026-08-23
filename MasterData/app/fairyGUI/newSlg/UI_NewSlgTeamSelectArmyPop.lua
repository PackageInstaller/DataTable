local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9i4n139"

function var_0_0:__ctor()
	self.m_army_typeController = self:getController("army_type")
	self.m_army_ctrlController = self:getController("army_ctrl")
	self.m_closeGraph = self:getChild("closeGraph")
	self.m_Btn_army1 = self:getChild("Btn_army1")
	self.m_Btn_army2 = self:getChild("Btn_army2")
	self.m_Btn_army3 = self:getChild("Btn_army3")
	self.m_Comp_army_icon1 = self:getChild("Comp_army_icon1")
	self.m_Comp_army_icon2 = self:getChild("Comp_army_icon2")
	self.m_Txt_desc = self:getChild("Txt_desc")
	self.m_Btn_go = self:getChild("Btn_go")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.Army_typeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.Army_ctrlCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
