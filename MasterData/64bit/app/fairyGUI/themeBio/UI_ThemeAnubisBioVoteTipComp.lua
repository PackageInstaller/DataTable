local var_0_0 = {}

var_0_0.URL = "ui://i8uevo9v1018gc5"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_icon = self:getChild("icon")
	self.m_waitTxt = self:getChild("waitTxt")
	self.m_goalTxt = self:getChild("goalTxt")
	self.m_selectTxt = self:getChild("selectTxt")
end

return var_0_0
