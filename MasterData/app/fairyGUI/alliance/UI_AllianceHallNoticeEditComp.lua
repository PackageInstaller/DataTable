local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcrv0q2"

function var_0_0:__ctor()
	self.m_noticeTypeController = self:getController("noticeType")
	self.m_noticeInput = self:getChild("noticeInput")
	self.m_textNum = self:getChild("textNum")
end

var_0_0.NoticeTypeCtrl = {
	declare = 0,
	announce = 1
}

return var_0_0
