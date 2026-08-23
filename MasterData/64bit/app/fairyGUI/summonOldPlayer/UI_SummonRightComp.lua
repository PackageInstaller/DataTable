local var_0_0 = {}

var_0_0.URL = "ui://lpxuu9tar06jn"

function var_0_0:__ctor()
	self.m_backBtn = self:getChild("backBtn")
	self.m_descTxt = self:getChild("descTxt")
	self.m_signList = self:getChild("signList")
	self.m_giftList = self:getChild("giftList")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
