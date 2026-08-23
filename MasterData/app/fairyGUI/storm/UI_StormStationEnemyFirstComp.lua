local var_0_0 = {}

var_0_0.URL = "ui://arku10fqifry5n"

function var_0_0:__ctor()
	self.m_rankController = self:getController("rank")
	self.m_touchBg = self:getChild("touchBg")
	self.m_bg = self:getChild("bg")
	self.m_effFirst = self:getChild("effFirst")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_touchKnight = self:getChild("touchKnight")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_fightValueTxt = self:getChild("fightValueTxt")
	self.m_rankIcon = self:getChild("rankIcon")
	self.m_titleTxt = self:getChild("titleTxt")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
