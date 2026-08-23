local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9jnyo74"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_Txt_rank = self:getChild("Txt_rank")
	self.m_List_reward = self:getChild("List_reward")
	self.m_List_reward2 = self:getChild("List_reward2")
end

var_0_0.TypeCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
