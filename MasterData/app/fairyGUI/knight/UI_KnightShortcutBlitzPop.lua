local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivf2y1fh"

function var_0_0:__ctor()
	self.m_isShowConvertController = self:getController("isShowConvert")
	self.m_popPanel = self:getChild("popPanel")
	self.m_dungeonList = self:getChild("dungeonList")
	self.m_convertItemIcon = self:getChild("convertItemIcon")
	self.m_targetItemIcon = self:getChild("targetItemIcon")
	self.m_curNumTxt = self:getChild("curNumTxt")
	self.m_maxNumTxt = self:getChild("maxNumTxt")
	self.m_addNumComp = self:getChild("addNumComp")
	self.m_convertBtn = self:getChild("convertBtn")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsShowConvertCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
