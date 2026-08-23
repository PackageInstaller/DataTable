local var_0_0 = {}

var_0_0.URL = "ui://iibfqm99u639kk2pg"

function var_0_0:__ctor()
	self.m_isMainTeamController = self:getController("isMainTeam")
	self.m_isModifyingController = self:getController("isModifying")
	self.m_typeController = self:getController("type")
	self.m_cancelClick = self:getChild("cancelClick")
	self.m_knightIcon1 = self:getChild("knightIcon1")
	self.m_knightIcon2 = self:getChild("knightIcon2")
	self.m_knightIcon3 = self:getChild("knightIcon3")
	self.m_knightIcon4 = self:getChild("knightIcon4")
	self.m_knightIcon5 = self:getChild("knightIcon5")
	self.m_knightIcon6 = self:getChild("knightIcon6")
	self.m_editBtn = self:getChild("editBtn")
	self.m_teamIdTxt = self:getChild("teamIdTxt")
	self.m_teamNameTxt = self:getChild("teamNameTxt")
	self.m_changeNameBtn = self:getChild("changeNameBtn")
	self.m_nameInput = self:getChild("nameInput")
	self.m_label = self:getChild("label")
end

var_0_0.IsMainTeamCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsModifyingCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.TypeCtrl = {
	page0 = 0,
	page2 = 8,
	page1 = 1
}

return var_0_0
