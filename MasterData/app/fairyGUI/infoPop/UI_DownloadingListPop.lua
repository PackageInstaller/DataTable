local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bn7t9d1v5dss8"

function var_0_0:__ctor()
	self.m_isGetAllRwdController = self:getController("isGetAllRwd")
	self.m_finishAwardsList = self:getChild("finishAwardsList")
	self.m_downloadList = self:getChild("downloadList")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsGetAllRwdCtrl = {
	get = 1,
	normal = 0
}

return var_0_0
