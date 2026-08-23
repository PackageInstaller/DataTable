local var_0_0 = {}

var_0_0.URL = "ui://pbd24silwcihw"

function var_0_0:__ctor()
	self.m_title = self:getChild("title")
	self.m_descPic = self:getChild("descPic")
	self.m_descComp = self:getChild("descComp")
	self.m_leftArrow = self:getChild("leftArrow")
	self.m_rightArrow = self:getChild("rightArrow")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
