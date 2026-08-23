local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88ousg1rrhz"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_effPopTitle = self:getChild("effPopTitle")
	self.m_title = self:getChild("title")
	self.m_effPopbg = self:getChild("effPopbg")
	self.m_hurtList = self:getChild("hurtList")
	self.m_autoNode = self:getChild("autoNode")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.StateCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.IsEmptyCtrl = {
	empty = 1,
	normal = 0
}

return var_0_0
