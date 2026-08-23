local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9kq3l68dc"

function var_0_0:__ctor()
	self.m_move_stateController = self:getController("move_state")
	self.m_closeGraph = self:getChild("closeGraph")
	self.m_Txt_desc = self:getChild("Txt_desc")
	self.m_Btn_cancel = self:getChild("Btn_cancel")
	self.m_Btn_ok = self:getChild("Btn_ok")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.Move_stateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
