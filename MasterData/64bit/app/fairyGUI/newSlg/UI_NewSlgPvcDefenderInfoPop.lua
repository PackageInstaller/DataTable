local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9z25j3f"

function var_0_0:__ctor()
	self.m_closeGraph = self:getChild("closeGraph")
	self.m_List_info = self:getChild("List_info")
	self.m_Txt_authority = self:getChild("Txt_authority")
	self.m_titleTxt = self:getChild("titleTxt")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
