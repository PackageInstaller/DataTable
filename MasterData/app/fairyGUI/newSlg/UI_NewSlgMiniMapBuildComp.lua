local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9of2d68eu"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_has_bubbleController = self:getController("has_bubble")
	self.m_attackFlag = self:getChild("attackFlag")
	self.m_eff = self:getChild("eff")
	self.m_Comp_place = self:getChild("Comp_place")
	self.m_List_farmIcon = self:getChild("List_farmIcon")
end

var_0_0.TypeCtrl = {
	page2 = 2,
	page5 = 5,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page6 = 6,
	page3 = 3,
	page7 = 7
}
var_0_0.Has_bubbleCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
