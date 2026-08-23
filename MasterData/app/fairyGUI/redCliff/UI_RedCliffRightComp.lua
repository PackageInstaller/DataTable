local var_0_0 = {}

var_0_0.URL = "ui://ugwozn2sj2ge27"

function var_0_0:__ctor()
	self.m_applyStateController = self:getController("applyState")
	self.m_gameStageController = self:getController("gameStage")
	self.m_poolList = self:getChild("poolList")
	self.m_tipTxt = self:getChild("tipTxt")
	self.m_upArrow = self:getChild("upArrow")
	self.m_downArrow = self:getChild("downArrow")
	self.m_point1 = self:getChild("point1")
	self.m_point2 = self:getChild("point2")
	self.m_point3 = self:getChild("point3")
	self.m_point4 = self:getChild("point4")
	self.m_finishTipGroup = self:getChild("finishTipGroup")
	self.m_upgradeTipGroup = self:getChild("upgradeTipGroup")
	self.m_applyBtn = self:getChild("applyBtn")
	self.m_fightBtn = self:getChild("fightBtn")
	self.m_screenTouch = self:getChild("screenTouch")
end

return var_0_0
