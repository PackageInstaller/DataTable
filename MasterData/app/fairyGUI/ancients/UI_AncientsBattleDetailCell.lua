local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2gvcg3z"

function var_0_0:__ctor()
	self.m_posController = self:getController("pos")
	self.m_notUserController = self:getController("notUser")
	self.m_Comp_icon1 = self:getChild("Comp_icon1")
	self.m_Comp_icon2 = self:getChild("Comp_icon2")
	self.m_Comp_icon3 = self:getChild("Comp_icon3")
	self.m_List_turn = self:getChild("List_turn")
end

var_0_0.PosCtrl = {
	上 = 0,
	下 = 2,
	中 = 1
}
var_0_0.NotUserCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
