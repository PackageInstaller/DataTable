local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9l84a1a"

function var_0_0:__ctor()
	self.m_posController = self:getController("pos")
	self.m_selIndexController = self:getController("selIndex")
	self.m_Comp_info = self:getChild("Comp_info")
	self.m_teamList = self:getChild("teamList")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.PosCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.SelIndexCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}

return var_0_0
