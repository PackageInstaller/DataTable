local var_0_0 = {}

var_0_0.URL = "ui://foyq921sg2gw15"

function var_0_0:__ctor()
	self.m_isOpenController = self:getController("isOpen")
	self.m_towerName = self:getChild("towerName")
	self.m_towerEnglish = self:getChild("towerEnglish")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_touch = self:getChild("touch")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsOpenCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
