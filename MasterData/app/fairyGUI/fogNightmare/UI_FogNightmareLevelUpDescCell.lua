local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88okw9d9rrpy"

function var_0_0:__ctor()
	self.m_colorController = self:getController("color")
	self.m_indexText = self:getChild("indexText")
	self.m_descText = self:getChild("descText")
	self.m_numText = self:getChild("numText")
end

var_0_0.ColorCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
