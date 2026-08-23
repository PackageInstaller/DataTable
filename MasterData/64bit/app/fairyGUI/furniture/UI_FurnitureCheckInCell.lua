local var_0_0 = {}

var_0_0.URL = "ui://irs65rts10brm3l"

function var_0_0:__ctor()
	self.m_bathCrockStateController = self:getController("bathCrockState")
	self.m_unlockedController = self:getController("unlocked")
	self.m_maxNumTxt = self:getChild("maxNumTxt")
	self.m_floorTxt = self:getChild("floorTxt")
	self.m_stayCountTxt = self:getChild("stayCountTxt")
	self.m_knightList = self:getChild("knightList")
	self.m_allDischargeBtn = self:getChild("allDischargeBtn")
	self.m_bathCrockStateBtn = self:getChild("bathCrockStateBtn")
	self.m_cdBar = self:getChild("cdBar")
	self.m_lockTipTxt = self:getChild("lockTipTxt")
end

return var_0_0
