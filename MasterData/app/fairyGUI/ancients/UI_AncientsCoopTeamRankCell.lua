local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2l7jr2h"

function var_0_0:__ctor()
	self.m_is_selfController = self:getController("is_self")
	self.m_haveBgController = self:getController("haveBg")
	self.m_Comp_rank = self:getChild("Comp_rank")
	self.m_Comp_pet = self:getChild("Comp_pet")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_Txt_num = self:getChild("Txt_num")
	self.m_Txt_level = self:getChild("Txt_level")
	self.m_Txt_point = self:getChild("Txt_point")
	self.m_Txt_fight = self:getChild("Txt_fight")
end

var_0_0.Is_selfCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HaveBgCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
