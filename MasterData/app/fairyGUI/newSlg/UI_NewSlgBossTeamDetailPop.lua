local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9f8iz89"

function var_0_0:__ctor()
	self.m_closeGraph = self:getChild("closeGraph")
	self.m_Comp_bossView = self:getChild("Comp_bossView")
	self.m_Txt_countDown = self:getChild("Txt_countDown")
	self.m_Txt_num = self:getChild("Txt_num")
	self.m_List_player = self:getChild("List_player")
	self.m_Comp_playerTeamInfo = self:getChild("Comp_playerTeamInfo")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
