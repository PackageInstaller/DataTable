local var_0_0 = {}

var_0_0.URL = "ui://ugwozn2smu7u8"

function var_0_0:__ctor()
	self.m_applyStateController = self:getController("applyState")
	self.m_ladderState = self:getChild("ladderState")
	self.m_applyBtn = self:getChild("applyBtn")
	self.m_cdTxt = self:getChild("cdTxt")
	self.m_applyTip = self:getChild("applyTip")
end

return var_0_0
