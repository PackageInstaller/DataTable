local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivv2sd8"

function var_0_0:__ctor()
	self.m_isMainController = self:getController("isMain")
	self.m_isLineUpController = self:getController("isLineUp")
	self.m_styleController = self:getController("style")
	self.m_showFavoController = self:getController("showFavo")
	self.m_knightPicRight = self:getChild("knightPicRight")
	self.m_knightPicLeft = self:getChild("knightPicLeft")
	self.m_knightPic = self:getChild("knightPic")
	self.m_effectComp = self:getChild("effectComp")
	self.m_nameComp = self:getChild("nameComp")
	self.m_knightMovieComp = self:getChild("knightMovieComp")
	self.m_favorBtn = self:getChild("favorBtn")
	self.m_infoBtn = self:getChild("infoBtn")
	self.m_skinBtn = self:getChild("skinBtn")
	self.m_showBtn = self:getChild("showBtn")
	self.m_devComp = self:getChild("devComp")
	self.m_weddingBtn = self:getChild("weddingBtn")
	self.m_touchBg = self:getChild("touchBg")
	self.m_rightBtn = self:getChild("rightBtn")
	self.m_leftBtn = self:getChild("leftBtn")
	self.m_topBar = self:getChild("topBar")
	self.m_switchTransition = self:getTransition("switch")
	self.m_backTransition = self:getTransition("back")
	self.m_enterTransition = self:getTransition("enter")
	self.m_right_inTransition = self:getTransition("right_in")
	self.m_left_inTransition = self:getTransition("left_in")
	self.m_juzhong_1Transition = self:getTransition("juzhong_1")
	self.m_enter_lineupTransition = self:getTransition("enter_lineup")
	self.m_juzhong_2Transition = self:getTransition("juzhong_2")
	self.m_uihideTransition = self:getTransition("uihide")
	self.m_uishowTransition = self:getTransition("uishow")
end

var_0_0.IsMainCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsLineUpCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.StyleCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowFavoCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
