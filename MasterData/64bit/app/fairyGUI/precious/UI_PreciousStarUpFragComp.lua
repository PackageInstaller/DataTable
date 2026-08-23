local var_0_0 = {}

var_0_0.URL = "ui://671qywx2c9i11g"

function var_0_0:__ctor()
	self.m_fullStarController = self:getController("fullStar")
	self.m_enoughController = self:getController("enough")
	self.m_fragItemIcon = self:getChild("fragItemIcon")
	self.m_name = self:getChild("name")
	self.m_numText = self:getChild("numText")
	self.m_fragBtn = self:getChild("fragBtn")
	self.m_fragProgBar = self:getChild("fragProgBar")
	self.m_starUpBtn = self:getChild("starUpBtn")
	self.m_fullFragItemIcon = self:getChild("fullFragItemIcon")
	self.m_sellBtn = self:getChild("sellBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
