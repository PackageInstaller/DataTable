local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1abvq3n"

function var_0_0:__ctor()
	self.m_isPlayAminController = self:getController("isPlayAmin")
	self.m_waitCollectController = self:getController("waitCollect")
	self.m_levelText = self:getChild("levelText")
	self.m_levelPro = self:getChild("levelPro")
	self.m_expText = self:getChild("expText")
	self.m_effectComp = self:getChild("effectComp")
	self.m_hangUpIconLoader = self:getChild("hangUpIconLoader")
	self.m_hangUpText = self:getChild("hangUpText")
	self.m_timesTipText = self:getChild("timesTipText")
	self.m_goodsBtn = self:getChild("goodsBtn")
	self.m_haloEffectNode = self:getChild("haloEffectNode")
	self.m_numText = self:getChild("numText")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_topEffectNode = self:getChild("topEffectNode")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsPlayAminCtrl = {
	playAmin = 1,
	normal = 0
}
var_0_0.WaitCollectCtrl = {
	wait = 1,
	normal = 0
}

return var_0_0
