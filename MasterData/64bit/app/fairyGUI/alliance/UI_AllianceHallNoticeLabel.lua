local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcmq562f"

function var_0_0:__ctor()
	self.m_canEditController = self:getController("canEdit")
	self.m_editBtn = self:getChild("editBtn")
end

var_0_0.CanEditCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
