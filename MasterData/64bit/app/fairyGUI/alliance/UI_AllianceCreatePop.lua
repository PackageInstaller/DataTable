local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lctba7q"

function var_0_0:__ctor()
	self.m_isLevelEnoughController = self:getController("isLevelEnough")
	self.m_popPanel = self:getChild("popPanel")
	self.m_fragList = self:getChild("fragList")
	self.m_resComp = self:getChild("resComp")
	self.m_inputText = self:getChild("inputText")
	self.m_noCheck = self:getChild("noCheck")
	self.m_needCheck = self:getChild("needCheck")
	self.m_chooseLevelComp = self:getChild("chooseLevelComp")
	self.m_createBtn = self:getChild("createBtn")
	self.m_levelCond = self:getChild("levelCond")
	self.m_content = self:getChild("content")
end

var_0_0.IsLevelEnoughCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
