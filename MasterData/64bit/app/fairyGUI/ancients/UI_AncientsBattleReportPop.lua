local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2gvcg3v"

function var_0_0:__ctor()
	self.m_is_emptyController = self:getController("is_empty")
	self.m_popPanel = self:getChild("popPanel")
	self.m_Txt_count = self:getChild("Txt_count")
	self.m_Txt_rate = self:getChild("Txt_rate")
	self.m_Txt_kill = self:getChild("Txt_kill")
	self.m_Txt_score = self:getChild("Txt_score")
	self.m_List_report = self:getChild("List_report")
	self.m_content = self:getChild("content")
end

var_0_0.Is_emptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
