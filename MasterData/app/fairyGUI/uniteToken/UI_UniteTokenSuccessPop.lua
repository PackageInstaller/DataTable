local var_0_0 = {}

var_0_0.URL = "ui://3yl23vbxo4o41q"

function var_0_0:__ctor()
	self.m_baseCompPop = self:getChild("baseCompPop")
	self.m_infoComp = self:getChild("infoComp")
	self.m_effPlaceHolder = self:getChild("effPlaceHolder")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
