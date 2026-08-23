local var_0_0 = {}

var_0_0.URL = "ui://nz3msl46nqhjgibw5"

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
	selected = 2,
	completed = 3,
	["not have"] = 1,
	none = 0
}
var_0_0.TipStatueCtrl = {
	maxStar = 3,
	up = 2,
	limit = 1,
	normal = 0
}
var_0_0.ColorCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
