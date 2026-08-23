local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7yjd9r5ibhn"

function var_0_0:__ctor()
	self.m_editController = self:getController("edit")
	self.m_Txt_edit_value = self:getChild("Txt_edit_value")
	self.m_Txt_value = self:getChild("Txt_value")
end

var_0_0.EditCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
