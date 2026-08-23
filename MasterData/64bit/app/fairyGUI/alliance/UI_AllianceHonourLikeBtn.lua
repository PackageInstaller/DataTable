local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcxfgb71"

function var_0_0:__ctor()
	self.m_likeStateController = self:getController("likeState")
	self.m_likeNum = self:getChild("likeNum")
	self.m_effectNode = self:getChild("effectNode")
	self.m_eff = self:getChild("eff")
	self.m_loopTransition = self:getTransition("loop")
end

var_0_0.LikeStateCtrl = {
	page1 = 2,
	page0 = 0
}

return var_0_0
