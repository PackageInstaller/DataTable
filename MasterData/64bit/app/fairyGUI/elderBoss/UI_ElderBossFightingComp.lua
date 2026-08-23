local var_0_0 = {}

var_0_0.URL = "ui://8cx1i074f9832h"

function var_0_0:__ctor()
	self.m_openController = self:getController("open")
	self.m_hitPos = self:getChild("hitPos")
	self.m_fightComp = self:getChild("fightComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.OpenCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
