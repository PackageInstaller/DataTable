local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9k1jb969js"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_picLoader = self:getChild("picLoader")
	self.m_progComp = self:getChild("progComp")
	self.m_progTxt = self:getChild("progTxt")
	self.m_taskNameTxt = self:getChild("taskNameTxt")
	self.m_descTxt = self:getChild("descTxt")
	self.m_taskDesc2Txt = self:getChild("taskDesc2Txt")
	self.m_rewardList = self:getChild("rewardList")
	self.m_progressTimeTxt = self:getChild("progressTimeTxt")
	self.m_lockStr = self:getChild("lockStr")
end

var_0_0.StateCtrl = {
	page2 = 2,
	page1 = 4,
	page4 = 3,
	page0 = 1,
	page3 = 0
}

return var_0_0
