local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9whxt68ru"

function var_0_0:__ctor()
	self.m_buildTypeController = self:getController("buildType")
	self.m_hasLineupController = self:getController("hasLineup")
	self.m_seasonController = self:getController("season")
	self.m_effTitle = self:getChild("effTitle")
	self.m_curBuild = self:getChild("curBuild")
	self.m_nextBuild = self:getChild("nextBuild")
	self.m_otherValue1 = self:getChild("otherValue1")
	self.m_otherValue2 = self:getChild("otherValue2")
	self.m_otherValue3 = self:getChild("otherValue3")
	self.m_otherValue4 = self:getChild("otherValue4")
	self.m_lineupValue1 = self:getChild("lineupValue1")
	self.m_lineupValue2 = self:getChild("lineupValue2")
	self.m_lineupValue3 = self:getChild("lineupValue3")
	self.m_lineupValue4 = self:getChild("lineupValue4")
	self.m_lineupGroup = self:getChild("lineupGroup")
	self.m_baseValue1 = self:getChild("baseValue1")
	self.m_baseValue2 = self:getChild("baseValue2")
	self.m_baseValue3 = self:getChild("baseValue3")
	self.m_baseValue4 = self:getChild("baseValue4")
	self.m_baseGroup = self:getChild("baseGroup")
	self.m_enter0Transition = self:getTransition("enter0")
	self.m_enter1Transition = self:getTransition("enter1")
	self.m_enter2Transition = self:getTransition("enter2")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.BuildTypeCtrl = {
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.HasLineupCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.SeasonCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
