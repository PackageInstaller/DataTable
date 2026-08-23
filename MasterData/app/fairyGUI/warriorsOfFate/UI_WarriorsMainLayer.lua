local var_0_0 = {}

var_0_0.URL = "ui://lgwihzjq7lyw0"

function var_0_0:__ctor()
	self.m_compController = self:getController("comp")
	self.m_content = self:getChild("content")
	self.m_listBg = self:getChild("listBg")
	self.m_lableList = self:getChild("lableList")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_leftArrowBtn = self:getChild("leftArrowBtn")
	self.m_rightArrowBtn = self:getChild("rightArrowBtn")
	self.m_windBtn = self:getChild("windBtn")
	self.m_progressComp = self:getChild("progressComp")
	self.m_mapComp = self:getChild("mapComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
