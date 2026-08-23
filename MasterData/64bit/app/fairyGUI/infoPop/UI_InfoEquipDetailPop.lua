local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnp0x6gibxc"

function var_0_0:__ctor()
	self.m_tabTypeController = self:getController("tabType")
	self.m_infoPopBase = self:getChild("infoPopBase")
end

var_0_0.TabTypeCtrl = {
	信息 = 0,
	套装 = 1
}

return var_0_0
