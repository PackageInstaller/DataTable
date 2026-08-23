local var_0_0 = {}

var_0_0.URL = "ui://foyq921sg2gw1c"

function var_0_0:__ctor()
	self.m_stageTypeController = self:getController("stageType")
	self.m_difficultyController = self:getController("difficulty")
	self.m_bgComp = self:getChild("bgComp")
	self.m_layerName = self:getChild("layerName")
	self.m_buffDesc = self:getChild("buffDesc")
	self.m_buffGroup = self:getChild("buffGroup")
	self.m_debuffDesc = self:getChild("debuffDesc")
	self.m_mapView = self:getChild("mapView")
	self.m_groupName = self:getChild("groupName")
	self.m_rankRewardBtn = self:getChild("rankRewardBtn")
	self.m_activityBtn = self:getChild("activityBtn")
	self.m_onekeyBtn = self:getChild("onekeyBtn")
	self.m_checkBtn = self:getChild("checkBtn")
	self.m_touchlLayer = self:getChild("touchlLayer")
	self.m_topBar = self:getChild("topBar")
end

var_0_0.StageTypeCtrl = {
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.DifficultyCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
