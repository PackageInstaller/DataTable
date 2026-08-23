local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2gvvf6k"

function var_0_0:__ctor()
	self.m_is_leaderController = self:getController("is_leader")
	self.m_Comp_icon = self:getChild("Comp_icon")
	self.m_Comp_name = self:getChild("Comp_name")
end

var_0_0.Is_leaderCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
