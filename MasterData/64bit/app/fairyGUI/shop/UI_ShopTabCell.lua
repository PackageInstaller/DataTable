local var_0_0 = {}

var_0_0.URL = "ui://454a48jpfxqyp"

function var_0_0:__ctor()
	self.m_hasSubController = self:getController("hasSub")
	self.m_isSeasonController = self:getController("isSeason")
	self.m_seasonStatusController = self:getController("seasonStatus")
	self.m_styleController = self:getController("style")
	self.m_bg = self:getChild("bg")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_subBg = self:getChild("subBg")
	self.m_subList = self:getChild("subList")
	self.m_t0Transition = self:getTransition("t0")
end

var_0_0.HasSubCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsSeasonCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.SeasonStatusCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.StyleCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
