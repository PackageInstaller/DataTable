local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2l7jr2i"

function var_0_0:__ctor()
	self.m_is_selfController = self:getController("is_self")
	self.m_haveBgController = self:getController("haveBg")
	self.m_awardTypeController = self:getController("awardType")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_List_award = self:getChild("List_award")
	self.m_rankingAliasComp = self:getChild("rankingAliasComp")
end

var_0_0.Is_selfCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HaveBgCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.AwardTypeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
