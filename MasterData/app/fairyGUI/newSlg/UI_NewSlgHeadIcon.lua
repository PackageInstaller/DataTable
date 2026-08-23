local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9kpj468g6"

function var_0_0:__ctor()
	self.m_levelController = self:getController("level")
	self.m_iconComp = self:getChild("iconComp")
	self.m_rotateImg = self:getChild("rotateImg")
end

var_0_0.LevelCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
