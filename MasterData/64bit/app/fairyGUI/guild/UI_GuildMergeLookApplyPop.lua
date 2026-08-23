local var_0_0 = {}

var_0_0.URL = "ui://h35b870bbpqe68"

function var_0_0:__ctor()
	self.m_isConfirmController = self:getController("isConfirm")
	self.m_hasChangeController = self:getController("hasChange")
	self.m_popPanel = self:getChild("popPanel")
	self.m_applyGuildName = self:getChild("applyGuildName")
	self.m_mergeUserNum = self:getChild("mergeUserNum")
	self.m_applyList = self:getChild("applyList")
	self.m_myGuildName = self:getChild("myGuildName")
	self.m_canChangeDesc = self:getChild("canChangeDesc")
	self.m_myUserList = self:getChild("myUserList")
	self.m_applyTip = self:getChild("applyTip")
	self.m_allSelectBtn = self:getChild("allSelectBtn")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_lockTime = self:getChild("lockTime")
	self.m_cancelBtn = self:getChild("cancelBtn")
	self.m_content = self:getChild("content")
end

return var_0_0
