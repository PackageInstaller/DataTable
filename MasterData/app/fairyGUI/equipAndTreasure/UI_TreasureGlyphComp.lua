local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7osjs1u"

function var_0_0:__ctor()
	self.m_isFullController = self:getController("isFull")
	self.m_isActiveController = self:getController("isActive")
	self.m_glyphComp1 = self:getChild("glyphComp1")
	self.m_glyphComp2 = self:getChild("glyphComp2")
	self.m_attrBg1 = self:getChild("attrBg1")
	self.m_attrbg2 = self:getChild("attrbg2")
	self.m_attrComp1 = self:getChild("attrComp1")
	self.m_attrComp2 = self:getChild("attrComp2")
	self.m_glyphTipComp = self:getChild("glyphTipComp")
	self.m_suitText = self:getChild("suitText")
	self.m_attrValueBg1 = self:getChild("attrValueBg1")
	self.m_attrValueBg2 = self:getChild("attrValueBg2")
	self.m_attrValueBg3 = self:getChild("attrValueBg3")
	self.m_attrValueBg4 = self:getChild("attrValueBg4")
	self.m_attrValueComp1 = self:getChild("attrValueComp1")
	self.m_attrValueComp2 = self:getChild("attrValueComp2")
	self.m_attrValueComp3 = self:getChild("attrValueComp3")
	self.m_attrValueComp4 = self:getChild("attrValueComp4")
	self.m_glyphTouchBtn = self:getChild("glyphTouchBtn")
	self.m_glyphBtn = self:getChild("glyphBtn")
	self.m_resNumComp = self:getChild("resNumComp")
	self.m_fullTip = self:getChild("fullTip")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsFullCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsActiveCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
