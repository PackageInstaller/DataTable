local var_0_0 = {}

var_0_0.URL = "ui://z48x0zjhofaj1h"

function var_0_0:__ctor()
	self.m_lightController = self:getController("light")
	self.m_isFragController = self:getController("isFrag")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_fragGLoader = self:getChild("fragGLoader")
	self.m_selectLoader = self:getChild("selectLoader")
	self.m_eff = self:getChild("eff")
end

return var_0_0
