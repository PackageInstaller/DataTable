local var_0_0 = {}

var_0_0.URL = "ui://irs65rtsgakjm93"

function var_0_0:__ctor()
	self.m_hideUIController = self:getController("hideUI")
	self.m_bgComp = self:getChild("bgComp")
	self.m_roomComp = self:getChild("roomComp")
	self.m_comfortLvComp = self:getChild("comfortLvComp")
	self.m_tabListBg = self:getChild("tabListBg")
	self.m_floorTabList = self:getChild("floorTabList")
	self.m_lookBtn = self:getChild("lookBtn")
	self.m_leftGroup = self:getChild("leftGroup")
	self.m_zoomSlider = self:getChild("zoomSlider")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_charmNumTxt = self:getChild("charmNumTxt")
	self.m_effCharmNunTxt = self:getChild("effCharmNunTxt")
	self.m_praiseBtn = self:getChild("praiseBtn")
	self.m_hideGroup = self:getChild("hideGroup")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
	self.m_upTransition = self:getTransition("up")
end

return var_0_0
