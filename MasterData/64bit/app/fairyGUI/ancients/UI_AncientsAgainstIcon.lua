local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2gdro63"

function var_0_0:__ctor()
	self.m_shuiyinController = self:getController("shuiyin")
	self.m_is_likeController = self:getController("is_like")
	self.m_is_kingController = self:getController("is_king")
	self.m_is_grayController = self:getController("is_gray")
	self.m_is_emptyController = self:getController("is_empty")
	self.m_Btn_like = self:getChild("Btn_like")
	self.m_headCutComp = self:getChild("headCutComp")
	self.m_Txt_name_king = self:getChild("Txt_name_king")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_Txt_fight = self:getChild("Txt_fight")
	self.m_effDi = self:getChild("effDi")
	self.m_effKing = self:getChild("effKing")
end

var_0_0.ShuiyinCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_likeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_kingCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_grayCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_emptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
