local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivjyr415"

function var_0_0:__ctor()
	self.m_barPlace = self:getChild("barPlace")
	self.m_effectHolder = self:getChild("effectHolder")
	self.m_barPic = self:getChild("barPic")
	self.m_maskPlace = self:getChild("maskPlace")
	self.m_rankText = self:getChild("rankText")
	self.m_levelText = self:getChild("levelText")
	self.m_enterTransition = self:getTransition("enter")
	self.m_advanceTransition = self:getTransition("advance")
end

return var_0_0
