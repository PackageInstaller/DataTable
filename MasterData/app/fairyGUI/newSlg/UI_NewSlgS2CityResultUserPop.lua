local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o3jb9693y"

function var_0_0:__ctor()
	self.m_is_defController = self:getController("is_def")
	self.m_closeGraph = self:getChild("closeGraph")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_List_team = self:getChild("List_team")
	self.m_allianceName = self:getChild("allianceName")
	self.m_teamNum = self:getChild("teamNum")
	self.m_totalScore = self:getChild("totalScore")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.Is_defCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
