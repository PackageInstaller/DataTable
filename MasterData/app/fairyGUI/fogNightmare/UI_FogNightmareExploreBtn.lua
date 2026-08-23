local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oo7bud7"

function var_0_0:__ctor()
	self.m_colorController = self:getController("color")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_tip = self:getChild("tip")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_effGet = self:getChild("effGet")
end

var_0_0.ColorCtrl = {
	white = 1,
	red = 0
}

return var_0_0
