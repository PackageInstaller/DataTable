local var_0_0 = {}

var_0_0.URL = "ui://i8uevo9vl5qq9s"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_clueController = self:getController("clue")
	self.m_tabComp1 = self:getChild("tabComp1")
	self.m_tabComp2 = self:getChild("tabComp2")
	self.m_tabComp3 = self:getChild("tabComp3")
	self.m_tabs = self:getChild("tabs")
	self.m_clueComp_1_4 = self:getChild("clueComp_1_4")
	self.m_clueComp_1_3 = self:getChild("clueComp_1_3")
	self.m_clueComp_1_2 = self:getChild("clueComp_1_2")
	self.m_clueComp_1_1 = self:getChild("clueComp_1_1")
	self.m_clueComp_1_5 = self:getChild("clueComp_1_5")
	self.m_chapter1 = self:getChild("chapter1")
	self.m_clueComp_2_1 = self:getChild("clueComp_2_1")
	self.m_clueComp_2_2 = self:getChild("clueComp_2_2")
	self.m_clueComp_2_3 = self:getChild("clueComp_2_3")
	self.m_clueComp_2_4 = self:getChild("clueComp_2_4")
	self.m_clueComp_2_5 = self:getChild("clueComp_2_5")
	self.m_chapter2 = self:getChild("chapter2")
	self.m_clueComp_3_1 = self:getChild("clueComp_3_1")
	self.m_clueComp_3_2 = self:getChild("clueComp_3_2")
	self.m_clueComp_3_3 = self:getChild("clueComp_3_3")
	self.m_clueComp_3_4 = self:getChild("clueComp_3_4")
	self.m_clueComp_3_5 = self:getChild("clueComp_3_5")
	self.m_chapter3 = self:getChild("chapter3")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
