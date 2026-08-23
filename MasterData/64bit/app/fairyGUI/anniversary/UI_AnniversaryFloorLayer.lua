local var_0_0 = {}

var_0_0.URL = "ui://pb5qrmiqt2we16"

function var_0_0:__ctor()
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_bgEffLoader = self:getChild("bgEffLoader")
	self.m_curDescTxt = self:getChild("curDescTxt")
	self.m_curLoader = self:getChild("curLoader")
	self.m_curFloorText = self:getChild("curFloorText")
	self.m_floorGroup = self:getChild("floorGroup")
	self.m_upFloorBtn = self:getChild("upFloorBtn")
	self.m_downFloorBtn = self:getChild("downFloorBtn")
	self.m_floorAwardList = self:getChild("floorAwardList")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
