local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5f5cm7f6"

function var_0_0:__ctor()
	self.m_showStateController = self:getController("showState")
	self.m_knightList = self:getChild("knightList")
	self.m_showRange = self:getChild("showRange")
	self.m_selectKnight = self:getChild("selectKnight")
	self.m_selectMonster = self:getChild("selectMonster")
	self.m_asyncUpdateBtn = self:getChild("asyncUpdateBtn")
	self.m_knightRecoverHpBtn = self:getChild("knightRecoverHpBtn")
	self.m_moreDebugBtn = self:getChild("moreDebugBtn")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_knightCompHolder = self:getChild("knightCompHolder")
	self.m_showCompBtn = self:getChild("showCompBtn")
end

return var_0_0
