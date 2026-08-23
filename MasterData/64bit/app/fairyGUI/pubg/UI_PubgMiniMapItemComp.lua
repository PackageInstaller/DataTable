local var_0_0 = {}

var_0_0.URL = "ui://pbd24silx2075z"

function var_0_0:__ctor()
	self.m_ctrlController = self:getController("ctrl")
	self.m_icon = self:getChild("icon")
	self.m_effAirDrop = self:getChild("effAirDrop")
	self.m_airDropTransition = self:getTransition("airDrop")
	self.m_airDropLoopTransition = self:getTransition("airDropLoop")
end

return var_0_0
