local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepixw1wkk33g"

function var_0_0:__ctor()
	self.m_progStatusController = self:getController("progStatus")
	self.m_goldSavingBtn = self:getChild("goldSavingBtn")
	self.m_effComp = self:getChild("effComp")
	self.m_upNumText = self:getChild("upNumText")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_progComp = self:getChild("progComp")
	self.m_textupTransition = self:getTransition("textup")
end

var_0_0.ProgStatusCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
