local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7yctzp5ibj3"

function var_0_0:__ctor()
	self.m_viewComp = self:getChild("viewComp")
	self.m_modeComp = self:getChild("modeComp")
	self.m_slotStatueList = self:getChild("slotStatueList")
	self.m_viewSizeSelect = self:getChild("viewSizeSelect")
	self.m_timeScaleSelect = self:getChild("timeScaleSelect")
	self.m_anmiSelect = self:getChild("anmiSelect")
	self.m_slotSelect = self:getChild("slotSelect")
	self.m_dirSelect = self:getChild("dirSelect")
	self.m_playBtn = self:getChild("playBtn")
	self.m_eventComp = self:getChild("eventComp")
	self.m_stateTxt = self:getChild("stateTxt")
	self.m_viewPosTxt = self:getChild("viewPosTxt")
end

return var_0_0
