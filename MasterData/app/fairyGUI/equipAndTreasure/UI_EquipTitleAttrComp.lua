local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7rkfr9o"

function var_0_0:__ctor()
	self.m_isDevlopController = self:getController("isDevlop")
	self.m_infoBtnController = self:getController("infoBtn")
	self.m_list = self:getChild("list")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsDevlopCtrl = {
	已养成 = 1,
	未养成 = 0
}
var_0_0.InfoBtnCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
