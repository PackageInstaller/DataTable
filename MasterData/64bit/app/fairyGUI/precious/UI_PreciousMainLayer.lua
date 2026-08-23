local var_0_0 = {}

var_0_0.URL = "ui://671qywx2gn4y0"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_curNumTxt = self:getChild("curNumTxt")
	self.m_maxNumTxt = self:getChild("maxNumTxt")
	self.m_siftBtn = self:getChild("siftBtn")
	self.m_tabList = self:getChild("tabList")
	self.m_emptyComp = self:getChild("emptyComp")
	self.m_suitList = self:getChild("suitList")
	self.m_recycleBtn = self:getChild("recycleBtn")
	self.m_formationBtn = self:getChild("formationBtn")
	self.m_recruitBtn = self:getChild("recruitBtn")
	self.m_siftComp = self:getChild("siftComp")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
