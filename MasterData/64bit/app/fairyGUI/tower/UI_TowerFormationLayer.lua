local var_0_0 = {}

var_0_0.URL = "ui://foyq921slyd73i"

function var_0_0:__ctor()
	self.m_stageTypeController = self:getController("stageType")
	self.m_hasAddCapacityController = self:getController("hasAddCapacity")
	self.m_knightIcon1 = self:getChild("knightIcon1")
	self.m_knightIcon2 = self:getChild("knightIcon2")
	self.m_knightIcon3 = self:getChild("knightIcon3")
	self.m_knightIcon4 = self:getChild("knightIcon4")
	self.m_knightIcon5 = self:getChild("knightIcon5")
	self.m_knightIcon6 = self:getChild("knightIcon6")
	self.m_fightValueText = self:getChild("fightValueText")
	self.m_curCount = self:getChild("curCount")
	self.m_maxCount = self:getChild("maxCount")
	self.m_stageOrder = self:getChild("stageOrder")
	self.m_rewardList = self:getChild("rewardList")
	self.m_challengeBtn = self:getChild("challengeBtn")
	self.m_buffGroup = self:getChild("buffGroup")
	self.m_buffServer = self:getChild("buffServer")
	self.m_buffActivity = self:getChild("buffActivity")
	self.m_addRes1 = self:getChild("addRes1")
	self.m_addRes2 = self:getChild("addRes2")
	self.m_addRes3 = self:getChild("addRes3")
	self.m_addRes4 = self:getChild("addRes4")
	self.m_checkBtn = self:getChild("checkBtn")
	self.m_recommendValue = self:getChild("recommendValue")
	self.m_infoBtn = self:getChild("infoBtn")
	self.m_topBar = self:getChild("topBar")
	self.m_bottom1 = self:getChild("bottom1")
	self.m_bottom4 = self:getChild("bottom4")
	self.m_bottom2 = self:getChild("bottom2")
	self.m_bottom5 = self:getChild("bottom5")
	self.m_bottom3 = self:getChild("bottom3")
	self.m_bottom6 = self:getChild("bottom6")
	self.m_knight1 = self:getChild("knight1")
	self.m_knight4 = self:getChild("knight4")
	self.m_knight2 = self:getChild("knight2")
	self.m_knight5 = self:getChild("knight5")
	self.m_knight6 = self:getChild("knight6")
	self.m_knight3 = self:getChild("knight3")
end

var_0_0.StageTypeCtrl = {
	page1 = 1,
	page0 = 0,
	page3 = 3,
	page2 = 2
}
var_0_0.HasAddCapacityCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
