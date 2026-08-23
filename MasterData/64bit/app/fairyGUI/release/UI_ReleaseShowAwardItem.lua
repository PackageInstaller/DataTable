local var_0_0 = {}

var_0_0.URL = "ui://ltl1fuv2k15o2b"

function var_0_0:__ctor()
	self.m_itemQualityLoader = self:getChild("itemQualityLoader")
	self.m_eff_item_idel_holder = self:getChild("eff_item_idel_holder")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_item = self:getChild("item")
	self.m_numTxt = self:getChild("numTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_eff_fag_enter_holder = self:getChild("eff_fag_enter_holder")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
