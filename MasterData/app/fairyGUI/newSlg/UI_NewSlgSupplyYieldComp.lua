local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9mlm82z"

function var_0_0:__ctor()
	self.m_is_fullController = self:getController("is_full")
	self.m_is_emptyController = self:getController("is_empty")
	self.m_Comp_efficient = self:getChild("Comp_efficient")
	self.m_Comp_store = self:getChild("Comp_store")
	self.m_Comp_build = self:getChild("Comp_build")
	self.m_Comp_limit = self:getChild("Comp_limit")
	self.m_Comp_bar = self:getChild("Comp_bar")
	self.m_Txt_time = self:getChild("Txt_time")
	self.m_List_award = self:getChild("List_award")
	self.m_Comp_cost = self:getChild("Comp_cost")
	self.m_Btn_call = self:getChild("Btn_call")
	self.m_Btn_get = self:getChild("Btn_get")
	self.m_Txt_get = self:getChild("Txt_get")
	self.m_Comp_empty = self:getChild("Comp_empty")
end

return var_0_0
