local var_0_0 = {}

var_0_0.URL = "ui://16fa1nlapz8f34"

function var_0_0:__ctor()
	self.m_percentNumController = self:getController("percentNum")
	self.m_whiteImg1 = self:getChild("whiteImg1")
	self.m_whiteImg2 = self:getChild("whiteImg2")
	self.m_whiteImg3 = self:getChild("whiteImg3")
	self.m_whiteImg4 = self:getChild("whiteImg4")
	self.m_redImg1 = self:getChild("redImg1")
	self.m_redImg2 = self:getChild("redImg2")
	self.m_redImg3 = self:getChild("redImg3")
	self.m_redImg4 = self:getChild("redImg4")
end

var_0_0.PercentNumCtrl = {
	four = 0,
	three = 1
}

return var_0_0
