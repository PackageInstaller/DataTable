local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2hhrq3i"

function var_0_0:__ctor()
	self.m_level_showController = self:getController("level_show")
	self.m_qualityController = self:getController("quality")
	self.m_name_showController = self:getController("name_show")
	self.m_star_showController = self:getController("star_show")
	self.m_icon_scaleController = self:getController("icon_scale")
	self.m_shuiyinController = self:getController("shuiyin")
	self.m_Comp_base = self:getChild("Comp_base")
	self.m_loader2 = self:getChild("loader2")
	self.m_Txt_level = self:getChild("Txt_level")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_Frame_icon = self:getChild("Frame_icon")
	self.m_Frame_eff = self:getChild("Frame_eff")
	self.m_Txt_shuiyin = self:getChild("Txt_shuiyin")
	self.m_hint_blinkTransition = self:getTransition("hint_blink")
end

var_0_0.Level_showCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.QualityCtrl = {
	page5 = 5,
	page4 = 4,
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page12 = 12,
	page11 = 11,
	page10 = 10,
	page9 = 9,
	page8 = 8,
	page7 = 7,
	page6 = 6
}
var_0_0.Name_showCtrl = {
	page0 = 1,
	page1 = 2
}
var_0_0.Star_showCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Icon_scaleCtrl = {
	page3 = 2,
	page1 = 1,
	page0 = 0,
	page2 = 4
}
var_0_0.ShuiyinCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
