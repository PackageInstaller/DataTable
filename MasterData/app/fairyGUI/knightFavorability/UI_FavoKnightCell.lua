local var_0_0 = {}

var_0_0.URL = "ui://ywebtoins9rh1"

function var_0_0:__ctor()
	self.m_storyFlagController = self:getController("storyFlag")
	self.m_isLineUpController = self:getController("isLineUp")
	self.m_picComp = self:getChild("picComp")
	self.m_weddingFrameComp = self:getChild("weddingFrameComp")
	self.m_knightNameTxt = self:getChild("knightNameTxt")
	self.m_favoProgComp = self:getChild("favoProgComp")
	self.m_favoLevelTxt = self:getChild("favoLevelTxt")
	self.m_redPointComp = self:getChild("redPointComp")
end

return var_0_0
