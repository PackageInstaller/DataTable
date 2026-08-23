local var_0_0 = {}

var_0_0.URL = "ui://0vs2yqm8ipc91"

function var_0_0:__ctor()
	self.m_bgGLoader = self:getChild("bgGLoader")
	self.m_knightBtn1 = self:getChild("knightBtn1")
	self.m_effectNode = self:getChild("effectNode")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_selTargetBtn = self:getChild("selTargetBtn")
	self.m_recruitOneBtn = self:getChild("recruitOneBtn")
	self.m_recruitTenBtn = self:getChild("recruitTenBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
