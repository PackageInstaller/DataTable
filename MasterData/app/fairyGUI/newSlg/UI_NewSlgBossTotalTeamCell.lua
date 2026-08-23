local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9ouc78k"

function var_0_0:__ctor()
	self.m_is_inController = self:getController("is_in")
	self.m_Txt_desc = self:getChild("Txt_desc")
	self.m_Txt_level = self:getChild("Txt_level")
	self.m_Txt_countDown = self:getChild("Txt_countDown")
	self.m_Comp_leaderName = self:getChild("Comp_leaderName")
	self.m_Comp_userIcon1 = self:getChild("Comp_userIcon1")
	self.m_Comp_userIcon2 = self:getChild("Comp_userIcon2")
	self.m_Comp_userIcon3 = self:getChild("Comp_userIcon3")
	self.m_Comp_userIcon4 = self:getChild("Comp_userIcon4")
	self.m_Btn_join = self:getChild("Btn_join")
	self.m_Btn_share = self:getChild("Btn_share")
	self.m_Btn_check = self:getChild("Btn_check")
	self.m_Comp_army = self:getChild("Comp_army")
end

var_0_0.Is_inCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
