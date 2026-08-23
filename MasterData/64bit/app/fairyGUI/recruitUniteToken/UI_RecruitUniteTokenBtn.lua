local var_0_0 = {}

var_0_0.URL = "ui://3jnmvl3pvb7pgibzl"

function var_0_0:__ctor()
	self.m_showFeatureController = self:getController("showFeature")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_qualityTextLoader = self:getChild("qualityTextLoader")
	self.m_featureText1 = self:getChild("featureText1")
end

return var_0_0
