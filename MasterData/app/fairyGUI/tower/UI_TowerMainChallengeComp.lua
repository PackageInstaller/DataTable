local var_0_0 = {}

var_0_0.URL = "ui://foyq921sg2gw1d"

function var_0_0:__ctor()
	self.m_hasAddCapacityController = self:getController("hasAddCapacity")
	self.m_difficultyController = self:getController("difficulty")
	self.m_stageOrder = self:getChild("stageOrder")
	self.m_rewardList = self:getChild("rewardList")
	self.m_challengeBtn = self:getChild("challengeBtn")
	self.m_formationBtn = self:getChild("formationBtn")
	self.m_buffServer = self:getChild("buffServer")
	self.m_buffActivity = self:getChild("buffActivity")
	self.m_addRes1 = self:getChild("addRes1")
	self.m_addRes2 = self:getChild("addRes2")
	self.m_addRes3 = self:getChild("addRes3")
	self.m_addRes4 = self:getChild("addRes4")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.HasAddCapacityCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.DifficultyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
