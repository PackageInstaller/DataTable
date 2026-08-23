local var_0_0 = {}

var_0_0.URL = "ui://6r1mv52wsxjl5x"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_showTypeController = self:getController("showType")
	self.m_canGetAwardController = self:getController("canGetAward")
	self.m_isSignController = self:getController("isSign")
	self.m_isRemindController = self:getController("isRemind")
	self.m_monthBgCardBg = self:getChild("monthBgCardBg")
	self.m_monthBgCard = self:getChild("monthBgCard")
	self.m_discountNumTxt = self:getChild("discountNumTxt")
	self.m_discountTxt = self:getChild("discountTxt")
	self.m_remainTimeTxt = self:getChild("remainTimeTxt")
	self.m_signedLoader = self:getChild("signedLoader")
	self.m_priceText = self:getChild("priceText")
	self.m_onceGetIcon = self:getChild("onceGetIcon")
	self.m_onceGetNumTxt = self:getChild("onceGetNumTxt")
	self.m_allGetIcon1 = self:getChild("allGetIcon1")
	self.m_allGetNumTxt1 = self:getChild("allGetNumTxt1")
	self.m_allGetIcon2 = self:getChild("allGetIcon2")
	self.m_allGetNumTxt2 = self:getChild("allGetNumTxt2")
	self.m_allGetIcon3 = self:getChild("allGetIcon3")
	self.m_allGetNumTxt3 = self:getChild("allGetNumTxt3")
	self.m_awardComp1 = self:getChild("awardComp1")
	self.m_awardComp2 = self:getChild("awardComp2")
	self.m_awardComp3 = self:getChild("awardComp3")
	self.m_line = self:getChild("line")
	self.m_awardComp4 = self:getChild("awardComp4")
	self.m_getAwardArea = self:getChild("getAwardArea")
	self.m_effLoop = self:getChild("effLoop")
	self.m_loopTransition = self:getTransition("loop")
end

var_0_0.TypeCtrl = {
	高级 = 1,
	基础 = 0
}
var_0_0.ShowTypeCtrl = {
	商店 = 0,
	确认弹窗 = 1
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
