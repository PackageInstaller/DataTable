local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wgech3j"

function var_0_0:__ctor()
	self.m_stageController = self:getController("stage")
	self.m_upIcon = self:getChild("upIcon")
	self.m_donwIcon = self:getChild("donwIcon")
end

var_0_0.StageCtrl = {
	page2 = 2,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}

return var_0_0
