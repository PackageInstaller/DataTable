local var_0_0 = {}

var_0_0.URL = "ui://671qywx2l2ws1r"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_stateController = self:getController("state")
	self.m_suitIconLoader = self:getChild("suitIconLoader")
	self.m_suitNameText = self:getChild("suitNameText")
	self.m_starComp = self:getChild("starComp")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_qualitySelectBgLeft = self:getChild("qualitySelectBgLeft")
	self.m_qualitySelectBgRight = self:getChild("qualitySelectBgRight")
	self.m_effectHolder = self:getChild("effectHolder")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_haveLoader1 = self:getChild("haveLoader1")
	self.m_haveLoader2 = self:getChild("haveLoader2")
	self.m_haveLoader3 = self:getChild("haveLoader3")
	self.m_unActiveGroup = self:getChild("unActiveGroup")
	self.m_canStarUpGroup = self:getChild("canStarUpGroup")
	self.m_canActiveGroup = self:getChild("canActiveGroup")
end

return var_0_0
