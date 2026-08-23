local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2doeo6d"

function var_0_0:__ctor()
	self.m_has_turnController = self:getController("has_turn")
	self.m_show_userController = self:getController("show_user")
	self.m_Txt_score = self:getChild("Txt_score")
	self.m_Comp_user = self:getChild("Comp_user")
	self.m_List_turn = self:getChild("List_turn")
end

var_0_0.Has_turnCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.Show_userCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
