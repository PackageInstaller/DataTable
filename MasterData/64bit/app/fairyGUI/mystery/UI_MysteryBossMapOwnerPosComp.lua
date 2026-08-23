local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8edx2x4t"

function var_0_0:__ctor()
	self.m_emptyPosController = self:getController("emptyPos")
	self.m_placeDown2 = self:getChild("placeDown2")
	self.m_placeDown1 = self:getChild("placeDown1")
	self.m_placeHolderComp = self:getChild("placeHolderComp")
	self.m_placeUp1 = self:getChild("placeUp1")
	self.m_placeUp2 = self:getChild("placeUp2")
end

return var_0_0
