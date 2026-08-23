local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9htqg68fd"

function var_0_0:__ctor()
	self.m_miniMapComp = self:getChild("miniMapComp")
	self.m_clickBgLoader = self:getChild("clickBgLoader")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_numTxt = self:getChild("numTxt")
	self.m_tipsBtn = self:getChild("tipsBtn")
	self.m_descTxt = self:getChild("descTxt")
	self.m_mapClickGraph = self:getChild("mapClickGraph")
end

return var_0_0
