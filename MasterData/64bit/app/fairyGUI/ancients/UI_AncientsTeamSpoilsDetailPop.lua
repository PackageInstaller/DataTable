local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2xhbl4i"

function var_0_0:__ctor()
	self.m_has_myDiceController = self:getController("has_myDice")
	self.m_is_emptyController = self:getController("is_empty")
	self.m_diceAnimController = self:getController("diceAnim")
	self.m_Comp_icon = self:getChild("Comp_icon")
	self.m_Comp_cost = self:getChild("Comp_cost")
	self.m_Btn_alloate = self:getChild("Btn_alloate")
	self.m_Txt_curPoint = self:getChild("Txt_curPoint")
	self.m_Btn_giveup = self:getChild("Btn_giveup")
	self.m_List_dices = self:getChild("List_dices")
	self.m_Comp_effect = self:getChild("Comp_effect")
	self.m_diceAnimMask = self:getChild("diceAnimMask")
	self.m_dicePlaceHolder = self:getChild("dicePlaceHolder")
	self.m_dicePlaceHolder2 = self:getChild("dicePlaceHolder2")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.Has_myDiceCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Is_emptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.DiceAnimCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
