local var_0_0 = {}

var_0_0.URL = "ui://qzlsgbi1nc3mm"

function var_0_0:__ctor()
	self.m_showSpineController = self:getController("showSpine")
	self.m_leftSpineHolder = self:getChild("leftSpineHolder")
	self.m_spineHolder = self:getChild("spineHolder")
	self.m_rightSpineHolder = self:getChild("rightSpineHolder")
	self.m_nameComp = self:getChild("nameComp")
	self.m_leftBtn = self:getChild("leftBtn")
	self.m_rightBtn = self:getChild("rightBtn")
	self.m_showBtn = self:getChild("showBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_right_inTransition = self:getTransition("right_in")
	self.m_left_inTransition = self:getTransition("left_in")
end

return var_0_0
