local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9mitv35"

function var_0_0:__ctor()
	self.m_scaleController = self:getController("scale")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.ScaleCtrl = {
	page3 = 2,
	page2 = 1,
	page1 = 3,
	page0 = 0
}

return var_0_0
