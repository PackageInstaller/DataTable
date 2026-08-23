local var_0_0 = {}

var_0_0.URL = "ui://3ryajb8dl359lgic5e"

function var_0_0:__ctor()
	self.m_isFragController = self:getController("isFrag")
	self.m_isNewController = self:getController("isNew")
	self.m_fragBgEffectNode = self:getChild("fragBgEffectNode")
	self.m_bgEffectNode = self:getChild("bgEffectNode")
	self.m_groupIcon = self:getChild("groupIcon")
	self.m_fragBgLoader = self:getChild("fragBgLoader")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_icon = self:getChild("icon")
	self.m_fragNumText = self:getChild("fragNumText")
	self.m_fragIcon = self:getChild("fragIcon")
	self.m_nameText = self:getChild("nameText")
	self.m_nameEffectNode = self:getChild("nameEffectNode")
	self.m_artifactBelongIcon = self:getChild("artifactBelongIcon")
	self.m_topEffectNode = self:getChild("topEffectNode")
	self.m_enterTransition = self:getTransition("enter")
	self.m_switchFragTransition = self:getTransition("switchFrag")
	self.m_bgEffIdleTransition = self:getTransition("bgEffIdle")
end

var_0_0.IsFragCtrl = {
	switch = 3,
	frag = 1,
	normal = 0
}
var_0_0.IsNewCtrl = {
	new = 1,
	normal = 0
}

return var_0_0
