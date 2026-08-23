local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9rvr168mu"

function var_0_0:__ctor()
	self.m_emptyController = self:getController("empty")
	self.m_Txt_monsterName = self:getChild("Txt_monsterName")
	self.m_redGraph = self:getChild("redGraph")
	self.m_Txt_fist_reward = self:getChild("Txt_fist_reward")
	self.m_List_icons = self:getChild("List_icons")
	self.m_Comp_award = self:getChild("Comp_award")
	self.m_Txt_empty = self:getChild("Txt_empty")
end

var_0_0.EmptyCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
