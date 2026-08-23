local var_0_0 = {}

var_0_0.URL = "ui://9n9qtghbnxn68o"

function var_0_0:__ctor()
	self.m_isShowHpBarController = self:getController("isShowHpBar")
	self.m_bossImgComp = self:getChild("bossImgComp")
	self.m_sealLoader = self:getChild("sealLoader")
	self.m_sealLevelText = self:getChild("sealLevelText")
	self.m_hpBar = self:getChild("hpBar")
	self.m_hpText = self:getChild("hpText")
	self.m_finalBossNameText = self:getChild("finalBossNameText")
end

return var_0_0
