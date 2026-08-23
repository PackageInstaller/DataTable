local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9qdqe82"

function var_0_0:__ctor()
	self.m_statusController = self:getController("status")
	self.m_isLeakController = self:getController("isLeak")
	self.m_Txt_desc = self:getChild("Txt_desc")
	self.m_Txt_exp = self:getChild("Txt_exp")
	self.m_Btn_achieve = self:getChild("Btn_achieve")
	self.m_Btn_goto = self:getChild("Btn_goto")
	self.m_Comp_prog = self:getChild("Comp_prog")
	self.m_Txt_prog = self:getChild("Txt_prog")
end

return var_0_0
