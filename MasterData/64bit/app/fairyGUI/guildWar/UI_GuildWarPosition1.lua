local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mjwtue"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_processColorController = self:getController("processColor")
	self.m_myGuildController = self:getController("myGuild")
	self.m_realBuildIcon = self:getChild("realBuildIcon")
	self.m_progressTxt = self:getChild("progressTxt")
	self.m_progressBaseTxt = self:getChild("progressBaseTxt")
	self.m_buildIcon = self:getChild("buildIcon")
	self.m_effComp1 = self:getChild("effComp1")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_playerIcon1 = self:getChild("playerIcon1")
	self.m_playerIcon2 = self:getChild("playerIcon2")
	self.m_buildHpProgress = self:getChild("buildHpProgress")
	self.m_effComp2 = self:getChild("effComp2")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page3 = 3,
	page2 = 2,
	page1 = 1
}
var_0_0.ProcessColorCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.MyGuildCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
