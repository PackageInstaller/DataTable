local var_0_0 = {}

var_0_0.URL = "ui://46vpuvxvsvn8i"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_hasGroupController = self:getController("hasGroup")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_knightLoader = self:getChild("knightLoader")
	self.m_bgEffect = self:getChild("bgEffect")
	self.m_titleEffect = self:getChild("titleEffect")
	self.m_timeBg = self:getChild("timeBg")
	self.m_timeImg = self:getChild("timeImg")
	self.m_timeText = self:getChild("timeText")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_curBoxComp = self:getChild("curBoxComp")
	self.m_discountTxt = self:getChild("discountTxt")
	self.m_labelEffect = self:getChild("labelEffect")
	self.m_preBoxComp = self:getChild("preBoxComp")
	self.m_preViewBtn = self:getChild("preViewBtn")
	self.m_nextBoxComp = self:getChild("nextBoxComp")
	self.m_nextViewBtn = self:getChild("nextViewBtn")
	self.m_getBtn = self:getChild("getBtn")
	self.m_giftList = self:getChild("giftList")
	self.m_enterTransition = self:getTransition("enter")
	self.m_preBoxTransition = self:getTransition("preBox")
	self.m_nextBoxTransition = self:getTransition("nextBox")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
