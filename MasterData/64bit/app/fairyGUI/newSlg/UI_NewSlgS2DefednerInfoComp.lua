local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9kual9697s"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_teamList = self:getChild("teamList")
	self.m_Txt_authority = self:getChild("Txt_authority")
	self.m_defTxt = self:getChild("defTxt")
	self.m_defList = self:getChild("defList")
end

return var_0_0
