local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2kr031k"

function var_0_0:__ctor()
	self.m_has_rankController = self:getController("has_rank")
	self.m_img0 = self:getChild("img0")
	self.m_Comp_icon = self:getChild("Comp_icon")
	self.m_Btn_refuse = self:getChild("Btn_refuse")
	self.m_Btn_join = self:getChild("Btn_join")
	self.m_Txt_rank = self:getChild("Txt_rank")
	self.m_Txt_level = self:getChild("Txt_level")
	self.m_Comp_name = self:getChild("Comp_name")
	self.m_Txt_fight_value = self:getChild("Txt_fight_value")
	self.m_Txt_score = self:getChild("Txt_score")
end

var_0_0.Has_rankCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
