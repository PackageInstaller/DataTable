local var_0_0 = {}

var_0_0.URL = "ui://0xhekt5ief2w1f"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isFinalController = self:getController("isFinal")
	self.m_pro = self:getChild("pro")
	self.m_bg = self:getChild("bg")
	self.m_bar = self:getChild("bar")
	self.m_numTxt = self:getChild("numTxt")
	self.m_eff = self:getChild("eff")
	self.m_proText = self:getChild("proText")
end

return var_0_0
