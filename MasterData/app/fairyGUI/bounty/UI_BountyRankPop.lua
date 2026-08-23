local var_0_0 = {}

var_0_0.URL = "ui://1v7lxemfn1mf18"

function var_0_0:__ctor()
	self.m_rankTypeController = self:getController("rankType")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_leftTabList = self:getChild("leftTabList")
	self.m_topTabList = self:getChild("topTabList")
	self.m_rankList = self:getChild("rankList")
	self.m_awardList = self:getChild("awardList")
	self.m_rankGroup = self:getChild("rankGroup")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_topBarComp = self:getChild("topBarComp")
end

return var_0_0
