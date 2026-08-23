local var_0_0 = {}

var_0_0.URL = "ui://foyq921sxc1b67"

function var_0_0:__ctor()
	self.m_isShowFinishController = self:getController("isShowFinish")
	self.m_popPanel = self:getChild("popPanel")
	self.m_rewardList = self:getChild("rewardList")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_content = self:getChild("content")
end

var_0_0.IsShowFinishCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
