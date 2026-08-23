local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7yhmzu5ibjg"

function var_0_0:__ctor()
	self.m_modeController = self:getController("mode")
	self.m_scrollTextComp = self:getChild("scrollTextComp")
	self.m_scrollTextComp_3 = self:getChild("scrollTextComp_3")
	self.m_autoSizeTxt = self:getChild("autoSizeTxt")
	self.m_fixedWidthTxt = self:getChild("fixedWidthTxt")
	self.m_fixedWidthTxt_2 = self:getChild("fixedWidthTxt_2")
	self.m_autoScaleTxt = self:getChild("autoScaleTxt")
end

var_0_0.ModeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
