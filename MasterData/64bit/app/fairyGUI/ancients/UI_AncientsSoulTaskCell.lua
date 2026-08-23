local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2unko3g"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_bg = self:getChild("bg")
	self.m_Txt_desc = self:getChild("Txt_desc")
	self.m_List_award = self:getChild("List_award")
	self.m_Txt_prog = self:getChild("Txt_prog")
	self.m_Btn_get = self:getChild("Btn_get")
	self.m_Btn_go = self:getChild("Btn_go")
	self.m_taskGetEffect = self:getChild("taskGetEffect")
end

var_0_0.StateCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
