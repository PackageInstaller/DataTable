local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9qhbr8o"

function var_0_0:__ctor()
	self.m_relaCtrlController = self:getController("relaCtrl")
	self.m_blackCtrlController = self:getController("blackCtrl")
	self.m_other_serverController = self:getController("other_server")
	self.m_has_allianceController = self:getController("has_alliance")
	self.m_knightPH = self:getChild("knightPH")
	self.m_pos = self:getChild("pos")
	self.m_Btn_add = self:getChild("Btn_add")
	self.m_Btn_chat = self:getChild("Btn_chat")
	self.m_Btn_defriend = self:getChild("Btn_defriend")
	self.m_Label_name = self:getChild("Label_name")
	self.m_Label_army = self:getChild("Label_army")
	self.m_Label_server = self:getChild("Label_server")
	self.m_Label_clan = self:getChild("Label_clan")
	self.m_Comp_desc = self:getChild("Comp_desc")
	self.m_List_team = self:getChild("List_team")
end

return var_0_0
