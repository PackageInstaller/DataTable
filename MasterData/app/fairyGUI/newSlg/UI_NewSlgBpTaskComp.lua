local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9qdqe81"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_List_task = self:getChild("List_task")
	self.m_List_seasonTask = self:getChild("List_seasonTask")
	self.m_Txt_timeTip = self:getChild("Txt_timeTip")
	self.m_ComBtnTab1 = self:getChild("ComBtnTab1")
	self.m_ComBtnTab2 = self:getChild("ComBtnTab2")
end

return var_0_0
