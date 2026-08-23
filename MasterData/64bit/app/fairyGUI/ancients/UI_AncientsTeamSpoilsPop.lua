local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs29qak23"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_soul_typeController = self:getController("soul_type")
	self.m_tabTypeController = self:getController("tabType")
	self.m_is_fullExpController = self:getController("is_fullExp")
	self.m_red_posController = self:getController("red_pos")
	self.m_popPanel = self:getChild("popPanel")
	self.m_Tab_week2 = self:getChild("Tab_week2")
	self.m_Tab_week3 = self:getChild("Tab_week3")
	self.m_Tab_week4 = self:getChild("Tab_week4")
	self.m_Btn_week2 = self:getChild("Btn_week2")
	self.m_Btn_week3 = self:getChild("Btn_week3")
	self.m_Btn_week4 = self:getChild("Btn_week4")
	self.m_List_notAllocated = self:getChild("List_notAllocated")
	self.m_List_allocating = self:getChild("List_allocating")
	self.m_Img_box = self:getChild("Img_box")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_Txt_point = self:getChild("Txt_point")
	self.m_Txt_pointTime = self:getChild("Txt_pointTime")
	self.m_Comp_progress = self:getChild("Comp_progress")
	self.m_Txt_allocateTime = self:getChild("Txt_allocateTime")
	self.m_Btn_detail = self:getChild("Btn_detail")
	self.m_Comp_allocated = self:getChild("Comp_allocated")
	self.m_Comp_res = self:getChild("Comp_res")
	self.m_Txt_openTime = self:getChild("Txt_openTime")
	self.m_094 = self:getChild("094")
	self.m_Tab_redPoint = self:getChild("Tab_redPoint")
	self.m_content = self:getChild("content")
end

var_0_0.StateCtrl = {
	已分配 = 2,
	分配中 = 1,
	未分配 = 0,
	周一 = 3
}
var_0_0.Soul_typeCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}
var_0_0.TabTypeCtrl = {
	周三 = 1,
	周二 = 0,
	周四 = 2
}
var_0_0.Is_fullExpCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.Red_posCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}

return var_0_0
