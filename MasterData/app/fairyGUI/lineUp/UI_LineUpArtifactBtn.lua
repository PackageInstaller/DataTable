local var_0_0 = {}

var_0_0.URL = "ui://ij78oondtnrvgk"

function var_0_0:__ctor()
	self.m_isWearController = self:getController("isWear")
	self.m_effectComp = self:getChild("effectComp")
	self.m_starComp = self:getChild("starComp")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsWearCtrl = {
	未装备 = 0,
	已装备 = 1
}

return var_0_0
