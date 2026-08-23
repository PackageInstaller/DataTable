local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2owst2h"

function var_0_0:__ctor()
	self.m_qualityController = self:getController("quality")
	self.m_show_scriptController = self:getController("show_script")
	self.m_is_rareController = self:getController("is_rare")
	self.m_loader1 = self:getChild("loader1")
	self.m_Img_icon = self:getChild("Img_icon")
	self.m_loader0 = self:getChild("loader0")
	self.m_Icon_rare = self:getChild("Icon_rare")
	self.m_Comp_effect = self:getChild("Comp_effect")
end

var_0_0.QualityCtrl = {
	page0 = 8,
	page12 = 15,
	page11 = 14,
	page10 = 12,
	page9 = 11,
	page8 = 10,
	page7 = 9,
	page6 = 6,
	page5 = 5,
	page4 = 4,
	page3 = 3,
	page2 = 2,
	page1 = 1
}
var_0_0.Show_scriptCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_rareCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
