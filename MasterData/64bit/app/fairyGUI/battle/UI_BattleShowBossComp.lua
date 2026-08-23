local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2t72q7h"

function var_0_0:__ctor()
	self.m_bg = self:getChild("bg")
	self.m_spinePlaceHolder = self:getChild("spinePlaceHolder")
	self.m_bossNameText = self:getChild("bossNameText")
	self.m_locationText = self:getChild("locationText")
	self.m_strategyText = self:getChild("strategyText")
	self.m_skillIcon1 = self:getChild("skillIcon1")
	self.m_skillIcon2 = self:getChild("skillIcon2")
	self.m_skillIcon3 = self:getChild("skillIcon3")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
