local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9ewxk4f"

function var_0_0:__ctor()
	self.m_maxController = self:getController("max")
	self.m_show_bgController = self:getController("show_bg")
	self.m_is_darkController = self:getController("is_dark")
	self.m_Txt_name = self:getChild("Txt_name")
	self.m_Txt_cur = self:getChild("Txt_cur")
	self.m_Txt_next = self:getChild("Txt_next")
end

return var_0_0
