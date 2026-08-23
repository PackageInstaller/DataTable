local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o3jb9693w"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_closeGraph = self:getChild("closeGraph")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_List_city = self:getChild("List_city")
	self.m_occupiedScore = self:getChild("occupiedScore")
	self.m_dailyScore = self:getChild("dailyScore")
	self.m_personScore = self:getChild("personScore")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
