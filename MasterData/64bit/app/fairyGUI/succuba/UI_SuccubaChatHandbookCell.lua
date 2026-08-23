local var_0_0 = {}

var_0_0.URL = "ui://qzlsgbi1jr2h3m"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_desTxt = self:getChild("desTxt")
	self.m_stateTxt = self:getChild("stateTxt")
	self.m_attrTxt = self:getChild("attrTxt")
	self.m_maskLoader = self:getChild("maskLoader")
	self.m_playBtn = self:getChild("playBtn")
end

return var_0_0
