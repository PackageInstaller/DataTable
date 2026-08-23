local var_0_0 = {}

var_0_0.URL = "ui://ymg6v2ln7s1or"

function var_0_0:__ctor()
	self.m_hideUIController = self:getController("hideUI")
	self.m_isShowDescController = self:getController("isShowDesc")
	self.m_isOwnController = self:getController("isOwn")
	self.m_isShowLookController = self:getController("isShowLook")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_knightSpineComp = self:getChild("knightSpineComp")
	self.m_knightMovieComp = self:getChild("knightMovieComp")
	self.m_effectComp = self:getChild("effectComp")
	self.m_iconLock = self:getChild("iconLock")
	self.m_sliderBg = self:getChild("sliderBg")
	self.m_slider = self:getChild("slider")
	self.m_spineComp = self:getChild("spineComp")
	self.m_skinComp = self:getChild("skinComp")
	self.m_hideUIBtn = self:getChild("hideUIBtn")
	self.m_descBtn = self:getChild("descBtn")
	self.m_switchSkinBtn = self:getChild("switchSkinBtn")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_descComp = self:getChild("descComp")
	self.m_touchBg = self:getChild("touchBg")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
	self.m_changeEndTransition = self:getTransition("changeEnd")
	self.m_changeStarTransition = self:getTransition("changeStar")
	self.m_shopEnter0Transition = self:getTransition("shopEnter0")
	self.m_shopEnter1Transition = self:getTransition("shopEnter1")
	self.m_shopBack1Transition = self:getTransition("shopBack1")
	self.m_lookInTransition = self:getTransition("lookIn")
	self.m_lookOutTransition = self:getTransition("lookOut")
end

return var_0_0
