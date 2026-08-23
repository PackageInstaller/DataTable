local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9m04t8ah"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_Txt_desc = self:getChild("Txt_desc")
	self.m_List_normalBuy = self:getChild("List_normalBuy")
	self.m_List_specialBuy = self:getChild("List_specialBuy")
	self.m_Btn_normalBuy = self:getChild("Btn_normalBuy")
	self.m_Btn_specialBuy = self:getChild("Btn_specialBuy")
	self.m_Txt_giftDesc = self:getChild("Txt_giftDesc")
	self.m_Btn_close = self:getChild("Btn_close")
	self.m_Comp_Eff = self:getChild("Comp_Eff")
	self.m_Comp_Eff2 = self:getChild("Comp_Eff2")
	self.m_Comp_gift = self:getChild("Comp_gift")
	self.m_Txt_giftName = self:getChild("Txt_giftName")
end

return var_0_0
