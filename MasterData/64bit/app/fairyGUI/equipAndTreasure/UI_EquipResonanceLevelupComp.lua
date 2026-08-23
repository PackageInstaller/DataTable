local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7aondaj"

function var_0_0:__ctor()
	self.m_hideNextController = self:getController("hideNext")
	self.m_fromLevelComp = self:getChild("fromLevelComp")
	self.m_toLevelComp = self:getChild("toLevelComp")
end

var_0_0.HideNextCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
