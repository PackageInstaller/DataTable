local var_0_0 = {}

var_0_0.URL = "ui://3jnmvl3pj3e6gic0r"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_eff_idel_holder = self:getChild("eff_idel_holder")
	self.m_icon = self:getChild("icon")
	self.m_eff_enter_holder = self:getChild("eff_enter_holder")
	self.m_newImg = self:getChild("newImg")
	self.m_miniQualityLoader = self:getChild("miniQualityLoader")
	self.m_fragNumTxt = self:getChild("fragNumTxt")
	self.m_fragIcon = self:getChild("fragIcon")
	self.m_eff_frag_holder = self:getChild("eff_frag_holder")
	self.m_fragShow = self:getChild("fragShow")
	self.m_uniteToken = self:getChild("uniteToken")
	self.m_itemQualityLoader = self:getChild("itemQualityLoader")
	self.m_eff_item_idel_holder = self:getChild("eff_item_idel_holder")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_numTxt = self:getChild("numTxt")
	self.m_item = self:getChild("item")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_eff_fag_enter_holder = self:getChild("eff_fag_enter_holder")
	self.m_enterTransition = self:getTransition("enter")
	self.m_enter1Transition = self:getTransition("enter1")
end

return var_0_0
