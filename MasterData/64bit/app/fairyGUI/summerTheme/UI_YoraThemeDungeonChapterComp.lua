local var_0_0 = {}

var_0_0.URL = "ui://99hn3059led9kk3uv"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_isPassController = self:getController("isPass")
	self.m_starController = self:getController("star")
	self.m_stageIdTxt = self:getChild("stageIdTxt")
	self.m_stageNameTxt = self:getChild("stageNameTxt")
	self.m_starComp = self:getChild("starComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_passTransition = self:getTransition("pass")
end

var_0_0.TypeCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsPassCtrl = {
	未通关 = 0,
	通关 = 1
}
var_0_0.StarCtrl = {
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
