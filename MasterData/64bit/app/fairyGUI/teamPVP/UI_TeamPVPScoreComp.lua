local var_0_0 = {}

var_0_0.URL = "ui://akds0szatrxs4s"

function var_0_0:__ctor()
	self.m_isFoodController = self:getController("isFood")
	self.m_blueScoreTxt = self:getChild("blueScoreTxt")
	self.m_redScoreTxt = self:getChild("redScoreTxt")
end

return var_0_0
