local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88ou8jrrri2"

function var_0_0:__ctor()
	self.m_isFreeController = self:getController("isFree")
	self.m_popPanel = self:getChild("popPanel")
	self.m_checkBtn = self:getChild("checkBtn")
	self.m_cancelBtn = self:getChild("cancelBtn")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_costComp = self:getChild("costComp")
	self.m_txtFreeCost = self:getChild("txtFreeCost")
	self.m_costBackComp = self:getChild("costBackComp")
	self.m_lastTimes = self:getChild("lastTimes")
end

var_0_0.IsFreeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
