local var_0_0 = {}

var_0_0.URL = "ui://pbd24siluhir7l"

function var_0_0:__ctor()
	self.m_showProgressController = self:getController("showProgress")
	self.m_bg = self:getChild("bg")
	self.m_effRefresh = self:getChild("effRefresh")
	self.m_effGet = self:getChild("effGet")
	self.m_effAirDrop = self:getChild("effAirDrop")
	self.m_leftProgress = self:getChild("leftProgress")
	self.m_getTransition = self:getTransition("get")
	self.m_airDropTransition = self:getTransition("airDrop")
	self.m_resetTransition = self:getTransition("reset")
end

return var_0_0
