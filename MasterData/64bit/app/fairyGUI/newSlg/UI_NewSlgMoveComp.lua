local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9r36z10"

function var_0_0:__ctor()
	self.m_c1Controller = self:getController("c1")
	self.m_Comp_bannerInfo = self:getChild("Comp_bannerInfo")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_Txt_pos = self:getChild("Txt_pos")
	self.m_Txt_tip = self:getChild("Txt_tip")
	self.m_Txt_cd = self:getChild("Txt_cd")
	self.m_Btn_move = self:getChild("Btn_move")
	self.m_freeBtn = self:getChild("freeBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.C1Ctrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page3 = 3
}

return var_0_0
