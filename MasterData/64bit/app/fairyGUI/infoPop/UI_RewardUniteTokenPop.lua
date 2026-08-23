local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bno6izgibyc"

function var_0_0:__ctor()
	self.m_effPlaceHolder = self:getChild("effPlaceHolder")
	self.m_itemLoader = self:getChild("itemLoader")
	self.m_itemSpineDad = self:getChild("itemSpineDad")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_qualityIcon = self:getChild("qualityIcon")
	self.m_qualityEffectNode = self:getChild("qualityEffectNode")
	self.m_fragIcon2 = self:getChild("fragIcon2")
	self.m_autoFragmentTxt2 = self:getChild("autoFragmentTxt2")
	self.m_convertGroup = self:getChild("convertGroup")
	self.m_shareComp = self:getChild("shareComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
