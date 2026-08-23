local var_0_0 = {}

var_0_0.URL = "ui://1q5ehb83e4001w"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isWitchController = self:getController("isWitch")
	self.m_itemIconBg = self:getChild("itemIconBg")
	self.m_itemLoader = self:getChild("itemLoader")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_numTxt = self:getChild("numTxt")
	self.m_itemMaskLoader = self:getChild("itemMaskLoader")
	self.m_receiveLoader = self:getChild("receiveLoader")
	self.m_canReceiveLoader = self:getChild("canReceiveLoader")
end

return var_0_0
