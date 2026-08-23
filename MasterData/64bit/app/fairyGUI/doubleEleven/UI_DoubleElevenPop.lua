local var_0_0 = {}

var_0_0.URL = "ui://vtqfjjaif2do0"

function var_0_0:__ctor()
	self.m_displayTypeController = self:getController("displayType")
	self.m_enterEffect = self:getChild("enterEffect")
	self.m_enterNYEffect = self:getChild("enterNYEffect")
	self.m_goodsList = self:getChild("goodsList")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_idleEffect = self:getChild("idleEffect")
	self.m_idleNYEffect = self:getChild("idleNYEffect")
	self.m_enterTransition = self:getTransition("enter")
	self.m_enter6Transition = self:getTransition("enter6")
end

var_0_0.DisplayTypeCtrl = {
	page24 = 26,
	page23 = 25,
	page22 = 24,
	page21 = 23,
	page20 = 22,
	page19 = 21,
	page18 = 20,
	page17 = 19,
	page16 = 18,
	page15 = 17,
	page14 = 16,
	page13 = 15,
	page12 = 14,
	page11 = 13,
	page10 = 12,
	page9 = 11,
	page8 = 10,
	page7 = 9,
	page6 = 8,
	page5 = 7,
	page4 = 4,
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page26 = 28,
	page25 = 27
}

return var_0_0
