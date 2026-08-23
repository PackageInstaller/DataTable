local var_0_0 = {}

var_0_0.URL = "ui://foyq921stx7p8w"

function var_0_0:__ctor()
	self.m_isOpenController = self:getController("isOpen")
	self.m_difficultyController = self:getController("difficulty")
	self.m_hard = self:getChild("hard")
	self.m_hardKazari = self:getChild("hardKazari")
	self.m_effTitle = self:getChild("effTitle")
	self.m_effectNode = self:getChild("effectNode")
	self.m_towerName = self:getChild("towerName")
	self.m_towerEnglish = self:getChild("towerEnglish")
	self.m_touch = self:getChild("touch")
	self.m_progressText = self:getChild("progressText")
	self.m_towerOrder = self:getChild("towerOrder")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsOpenCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.DifficultyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
