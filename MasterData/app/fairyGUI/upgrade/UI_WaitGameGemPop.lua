local var_0_0 = {}

var_0_0.URL = "ui://4kvnuk1fqv442q"

function var_0_0:__ctor()
	self.m_chessboardComp = self:getChild("chessboardComp")
	self.m_gemEffDad = self:getChild("gemEffDad")
	self.m_infoComp = self:getChild("infoComp")
	self.m_returnBtn = self:getChild("returnBtn")
	self.m_title = self:getChild("title")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
