local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcrv0q6"

function var_0_0:__ctor()
	self.m_noticeTypeController = self:getController("noticeType")
	self.m_popPanel = self:getChild("popPanel")
	self.m_editComp = self:getChild("editComp")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_content = self:getChild("content")
end

var_0_0.NoticeTypeCtrl = {
	declare = 0,
	announce = 1
}

return var_0_0
