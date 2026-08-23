local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2k615go"

function var_0_0:__ctor()
	self.m_isNewController = self:getController("isNew")
	self.m_damageHolder = self:getChild("damageHolder")
	self.m_newEffect = self:getChild("newEffect")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
	self.m_numChangeTransition = self:getTransition("numChange")
end

var_0_0.IsNewCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
