local var_0_0 = {}

var_0_0.URL = "ui://1v7lxemfo8km1l"

function var_0_0:__ctor()
	self.m_selectTypeController = self:getController("selectType")
	self.m_isChooseController = self:getController("isChoose")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_justShowMineController = self:getController("justShowMine")
	self.m_monsterList = self:getChild("monsterList")
	self.m_touchComp = self:getChild("touchComp")
	self.m_chooseComp = self:getChild("chooseComp")
	self.m_chooseStarBtn = self:getChild("chooseStarBtn")
	self.m_emptyComp = self:getChild("emptyComp")
	self.m_topBarComp = self:getChild("topBarComp")
end

return var_0_0
