local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnu50clgich7"

function var_0_0:__ctor()
	self.m_isMulityController = self:getController("isMulity")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_shareComp = self:getChild("shareComp")
	self.m_flushTopNode = self:getChild("flushTopNode")
	self.m_effTitle = self:getChild("effTitle")
	self.m_titleBg = self:getChild("titleBg")
	self.m_item1 = self:getChild("item1")
	self.m_item2 = self:getChild("item2")
	self.m_normalEnterTransition = self:getTransition("normalEnter")
	self.m_enter_2Transition = self:getTransition("enter_2")
	self.m_enter_1Transition = self:getTransition("enter_1")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsMulityCtrl = {
	mulity = 1,
	one = 0
}

return var_0_0
