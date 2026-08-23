local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2shgl6e"

function var_0_0:__ctor()
	self.m_is_winController = self:getController("is_win")
	self.m_showBgController = self:getController("showBg")
	self.m_Txt_index = self:getChild("Txt_index")
	self.m_Txt_atk_name = self:getChild("Txt_atk_name")
	self.m_Txt_def_name = self:getChild("Txt_def_name")
	self.m_Btn_video = self:getChild("Btn_video")
end

var_0_0.Is_winCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowBgCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
