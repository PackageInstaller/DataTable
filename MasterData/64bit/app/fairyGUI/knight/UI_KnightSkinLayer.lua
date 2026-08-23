local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yiv9jwhmh"

function var_0_0:__ctor()
	self.m_hideUIController = self:getController("hideUI")
	self.m_isOwnController = self:getController("isOwn")
	self.m_isShowLookController = self:getController("isShowLook")
	self.m_isShowDescController = self:getController("isShowDesc")
	self.m_knightSpineComp = self:getChild("knightSpineComp")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_knightMovieComp = self:getChild("knightMovieComp")
	self.m_effectComp = self:getChild("effectComp")
	self.m_iconLock = self:getChild("iconLock")
	self.m_spineComp = self:getChild("spineComp")
	self.m_skinComp = self:getChild("skinComp")
	self.m_shareComp = self:getChild("shareComp")
	self.m_hideUIBtn = self:getChild("hideUIBtn")
	self.m_descBtn = self:getChild("descBtn")
	self.m_switchSkinBtn = self:getChild("switchSkinBtn")
	self.m_bookBtn = self:getChild("bookBtn")
	self.m_sliderBg = self:getChild("sliderBg")
	self.m_slider = self:getChild("slider")
	self.m_descComp = self:getChild("descComp")
	self.m_touchBg = self:getChild("touchBg")
	self.m_scaleText = self:getChild("scaleText")
	self.m_posText = self:getChild("posText")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
	self.m_changeEndTransition = self:getTransition("changeEnd")
	self.m_changeStarTransition = self:getTransition("changeStar")
	self.m_lookinTransition = self:getTransition("lookin")
	self.m_lookoutTransition = self:getTransition("lookout")
end

var_0_0.HideUICtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsOwnCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsShowLookCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsShowDescCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
