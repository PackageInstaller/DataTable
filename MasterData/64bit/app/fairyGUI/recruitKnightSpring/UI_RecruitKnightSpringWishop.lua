local var_0_0 = {}

var_0_0.URL = "ui://16fa1nlapz8f30"

function var_0_0:__ctor()
	self.m_wishState1Controller = self:getController("wishState1")
	self.m_wishState2Controller = self:getController("wishState2")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_percentComp = self:getChild("percentComp")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_memberComp1 = self:getChild("memberComp1")
	self.m_wishList = self:getChild("wishList")
	self.m_tabList = self:getChild("tabList")
	self.m_mask = self:getChild("mask")
	self.m_tipText = self:getChild("tipText")
	self.m_curText = self:getChild("curText")
	self.m_nextText = self:getChild("nextText")
	self.m_timesComp = self:getChild("timesComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
