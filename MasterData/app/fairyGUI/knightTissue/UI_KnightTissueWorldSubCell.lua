local var_0_0 = {}

var_0_0.URL = "ui://gntkqnnjtgg01r"

function var_0_0:__ctor()
	self.m_selectStateController = self:getController("selectState")
	self.m_unlockTransition = self:getTransition("unlock")
end

var_0_0.SelectStateCtrl = {
	未选中 = 1,
	选中 = 0
}

return var_0_0
