local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9jt0v6e"

function var_0_0:__ctor()
	self.m_rankController = self:getController("rank")
	self.m_Comp_rank = self:getChild("Comp_rank")
	self.m_Icon_rank = self:getChild("Icon_rank")
	self.m_Txt_Unionname = self:getChild("Txt_Unionname")
	self.m_Txt_cityName = self:getChild("Txt_cityName")
	self.m_Txt_score = self:getChild("Txt_score")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_Comp_Eff = self:getChild("Comp_Eff")
end

return var_0_0
