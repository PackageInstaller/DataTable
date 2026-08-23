local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt912oj68bk"

function var_0_0:__ctor()
	self.m_rankController = self:getController("rank")
	self.m_typeController = self:getController("type")
	self.m_Txt_title = self:getChild("Txt_title")
	self.m_Comp_rank = self:getChild("Comp_rank")
	self.m_Txt_tips = self:getChild("Txt_tips")
	self.m_List_reward = self:getChild("List_reward")
	self.m_Img_icon = self:getChild("Img_icon")
	self.m_Comp_res = self:getChild("Comp_res")
	self.m_Comp_mileage = self:getChild("Comp_mileage")
	self.m_Comp_loss = self:getChild("Comp_loss")
end

return var_0_0
