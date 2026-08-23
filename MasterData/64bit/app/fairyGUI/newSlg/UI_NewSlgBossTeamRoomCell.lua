local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9qhbr86"

function var_0_0:__ctor()
	self.m_is_selfController = self:getController("is_self")
	self.m_can_joinController = self:getController("can_join")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_Btn_join = self:getChild("Btn_join")
	self.m_Txt_countDown = self:getChild("Txt_countDown")
	self.m_Comp_teamUserIcon1 = self:getChild("Comp_teamUserIcon1")
	self.m_Comp_teamUserIcon2 = self:getChild("Comp_teamUserIcon2")
	self.m_Comp_teamUserIcon3 = self:getChild("Comp_teamUserIcon3")
	self.m_Comp_teamUserIcon4 = self:getChild("Comp_teamUserIcon4")
end

var_0_0.Is_selfCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.Can_joinCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
