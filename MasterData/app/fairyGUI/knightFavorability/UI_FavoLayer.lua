local var_0_0 = {}

var_0_0.URL = "ui://ywebtoins9rh0"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_showLinesController = self:getController("showLines")
	self.m_knightPlaceHolderComp = self:getChild("knightPlaceHolderComp")
	self.m_knightMovieComp = self:getChild("knightMovieComp")
	self.m_effectComp = self:getChild("effectComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_knightLines = self:getChild("knightLines")
	self.m_check1 = self:getChild("check1")
	self.m_check2 = self:getChild("check2")
	self.m_check3 = self:getChild("check3")
	self.m_check4 = self:getChild("check4")
	self.m_panelPlaceHolderComp = self:getChild("panelPlaceHolderComp")
	self.m_heightTempImg = self:getChild("heightTempImg")
	self.m_weddingBtn = self:getChild("weddingBtn")
	self.m_guideGraph = self:getChild("guideGraph")
	self.m_dressListComp = self:getChild("dressListComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
