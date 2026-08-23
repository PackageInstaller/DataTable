local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lehcvid"

function var_0_0:__ctor()
	self.m_isTempController = self:getController("isTemp")
	self.m_enTitle = self:getChild("enTitle")
end

var_0_0.IsTempCtrl = {
	temp = 1,
	normal = 0
}

return var_0_0
