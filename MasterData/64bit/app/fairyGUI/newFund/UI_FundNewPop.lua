local var_0_0 = {}

var_0_0.URL = "ui://gmpp9vw0h36u1g"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_oneKeyController = self:getController("oneKey")
	self.m_isBuyController = self:getController("isBuy")
	self.m_hasDataController = self:getController("hasData")
	self.m_closePnl = self:getChild("closePnl")
	self.m_eff = self:getChild("eff")
	self.m_eff2 = self:getChild("eff2")
	self.m_payBtn = self:getChild("payBtn")
	self.m_taskNameTxt = self:getChild("taskNameTxt")
	self.m_fundList = self:getChild("fundList")
	self.m_discountTxt = self:getChild("discountTxt")
	self.m_curStageTxt = self:getChild("curStageTxt")
	self.m_descTxt = self:getChild("descTxt")
	self.m_oneKeyBtn = self:getChild("oneKeyBtn")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_enter0Transition = self:getTransition("enter0")
	self.m_enter1Transition = self:getTransition("enter1")
	self.m_enter2Transition = self:getTransition("enter2")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
