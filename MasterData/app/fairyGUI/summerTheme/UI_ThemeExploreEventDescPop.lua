local var_0_0 = {}

var_0_0.URL = "ui://99hn3059lz1jkk340"

function var_0_0:__ctor()
	self.m_styleController = self:getController("style")
	self.m_bgImg = self:getChild("bgImg")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_descTxtComp = self:getChild("descTxtComp")
	self.m_operateBtn = self:getChild("operateBtn")
	self.m_itemImg = self:getChild("itemImg")
	self.m_roleImg = self:getChild("roleImg")
end

var_0_0.StyleCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
