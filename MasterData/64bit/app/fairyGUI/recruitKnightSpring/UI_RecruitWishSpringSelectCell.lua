local var_0_0 = {}

var_0_0.URL = "ui://16fa1nlao4an65"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_tipStatueController = self:getController("tipStatue")
	self.m_colorController = self:getController("color")
	self.m_item = self:getChild("item")
	self.m_starBg = self:getChild("starBg")
	self.m_tipText = self:getChild("tipText")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.StateCtrl = {
	completed = 2,
	selected = 1,
	["not have"] = 3,
	none = 0
}
var_0_0.TipStatueCtrl = {
	up = 2,
	limit = 1,
	normal = 0,
	maxStar = 3
}
var_0_0.ColorCtrl = {
	page1 = 0,
	page0 = 1
}

return var_0_0
