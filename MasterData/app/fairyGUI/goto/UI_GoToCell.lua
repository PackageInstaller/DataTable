local var_0_0 = {}

var_0_0.URL = "ui://hidrio60v7z06"

function var_0_0:__ctor()
	self.m_openStateController = self:getController("openState")
	self.m_titleTxt = self:getChild("titleTxt")
	self.m_goToBtn = self:getChild("goToBtn")
end

var_0_0.OpenStateCtrl = {
	隐藏 = 3,
	未开启 = 0,
	开启 = 1
}

return var_0_0
