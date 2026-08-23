local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs29qak26"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_is_myController = self:getController("is_my")
	self.m_hasBgController = self:getController("hasBg")
	self.m_Txt_maxPoint = self:getChild("Txt_maxPoint")
	self.m_Txt_playerName = self:getChild("Txt_playerName")
	self.m_Txt_goodsName = self:getChild("Txt_goodsName")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_myCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasBgCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
