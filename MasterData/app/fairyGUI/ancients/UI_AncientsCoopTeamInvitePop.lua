local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2be3m13"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_is_emptyController = self:getController("is_empty")
	self.m_is_finalController = self:getController("is_final")
	self.m_ComPopPanel = self:getChild("ComPopPanel")
	self.m_List_team = self:getChild("List_team")
	self.m_Comp_empty = self:getChild("Comp_empty")
	self.m_Btn_search = self:getChild("Btn_search")
	self.m_Label_seek = self:getChild("Label_seek")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.Is_emptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_finalCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
