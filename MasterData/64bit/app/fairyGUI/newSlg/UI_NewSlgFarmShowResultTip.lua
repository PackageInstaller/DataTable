local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9dzft96984"

function var_0_0:__ctor()
	self.m_tpController = self:getController("tp")
	self.m_isSuccController = self:getController("isSucc")
	self.m_Txt_title = self:getChild("Txt_title")
end

var_0_0.TpCtrl = {
	page0 = 6,
	page2 = 8,
	page1 = 7
}
var_0_0.IsSuccCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
