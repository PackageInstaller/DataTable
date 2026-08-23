local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7rqrub3"

function var_0_0:__ctor()
	self.m_selectController = self:getController("select")
	self.m_showLikeFlagController = self:getController("showLikeFlag")
	self.m_showMaskController = self:getController("showMask")
	self.m_baseIcon = self:getChild("baseIcon")
	self.m_useNumText = self:getChild("useNumText")
	self.m_subBtn = self:getChild("subBtn")
end

var_0_0.SelectCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowLikeFlagCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowMaskCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
