local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivsxwjboj"

function var_0_0:__ctor()
	self.m_emptyController = self:getController("empty")
	self.m_rootBg = self:getChild("rootBg")
	self.m_levelBg = self:getChild("levelBg")
	self.m_levelText = self:getChild("levelText")
	self.m_levelGroup = self:getChild("levelGroup")
	self.m_imgEmpty = self:getChild("imgEmpty")
end

var_0_0.EmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
