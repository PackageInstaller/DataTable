local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2gvcg3w"

function var_0_0:__ctor()
	self.m_isWinController = self:getController("isWin")
	self.m_Txt_date = self:getChild("Txt_date")
	self.m_Comp_pet_Equip = self:getChild("Comp_pet_Equip")
	self.m_Comp_name = self:getChild("Comp_name")
	self.m_Txt_score = self:getChild("Txt_score")
	self.m_Txt_add = self:getChild("Txt_add")
	self.m_Btn_detail = self:getChild("Btn_detail")
end

var_0_0.IsWinCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
