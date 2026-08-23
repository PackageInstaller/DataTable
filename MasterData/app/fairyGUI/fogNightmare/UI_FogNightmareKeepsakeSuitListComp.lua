local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oddqk9rrs9"

function var_0_0:__ctor()
	self.m_hideIconController = self:getController("hideIcon")
	self.m_loaderBtn = self:getChild("loaderBtn")
	self.m_list = self:getChild("list")
end

var_0_0.HideIconCtrl = {
	hide = 1,
	show = 0
}

return var_0_0
