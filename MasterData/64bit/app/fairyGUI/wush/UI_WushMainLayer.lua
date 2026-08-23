local var_0_0 = {}

var_0_0.URL = "ui://dcwd6ppekveok"

function var_0_0:__ctor()
	self.m_showBtnController = self:getController("showBtn")
	self.m_isShowInfoController = self:getController("isShowInfo")
	self.m_bgComp = self:getChild("bgComp")
	self.m_depthComp = self:getChild("depthComp")
	self.m_attrComp = self:getChild("attrComp")
	self.m_playTimesComp = self:getChild("playTimesComp")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_wushBtn = self:getChild("wushBtn")
	self.m_posHolderComp = self:getChild("posHolderComp")
	self.m_lineupBtn = self:getChild("lineupBtn")
	self.m_lineUpList = self:getChild("lineUpList")
	self.m_floorComp = self:getChild("floorComp")
	self.m_autoBtn = self:getChild("autoBtn")
	self.m_blitzAllBtn = self:getChild("blitzAllBtn")
	self.m_blitzBtn = self:getChild("blitzBtn")
	self.m_battleInfoComp = self:getChild("battleInfoComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_guideComp = self:getChild("guideComp")
	self.m_leftTransition = self:getTransition("left")
	self.m_rightTransition = self:getTransition("right")
	self.m_enterTransition = self:getTransition("enter")
	self.m_switchTransition = self:getTransition("switch")
end

return var_0_0
