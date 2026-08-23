local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2wlotst15yh"

function var_0_0:__ctor()
	self.m_mask_loader = self:getChild("mask_loader")
	self.m_Effstart_comp = self:getChild("Effstart_comp")
	self.m_start = self:getChild("start")
	self.m_Left_comp = self:getChild("Left_comp")
	self.m_Right_comp = self:getChild("Right_comp")
	self.m_VSEff_comp = self:getChild("VSEff_comp")
	self.m_fight = self:getChild("fight")
	self.m_Effplay_comp = self:getChild("Effplay_comp")
	self.m_Result_comp = self:getChild("Result_comp")
	self.m_winTransition = self:getTransition("win")
	self.m_loseTransition = self:getTransition("lose")
	self.m_pingTransition = self:getTransition("ping")
end

return var_0_0
