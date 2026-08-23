local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88ocvg89rrtc"

function var_0_0:__ctor()
	self.m_showUniteTokenController = self:getController("showUniteToken")
	self.m_monsterList = self:getChild("monsterList")
	self.m_uniteTokenList = self:getChild("uniteTokenList")
	self.m_fightText = self:getChild("fightText")
	self.m_showSkillComp = self:getChild("showSkillComp")
end

var_0_0.ShowUniteTokenCtrl = {
	hide = 0,
	show = 1
}

return var_0_0
