local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oh6589rrq3"

function var_0_0:__ctor()
	self.m_showSplitLineController = self:getController("showSplitLine")
	self.m_content = self:getChild("content")
end

var_0_0.ShowSplitLineCtrl = {
	hide = 0,
	show = 1
}

return var_0_0
