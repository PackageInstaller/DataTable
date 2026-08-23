local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2xhbl4d"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_me_maxController = self:getController("me_max")
	self.m_has_myDiceController = self:getController("has_myDice")
	self.m_has_diceController = self:getController("has_dice")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_Txt_goodsName = self:getChild("Txt_goodsName")
	self.m_Comp_icon = self:getChild("Comp_icon")
	self.m_goodsNum = self:getChild("goodsNum")
	self.m_Txt_curPoint = self:getChild("Txt_curPoint")
	self.m_Txt_maxPoint = self:getChild("Txt_maxPoint")
	self.m_Btn_check = self:getChild("Btn_check")
end

var_0_0.StateCtrl = {
	分配中 = 1,
	未分配 = 0
}
var_0_0.Me_maxCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Has_myDiceCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.Has_diceCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
