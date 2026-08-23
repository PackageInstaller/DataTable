local var_0_0 = {}

var_0_0.URL = "ui://gntkqnnjhfmj5"

function var_0_0:__ctor()
	self.m_isOwnController = self:getController("isOwn")
	self.m_subComp = self:getChild("subComp")
	self.m_touchLoader = self:getChild("touchLoader")
	self.m_favoLevelTxt = self:getChild("favoLevelTxt")
	self.m_giftGroup = self:getChild("giftGroup")
end

var_0_0.IsOwnCtrl = {
	拥有 = 0,
	未拥有 = 1
}

return var_0_0
