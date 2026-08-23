local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5ls4bx7fn"

function var_0_0:__ctor()
	self.m_singleModeController = self:getController("singleMode")
	self.m_curNumTxt = self:getChild("curNumTxt")
	self.m_nextNumTxt = self:getChild("nextNumTxt")
end

return var_0_0
