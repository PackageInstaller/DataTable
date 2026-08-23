local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2gvvf6i"

function var_0_0:__ctor()
	self.m_is_finishController = self:getController("is_finish")
	self.m_Comp_label = self:getChild("Comp_label")
	self.m_List_award = self:getChild("List_award")
	self.m_IconComp = self:getChild("IconComp")
	self.m_playerNameTxt = self:getChild("playerNameTxt")
	self.m_fightValueTxt = self:getChild("fightValueTxt")
end

var_0_0.Is_finishCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
