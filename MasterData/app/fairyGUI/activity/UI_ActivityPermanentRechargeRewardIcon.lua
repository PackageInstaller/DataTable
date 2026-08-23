local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wo238a7"

function var_0_0:__ctor()
	self.m_hasDrawController = self:getController("hasDraw")
	self.m_icon = self:getChild("icon")
end

var_0_0.HasDrawCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
