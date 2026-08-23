local var_0_0 = {}

var_0_0.URL = "ui://3wkhfdlxvzejlgich8"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_isNewController = self:getController("isNew")
	self.m_fragBgEffectNode = self:getChild("fragBgEffectNode")
	self.m_fragBgLoader = self:getChild("fragBgLoader")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_iconComp = self:getChild("iconComp")
	self.m_numText = self:getChild("numText")
	self.m_nameText = self:getChild("nameText")
	self.m_nameLeftLoader = self:getChild("nameLeftLoader")
	self.m_nameRightLoader = self:getChild("nameRightLoader")
	self.m_nameEffectNode = self:getChild("nameEffectNode")
	self.m_petBelongIcon = self:getChild("petBelongIcon")
	self.m_bgEffectNode = self:getChild("bgEffectNode")
	self.m_topEffectNode = self:getChild("topEffectNode")
	self.m_enterTransition = self:getTransition("enter")
	self.m_switchFragTransition = self:getTransition("switchFrag")
	self.m_bgEffIdleTransition = self:getTransition("bgEffIdle")
end

return var_0_0
