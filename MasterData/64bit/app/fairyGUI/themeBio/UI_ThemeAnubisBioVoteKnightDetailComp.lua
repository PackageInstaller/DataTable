local var_0_0 = {}

var_0_0.URL = "ui://i8uevo9v1018gc0"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_showTipController = self:getController("showTip")
	self.m_effectController = self:getController("effect")
	self.m_descTxt = self:getChild("descTxt")
	self.m_tipTxt = self:getChild("tipTxt")
	self.m_knightComp = self:getChild("knightComp")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
