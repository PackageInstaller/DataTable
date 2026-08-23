local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcglf07o"

function var_0_0:__ctor()
	self.m_stageController = self:getController("stage")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_titleTip = self:getChild("titleTip")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_descTxt = self:getChild("descTxt")
	self.m_content = self:getChild("content")
end

var_0_0.StageCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
