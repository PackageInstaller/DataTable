local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8ltoz97p"

function var_0_0:__ctor()
	self.m_tabTypeController = self:getController("tabType")
	self.m_emptyTypeController = self:getController("emptyType")
	self.m_popPanel = self:getChild("popPanel")
	self.m_oneKeyInviteBtn = self:getChild("oneKeyInviteBtn")
	self.m_oneKeyCallBtn = self:getChild("oneKeyCallBtn")
	self.m_memberList = self:getChild("memberList")
	self.m_content = self:getChild("content")
end

var_0_0.TabTypeCtrl = {
	好友 = 0,
	公会 = 1
}
var_0_0.EmptyTypeCtrl = {
	未加入公会 = 3,
	公会为空 = 2,
	好友为空 = 1,
	不为空 = 0
}

return var_0_0
