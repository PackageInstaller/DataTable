local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o3jb9693v"

function var_0_0:__ctor()
	self.m_closeGraph = self:getChild("closeGraph")
	self.m_cityName = self:getChild("cityName")
	self.m_List_alliance = self:getChild("List_alliance")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
