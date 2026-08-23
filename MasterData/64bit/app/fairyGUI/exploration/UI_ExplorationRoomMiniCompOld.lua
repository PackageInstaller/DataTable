local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25tr5ia1"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isShowPointController = self:getController("isShowPoint")
	self.m_iconEffectDown = self:getChild("iconEffectDown")
	self.m_stateIcon = self:getChild("stateIcon")
	self.m_iconEffectUp = self:getChild("iconEffectUp")
	self.m_effLineNode = self:getChild("effLineNode")
end

return var_0_0
