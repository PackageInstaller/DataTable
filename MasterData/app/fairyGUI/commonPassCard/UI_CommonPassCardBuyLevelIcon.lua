local var_0_0 = {}

var_0_0.URL = "ui://1b29hdofhh9b3s"

function var_0_0:__ctor()
	self.m_isShowMaskController = self:getController("isShowMask")
	self.m_baseIcon = self:getChild("baseIcon")
end

var_0_0.IsShowMaskCtrl = {
	是 = 1,
	否 = 0
}

return var_0_0
