local var_0_0 = {}

var_0_0.URL = "ui://c64rm38ywczd1k"

function var_0_0:__ctor()
	self.m_hasKnightController = self:getController("hasKnight")
	self.m_leftKnightIcon = self:getChild("leftKnightIcon")
	self.m_rightKnightIcon = self:getChild("rightKnightIcon")
	self.m_effectNode = self:getChild("effectNode")
end

var_0_0.HasKnightCtrl = {
	defalut = 0,
	has = 1
}

return var_0_0
