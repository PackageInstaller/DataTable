local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5sp297d2"

function var_0_0:__ctor()
	self.m_singleLvController = self:getController("singleLv")
	self.m_buildIcon = self:getChild("buildIcon")
	self.m_beforeTxt = self:getChild("beforeTxt")
	self.m_afterTxt = self:getChild("afterTxt")
	self.m_nameTxt = self:getChild("nameTxt")
end

return var_0_0
