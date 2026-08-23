local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1xku31n"

function var_0_0:__ctor()
	self.m_bgComp = self:getChild("bgComp")
	self.m_maskLoader = self:getChild("maskLoader")
	self.m_entranceBtn1 = self:getChild("entranceBtn1")
	self.m_entranceBtn2 = self:getChild("entranceBtn2")
	self.m_entranceBtn3 = self:getChild("entranceBtn3")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_outPutComp1 = self:getChild("outPutComp1")
	self.m_outPutComp2 = self:getChild("outPutComp2")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
