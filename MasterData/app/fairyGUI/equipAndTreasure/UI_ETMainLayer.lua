local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7y7ok0"

function var_0_0:__ctor()
	self.m_showDialogController = self:getController("showDialog")
	self.m_groupController = self:getController("group")
	self.m_fitHeightImg = self:getChild("fitHeightImg")
	self.m_attrPlaceHolder = self:getChild("attrPlaceHolder")
	self.m_equipAttrHolder = self:getChild("equipAttrHolder")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_equipSelectHolder = self:getChild("equipSelectHolder")
	self.m_treasureSelPlaceHolder = self:getChild("treasureSelPlaceHolder")
	self.m_mastBtn = self:getChild("mastBtn")
	self.m_groupComp = self:getChild("groupComp")
	self.m_lineUpComp = self:getChild("lineUpComp")
	self.m_lineUpList = self:getChild("lineUpList")
	self.m_enterTransition = self:getTransition("enter")
	self.m_move_0Transition = self:getTransition("move_0")
	self.m_move_1Transition = self:getTransition("move_1")
end

var_0_0.ShowDialogCtrl = {
	page2 = 2,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}
var_0_0.GroupCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
