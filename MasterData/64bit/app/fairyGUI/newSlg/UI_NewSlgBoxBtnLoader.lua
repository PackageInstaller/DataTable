local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9tvpg68dx"

function var_0_0:__ctor()
	self.m_txt_showController = self:getController("txt_show")
	self.m_shadowController = self:getController("shadow")
end

var_0_0.Txt_showCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShadowCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
