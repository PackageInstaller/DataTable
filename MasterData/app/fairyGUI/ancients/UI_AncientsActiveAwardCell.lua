local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2unko3c"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_Comp_icon = self:getChild("Comp_icon")
	self.m_Txt_score = self:getChild("Txt_score")
	self.m_Comp_touch = self:getChild("Comp_touch")
	self.m_Comp_effect = self:getChild("Comp_effect")
	self.m_iconEffect = self:getChild("iconEffect")
	self.m_dotEffect = self:getChild("dotEffect")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
