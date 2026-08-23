local var_0_0 = {}

var_0_0.URL = "ui://qzlsgbi1jr2h3n"

function var_0_0:__ctor()
	self.m_showTypeController = self:getController("showType")
	self.m_spineNode = self:getChild("spineNode")
	self.m_touchNode = self:getChild("touchNode")
	self.m_dialogComp = self:getChild("dialogComp")
	self.m_chooseItem1 = self:getChild("chooseItem1")
	self.m_chooseItem2 = self:getChild("chooseItem2")
	self.m_chooseItem3 = self:getChild("chooseItem3")
	self.m_movieNode = self:getChild("movieNode")
end

return var_0_0
