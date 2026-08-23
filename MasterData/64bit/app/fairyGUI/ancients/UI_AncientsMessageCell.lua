local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2r02u2h"

function var_0_0:__ctor()
	self.m_is_captainController = self:getController("is_captain")
	self.m_Comp_name = self:getChild("Comp_name")
	self.m_Txt_time = self:getChild("Txt_time")
	self.m_Txt_Message = self:getChild("Txt_Message")
end

var_0_0.Is_captainCtrl = {
	是队长 = 1,
	不是队长 = 0
}

return var_0_0
