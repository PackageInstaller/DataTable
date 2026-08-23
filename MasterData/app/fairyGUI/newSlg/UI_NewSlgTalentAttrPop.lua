local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9l28f969kj"

function var_0_0:__ctor()
	self.m_hasShowController = self:getController("hasShow")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_showComp = self:getChild("showComp")
	self.m_content = self:getChild("content")
end

var_0_0.HasShowCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
