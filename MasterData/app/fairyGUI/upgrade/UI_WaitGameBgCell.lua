local var_0_0 = {}

var_0_0.URL = "ui://4kvnuk1fqv44p"

function var_0_0:__ctor()
	self.m_hideStarController = self:getController("hideStar")
	self.m_gameIdController = self:getController("gameId")
	self.m_eliEffDad = self:getChild("eliEffDad")
end

return var_0_0
