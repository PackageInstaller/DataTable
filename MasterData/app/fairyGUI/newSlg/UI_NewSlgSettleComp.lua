local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9oxju5v"

function var_0_0:__ctor()
	self.m_isAttackedController = self:getController("isAttacked")
	self.m_Comp_effect = self:getChild("Comp_effect")
	self.m_Comp_place = self:getChild("Comp_place")
	self.m_Txt_time = self:getChild("Txt_time")
	self.m_Txt_lv = self:getChild("Txt_lv")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_Txt_allianceName = self:getChild("Txt_allianceName")
	self.m_Comp_allianceLeaderName = self:getChild("Comp_allianceLeaderName")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsAttackedCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
