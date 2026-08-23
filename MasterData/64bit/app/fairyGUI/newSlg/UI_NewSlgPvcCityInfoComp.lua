local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9z25j3j"

function var_0_0:__ctor()
	self.m_is_captureController = self:getController("is_capture")
	self.m_is_infController = self:getController("is_inf")
	self.m_isCanAttackController = self:getController("isCanAttack")
	self.m_Comp_bannerInfo = self:getChild("Comp_bannerInfo")
	self.m_Btn_share = self:getChild("Btn_share")
	self.m_Txt_cityName = self:getChild("Txt_cityName")
	self.m_Txt_pos = self:getChild("Txt_pos")
	self.m_Comp_prog = self:getChild("Comp_prog")
	self.m_Txt_prog = self:getChild("Txt_prog")
	self.m_Txt_cityDesc = self:getChild("Txt_cityDesc")
	self.m_Comp_troop = self:getChild("Comp_troop")
	self.m_Txt_troopNum = self:getChild("Txt_troopNum")
	self.m_Btn_checkDefenderInfo = self:getChild("Btn_checkDefenderInfo")
	self.m_Btn_gather = self:getChild("Btn_gather")
	self.m_Btn_award = self:getChild("Btn_award")
	self.m_Btn_rank = self:getChild("Btn_rank")
	self.m_lvTxt = self:getChild("lvTxt")
	self.m_decayTxt = self:getChild("decayTxt")
	self.m_loaderBtn = self:getChild("loaderBtn")
	self.m_tipsComp = self:getChild("tipsComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.Is_captureCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_infCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsCanAttackCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
