local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepn7cvkk2qg"

function var_0_0:__ctor()
	self.m_styleController = self:getController("style")
	self.m_redPointLoader = self:getChild("redPointLoader")
	self.m_tipEffectSpine = self:getChild("tipEffectSpine")
	self.m_idTxt = self:getChild("idTxt")
	self.m_redPointLoopTransition = self:getTransition("redPointLoop")
end

var_0_0.StyleCtrl = {
	page5 = 5,
	page4 = 4,
	limitTime = 3,
	redPoint = 1,
	empty = 0,
	new = 2
}

return var_0_0
