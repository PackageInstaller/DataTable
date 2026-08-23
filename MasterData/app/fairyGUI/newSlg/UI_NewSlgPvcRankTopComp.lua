local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9jt0v6c"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_Comp_rank = self:getChild("Comp_rank")
	self.m_Txt_commandValue = self:getChild("Txt_commandValue")
	self.m_Txt_score = self:getChild("Txt_score")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_user = self:getChild("user")
	self.m_Txt_Unionname = self:getChild("Txt_Unionname")
	self.m_Txt_cityName = self:getChild("Txt_cityName")
	self.m_Txt_AlliScore = self:getChild("Txt_AlliScore")
	self.m_Txt_leaderName = self:getChild("Txt_leaderName")
	self.m_alli = self:getChild("alli")
	self.m_Comp_Eff = self:getChild("Comp_Eff")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page2 = 5,
	page1 = 1
}

return var_0_0
