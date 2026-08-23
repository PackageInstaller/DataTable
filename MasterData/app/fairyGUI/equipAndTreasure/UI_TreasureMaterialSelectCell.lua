local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7rhsd2u"

function var_0_0:__ctor()
	self.m_showMaskController = self:getController("showMask")
	self.m_treasureIcon = self:getChild("treasureIcon")
	self.m_maskImg = self:getChild("maskImg")
	self.m_checkBtn = self:getChild("checkBtn")
end

var_0_0.ShowMaskCtrl = {
	down = 1,
	up = 0
}

return var_0_0
