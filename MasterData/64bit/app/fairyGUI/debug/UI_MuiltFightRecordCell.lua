local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7yjh3a5ibj8"

function var_0_0:__ctor()
	self.m_mark_typeController = self:getController("mark_type")
	self.m_nameText = self:getChild("nameText")
	self.m_typeText = self:getChild("typeText")
	self.m_saveBtn = self:getChild("saveBtn")
	self.m_renameBtn = self:getChild("renameBtn")
	self.m_replaceBtn = self:getChild("replaceBtn")
	self.m_mark1Btn = self:getChild("mark1Btn")
	self.m_mark2Btn = self:getChild("mark2Btn")
	self.m_delBtn = self:getChild("delBtn")
	self.m_upBtn = self:getChild("upBtn")
	self.m_downBtn = self:getChild("downBtn")
end

var_0_0.Mark_typeCtrl = {
	基础 = 1,
	无 = 0,
	迭代 = 2
}

return var_0_0
