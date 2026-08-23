local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5rcut0"

function var_0_0:__ctor()
	self.m_bossSleepHolder = self:getChild("bossSleepHolder")
	self.m_entityHolder = self:getChild("entityHolder")
	self.m_dropHolder = self:getChild("dropHolder")
	self.m_mapEffectHolder = self:getChild("mapEffectHolder")
	self.m_maskHolder = self:getChild("maskHolder")
	self.m_talkHolder = self:getChild("talkHolder")
	self.m_effectComp = self:getChild("effectComp")
	self.m_cloudHolder = self:getChild("cloudHolder")
end

return var_0_0
