local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9gr5v68ck"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_Btn_icon = self:getChild("Btn_icon")
	self.m_Comp_type = self:getChild("Comp_type")
	self.m_effFight = self:getChild("effFight")
	self.m_effMarc = self:getChild("effMarc")
	self.m_Txt_cd = self:getChild("Txt_cd")
	self.m_Group_cd = self:getChild("Group_cd")
end

var_0_0.TypeCtrl = {
	page2 = 2,
	page1 = 1,
	page4 = 5,
	page0 = 0,
	page3 = 3
}

return var_0_0
