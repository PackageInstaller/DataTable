local var_0_0 = {}

var_0_0.URL = "ui://p0nkxg53j3e684"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_actionCircleBar = self:getChild("actionCircleBar")
	self.m_percentageAddTxt = self:getChild("percentageAddTxt")
end

return var_0_0
