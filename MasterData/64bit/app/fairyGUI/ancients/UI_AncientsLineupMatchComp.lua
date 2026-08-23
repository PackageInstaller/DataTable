local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2uvdvh"

function var_0_0:__ctor()
	self.m_is_matchingController = self:getController("is_matching")
	self.m_Comp_pet_equip = self:getChild("Comp_pet_equip")
	self.m_Txt_pet_level = self:getChild("Txt_pet_level")
	self.m_Txt_score = self:getChild("Txt_score")
	self.m_Txt_match_desc = self:getChild("Txt_match_desc")
	self.m_Txt_score_desc = self:getChild("Txt_score_desc")
	self.m_Btn_match = self:getChild("Btn_match")
	self.m_Txt_cd = self:getChild("Txt_cd")
	self.m_Txt_cd2 = self:getChild("Txt_cd2")
	self.m_daoshuTransition = self:getTransition("daoshu")
end

var_0_0.Is_matchingCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
