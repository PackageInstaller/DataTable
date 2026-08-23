local var_0_0 = {}

var_0_0.URL = "ui://xigti88c9p794u"

function var_0_0:__ctor()
	self.m_isRecommendController = self:getController("isRecommend")
	self.m_loader = self:getChild("loader")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.IsRecommendCtrl = {
	recommend = 1,
	normal = 0
}

return var_0_0
