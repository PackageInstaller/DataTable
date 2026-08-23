local var_0_0 = {}

var_0_0.URL = "ui://1hwemy6ugc0k1s"

function var_0_0:__ctor()
	self.m_isLightController = self:getController("isLight")
	self.m_showLoader = self:getChild("showLoader")
end

var_0_0.IsLightCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
