local var_0_0 = {}

var_0_0.URL = "ui://8cx1i074wurd2u"

function var_0_0:__ctor()
	self.m_title = self:getChild("title")
	self.m_descText = self:getChild("descText")
	self.m_knightList = self:getChild("knightList")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_joinBtn = self:getChild("joinBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
