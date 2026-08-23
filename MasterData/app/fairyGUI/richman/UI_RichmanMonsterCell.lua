local var_0_0 = {}

var_0_0.URL = "ui://fu6pxbhwi6ei3u"

function var_0_0:__ctor()
	self.m_canSkipController = self:getController("canSkip")
	self.m_fightValueText = self:getChild("fightValueText")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_challengeBtn = self:getChild("challengeBtn")
	self.m_monsterIconList = self:getChild("monsterIconList")
end

return var_0_0
