local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5oqgsx7ff"

function var_0_0:__ctor()
	self.m_knightName = self:getChild("knightName")
	self.m_curAttr = self:getChild("curAttr")
	self.m_attrList = self:getChild("attrList")
	self.m_buffList = self:getChild("buffList")
	self.m_passiveList = self:getChild("passiveList")
	self.m_curRootState = self:getChild("curRootState")
	self.m_curSubState = self:getChild("curSubState")
	self.m_battleReport = self:getChild("battleReport")
	self.m_hideView = self:getChild("hideView")
end

return var_0_0
