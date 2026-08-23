local var_0_0 = {}

var_0_0.URL = "ui://gntkqnnjtgg01q"

function var_0_0:__ctor()
	self.m_selectStateController = self:getController("selectState")
	self.m_arrow1 = self:getChild("arrow1")
	self.m_arrow2 = self:getChild("arrow2")
	self.m_enNameTxt = self:getChild("enNameTxt")
end

var_0_0.SelectStateCtrl = {
	未选中 = 0,
	选中 = 1
}

return var_0_0
