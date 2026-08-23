local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2pci754"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_Loader_pet = self:getChild("Loader_pet")
	self.m_Txt_fight_value = self:getChild("Txt_fight_value")
end

var_0_0.StateCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page3 = 3
}

return var_0_0
