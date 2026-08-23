local var_0_0 = {}

var_0_0.URL = "ui://n47h6oagpgj76h"

function var_0_0:__ctor()
	self.m_autoUseController = self:getController("autoUse")
	self.m_popPanel = self:getChild("popPanel")
	self.m_remainNumTxt = self:getChild("remainNumTxt")
	self.m_chooseNumComp = self:getChild("chooseNumComp")
	self.m_beginBtn = self:getChild("beginBtn")
	self.m_itemIconLoader = self:getChild("itemIconLoader")
	self.m_itemNameTxt = self:getChild("itemNameTxt")
	self.m_itemNumTxt = self:getChild("itemNumTxt")
	self.m_content = self:getChild("content")
end

var_0_0.AutoUseCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
