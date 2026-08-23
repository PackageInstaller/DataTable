local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nkkxd0mibyi"

function var_0_0:__ctor()
	self.m_noTimesController = self:getController("noTimes")
	self.m_otherKnightList = self:getChild("otherKnightList")
	self.m_mineKnightList = self:getChild("mineKnightList")
	self.m_quitBtn = self:getChild("quitBtn")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_giveUpTimeTxt = self:getChild("giveUpTimeTxt")
end

return var_0_0
