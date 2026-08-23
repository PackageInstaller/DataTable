local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9kpj468gc"

function var_0_0:__ctor()
	self.m_colorController = self:getController("color")
	self.m_fontSizeController = self:getController("fontSize")
	self.m_Txt_num = self:getChild("Txt_num")
end

var_0_0.ColorCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.FontSizeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
