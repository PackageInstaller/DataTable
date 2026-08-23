local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2uvdvf"

function var_0_0:__ctor()
	self.m_showDetailController = self:getController("showDetail")
	self.m_isLeaderController = self:getController("isLeader")
	self.m_Txt_team_score = self:getChild("Txt_team_score")
	self.m_Btn_showDetail = self:getChild("Btn_showDetail")
	self.m_Btn_setting = self:getChild("Btn_setting")
	self.m_userScoreList = self:getChild("userScoreList")
end

var_0_0.ShowDetailCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsLeaderCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
