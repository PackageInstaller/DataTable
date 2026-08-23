local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bn8quorc1"

function var_0_0:__ctor()
	self.m_monsterComp = self:getChild("monsterComp")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_descTxt = self:getChild("descTxt")
	self.m_cancelBtn = self:getChild("cancelBtn")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_checkBtn = self:getChild("checkBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
