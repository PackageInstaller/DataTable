local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9l84a1r"

function var_0_0:__ctor()
	self.m_item_typeController = self:getController("item_type")
	self.m_is_emptyController = self:getController("is_empty")
	self.m_closeGraph = self:getChild("closeGraph")
	self.m_List_item = self:getChild("List_item")
	self.m_Btn_ok = self:getChild("Btn_ok")
	self.m_Btn_knight = self:getChild("Btn_knight")
	self.m_Btn_uniteToken = self:getChild("Btn_uniteToken")
	self.m_Btn_pet = self:getChild("Btn_pet")
	self.m_Comp_empty = self:getChild("Comp_empty")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.Item_typeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.Is_emptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
