local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88otxtprrix"

function var_0_0:__ctor()
	self.m_isCurLevelController = self:getController("isCurLevel")
	self.m_indexText = self:getChild("indexText")
	self.m_descText = self:getChild("descText")
end

var_0_0.IsCurLevelCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
