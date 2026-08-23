local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5lrhf785"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_coinComp = self:getChild("coinComp")
	self.m_equipList = self:getChild("equipList")
	self.m_knightHolder = self:getChild("knightHolder")
	self.m_leftBtn = self:getChild("leftBtn")
	self.m_rightBtn = self:getChild("rightBtn")
	self.m_moqiComp = self:getChild("moqiComp")
	self.m_jieComp = self:getChild("jieComp")
	self.m_pilaoComp = self:getChild("pilaoComp")
	self.m_xinqingComp = self:getChild("xinqingComp")
	self.m_fightValueTxt = self:getChild("fightValueTxt")
	self.m_placeLoader = self:getChild("placeLoader")
	self.m_infoComp = self:getChild("infoComp")
	self.m_bagComp = self:getChild("bagComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
