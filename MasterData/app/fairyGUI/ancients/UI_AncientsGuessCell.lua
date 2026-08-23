local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2gwxe5n"

function var_0_0:__ctor()
	self.m_bet_resultController = self:getController("bet_result")
	self.m_Comp_left = self:getChild("Comp_left")
	self.m_Comp_right = self:getChild("Comp_right")
end

var_0_0.Bet_resultCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}

return var_0_0
