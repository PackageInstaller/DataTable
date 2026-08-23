local var_0_0 = {}

var_0_0.URL = "ui://6r1mv52wgmjeby"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_canGetAwardController = self:getController("canGetAward")
	self.m_isSignController = self:getController("isSign")
	self.m_isRemindController = self:getController("isRemind")
	self.m_monthCardPicBg = self:getChild("monthCardPicBg")
	self.m_monthCardPic = self:getChild("monthCardPic")
	self.m_remainTimeTxt = self:getChild("remainTimeTxt")
	self.m_privilege1 = self:getChild("privilege1")
	self.m_privilege2 = self:getChild("privilege2")
	self.m_privilegeGroup = self:getChild("privilegeGroup")
	self.m_instantGetIcon = self:getChild("instantGetIcon")
	self.m_signAwardGroup = self:getChild("signAwardGroup")
	self.m_dayGetIcon1 = self:getChild("dayGetIcon1")
	self.m_dayGetIcon2 = self:getChild("dayGetIcon2")
	self.m_dayGetIcon3 = self:getChild("dayGetIcon3")
	self.m_dayAwardGroup = self:getChild("dayAwardGroup")
	self.m_allGetIcon1 = self:getChild("allGetIcon1")
	self.m_allGetIcon2 = self:getChild("allGetIcon2")
	self.m_allGetIcon3 = self:getChild("allGetIcon3")
	self.m_totalAwardGroup = self:getChild("totalAwardGroup")
	self.m_signBtn = self:getChild("signBtn")
	self.m_drawBtn = self:getChild("drawBtn")
	self.m_loopTransition = self:getTransition("loop")
end

var_0_0.TypeCtrl = {
	高级 = 1,
	基础 = 0
}
var_0_0.CanGetAwardCtrl = {
	已领取 = 2,
	不可领取 = 0,
	可领取 = 1
}
var_0_0.IsSignCtrl = {
	签署 = 1,
	未签署 = 0
}
var_0_0.IsRemindCtrl = {
	需要提醒 = 1,
	无需提醒 = 0
}

return var_0_0
