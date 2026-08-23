local var_0_0 = {}

var_0_0.URL = "ui://i8uevo9vzqdx9bnoqd"

function var_0_0:__ctor()
	self.m_bgIcon = self:getChild("bgIcon")
	self.m_bgEffectComp = self:getChild("bgEffectComp")
	self.m_placeComp = self:getChild("placeComp")
	self.m_picLoader = self:getChild("picLoader")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_descTxt = self:getChild("descTxt")
	self.m_titleShadow = self:getChild("titleShadow")
	self.m_title = self:getChild("title")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
