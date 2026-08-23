local var_0_0 = {}

var_0_0.URL = "ui://puryq37ki9x736"

function var_0_0:__ctor()
	self.m_scaleController = self:getController("scale")
	self.m_myselfController = self:getController("myself")
	self.m_stateController = self:getController("state")
	self.m_showCDController = self:getController("showCD")
	self.m_cheerPosController = self:getController("cheerPos")
	self.m_headCutComp = self:getChild("headCutComp")
	self.m_cdTxt = self:getChild("cdTxt")
	self.m_cheerBtn = self:getChild("cheerBtn")
	self.m_cheerNum = self:getChild("cheerNum")
	self.m_cheerGroup = self:getChild("cheerGroup")
	self.m_alliance = self:getChild("alliance")
	self.m_nameTxt = self:getChild("nameTxt")
end

return var_0_0
