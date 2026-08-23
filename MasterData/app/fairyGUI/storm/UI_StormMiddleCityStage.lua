local var_0_0 = {}

var_0_0.URL = "ui://arku10fqrpoi1n"

function var_0_0:__ctor()
	self.m_lineTipController = self:getController("lineTip")
	self.m_worldHold = self:getChild("worldHold")
	self.m_criComp = self:getChild("criComp")
	self.m_touchMap = self:getChild("touchMap")
	self.m_skillsBtn = self:getChild("skillsBtn")
	self.m_resetBtn = self:getChild("resetBtn")
	self.m_touchComp = self:getChild("touchComp")
	self.m_topBar = self:getChild("topBar")
	self.m_stageLvTxt = self:getChild("stageLvTxt")
	self.m_selectMapBtn = self:getChild("selectMapBtn")
	self.m_selectMapComp = self:getChild("selectMapComp")
	self.m_playTimesComp = self:getChild("playTimesComp")
	self.m_skipBattleBtn = self:getChild("skipBattleBtn")
end

return var_0_0
