local var_0_0 = {}

var_0_0.URL = "ui://3g2xiq47nwyx1s"

function var_0_0:__ctor()
	self.m_isAllNotReplaceController = self:getController("isAllNotReplace")
	self.m_teamName = self:getChild("teamName")
	self.m_matchPercent = self:getChild("matchPercent")
	self.m_oneKeyBtn = self:getChild("oneKeyBtn")
	self.m_compList = self:getChild("compList")
end

var_0_0.IsAllNotReplaceCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
