local var_0_0 = {}

var_0_0.URL = "ui://c84aee4vkhhl2h"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_bg = self:getChild("bg")
	self.m_effBg = self:getChild("effBg")
	self.m_stoneComp1 = self:getChild("stoneComp1")
	self.m_stoneComp5 = self:getChild("stoneComp5")
	self.m_stoneComp2 = self:getChild("stoneComp2")
	self.m_stoneComp4 = self:getChild("stoneComp4")
	self.m_stoneComp3 = self:getChild("stoneComp3")
	self.m_stoneOneComp = self:getChild("stoneOneComp")
	self.m_effHolder = self:getChild("effHolder")
	self.m_enterTransition = self:getTransition("enter")
	self.m_openTransition = self:getTransition("open")
end

return var_0_0
