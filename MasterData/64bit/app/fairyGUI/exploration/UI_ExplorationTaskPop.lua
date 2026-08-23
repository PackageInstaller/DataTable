local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25md7za8"

function var_0_0:__ctor()
	self.m_isFinishController = self:getController("isFinish")
	self.m_taskDesText = self:getChild("taskDesText")
	self.m_curText = self:getChild("curText")
	self.m_goalText = self:getChild("goalText")
	self.m_awardList = self:getChild("awardList")
	self.m_getBtn = self:getChild("getBtn")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_title = self:getChild("title")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_content = self:getChild("content")
end

var_0_0.IsFinishCtrl = {
	normal = 0,
	finish = 1
}

return var_0_0
