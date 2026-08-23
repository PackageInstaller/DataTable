local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8ltoz97i"

function var_0_0:__ctor()
	self.m_showGuildListController = self:getController("showGuildList")
	self.m_eff = self:getChild("eff")
	self.m_inputText = self:getChild("inputText")
	self.m_chooseNumComp = self:getChild("chooseNumComp")
	self.m_changeSettingBtn = self:getChild("changeSettingBtn")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_tipText = self:getChild("tipText")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.ShowGuildListCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
