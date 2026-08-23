local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2unko35"

function var_0_0:__ctor()
	self.m_lockController = self:getController("lock")
	self.m_ComRedPoint = self:getChild("ComRedPoint")
end

var_0_0.LockCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
