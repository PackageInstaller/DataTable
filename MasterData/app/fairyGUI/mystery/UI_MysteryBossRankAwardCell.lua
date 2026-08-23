local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8ebwsw42"

function var_0_0:__ctor()
	self.m_isHaveBgController = self:getController("isHaveBg")
	self.m_rankIdxTxt = self:getChild("rankIdxTxt")
	self.m_awardList = self:getChild("awardList")
end

return var_0_0
