local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcut1s55"

function var_0_0:__ctor()
	self.m_rankController = self:getController("rank")
	self.m_bg = self:getChild("bg")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_allianceName = self:getChild("allianceName")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_forceTxt = self:getChild("forceTxt")
	self.m_memberSize = self:getChild("memberSize")
	self.m_flag = self:getChild("flag")
	self.m_touchComp = self:getChild("touchComp")
end

var_0_0.RankCtrl = {
	["3"] = 3,
	["1"] = 1,
	["4+"] = 0,
	["2"] = 2
}

return var_0_0
